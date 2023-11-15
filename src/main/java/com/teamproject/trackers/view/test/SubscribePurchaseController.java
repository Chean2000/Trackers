package com.teamproject.trackers.view.test;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.teamproject.trackers.biz.followSubscribeLike.SubscribePurchaseService;
import com.teamproject.trackers.biz.followSubscribeLike.SubscribePurchaseVO;

@Controller
public class SubscribePurchaseController {

	private SubscribePurchaseService subscribePurchaseService;
    private HttpSession session;
	
    
    @Autowired
	public SubscribePurchaseController(SubscribePurchaseService subscribePurchaseService, HttpSession session) {
    	System.out.println("SubscribePurchaseController 생성");
		this.subscribePurchaseService = subscribePurchaseService;
		this.session = session;
	}
    
    
    
    
    @RequestMapping(value="/subscribe/{subscribe_id}", method=RequestMethod.POST)
    public @ResponseBody void insertSubscribePurchase(@PathVariable("subscribe_id") String subscribe_id, HttpServletRequest request) {
    	
    	//String path = request.getRequestURL();
    	System.out.println("path: "+request.getRequestURL());
    	System.out.println("subscribe_id: "+subscribe_id);
    	System.out.println("subscribe_id -> Long: "+Long.parseLong(subscribe_id));
    	
    	System.out.println("Controller - insertSubscribePurchase() 실행");
    	SubscribePurchaseVO vo = new SubscribePurchaseVO();
    	vo.setSubscribeId(Long.parseLong(subscribe_id));
    	vo.setId((long)session.getAttribute("id"));
    	//vo.setPayment(String.valueOf((long)session.getAttribute("id")));
    	//vo.setPayDate(new Date());
    	System.out.println(vo.toString());
    	
    	subscribePurchaseService.insertSubscribePurchase(vo);		
	}
	
    
    
    
}
