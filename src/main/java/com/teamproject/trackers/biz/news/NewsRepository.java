package com.teamproject.trackers.biz.news;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface NewsRepository extends JpaRepository<NewsVO, Long> {
	
	// 한달 간 소식 중 확인 안 한 소식 30개
	@Query(value = "SELECT * FROM news n WHERE n.id=:id and checked=0 and cre_date between date_add(now(), interval-1 month) and now() order by cre_date desc limit 30", 
			nativeQuery = true)
	List<NewsVO> getNewsList(@Param("id") long id);
}