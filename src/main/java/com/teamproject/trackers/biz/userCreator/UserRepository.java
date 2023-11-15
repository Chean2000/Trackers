package com.teamproject.trackers.biz.userCreator;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

public interface UserRepository extends JpaRepository<UserVO, Long> {
	
	
	// 로그인
	UserVO findByEmailAndPassword(String email, String password);

	
	// 이름, 전화번호, url, sns url 수정
	@Modifying(clearAutomatically = true)
	@Transactional
	@Query(value = "UPDATE user u SET u.name = :name, u.tel = :tel, u.url = :url, u.instagram = :instagram, u.youtube = :youtube WHERE u.id = :id", nativeQuery = true)
	void updateUser(@Param("id")long id, @Param("name")String name, @Param("tel")String tel, @Param("url")String url, @Param("instagram")String instagram, @Param("youtube")String youtube);
	
	// 비밀번호 수정
	@Modifying(clearAutomatically = true)
	@Transactional
	@Query(value = "UPDATE user u SET u.password = :password WHERE u.id = :id", nativeQuery = true)
	void updateUserPwd(@Param("id")long id, @Param("password")String pwd);

	// 유효성 검사
	// 로그인 성공 유무
	boolean existsByEmailAndPassword(String email, String password);
	
	// 이메일 중복 확인
	boolean existsByEmail(String email);
	
	// url 중복 확인
	boolean existsByUrl(String url);
	
	
	//------------------------------------------
	// 프로필
	
	// 프로필 이미지 업로드
	@Modifying(clearAutomatically = true)
	@Transactional
	@Query(value = "UPDATE user u SET u.profile_img = :profile_img WHERE u.id = :id", nativeQuery = true)
	void updateProfileImg(@Param("id")long id, @Param("profile_img")String profile_img);
	
	// 배경 이미지 업로드
	@Modifying(clearAutomatically = true)
	@Transactional
	@Query(value = "UPDATE user u SET u.bg_img = :bg_img WHERE u.id = :id", nativeQuery = true)
	void updateBackgroundImg(@Param("id")long id, @Param("bg_img")String bg_img);

}