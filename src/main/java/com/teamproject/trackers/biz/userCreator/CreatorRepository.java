package com.teamproject.trackers.biz.userCreator;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface CreatorRepository extends JpaRepository<CreatorVO, Long> {
	
	// 유효성 검사
	// 스토어명 중복 확인
	boolean existsByStoreName(String storeName);
	
	@Query(value="SELECT * FROM creator c where c.id = (SELECT u.id FROM user u WHERE u.url = :url)", nativeQuery = true)
	CreatorVO getCreator(@Param("url")String url);
	
}