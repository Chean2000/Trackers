package com.teamproject.trackers.view.common;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.teamproject.trackers.biz.common.AlertVO;
 
@Controller
public class CommonController {


	public AlertVO alert = new AlertVO();
	
	// alert창 페이지
	@RequestMapping(value="/common")
	public String alert(Model model) {		
		model.addAttribute("alert_str", alert.getStr());
		model.addAttribute("alert_path", alert.getPath());
		model.addAttribute("alert_flag", alert.isFlag());
		
		return "common/alert";
	}
	
	
	// 문의 내역(고객센터)
	@RequestMapping(value = "/store/center/inquires", method = RequestMethod.GET)
	public String getStoreCSList() {
		return "/my/inquiry-history";
	}
	// 문의 상세(고객센터)
	@RequestMapping(value = "/store/center/inquires/id", method = RequestMethod.GET)
	public String getStoreCS() {
		return "/my/customer-inquiry";
	}
	// 문의 작성(고객센터)
	@RequestMapping(value = "/store/center/inquiries", method = RequestMethod.GET)
	public String insertCS() {
		return "/store/st-center";
	}
	
	
	
	// 관리자
	// 고객센터 문의 리스트
	@RequestMapping(value = "/center/inquires", method = RequestMethod.GET)
	public String getCSList() {
		return "/admin/customer-center";
	}
	// 고객센터 문의 상세 조회
	@RequestMapping(value = "/center/inquires/inquiry_id", method = RequestMethod.GET)
	public String getCS() {
		return "/admin/customer-center-form";
	}
	
	// 팝업 리스트
	@RequestMapping(value = "/popup", method = RequestMethod.GET)
	public String getPopupList() {
		return "/admin/notice-popup";
	}
	// 팝업 상세
	@RequestMapping(value = "/popup/id", method = RequestMethod.GET)
	public String insertPopup() {
		return "/admin/notice-popup-form";
	}
	
}
