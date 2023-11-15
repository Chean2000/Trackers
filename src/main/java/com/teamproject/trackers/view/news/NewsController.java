package com.teamproject.trackers.view.news;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.teamproject.trackers.biz.news.NewsService;

@Controller
public class NewsController {
	
	private NewsService newsService;
    private HttpSession session;
	
    
    @Autowired
   	public NewsController(NewsService newsService, 
   			HttpSession session) {
   		this.newsService = newsService;
   		this.session = session;
   	}

	
	/* 내 소식 조회 */
	@RequestMapping(value="/news", method=RequestMethod.GET)
	public String getNewsList(Model model) {
		
		model.addAttribute("news", newsService.getNewsList((long) session.getAttribute("id")));		
		
		return "/my/news";
	}
	
}
