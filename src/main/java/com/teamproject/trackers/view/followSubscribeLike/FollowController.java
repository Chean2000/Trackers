package com.teamproject.trackers.view.followSubscribeLike;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.teamproject.trackers.biz.followSubscribeLike.FollowService;
import com.teamproject.trackers.biz.followSubscribeLike.FollowVO;
import com.teamproject.trackers.biz.followSubscribeLike.SubscribeInfoService;
import com.teamproject.trackers.biz.followSubscribeLike.SubscribeInfoVO;
import com.teamproject.trackers.biz.followSubscribeLike.SubscribePurchaseService;
import com.teamproject.trackers.biz.followSubscribeLike.SubscribePurchaseVO;
import com.teamproject.trackers.biz.profile.ProfileService;
import com.teamproject.trackers.biz.regularPurchase.TokenVO;
import com.teamproject.trackers.biz.regularPurchase.VerifyService;
import com.teamproject.trackers.view.common.CommonController;
import com.teamproject.trackers.view.test.GetTokenVO;
import com.teamproject.trackers.biz.userCreator.UserVO;


@Controller
public class FollowController {
	
	@Autowired
	private FollowService followService;
	@Autowired
	private HttpSession session;
	@Autowired
	private ProfileService profileService;
	@Autowired
	private SubscribePurchaseService subscribePurchaseService;
	@Autowired
	private SubscribeInfoService subscribeInfoService;
	@Autowired
	public CommonController common;
	@Autowired	
	private VerifyService verifyService;

	
	// 팔로우
	 @RequestMapping(value ="/profiles/{url}", method = RequestMethod.POST)
	 public String changestateFollow(@PathVariable("url") String url,
			 Model model, UserVO uvo, FollowVO fvo,SubscribePurchaseVO spvo) {
		 	//String m = "Join";
		
		 if( session.getAttribute("id") != null){
	         fvo.setFrom_id((long)session.getAttribute("id"));
	         fvo.setTo_id(profileService.getUser(url).getId());
	         
	         followService.insertFollower(fvo);	 
	         
	         common.alert.setStr("팔로우가 추가되었습니다."); 
	         common.alert.setPath("/profiles/"+url); 
	         common.alert.setFlag(true);
		 }
		return "redirect:/common";
	 }
	 
	 // 구독
	// 정기결제 빌링키 (payment) 저장 및 스케줄링 로직 포함
	 @RequestMapping(value ="/profile/{url}", method = RequestMethod.POST)
	 public String changestateSub(@PathVariable("url") String url, @RequestBody SubscribePurchaseVO spvo) {
				
		 //if( session.getAttribute("id") != null){
			System.out.println("controller");
			
			
			// 실제 결제 메소드 실행
			String doPurchase = doPurchase(spvo.getPayment());
			System.out.println(doPurchase);
			

			// 정기결제 스케줄링 메소드 실행 
			setPurchaseSchedule(spvo.getPayment());
			
						
		     subscribePurchaseService.changeSub(spvo);	
		     
		     if(followService.followT(url, spvo.getId()) == null){
		    	FollowVO vo = new FollowVO();
		    	vo.setFrom_id(spvo.getId());
		    	vo.setTo_id(subscribeInfoService.getSubscribeCid(spvo.getSubscribeId()));
		    	
		    	followService.insertFollower(vo);
		    	
		     }
		     System.out.println("controller1"); 
		     common.alert.setStr("구독이 추가되었습니다."); 
		     common.alert.setPath("/profiles/"+url); 
		     common.alert.setFlag(true);
		 
		return "redirect:/common";
	 }
	 

	 
	 // 정기결제 실제 결제 과정
	 public String doPurchase(String customer_uid) {
		 System.out.println("doPurchase() 실행");
		 	 
		 // 토큰 발급
		 String token = verifyService.getToken();
		 Gson str = new Gson();
		 token = token.substring(token.indexOf("response") + 10);
		 token = token.substring(0, token.length() - 1);
		 
		 TokenVO tokenVO = str.fromJson(token, TokenVO.class);
		 
		 String access_token = tokenVO.getAccess_token();
		 System.out.println("doPurchase() 에서 print한 Token : "+access_token);
		 
		 
		 // 서버로 요청할 헤더
		 RestTemplate restTemplate = new RestTemplate();
		 
		 HttpHeaders headers = new HttpHeaders();
		 headers.setContentType(MediaType.APPLICATION_JSON);
		 headers.add("Authorization", access_token);
		 
		 
		 //서버로 요청할 Body
		 JsonObject jsonObject = new JsonObject();
		 jsonObject.addProperty("merchant_uid", "정기결제 실결제");
		 jsonObject.addProperty("customer_uid", customer_uid);
		 jsonObject.addProperty("amount", 120);
		 jsonObject.addProperty("name", "월간구독상품");
		 
		 String json = str.toJson(jsonObject); 
		 System.out.println(json);
		 HttpEntity<String> entity = new HttpEntity<>(json, headers);
		 
		 String url = "https://api.iamport.kr/subscribe/payments/again";
		 
		 return restTemplate.postForObject(url, entity, String.class);
	 }
	 
	 
	// 정기결제 스케줄링 
	public String setPurchaseSchedule(String customer_uid) {
		System.out.println("setPurchaseSchedule() 실행");
		
		long timestamp = System.currentTimeMillis();
		System.out.println("현재 : "+timestamp);
		timestamp += 60000;
		System.out.println("예약 : "+timestamp);
		/*
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm", Locale.KOREA);
		cal.add(Calendar.MINUTE, +1);
		String date = sdf.format(cal.getTime());
		try {
			Date stp = sdf.parse(date);
			timestamp = stp.getTime()/1000;
			System.out.println("FollowController Timestamp : "+timestamp);
		} catch (ParseException e) {
			e.printStackTrace();
		} 
		*/
		
		// 토큰 발급
		String token = verifyService.getToken();
		Gson str = new Gson();
		token = token.substring(token.indexOf("response") + 10);
		token = token.substring(0, token.length() - 1);

		TokenVO tokenVO = str.fromJson(token, TokenVO.class);

		String access_token = tokenVO.getAccess_token();
		System.out.println("FollowController 에서 print한 Token : "+access_token);
		
		
		// 서버로 요청할 헤더
		RestTemplate restTemplate = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_JSON);
	    headers.add("Authorization", access_token);
	    

		//서버로 요청할 Body
	    JsonObject jsonObject = new JsonObject();
		jsonObject.addProperty("merchant_uid", timestamp);
		jsonObject.addProperty("schedule_at", timestamp);
		jsonObject.addProperty("amount", 120);
		jsonObject.addProperty("name", "월간구독상품");
		
		JsonArray jsonArr = new JsonArray();
		
		jsonArr.add(jsonObject); JsonObject reqJson = new JsonObject();
		
		reqJson.addProperty("customer_uid", customer_uid); 
		reqJson.add("schedules",jsonArr);
		String json = str.toJson(reqJson); 
		System.out.println(json);
		HttpEntity<String> entity = new HttpEntity<>(json, headers);
	   
	    String url = "https://api.iamport.kr/subscribe/payments/schedule";
	    
		return restTemplate.postForObject(url, entity, String.class);
	}
		
	
	

	 
	// 팔로우, 구독 취소
	 @RequestMapping(value ="/profiles/{url}", method = RequestMethod.DELETE)
	 public String unFollowSub(@PathVariable("url") String url, Model model,@RequestParam("type") String type, UserVO uvo, FollowVO fvo,SubscribeInfoVO sivo, SubscribePurchaseVO spvo) {
		 String c = "unSub";
		 String f= "unFollow";
		
		 if(f.equals(type) && session.getAttribute("id") != null) {
	
	         fvo.setFrom_id((long)session.getAttribute("id"));
	         fvo.setTo_id(profileService.getUser(url).getId());
	         
	         followService.deleteFollower(fvo);	 
	         
	         common.alert.setStr("팔로우가 취소되었습니다."); 
	         common.alert.setPath("/profiles/"+url); 
	         common.alert.setFlag(true);
		 }	
		 else if ( c.equals(type) && session.getAttribute("id") != null) {
			 spvo.setId((long)session.getAttribute("id"));
	         spvo.setSubscribeId(subscribePurchaseService.SubId(url));
	         
	         subscribePurchaseService.deleteSub(spvo);
	         
	         common.alert.setStr("구독이 취소되었습니다."); 
	         common.alert.setPath("/profiles/"+url); 
	         common.alert.setFlag(true);
		 }

		return "redirect:/common";
	 }
	 

}
