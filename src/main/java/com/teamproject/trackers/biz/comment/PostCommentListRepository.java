package com.teamproject.trackers.biz.comment;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.teamproject.trackers.biz.product.ProductListVO;

public interface PostCommentListRepository extends JpaRepository<PostCommentListVO, Long>{
	
	// 포스트 조회 시 포스트별 가장 최신 댓글 3개 출력
	List<PostCommentListVO> findTop3ByPostIdOrderByCreDateDesc(long postId);
	
	// 특정 포스트 댓글 전체 조회
	List<PostCommentListVO> findAllByPostId(long postId);
	
	
	
}