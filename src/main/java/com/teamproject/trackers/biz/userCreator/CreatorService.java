package com.teamproject.trackers.biz.userCreator;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CreatorService {
	
	@Autowired
	private CreatorRepository creatorRepository;
	@Autowired
	private CreatorViewRepository creatorViewRepository;
	
	// 스토어 열기(크리에이터 등록)
	public void insertCreator(CreatorVO vo) {
		creatorRepository.save(vo);
	}
	
	// 스토어 조회
	public Optional<CreatorViewVO> getCreator(CreatorViewVO vo) {
		return creatorViewRepository.findById(vo.getId());
	}
	
	// url, 전화번호 수정 - user 테이블
	public void updateUrlTel(CreatorViewVO vo) {
		creatorViewRepository.updateUrlTel(vo.getId(), vo.getTel(), vo.getUrl());
	}
	
	// url 수정 - user 테이블
	public void updateUrl(CreatorViewVO vo) {
		creatorViewRepository.updateUrl(vo.getId(), vo.getUrl());
	}
	
	// 스토어 수정 - creator 테이블
	public void updateCreator(CreatorViewVO vo) {
		creatorViewRepository.updateCreator(vo.getId(), vo.getStoreName(), vo.getBank(), vo.getAccount());
	}
	
	// 스토어 닫기
	public void deleteCreator(CreatorVO vo) {
		creatorRepository.deleteById(vo.getId());
	}
	
	
	// 유효성
	// 스토어명(중복 체크)
	public boolean validateStoreName(CreatorVO vo) {	
		return creatorRepository.existsByStoreName(vo.getStoreName());
	}
	
	// 스토어 유무 구분
	public CreatorVO getCreator(String url) {
		return creatorRepository.getCreator(url);
	}
}
