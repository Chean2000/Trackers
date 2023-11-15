package com.teamproject.trackers.biz.post;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.teamproject.trackers.biz.product.ProductVO;
  
@Repository("postIMGRepository")
public interface PostIMGRepository extends JpaRepository<PostIMGVO, Long>{
	
	// 작성
		public PostIMGVO save(PostIMGVO vo); 
	// 삭제
		public void deleteByPostId(Long postId);
	// 상세 조회
		public Optional<PostIMGVO> findByPostId(Long postId);
	// 리스트 조회
		public List<PostIMGVO> findAll();

		
	// 페이징에 따른 해당 포스트 이미지 조회
	@Query(value = "SELECT * FROM postimg p WHERE p.post_id=:post_id", nativeQuery = true)
	List<PostIMGVO> getPImgList(@Param("post_id") long postId);		
}
