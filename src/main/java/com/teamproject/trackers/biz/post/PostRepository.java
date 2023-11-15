package com.teamproject.trackers.biz.post;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;

import com.teamproject.trackers.biz.product.ProductListVO;
import com.teamproject.trackers.biz.userCreator.UserVO;

@Repository("postRepository")
public interface PostRepository extends JpaRepository<PostVO, Long>{
	
	// 작성
		public PostVO save(PostVO vo);
				
		  
	// 삭제
//		public void deleteByPostId(Long postId);
	// 상세 조회
//		public Optional<PostVO> findByPostId(Long postId);

		//외래키 user찾기
		@Query("SELECT u FROM UserVO u WHERE u.id = :id")
	    public Optional<UserVO> findUserByUserId(@Param("id") Long id);
		
	// 리스트 조회
		public List<PostVO> findAll();		
}