package com.teamproject.trackers.biz.followSubscribeLike;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SubscribeInfoService {
	
	@Autowired
	private SubscribeInfoRepository subscribeInfoRepository;
	
	// 구독 정보 조회
	public SubscribeInfoVO getSubscribeInfo(SubscribeInfoVO vo) {
		return subscribeInfoRepository.getSubscribeInfo(vo.getId());
	}
	
	// 구독 활성화(등록)
	public void insertSubscribeInfo(SubscribeInfoVO vo) {
		subscribeInfoRepository.save(vo);
	}
	
	// 구독 수정
	public void updateSubscribeInfo(SubscribeInfoVO vo) {
		subscribeInfoRepository.updateSubscribeInfo(vo.getId(), vo.getFile(), vo.getContent(), vo.getPrice());
	}
	// 구독 비활성화(삭제)
	public void deleteSubscribeInfo(SubscribeInfoVO vo) {
		subscribeInfoRepository.deleteSubscribeInfo(vo.getId());
	}
	// 구독자 수 카운트
	public long Sub(String url) {
		return subscribeInfoRepository.Sub(url);
	}
	
	// url에 따라서 멤버십 정보 가져오기
	public SubscribeInfoVO getSubInfo(String url) {
		return subscribeInfoRepository.getSubInfo(url);
	}
	
	// 구독 정보에 따른 크리에이터 아이디
	public long getSubscribeCid(long subscribe_id) {
		return subscribeInfoRepository.getSubscribeCid(subscribe_id);
	}
}
