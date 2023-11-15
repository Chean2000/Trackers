package com.teamproject.trackers.biz.post;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

public interface PostInfoListRepository extends JpaRepository<PostInfoListVO, Long>{
	
	// 포스트 분류 타입 x, 검색 o
	Page<PostInfoListVO> findByContentContaining(String keyword, Pageable pageable);
	
	// 포스트 분류 타입 o, 검색 o/x
	// 크리에이터들 포스트만
	@Query(value = "SELECT p.* FROM postinfolist p, creator c WHERE p.id=c.id and p.content like %:keyword%",
			countQuery = "SELECT p.* FROM postinfolist p, creator c WHERE p.id=c.id and p.content like %:keyword%",
			 nativeQuery = true)
	Page<PostInfoListVO> getCreatorPost(@Param("keyword") String keyword, Pageable pageable);
	
		
	// 팔로우한 사람들 포스트만
	@Query(value = "SELECT p.* FROM postinfolist p, follow f WHERE f.from_id=:id and p.id=f.to_id and p.content like %:keyword%",
			 countQuery = "SELECT p.* FROM postinfolist p, follow f WHERE f.from_id=:id and p.id=f.to_id and p.content like %:keyword%",
			 nativeQuery = true)
	Page<PostInfoListVO> getFollowPost(@Param("id") long id, @Param("keyword") String keyword, Pageable pageable);
	
	// 종아요 누른 포스트만
	@Query(value = "SELECT P.* FROM postinfolist p, thumbsup t WHERE t.id=:id and p.post_id=t.post_id and p.content like %:keyword%",
			 countQuery = "SELECT P.* FROM postinfolist p, thumbsup t WHERE t.id=:id and p.post_id=t.post_id and p.content like %:keyword%",
			 nativeQuery = true)
	Page<PostInfoListVO> getLikePost(@Param("id") long id, @Param("keyword") String keyword, Pageable pageable);
	
	// 댓글 단 포스트만
	@Query(value = "SELECT DISTINCT p.* FROM postinfolist p, comment c WHERE p.post_id=c.post_id and c.id=:id and p.content like %:keyword%",
			 countQuery = "SELECT DISTINCT p.* FROM postinfolist p, comment c WHERE p.post_id=c.post_id and c.id=:id and p.content like %:keyword%",
			 nativeQuery = true)
	Page<PostInfoListVO> getCommontPost(@Param("id") long id, @Param("keyword") String keyword, Pageable pageable);



	
	// 특정 상품을 태그한 포스트만
	@Query(value = "SELECT DISTINCT p.* FROM postinfolist p WHERE p.p_id=:pid and p.content like %:keyword%",
			countQuery = "SELECT DISTINCT p.* FROM postinfolist p WHERE p.p_id=:pid and p.content like %:keyword%",
			nativeQuery = true)
	Page<PostInfoListVO> getTagPost(@Param("pid") long pid, @Param("keyword") String keyword, Pageable pageable);
	
	
	
	
	// 특정 상품을 태그한 포스트만
	//Page<PostInfoListVO> findAllByPid(long pid, Pageable pageable);

	// 특정 회원의 포스트만
	Page<PostInfoListVO> findAllById(long id, Pageable pageable);
	
	
	// post_id 로 특정 포스트 조회
	PostInfoListVO findByPostId(long postId);


}