package com.teamproject.trackers.view.test;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;

@RestController
public class TestController {
	/*
	@Autowired
	//private ReqPaymentScheduler scheduler;
	
	@PostMapping("/payment1")
	public @ResponseBody void getImportToken(@RequestParam Map<String, Object> map)
			throws JsonMappingException, JsonProcessingException {
		Long customer_uid = Long.parseLong((String) map.get("customer_uid"));
		int price = Integer.parseInt((String) map.get("price"));
		long merchant_uid =  Long.parseLong((String) map.get("merchant_uid"));

		//if(getPayementStatus.paymentStatus(merchant_uid).equals("paid")) {
			//scheduler.startScheduler(customer_uid,price, merchant_uid);
		//}
	}
*/
}
