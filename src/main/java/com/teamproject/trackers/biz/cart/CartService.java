package com.teamproject.trackers.biz.cart;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CartService {
	
	private CartRepository cartRepository;
	private CartInfoRepository cartInfoRepository;
	
	@Autowired
	public CartService(CartRepository cartRepository, CartInfoRepository cartInfoRepository) {
		this.cartRepository = cartRepository;
		this.cartInfoRepository = cartInfoRepository;
	}
	
	
	/* 장바구니 추가 */
	public void insertCart(CartVO vo) {
		cartRepository.save(vo);
	}
	
	
	/* 장바구니 삭제 */
	public void deleteCart(long pid) {
		cartRepository.deleteByPid(pid);
	}
	
	
	/* 장바구니 목록 조회 */
	public List<CartInfoVO> getCartList(long id) {
		return cartInfoRepository.findAllById(id);
	}
	
	
	/* p_id로 특정상품 조회 */
	public CartInfoVO getCartItem(long pid) {
		return cartInfoRepository.findByPid(pid);
	}

	
	
	
}
