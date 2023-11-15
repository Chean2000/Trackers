package com.teamproject.trackers.biz.reviewInquiry;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;


public interface ReviewRepository extends JpaRepository<ReviewVO, ReviewId> {

	// 리뷰 조회
	@Query(value = "SELECT r.* FROM review r WHERE r.id=:id and r.p_id=:p_id",
			nativeQuery = true)
	ReviewVO getReview(@Param("id") long id, @Param("p_id") long p_id);
	
	
	// 리뷰 답변 업데이트
	@Modifying(clearAutomatically = true)
	@Transactional
	@Query(value = "UPDATE review r SET r.answer = :answer WHERE r.id=:id and r.p_id=:p_id",
			nativeQuery = true)
	void updateReviewComment(@Param("answer") String answer, @Param("id") long id, @Param("p_id") long p_id);
}
