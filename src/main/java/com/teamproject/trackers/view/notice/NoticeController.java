package com.teamproject.trackers.view.notice;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class NoticeController {
	
	
	/*  공지관리 페이지 띄워주기    */
	@RequestMapping(value = "/store/my/notices", method = RequestMethod.GET)
	public String getNoticeList() {
		return "/my-store/notice-management";
	}
	

}
