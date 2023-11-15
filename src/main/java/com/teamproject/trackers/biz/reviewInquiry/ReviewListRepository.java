package com.teamproject.trackers.biz.reviewInquiry;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.teamproject.trackers.biz.purchase.PurchaseListVO;


public interface ReviewListRepository extends JpaRepository<ReviewListVO, ReviewId> {

	// 상품별 리뷰 리스트
	List<ReviewListVO> findAllByPidOrderByCreDateDesc(long pid);

	// 크리에이터별 리뷰 리스트
	Page<ReviewListVO> findAllByCid(long cid, Pageable pageable);
	
	// 크리에이터별 리뷰 상세
	ReviewListVO findByIdAndPid(long id, long pid);

}
