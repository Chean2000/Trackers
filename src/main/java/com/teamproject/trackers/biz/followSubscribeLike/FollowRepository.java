package com.teamproject.trackers.biz.followSubscribeLike;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;


public interface FollowRepository extends JpaRepository<FollowVO, FollowId> {

	
	
	// 팔로우 수 가져오기 
	@Query(value = "SELECT COUNT(f.from_id) FROM follow f WHERE f.to_id = (SELECT id FROM user WHERE url = :url)",
			countQuery = "SELECT COUNT(f.from_id) FROM follow f WHERE f.to_id = (SELECT id FROM user WHERE url = :url)",
			nativeQuery = true)
	long Follower(@Param("url") String url);
	
	// follow 가져오기
	@Query(value = "SELECT f.from_id, f.to_id FROM follow f WHERE f.to_id = (SELECT u.id FROM user u WHERE u.url = :url) AND f.from_id = (SELECT u.id FROM user u WHERE u.id = :id)",nativeQuery = true)
	public FollowVO followT(@Param("url") String url, @Param("id") long id);
	
	// 팔로우 정보 수정 -구독한 사람의 정보를 제거하는거(팔로우 취소)
	//@Query(value="DELETE FROM follow WHERE from_id = :fromid  and to_id = :toid", nativeQuery = true)
	//void deleteFollow(@Param("fromid") long fromid, @Param("toid") long toid);
	
	
	// 사용자별 팔로우 리스트
	@Query(value = "SELECT u.url, u.profile_img, u.name FROM follow f, user u WHERE (:id is null or f.from_id=:id) AND f.to_id=u.id",nativeQuery = true)
	public List<Object[]> getFollowList(@Param("id") long id);
	
	
}
