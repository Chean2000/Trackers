package com.teamproject.trackers.biz.reviewInquiry;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;


@Service
public class ReviewService {

	@Autowired
	private ReviewRepository reviewRepository;
	@Autowired
	private ReviewListRepository reviewListRepository;

	
	// 리뷰 조회
	public ReviewVO getReview(long id, long p_id){
		return reviewRepository.getReview(id, p_id);
	}
	
	// 리뷰 작성
	public void insertReview(ReviewVO vo) {
		vo.setRating(vo.getRating()*10);
		vo.setCre_date(new Date());
		reviewRepository.save(vo);
	}
	
	// 특정 상품에 대한 리뷰 리스트
	public List<ReviewListVO> getProductReview(long p_id) {
		return reviewListRepository.findAllByPidOrderByCreDateDesc(p_id);
	}
	
	// 크리에이터별 리뷰 리스트
	public Page<ReviewListVO> getCreatorReview(long c_id, Pageable pageable){
		return reviewListRepository.findAllByCid(c_id, pageable);
	}
}
