package com.teamproject.trackers.biz.reviewInquiry;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

public interface InquiryRepository extends JpaRepository<InquiryVO, Long> {

	// 상품 상세페이지 상품 문의 리스트
	List<InquiryVO> findAllByPidOrderByCreDateDesc(long pid);
	
	// 사용자별 상품 문의 리스트
	Page<InquiryVO> findAllById(long id, Pageable pageable);
	
	// 크리에이터별 상품 문의 리스트
	@Query(value = "SELECT i.* FROM inquiry i, products p WHERE i.p_id=p.p_id AND p.id=:c_id", 
			countQuery = "SELECT i.* FROM inquiry i, products p WHERE i.p_id=p.p_id AND p.id=:c_id", 
			nativeQuery = true)
	Page<InquiryVO> findAllByCId(@Param("c_id")long c_id, Pageable pageable);
	
	
	// 상품 문의 답변 업데이트
	@Modifying(clearAutomatically = true)
	@Transactional
	@Query(value = "UPDATE inquiry SET answer = :answer, answer_date = :answer_date WHERE inquiry_id=:inquiry_id",
			nativeQuery = true)
	void updateInquiryComment(@Param("answer") String answer, @Param("answer_date") Date answer_date, @Param("inquiry_id") long inquiry_id);


}
