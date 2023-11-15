package com.teamproject.trackers.biz.product;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CreatorListRepository extends JpaRepository<CreatorListVO, Long> {
	
	// 베스트 크리에이터 5명
	List<CreatorListVO> findTop5ByOrderByPopularityDescSaleDesc();
		
	// 상품 리스트 페이징 및 검색	
	Page<CreatorListVO> findBystoreNameContaining(String keyword, Pageable pageable);
	
}