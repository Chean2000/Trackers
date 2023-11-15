package com.teamproject.trackers.biz.product;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface ProductPageRepository extends JpaRepository<ProductPageVO, Long> {

	// p_id로 특정 상품 조회
	ProductPageVO findByPid(long pid);
	
}


