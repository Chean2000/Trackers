package com.teamproject.trackers.biz.news;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NewsService {
	
	private NewsRepository newsRepository;
	
	@Autowired
	public NewsService(NewsRepository newsRepository) {
		this.newsRepository = newsRepository;
	}
	    
	// 소식 가져오기
	public List<NewsVO> getNewsList(long id) {
		return newsRepository.getNewsList(id);
	}
}
