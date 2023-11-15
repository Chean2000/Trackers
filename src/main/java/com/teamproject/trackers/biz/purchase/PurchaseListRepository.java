package com.teamproject.trackers.biz.purchase;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface PurchaseListRepository extends JpaRepository<PurchaseListVO, PurchaseId> {
	
	
	// 특정 회원의 구매내역 조회
	Page<PurchaseListVO> findAllById(long id, Pageable pageable);
	
	// 크리에이터 베스트5 상품 판매액 및 수량 리스트
	@Query(value = "SELECT p_name, COUNT(bak_p_id) AS quantity, SUM(price) AS total FROM purchaselist WHERE c_id=:id GROUP BY bak_p_id ORDER BY quantity DESC, total DESC LIMIT 5", nativeQuery = true)
	List<Object[]> getBest5Sales(@Param("id") long id);
	
}