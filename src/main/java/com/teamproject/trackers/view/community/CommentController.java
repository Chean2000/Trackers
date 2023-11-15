package com.teamproject.trackers.view.community;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.teamproject.trackers.biz.comment.CommentService;
import com.teamproject.trackers.biz.comment.CommentVO;
import com.teamproject.trackers.biz.post.PostService;
 
@Controller
@RequestMapping("**/comments/**")
public class CommentController {


	
	@Autowired
	private CommentService commentService;

	// 작성
	@RequestMapping(method = RequestMethod.POST)
	public String insertComment(CommentVO vo, HttpServletRequest request) {

System.out.println("vo.postid "+vo.getPostId());
		commentService.insertComment(vo);
		request.setAttribute("postId", vo.getPostId());
		
		String postId = Long.toString(vo.getPostId());
		
		return "redirect:/community/posts/"+postId;
	}
	
	
	// 댓글 삭제
	
		@RequestMapping(value = "/{comment_id}", method = RequestMethod.DELETE)
		public String deleteComment(@PathVariable("comment_id")Long commentid, HttpServletRequest request) {
			
			commentService.deleteComment(commentid);
			String url = request.getRequestURI();
System.out.println("url "+url);
			String c = "/comments";
			int index = url.indexOf(c);
			
			String path = url.substring(0,index);
System.out.println("path "+path);
					
			//return "redirect:/community/posts/"+postid;
			return "redirect:"+path;
		}
	
	// 삭제
	/*
	@RequestMapping(value = "/{comment_id}", method = RequestMethod.DELETE)
	public String deleteComment(@PathVariable("comment_id")Long commentid) {
		commentService.deleteComment(commentid);
		return "redirect:/community/posts";
	}
 	*/
	
	// 리스트 조회
	/*
	public Model getCommentList(Long postId, Model model) {
System.out.println("postId "+postId);		
System.out.println("comments "+commentService.getCommentList(postId).size());
		return model.addAttribute("comments", commentService.getCommentList(postId));
	}
	*/

	/*
	public String getCommentList(String path, @PathVariable("postId")Long postId, Model model) {
		model.addAttribute("commentService",commentService);
		model.addAttribute("comments", commentService.getCommentList(postId));
		return "redirect:"+path;
	}
	*/
}
