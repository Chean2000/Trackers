package com.teamproject.trackers.view.purchase;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.teamproject.trackers.biz.cart.CartService;
import com.teamproject.trackers.biz.product.ProductService;
import com.teamproject.trackers.biz.product.ProductVO;
import com.teamproject.trackers.biz.purchase.PurchaseService;
import com.teamproject.trackers.biz.purchase.PurchaseVO;
import com.teamproject.trackers.biz.purchase.WebhookVO;
import com.teamproject.trackers.biz.regularPurchase.VerifyService;
import com.teamproject.trackers.view.test.GetTokenVO;

@RestController
public class WebhookController {
	
	
	private VerifyService verifyService;
	private ProductService productService;
	private PurchaseService purchaseService;
	private CartService cartService;
	
	@Autowired
	public WebhookController(VerifyService verifyService, ProductService productService, PurchaseService purchaseService, CartService cartService) {
		this.verifyService = verifyService;
		this.productService = productService;
		this.purchaseService = purchaseService;
		this.cartService = cartService;
	}
	
	
	public ResponseEntity<?> getPurchaseInfo(String imp_uid, String access_token) {
		//System.out.println("getPurchaseInfo() 실행");
		// 결제 정보 받아오기
		RestTemplate restTemplate = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_JSON);
	    headers.add("Authorization", access_token);
	    
	    //Map<String, Object> map = new HashMap<>();
	    //map.put("imp_key", "");
	    //map.put("imp_secret", "");

	    //Gson var = new Gson();
	    //String json = var.toJson(map);
		//서버로 요청할 Body
	   
	    String url = "https://api.iamport.kr/payments/"+imp_uid;
	    //System.out.println("url: "+url);
	    HttpEntity<String> entity = new HttpEntity<>(headers);
	    
		return restTemplate.exchange(url, HttpMethod.GET, entity, Object.class);
	}
	
	
	
	@RequestMapping(value="/purchase/webhook", method=RequestMethod.POST)
	public void verifyPurchase(@RequestBody WebhookVO webhook, HttpServletRequest request, HttpServletResponse resp) throws IOException {
		System.out.println("WebhookController 도착");
		System.out.println(webhook.toString());
		
		// 웹훅에서 imp_uid 받아놓기
		String imp_uid = webhook.getImp_uid();
		
		
		// 토큰 발급		
		String token = verifyService.getToken();
		Gson str = new Gson();
		token = token.substring(token.indexOf("response") + 10);
		token = token.substring(0, token.length() - 1);

		GetTokenVO vo = str.fromJson(token, GetTokenVO.class);

		String access_token = vo.getAccess_token();
		//System.out.println(access_token);
		
		
		
		//결제 정보 받아오기
		ResponseEntity<?> purchaseInfo = getPurchaseInfo(imp_uid, access_token);
		//System.out.println("purchaseInfo: "+purchaseInfo);
		
		ObjectMapper mapper = new ObjectMapper();
        String info = mapper.writeValueAsString(purchaseInfo.getBody());
        System.out.println(info);
        
        
        // 실제 결제된 금액 구하기 
        String amount = info.substring(info.indexOf("amount")+8);
        amount = amount.substring(0, amount.indexOf(","));
        int paid_price = Integer.parseInt(amount);
        //System.out.println("AMOUNT");
        System.out.println(paid_price);
        
        
        
        // DB에서 상품 금액 조회
        // 결제 정보에서 p_id 구하기
        String p_id = info.substring(info.indexOf("merchant_uid")+15);
        p_id = p_id.substring(0, p_id.indexOf("_"));
        System.out.println(p_id);

        // -으로 이어진 형태 끊어주기
        String[] pidArr = p_id.split("-");
        
        // 각 상품의 금액 구해서 더한 다음 결제금액과 일치하는지 대조
        int total_price = 0;
        
        
        ArrayList<ProductVO> productList = new ArrayList<ProductVO>();
        
        for(String s : pidArr) {
        	ProductVO product = productService.getProduct(Long.parseLong(s));
        	// DB에 담을때 또 사용할 것이므로 객체는 배열에 담아두기
        	productList.add(product);
        	
        	System.out.println("p_id: "+product.getPid()+" / fin_price: "+(product.getPrice()-product.getSale()));
        	total_price += (product.getPrice()-product.getSale());
        }
        
        
        // 양쪽 총액 비교
        if(total_price == paid_price) {
        	// 일치할 시 DB에 purchase 저장
        	System.out.println("일치합니다!");
        	
        	// 결제 정보에서 구매자 id 구하기
            String id = info.substring(info.indexOf("merchant_uid")+15);
            id = id.substring(id.indexOf("_")+1);
            id = id.substring(0, id.indexOf("-"));
            System.out.println("final id: "+id);
        	
            // 이것도 배열로 돌려서 저장 
            for(int i = 0; i<productList.size(); i++) {
            	// VO 만들어서 보내주기
            	PurchaseVO purchase = new PurchaseVO();
            	ProductVO product = productList.get(i);
            	
            	purchase.setBak_p_id(product.getPid());
            	purchase.setId(Long.parseLong(id));
            	purchase.setC_id(product.getId());
            	purchase.setPrice(product.getPrice()-product.getSale());  
            	
            	
            	purchase.setCre_date(new java.util.Date());

            	purchaseService.insertPurchase(purchase);
            	
            	// 구매한 상품은 장바구니에서 삭제
            	cartService.deleteCart(product.getPid());
            }
            
        } else {
        	// 잘못된 결제건 
        	System.out.println("일치하지 않습니다!");
        	
        	// 이 경우엔 어떻게 처리할 것인지...
        }
		
	}
	

}
