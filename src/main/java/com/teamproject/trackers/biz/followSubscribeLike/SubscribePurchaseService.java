package com.teamproject.trackers.biz.followSubscribeLike;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamproject.trackers.biz.userCreator.UserVO;

@Service
public class SubscribePurchaseService {
	
	@Autowired
	private SubscribePurchaseRepository subscribePurchaseRepository;
	
	public SubscribePurchaseVO getSubscribePurchase(long subscribeId, long id) {
		return subscribePurchaseRepository.findBySubscribeIdAndId(subscribeId, id);
	}

	
	public void insertSubscribePurchase(SubscribePurchaseVO vo) {
		subscribePurchaseRepository.save(vo);		
	}
	
	public SubscribePurchaseVO SubT(String url, long id) {
		return subscribePurchaseRepository.subT(url, id);
	}
	
	public void deleteSub(SubscribePurchaseVO vo) {
		subscribePurchaseRepository.delete(vo);
	}
	
	public long SubId(String url) {
		return subscribePurchaseRepository.subid(url);
	}
	
	public SubscribePurchaseVO changeSub(SubscribePurchaseVO vo) {
		System.out.println("service");
		//System.out.println(vo.getPayment());
		return subscribePurchaseRepository.save(vo);
	}




	
}
