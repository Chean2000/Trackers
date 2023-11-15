package com.teamproject.trackers.view.profile;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonObject;
import com.teamproject.trackers.biz.comment.CommentService;
import com.teamproject.trackers.biz.comment.PostCommentListVO;
import com.teamproject.trackers.biz.followSubscribeLike.FollowService;
import com.teamproject.trackers.biz.followSubscribeLike.FollowVO;
import com.teamproject.trackers.biz.followSubscribeLike.SubscribeInfoService;
import com.teamproject.trackers.biz.followSubscribeLike.SubscribePurchaseService;
import com.teamproject.trackers.biz.post.PostIMGService;
import com.teamproject.trackers.biz.post.PostIMGVO;
import com.teamproject.trackers.biz.post.PostInfoListVO;
import com.teamproject.trackers.biz.post.PostService;
import com.teamproject.trackers.biz.product.ProductListVO;
import com.teamproject.trackers.biz.product.ProductService;
import com.teamproject.trackers.biz.profile.ProfileService;
import com.teamproject.trackers.biz.userCreator.CreatorService;
import com.teamproject.trackers.biz.userCreator.UserVO;


@Controller
@RequestMapping("/profiles")
public class ProfileController {
	
	private ProfileService profileService;
	private HttpSession session;
	private FollowService followService;
	private ProductService productService;
	private SubscribeInfoService subscribeInfoService;
	private SubscribePurchaseService subscribePurchaseService; 
	private CreatorService creatorService;
	private PostService postService;
	private PostIMGService postIMGService;
	private CommentService commentService;
	
	@Autowired
	public ProfileController(ProfileService profileService,
			HttpSession session,
			FollowService followService,
			ProductService productService,
			SubscribeInfoService subscribeInfoService,
			SubscribePurchaseService subscribePurchaseService,
			CreatorService creatorService,
			PostService postService,PostIMGService postIMGService,
			CommentService commentService) {
		
		this.profileService = profileService;
		this.session = session;
		this.followService = followService;
		this.productService = productService;
		this.postService = postService;
		this.postIMGService = postIMGService;
		this.commentService = commentService;
		this.subscribeInfoService = subscribeInfoService;
		this.subscribePurchaseService = subscribePurchaseService;
		this.creatorService = creatorService;
		this.creatorService = creatorService; 
	}
	
	 @RequestMapping(value ="/{url}", method = RequestMethod.GET)
	   public String getProfile(@PathVariable("url") String url, Model model, UserVO uvo, FollowVO fvo) {
	      
	      if(session.getAttribute("id") == null) {
	         model.addAttribute("profile", profileService.getUser(url));  // url에 따른 프로필 정보
	         model.addAttribute("count",followService.Follower(url)); //팔로우 수
	         model.addAttribute("subcount", subscribeInfoService.Sub(url)); //구독 수
	         model.addAttribute("getMembership",subscribeInfoService.getSubInfo(url)); //url 따른 멤버십 정보 가져오기
	         model.addAttribute("getCreator", creatorService.getCreator(url));
	      }else {
	         uvo.setId((long)session.getAttribute("id"));
	         model.addAttribute("profile", profileService.getUser(url));
	         model.addAttribute("count",followService.Follower(url));
	         model.addAttribute("subcount", subscribeInfoService.Sub(url));
	         model.addAttribute("checkf",followService.followT(url, (long)session.getAttribute("id"))); // 팔로우 여부 확인
	         model.addAttribute("checks",subscribePurchaseService.SubT(url, (long)session.getAttribute("id"))); // 구독 여부 확인
	         model.addAttribute("getMembership",subscribeInfoService.getSubInfo(url)); //url 따른 멤버십 정보 가져오기
	         model.addAttribute("getCreator", creatorService.getCreator(url));
	         model.addAttribute("getspsubid", subscribePurchaseService.SubId(url));
	        
	         	   
	      }
	   
	        return "/profiles/profile";
	      
	   }

	
        ////* 크리에이터 프로필 - 상품목록 조회 *////
	@RequestMapping(value="/{url}/products", method=RequestMethod.GET, produces = "application/text; charset=UTF-8")
	@ResponseBody
    public String getCreatorProductList(@PathVariable("url") String url, 
    												@RequestParam("page") int page, 
    												@RequestParam("sort") String sort,
    												HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
    	req.setCharacterEncoding("utf-8");
    	resp.setContentType("text/html;charset=utf-8");
    	
    	
		// URL로 id 얻기
		long id = profileService.getUser(url).getId();
    	System.out.println("id: "+id);
   	
    	// 정렬 및 페이징 
		Page<ProductListVO> list = null;
		Pageable pageable = null;
		
		
		// 정렬
		if(sort.equals("creDate")) {
			System.out.println("sort: creDate");
			pageable = PageRequest.of(page, 9, Sort.by(Sort.Direction.DESC, "creDate"));
		}else if(sort.equals("highprice")) {
			pageable = PageRequest.of(page, 9, Sort.by(Sort.Direction.DESC, "salePrice"));
		}else if(sort.equals("lowprice")) {
			pageable = PageRequest.of(page, 9, Sort.by(Sort.Direction.ASC, "salePrice"));
		}else {
			pageable = PageRequest.of(page, 9, Sort.by(Sort.Direction.DESC, sort));	// 시작 페이지, 데이터 개수, 정렬 기준
		}
		
		list = productService.getCreatorProductList(id, pageable);
		System.out.println("list: "+list);
		
		int nowPage = list.getPageable().getPageNumber()+1;			// 현재 페이지, 0부터 시작하므로 +1
		int startPage = Math.max(nowPage-4, 1);						// 시작 페이지 번호
		int endPage = Math.min(nowPage+5, list.getTotalPages());	// 끝 페이지 번호
		System.out.println("nowPage: "+nowPage+" / startPage"+startPage+" / endPage: "+endPage);
		

		
		JsonObject paging = new JsonObject();
		paging.addProperty("nowPage", nowPage);
		paging.addProperty("startPage", startPage);
		paging.addProperty("endPage", endPage);
		paging.addProperty("sort", sort);
		
    	
		ObjectMapper mapper = new ObjectMapper();
		String listIntoString = mapper.writeValueAsString(list);
		System.out.println(listIntoString);

		String pagingIntoString = paging.toString();
		
		JsonObject wrapper = new JsonObject();
		wrapper.addProperty("list", listIntoString);
		wrapper.addProperty("paging", pagingIntoString);
		
		String wrapperIntoString = wrapper.toString();
		
		System.out.println(wrapperIntoString);
    	
    	return wrapperIntoString;
    }
		
		
	////* 회원 프로필 - 포스트목록 조회 *////
	@RequestMapping(value="/{url}/posts", method=RequestMethod.GET, produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String getUserPostList(@PathVariable("url") String url, @RequestParam("page") int page) throws Exception {
		
		// URL로 id 얻기
		long id = profileService.getUser(url).getId();
		
		// 정렬 및 페이징 
		Page<PostInfoListVO> list = null;
		Pageable pageable = null;
		
		pageable = PageRequest.of(page, 9, Sort.by(Sort.Direction.DESC, "postId"));
		
		
		list = postService.getUserPostList(id, pageable);

		
		// 이미지/댓글 리스트 조회
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
		System.out.println("nowPage: "+nowPage+" / startPage"+startPage+" / endPage: "+endPage);
		
		JsonObject paging = new JsonObject();
		paging.addProperty("nowPage", nowPage);
		paging.addProperty("startPage", startPage);
		paging.addProperty("endPage", endPage);
		
		
		
		
		ObjectMapper mapper = new ObjectMapper();
		String listIntoString = mapper.writeValueAsString(list);
		
		String pagingIntoString = paging.toString();
		
		String imgListIntoString = mapper.writeValueAsString(imgList);
		String commentListIntoString = mapper.writeValueAsString(commentList);

		
		JsonObject wrapper = new JsonObject();
		wrapper.addProperty("list", listIntoString);
		wrapper.addProperty("paging", pagingIntoString);
		wrapper.addProperty("imgs", imgListIntoString);
		wrapper.addProperty("comments", commentListIntoString);
		
		String wrapperIntoString = wrapper.toString();		
		
		return wrapperIntoString;
	}
		

}

