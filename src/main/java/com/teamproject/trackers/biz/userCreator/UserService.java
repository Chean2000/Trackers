package com.teamproject.trackers.biz.userCreator;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {
	
	@Autowired
	private UserRepository userRepository;
	
	// 로그인
	public UserVO isUser(UserVO vo) {		
		return userRepository.findByEmailAndPassword(vo.getEmail(), vo.getPassword());
	}
	
	// 회원 조희
	public Optional<UserVO> getUser(UserVO vo) {
		return userRepository.findById(vo.getId());
	}
	
	// 회원가입(회원 추가)
	public void insertUser(UserVO vo) {
		userRepository.save(vo);
	}
	
	// 회원 정보 수정
	public void updateUser(UserVO vo) {
		userRepository.updateUser(vo.getId(), vo.getName(), vo.getTel(), vo.getUrl(), vo.getInstagram(), vo.getYoutube());
	}
	
	// 비밀번호 수정
	public void updateUserPwd(UserVO vo) {
		userRepository.updateUserPwd(vo.getId(), vo.getPassword());
	}
	
	// 회원 탈퇴(회원 삭제)
	public void deleteUser(UserVO vo) {
		userRepository.deleteById(vo.getId());
	}
	
	
	// 유효성
	// 로그인 성공 유무
	public boolean validateSignin(UserVO vo) {
		return userRepository.existsByEmailAndPassword(vo.getEmail(), vo.getPassword());
	}
	
	// 이메일(중복 체크)
	public boolean validateEmail(UserVO vo) {
		return userRepository.existsByEmail(vo.getEmail());
	}
	
	// url(중복 체크)
	public boolean validateURL(UserVO vo) {		
		return userRepository.existsByUrl(vo.getUrl());
	}
	
	//----------------------------------------------
	// 프로필
	
	// 프로필 이미지 업로드
	public void updateProfileImage(UserVO vo) {
		userRepository.updateProfileImg(vo.getId(), vo.getProfile_img());
	}
	
	// 배경 이미지 업로드
	public void updateBackgorundImage(UserVO vo) {
		userRepository.updateBackgroundImg(vo.getId(), vo.getBg_img());
	}
}
