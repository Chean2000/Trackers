package com.teamproject.trackers.view.test;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.google.gson.Gson;

@Service
public class ImportPay {

	/*
	public String getToken() {
		
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
		return restTemplate.postForObject("https://api.iamport.kr/users/getToken", entity, String.class);
		
		
	}
	*/
}
