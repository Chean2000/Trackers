package com.teamproject.trackers.view.purchase;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.teamproject.trackers.biz.cart.CartInfoRepository;
import com.teamproject.trackers.biz.cart.CartInfoVO;
import com.teamproject.trackers.biz.cart.CartService;
import com.teamproject.trackers.biz.comment.PostCommentListVO;
import com.teamproject.trackers.biz.post.PostIMGVO;
import com.teamproject.trackers.biz.post.PostInfoListVO;
import com.teamproject.trackers.biz.product.CreatorListVO;
import com.teamproject.trackers.biz.product.ProductPageVO;
import com.teamproject.trackers.biz.product.ProductService;
import com.teamproject.trackers.biz.product.ProductVO;
import com.teamproject.trackers.biz.purchase.PurchaseListVO;
import com.teamproject.trackers.biz.purchase.PurchaseService;
import com.teamproject.trackers.biz.purchase.PurchaseVO;
import com.teamproject.trackers.biz.purchase.WebhookVO;
import com.teamproject.trackers.biz.regularPurchase.VerifyService;
import com.teamproject.trackers.view.test.GetTokenVO;


@Controller
@RequestMapping("/store")
public class PurchaseController {

	private PurchaseService purchaseService;
	private ProductService productService;
	private CartService cartService;
    private HttpSession session;
	
    
    @Autowired
	public PurchaseController(PurchaseService purchaseService, 
			ProductService productService, 
			CartService cartService, 
			HttpSession session) {
    	
		this.purchaseService = purchaseService;
		this.productService = productService;
		this.cartService = cartService;
		this.session = session;
	}
	
    // 구매내역 리스트 조회
    @RequestMapping(value="/purchases", method=RequestMethod.GET)
	public String getPurchaseList(PurchaseListVO vo, int page, Model model) {
    	vo.setId((long) session.getAttribute("id"));
    	
    	// 정렬 및 페이징 , 검색 처리
		Pageable pageable = PageRequest.of(page, 10, Sort.by(Sort.Direction.DESC, "creDate"));	// 시작 페이지, 데이터 개수, 정렬 기준
		Page<PurchaseListVO> list = purchaseService.getPurchaseList(vo, pageable);
		
		int nowPage = list.getPageable().getPageNumber()+1;			// 현재 페이지, 0부터 시작하므로 +1
		int startPage = Math.max(nowPage-4, 1);						// 시작 페이지 번호
		int endPage = Math.min(nowPage+5, list.getTotalPages());	// 끝 페이지 번호
		
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		
		model.addAttribute("purchases", list);
    			
    	
    	return "/my/purchase-history";
    }
    
    
    
    // 태그 모달창에 구매내역 데이터 전송
    @RequestMapping(value="/tag", method=RequestMethod.GET, produces = "application/text; charset=UTF-8")
	@ResponseBody
    public String getTagModal(PurchaseListVO vo, @RequestParam("page") int page) throws JsonProcessingException {

    	// 매개변수 vo 준비
    	vo.setId((long) session.getAttribute("id"));
		
		// 페이징 
    	Pageable pageable = PageRequest.of(page, 3, Sort.by(Sort.Direction.DESC, "creDate"));
		Page<PurchaseListVO> list = purchaseService.getPurchaseList(vo, pageable);
		
		int nowPage = list.getPageable().getPageNumber()+1;			// 현재 페이지, 0부터 시작하므로 +1
		int startPage = Math.max(nowPage-4, 1);						// 시작 페이지 번호
		int endPage = Math.min(nowPage+5, list.getTotalPages());	// 끝 페이지 번호
		
		JsonObject paging = new JsonObject();
		paging.addProperty("nowPage", nowPage);
		paging.addProperty("startPage", startPage);
		paging.addProperty("endPage", endPage);
				
		
		ObjectMapper mapper = new ObjectMapper();
		String listIntoString = mapper.writeValueAsString(list);
		
		String pagingIntoString = paging.toString();

		
		JsonObject wrapper = new JsonObject();
		wrapper.addProperty("list", listIntoString);
		wrapper.addProperty("paging", pagingIntoString);
		
		String wrapperIntoString = wrapper.toString();		
		
		return wrapperIntoString;
    }
    
    
    
	
	
	
	// 객체 받아서 넣는 버전
    /*
	public String insertPurchase(PurchaseVO vo) {		
		
		purchaseService.insertPurchase(vo);
		
		long p_id = vo.getBak_p_id();
		return "redirect:/store/products/"+p_id;
	}
	*/
	

	/* 구매하기 페이지 띄워주기 */
	@RequestMapping(value="/purchases/new", method=RequestMethod.GET)
	public String showPurchaseForm(@RequestParam List<String> pidList, Model model) {
		
		List<ProductPageVO> infolist = new ArrayList<>();
				
		// 체크된 p_id 리스트로 받아서 cartInfo 조회
		for(String pid : pidList) {			
			ProductPageVO info = productService.getProductPage(Long.parseLong(pid));						
			infolist.add(info);
		}
		
		// List형태로  model에 담기
		model.addAttribute("infolist", infolist);
		// 회원정보도 model에 한번 더 담아주기...?
		model.addAttribute("user", session.getAttribute("user"));
		
		return "store/st-purchase";
	}
	
	
	
}
