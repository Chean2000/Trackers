package com.teamproject.trackers.biz.profile;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.teamproject.trackers.biz.userCreator.UserVO;

@Repository("profileRepository")
public interface ProfileRepository extends JpaRepository<UserVO, Long> {
	
	//작성
	//public UserVO save(UserVO vo);
	
	//이름,유뷰브,인스타,배경&프로필 이미지
	public UserVO findByUrl(String url);
	

	


}
