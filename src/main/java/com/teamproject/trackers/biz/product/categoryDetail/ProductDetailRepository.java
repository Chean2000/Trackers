package com.teamproject.trackers.biz.product.categoryDetail;

import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductDetailRepository extends JpaRepository<ProductDetailVO, Long> {

	// p_id로 특정 상품 디테일 조회
	ProductDetailVO findByPid(long pid);
	
}
