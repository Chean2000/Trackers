package com.teamproject.trackers.biz.followSubscribeLike;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class FollowService {

	@Autowired
	private FollowRepository followRepository;

	
	public Object Follower(String url) {
		return (long) followRepository.Follower(url);
	}
	
	public FollowVO followT(String url, long id) {
		return followRepository.followT(url,id);
	}
	
	public void insertFollower(FollowVO vo) {
		followRepository.save(vo);
	}

	public void deleteFollower(FollowVO vo) {
		followRepository.delete(vo);
	}

	// 사용자별 팔로우 리스트
	public List<Object[]> getfollowList(long id){
		return followRepository.getFollowList(id);
	}

}
