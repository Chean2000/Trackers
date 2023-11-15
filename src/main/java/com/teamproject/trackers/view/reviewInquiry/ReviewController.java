package com.teamproject.trackers.view.reviewInquiry;

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

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonObject;
import com.teamproject.trackers.biz.followSubscribeLike.FollowService;
import com.teamproject.trackers.biz.followSubscribeLike.FollowVO;
import com.teamproject.trackers.biz.followSubscribeLike.SubscribeInfoService;
import com.teamproject.trackers.biz.product.ProductListVO;
import com.teamproject.trackers.biz.product.ProductService;
import com.teamproject.trackers.biz.profile.ProfileService;
import com.teamproject.trackers.biz.purchase.PurchaseListVO;
import com.teamproject.trackers.biz.purchase.PurchaseService;
import com.teamproject.trackers.biz.reviewInquiry.ReviewListVO;
import com.teamproject.trackers.biz.reviewInquiry.ReviewService;
import com.teamproject.trackers.biz.reviewInquiry.ReviewVO;
import com.teamproject.trackers.biz.userCreator.UserVO;

@Controller
public class ReviewController {

	private HttpSession session;
	private ReviewService reviewService;
	private PurchaseService purchaseService;
	
	@Autowired
	public ReviewController(
			HttpSession session,
			ReviewService reviewService,
			PurchaseService purchaseService) {
		this.session = session;
		this.reviewService = reviewService;
		this.purchaseService = purchaseService;
	}
	
	// 리뷰 상세 조회
	@RequestMapping(value ="/store/reviews/{p_id}", method = RequestMethod.GET)
	public String getReview(@PathVariable("p_id") long p_id, Model model) {
		long id = (long) session.getAttribute("id");
		
		model.addAttribute("p_info", purchaseService.getProductInfo(id, p_id).get());
		model.addAttribute("review", reviewService.getReview(id, p_id));
		
		return "/my/insert-review"; 
	}
	
	// 리뷰 작성
	@RequestMapping(value ="/store/reviews/{p_id}", method = RequestMethod.POST)
	public String insertReview(@PathVariable("p_id") long p_id, ReviewVO vo) {
		vo.setId((long) session.getAttribute("id"));
		vo.setPid(p_id);
		
		reviewService.insertReview(vo);
		
		return "redirect:/store/reviews/"+p_id; 
	}
	
	// 판매자 리뷰 리스트 조회
	@RequestMapping(value ="/store/my/reviews", method = RequestMethod.GET)
	public String getReviewList(int page, Model model) {

		// 정렬 및 페이징
		Pageable pageable = PageRequest.of(page, 10, Sort.by(Sort.Direction.DESC, "creDate"));	// 시작 페이지, 데이터 개수, 정렬 기준
		Page<ReviewListVO> list = reviewService.getCreatorReviewList((long) session.getAttribute("id"), pageable);
		
		int nowPage = list.getPageable().getPageNumber()+1;			// 현재 페이지, 0부터 시작하므로 +1
		int startPage = Math.max(nowPage-4, 1);						// 시작 페이지 번호
		int endPage = Math.min(nowPage+5, list.getTotalPages());	// 끝 페이지 번호
		
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		
		model.addAttribute("reviews", list);
				
		return "/my-store/review-management"; 
	}
	
	// 판매자 페이지 리뷰 상세 조회
	@RequestMapping(value ="/store/my/reviews/{p_id}/{id}", method = RequestMethod.GET)
	public String getReview(@PathVariable("p_id") long p_id, @PathVariable("id") long id, Model model) {
		
		model.addAttribute("p_info", purchaseService.getProductInfo(id, p_id).get());
		model.addAttribute("review", reviewService.getCreatorReview(id, p_id));
		
		return "/my-store/review-management-form";
	}
	
	// 리뷰 답변 업데이트
	@RequestMapping(value ="/store/reviews/{p_id}/{id}/comments", method = RequestMethod.POST)
	public String updateReviewComment(@PathVariable("p_id") long p_id, @PathVariable("id") long id, ReviewVO vo) {
		vo.setId(id);
		vo.setPid(p_id);
		
		reviewService.updateReviewComment(vo);
		
		return "redirect:/store/my/reviews/"+p_id+"/"+id;
	}
}

