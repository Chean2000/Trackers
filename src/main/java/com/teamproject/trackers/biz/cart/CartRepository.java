package com.teamproject.trackers.biz.cart;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface CartRepository extends JpaRepository<CartVO, Long> {

	/* 장바구니에서 상품 삭제 */
	void deleteByPid(long pid);
	
	
}
