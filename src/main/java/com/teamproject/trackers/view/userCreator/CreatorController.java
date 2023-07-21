package com.teamproject.trackers.view.userCreator;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.teamproject.trackers.biz.common.AlertVO;
import com.teamproject.trackers.biz.userCreator.CreatorService;
import com.teamproject.trackers.biz.userCreator.CreatorVO;
import com.teamproject.trackers.biz.userCreator.CreatorViewVO;

@Controller
public class CreatorController {

	@Autowired
	private CreatorService creatorService;
	@Autowired
    private HttpSession session;
	private AlertVO alert = new AlertVO();

	/*
	 * // 프로필 임시 연결
	 * 
	 * @RequestMapping(value="/profiles") public String getProfile() { return
	 * "/profiles/profile"; }
	 */

	
	// 스토어 열기(크리에이터 등록)
	@RequestMapping(value="/store/creators", method=RequestMethod.POST)
	public String insertCreator(CreatorVO vo, CreatorViewVO view_vo) {
		long id = (long)session.getAttribute("id");
		vo.setId(id);
		view_vo.setId(id);
		
		creatorService.insertCreator(vo);
		creatorService.updateUrlTel(view_vo);

		alert.setStr("스토어가 생성되었습니다.");
		alert.setPath("/profiles");
		alert.setFlag(true);

		return "redirect:/common";
	}
	
	// 스토어 조회
	@RequestMapping(value="/profiles/creators", method=RequestMethod.GET)
	public String getCreator(CreatorViewVO vo, Model model) {
		vo.setId((long)session.getAttribute("id"));
		model.addAttribute("creator", creatorService.getCreator(vo).get());
		
		return "/my-store/store-management";	// 스토어 관리 임시연결
	}
	
	// 스토어 수정
	@RequestMapping(value="/profiles/creators", method=RequestMethod.PUT)
	public String updateCreator(CreatorViewVO vo) {
		vo.setId((long)session.getAttribute("id"));
		creatorService.updateCreator(vo);
		creatorService.updateUrl(vo);
		
		alert.setStr("스토어 정보가 수정되었습니다.");
		alert.setPath("/profiles/creators");
		alert.setFlag(true);

		return "redirect:/common";
	}
	
		
	// 스토어 닫기
	@RequestMapping(value="/store/creators", method=RequestMethod.DELETE)
	public String deleteCreator(CreatorVO vo) {
		vo.setId((long)session.getAttribute("id"));
		creatorService.deleteCreator(vo);
		
		alert.setStr("스토어 삭제가 완료되었습니다.");
		alert.setPath("/store/main");
		alert.setFlag(true);

		return "redirect:/common";
	}
	
	
	// 유효성
	// 스토어명(중복 체크)
	@RequestMapping(value = "/validation/creator", method=RequestMethod.GET)
	@ResponseBody
	public boolean validateStoreName(CreatorVO vo) {	
		return creatorService.validateStoreName(vo);
	}
}
