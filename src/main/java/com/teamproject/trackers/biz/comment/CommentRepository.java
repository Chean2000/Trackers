package com.teamproject.trackers.biz.comment;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.teamproject.trackers.biz.product.ProductListVO;
import com.teamproject.trackers.biz.userCreator.UserVO;
 
@Repository("commentRepository")
public interface CommentRepository extends JpaRepository<CommentVO, Long>{
	
	// 작성
	@Modifying
	@Query(value="insert into comment(post_id, id, content) values(:postId,:id, :content)", nativeQuery = true)
	public int save(@Param("postId")Long post_id, @Param("id")Long id, @Param("content")String content); 
	
	
	// 삭제
	public void deleteByCommentid(Long commentid);
	
	// 리스트 조회
	public List<CommentVO> findAllByPostId(@Param("postId")Long postId);

	//외래키 user찾기
	@Query("SELECT u FROM UserVO u WHERE u.id = :id")
    public Optional<UserVO> findUserByUserId(@Param("id") Long id);
}