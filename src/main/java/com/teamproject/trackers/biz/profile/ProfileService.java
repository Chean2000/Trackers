package com.teamproject.trackers.biz.profile;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.teamproject.trackers.biz.userCreator.UserVO;

@Service
public class ProfileService {
	
	@Autowired
	@Qualifier("profileRepository")
	private ProfileRepository profileRepository;
	
	// update
	public UserVO insertProfile(UserVO vo) {
		return profileRepository.save(vo);
	}
	
	// 조회 
	public UserVO getUser(String url){
		//return profileRepository.test(url);
		return profileRepository.findByUrl(url);
	}


}
