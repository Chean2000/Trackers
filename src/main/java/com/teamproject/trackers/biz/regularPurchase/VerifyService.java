package com.teamproject.trackers.biz.regularPurchase;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.google.gson.Gson;


@Service
public class VerifyService {

	
	// 정기결제 토큰 얻어오기
	public String getToken() {
		
		System.out.println("getToken() 실행");
		
		RestTemplate restTemplate = new RestTemplate();
	
		//서버로 요청할 Header
		HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_JSON);
		
	    
	    Map<String, Object> map = new HashMap<>();
	    map.put("imp_key", "2683684427131538");
	    map.put("imp_secret", "c8BLGUq15RxOKEEuKkHrpimIuaMK0mL4sJ5tPsaIDLddad9vKWAF9hIEltEjVDoPegGk4IrwCHW9A4cG");
	    
	   
	    Gson var = new Gson();
	    String json=var.toJson(map);
		//서버로 요청할 Body
	   
	    HttpEntity<String> entity = new HttpEntity<>(json,headers);
		String result = restTemplate.postForObject("https://api.iamport.kr/users/getToken", entity, String.class);
		System.out.println("getToken() 의 RESULT "+result);
		return restTemplate.postForObject("https://api.iamport.kr/users/getToken", entity, String.class);
		
		
	}
	
}
