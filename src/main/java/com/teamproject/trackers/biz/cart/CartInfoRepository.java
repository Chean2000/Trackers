package com.teamproject.trackers.biz.cart;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface CartInfoRepository extends JpaRepository<CartInfoVO, CartId> {
	
	
	/* 장바구니 목록 조회 */
	List<CartInfoVO> findAllById(long id);
	
	
	/* p_id로 특정상품 정보 조회 */
	CartInfoVO findByPid(long pid);

}
