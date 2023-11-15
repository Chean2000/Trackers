package com.teamproject.trackers.biz.purchase;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface PurchaseRepository extends JpaRepository<PurchaseVO, PurchaseId> {
	
	// 특정 회원의 구매내역 조회
	PurchaseVO findById(long id);
	
	// 크리에이터 한달 판매액
	@Query(value = "SELECT IFNULL(SUM(price), 0) FROM purchase WHERE c_id=:id and MONTH(cre_date)=:month", nativeQuery = true)
	Integer getMonthSales(@Param("id") long id, @Param("month") int month);
}