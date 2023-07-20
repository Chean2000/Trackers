package com.teamproject.trackers.biz.comment;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.teamproject.trackers.biz.userCreator.UserVO;

@Service 
public class CommentService {

	@Autowired
	@Qualifier("commentRepository")
	private CommentRepository commentRepository;
	
	
	// 작성
	public void insertComment(CommentVO vo) {
System.out.println("vopoid "+vo.getPostId());		
System.out.println("void "+vo.getId());		
System.out.println("voco "+vo.getContent());		
		commentRepository.save(vo.getPostId(), vo.getId(), vo.getContent());
	}
	
	// 삭제
	public void deleteComment(Long commentid) {
		commentRepository.deleteByCommentid(commentid);
	}
	
	// 리스트 조회
	public List<CommentVO> getCommentList(Long postId){
System.out.println("colist postid "+postId);	
		return commentRepository.findAllByPostId(postId);
	}
	
	public Optional<UserVO> getUser(Long commentId) {
        Optional<CommentVO> commentOptional = commentRepository.findById(commentId); 
        if (commentOptional.isPresent()) {
        	CommentVO commentVO = commentOptional.get();
            return commentRepository.findUserByUserId(commentVO.getId());
        }
        return Optional.empty();
    }
}