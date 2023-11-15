package com.teamproject.trackers.view.community;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.teamproject.trackers.biz.comment.CommentService;
import com.teamproject.trackers.biz.comment.CommentVO;
import com.teamproject.trackers.biz.comment.PostCommentListVO;
import com.teamproject.trackers.biz.common.AlertVO;
import com.teamproject.trackers.biz.followSubscribeLike.FollowService;
import com.teamproject.trackers.biz.post.PostIMGService;
import com.teamproject.trackers.biz.post.PostIMGVO;
import com.teamproject.trackers.biz.post.PostInfoListRepository;
import com.teamproject.trackers.biz.post.PostInfoListVO;
import com.teamproject.trackers.biz.post.PostService;
import com.teamproject.trackers.biz.post.PostVO;
import com.teamproject.trackers.biz.product.CreatorListVO;
import com.teamproject.trackers.biz.product.ProductListVO;
import com.teamproject.trackers.biz.product.ProductVO;
import com.teamproject.trackers.biz.userCreator.UserService;
import com.teamproject.trackers.biz.userCreator.UserVO;
import com.teamproject.trackers.view.userCreator.UserController;

@Controller
@RequestMapping("/community")
public class PostController {
	
	@Autowired
	private PostService postService;
	
	@Autowired
	private PostIMGService postIMGService;
	
	@Autowired
	private CommentService commentService;
	
	@Autowired
	private FollowService followService;
	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private PostInfoListRepository postInfoListRepository;
	
	private AlertVO alert = new AlertVO();
	
	// 사용자 팔로우 목록
	private List<Object[]> followList() {
		long id = 0;
		List<Object[]> followList = null;
		
		if (session.getAttribute("id") != null) {
			id = (long) session.getAttribute("id");
			followList = followService.getfollowList((long) session.getAttribute("id"));
		}
		
		return followList;
	}
	
	
	// 이미지 모달창
	@RequestMapping(value="/image-modal")
	public String imageModal() {
		return "modal/image-modal";
	}
	
	
	// 태그 모달창
	@RequestMapping(value="/tag-modal")
	public String taggModal(Model model) {
		return "modal/tag-modal";
	}
	
	
	
	// posts 없이 들어올 경우 우회 
	@RequestMapping(value="", method=RequestMethod.GET)
	public String coMain(Model model) {
		return "redirect:/community/posts?page=0&type=all";
	}
	
	
			
		
	// 작성
	@RequestMapping(value = "/posts", method = RequestMethod.POST)
	public String insertPost(PostVO vo, PostIMGVO imgvo , @RequestParam("post-img")List<MultipartFile> files, HttpServletRequest request) throws Exception {	

		PostVO p = postService.insertPost(vo);	
		
		List<String> fileNames = new ArrayList<>();
		String path = request.getServletContext().getRealPath("/resources/postimg/");	
		
		for (MultipartFile file : files) {
			if(!file.isEmpty()) { //uploadFile !=null

				//새로운 파일 이름
				String fileName = p.getPostId()+"_"+System.currentTimeMillis()+"_"+file.getOriginalFilename();
				fileNames.add(fileName);
System.out.println("newfile "+"/resources/postimg/"+fileName);				
				// 로컬에 파일 저장			
				file.transferTo(new File(path+fileName));
	
			}
		}
		
		// imgvo 저장하기
		for (String fileName : fileNames) {
			imgvo.setImg("/resources/postimg/"+fileName);
			imgvo.setPostId(p.getPostId());
			postIMGService.insertPostIMG(imgvo);
		}
			
		
		return "redirect:/community/posts/"+p.getPostId();
	}
	
	
	
	
	// 포스트 삭제
	@RequestMapping(value = "/posts/{postId}", method = RequestMethod.DELETE)
	public String deletePost(@PathVariable("postId")Long postId) {
		postService.deletePost(postId);
		// comment도 삭제
		 alert.setStr("포스트가 삭제되었습니다."); 

		return "redirect:/community/posts";
	}	
	
	// 댓글 작성
	/*	@RequestMapping(value = "posts/{postId}/comments", method = RequestMethod.POST)
		public String insertComment(CommentVO vo, HttpServletRequest request) {

	System.out.println("vo.postid "+vo.getPostId());
			commentService.insertComment(vo);
			request.setAttribute("postId", vo.getPostId());
			
			String postId = Long.toString(vo.getPostId());
			
			return "redirect:/community/posts/"+postId;
		}
  	*/

	// 댓글 삭제
	/*
			@RequestMapping(value = "/posts/{postId}/comments/{comment_id}", method = RequestMethod.DELETE)
			public String deleteComment(@PathVariable("comment_id")Long commentid, @PathVariable("postId")Long postId) {
		System.out.println("delete postid "+postId);		
				commentService.deleteComment(commentid);
				String postid = Long.toString(postId);
				return "redirect:/community/posts/"+postid;
			}
 	*/
	
	
	// 상세 조회
	@RequestMapping(value="/posts/{postId}", method=RequestMethod.GET)
	public String getPost(@PathVariable("postId")Long postId, Model model) {
		
		PostInfoListVO vo = postInfoListRepository.findByPostId(postId);
		
		// 이미지 목록
		List<PostIMGVO> imgList = postIMGService.getPImgList(postId);
		
		// 댓글 목록
		List<PostCommentListVO> commentList = commentService.getCommentListPage(postId);	
		
		// 사이드바 팔로잉 목록
		model.addAttribute("followList", followList());
		
		model.addAttribute("post", vo);
		model.addAttribute("imgList", imgList);
		model.addAttribute("commentList", commentList);
		

		return "community/co-post";
	}
	
	
	// 리스트 조회
	/*
	@RequestMapping(value="/posts", method=RequestMethod.GET)
	public String getPostList(Model model) {
		
		//this.getPost(postId, model);
		
		model.addAttribute("commentService",commentService);		
		model.addAttribute("postService",postService);
		model.addAttribute("postList", postService.getPostList());
		model.addAttribute("postIMGList", postIMGService);
		return "community/co-main";
	}
	*/
	
	// 리스트 조회(페이징)
	@RequestMapping(value="/posts", method=RequestMethod.GET)
	public String getPostList(Integer page, String type, String keyword, String pid, Model model) {
		
		
		// 정렬 및 페이징 , 검색 처리
		Page<PostInfoListVO> list = null;
		Pageable pageable = null;
		if(type != null) {
			
			if(!type.equals("all")) {
				// 정렬
				pageable = PageRequest.of(page, 10, Sort.by(Sort.Direction.DESC, "cre_date"));
				// 검색 x 경우
				if(keyword == null) keyword="";
				
				if(type.equals("creator")) list = postService.getCreatorPostList(keyword, pageable);
				else if(type.equals("tag")) list = postService.getTagPostList(Long.parseLong(pid), keyword, pageable);
				else list = postService.getTypeList(type, (long) session.getAttribute("id"), keyword, pageable);
			}else {
				// 정렬
				pageable = PageRequest.of(page, 10, Sort.by(Sort.Direction.DESC, "creDate"));
				
				// 검색
				if(keyword != null) {			// 검색 o
					list = postService.getSearchPostList(keyword, pageable);
				}else {							// 검색 x
					keyword = "";
					list = postService.getPostList(pageable);
				}
			}
			
			
			// 포스트 이미지 리스트 조회
			HashMap<Long, List<PostIMGVO>> imgList = new HashMap<>();
			HashMap<Long, List<PostCommentListVO>> commentList = new HashMap<>();
			for(PostInfoListVO p : list.getContent()) {
				List<PostIMGVO> pi = postIMGService.getPImgList(p.getPostId());
				List<PostCommentListVO> ci = commentService.getPostCommentList(p.getPostId());
				
				// 포스트 이미지 리스트
				for(PostIMGVO item : pi) {
					if(imgList.get(item.getPostId()) != null) {
						imgList.get(item.getPostId()).add(item);
					}else {
						ArrayList<PostIMGVO> imgs = new ArrayList<>();
						imgs.add(item);
						imgList.put(item.getPostId(), imgs);
					}
				}
				
				// 댓글 리스트
				for(PostCommentListVO item : ci) {
					if(commentList.get(item.getPostId()) != null) {
						commentList.get(item.getPostId()).add(item);
					}else {
						ArrayList<PostCommentListVO> comments = new ArrayList<>();
						comments.add(item);
						commentList.put(item.getPostId(), comments);
					}
				}
			}
			
			int nowPage = list.getPageable().getPageNumber()+1;			// 현재 페이지, 0부터 시작하므로 +1
			int startPage = Math.max(nowPage-4, 1);						// 시작 페이지 번호
			int endPage = Math.min(nowPage+5, list.getTotalPages());	// 끝 페이지 번호
			
			model.addAttribute("nowPage", nowPage);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			
			model.addAttribute("posts", list);
			model.addAttribute("imgs", imgList);
			model.addAttribute("comments", commentList);
			model.addAttribute("type", type);
			model.addAttribute("keyword", keyword);
			
			// 사용자 팔로우 목록
			model.addAttribute("followList", followList());
			
			return "community/co-main";
		}else {
			return "redirect:/community/posts?page=0&type=all";
		}
	}

}
