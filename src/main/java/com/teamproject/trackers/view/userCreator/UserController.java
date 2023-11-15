package com.teamproject.trackers.view.userCreator;

import java.io.File;
import java.io.IOException;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.teamproject.trackers.biz.common.AlertVO;

import com.teamproject.trackers.biz.userCreator.UserService;
import com.teamproject.trackers.biz.userCreator.UserVO;
import com.teamproject.trackers.view.common.CommonController;


@Controller
public class UserController {

	@Autowired
	private UserService userService;
	@Autowired
    private HttpSession session;
	@Autowired
	public CommonController common;
	
	// 모달
	@RequestMapping(value="/signin-modal")
	public String signinModal() {
		return "modal/signin-modal";
	}
	@RequestMapping(value="/signup-modal")
	public String signupModal() {
		return "modal/signup-modal";
	}
	@RequestMapping(value="/store-create-modal")
	public String storeCreateModal(UserVO vo, Model model) {
		vo.setId((long)session.getAttribute("id"));
		model.addAttribute("user", userService.getUser(vo).get());
		
		return "modal/store-create-modal";
	}
	
	
	// 로그아웃
	@RequestMapping(value="/users/logout", method=RequestMethod.POST)
	public String logout(){
		if(session.getAttribute("id") != null) {
			session.invalidate();
			
			common.alert.setStr("로그아웃 되었습니다.");
			common.alert.setPath("/");
			common.alert.setFlag(true);

			return "redirect:/common";
		}
		
		return "redirect:/";
	}
	
	// 로그인
	@RequestMapping(value="/users/signin", method=RequestMethod.POST)
	public String signin(String path, UserVO vo) throws IllegalAccessException{
		if(userService.isUser(vo) != null) {

			session.setAttribute("id", userService.isUser(vo).getId());
			session.setAttribute("user", userService.isUser(vo));
			
			System.out.println("성공");
		}
		
		// 커뮤니티에서 로그인 한 경우 page 파라미터 추가
		if(path.equals("/community/posts")) path += "?page=0&type=all";
		
		return "redirect:"+path;
	}
	
	// 회원가입
	@RequestMapping(value="/users", method=RequestMethod.POST)
	public String insertUser(String path, UserVO vo){
		
		userService.insertUser(vo);
		
		common.alert.setStr("회원가입이 완료되었습니다.");
		common.alert.setPath(path);
		common.alert.setFlag(true);
		
		return "redirect:/common";
	}
	
	// 회원 정보 수정
	@RequestMapping(value="/users", method=RequestMethod.PUT)
	public String updateUser(UserVO vo) {	
		vo.setId((long)session.getAttribute("id"));
		userService.updateUser(vo);
		
		UserVO user = (UserVO) session.getAttribute("user");
		user.setName(vo.getName());
		user.setUrl(vo.getUrl());
		user.setTel(vo.getTel());
		
		common.alert.setStr("회원정보가 수정되었습니다.");
		common.alert.setPath("/users?path=info");
		common.alert.setFlag(true);
		
		return "redirect:/common";
	}
	
	
	// 비밀번호 수정
	@RequestMapping(value="/users/pwd", method=RequestMethod.PUT)
	public String updateUserPwd(UserVO vo) {
		vo.setId((long)session.getAttribute("id"));
		userService.updateUserPwd(vo);
	 
		common.alert.setStr("비밀번호가 변경되었습니다.");
		common.alert.setPath("/users?path=ipwdnfo");
		common.alert.setFlag(true);
		
		return "redirect:/common";
	}

	
	// 회원 탈퇴
	@RequestMapping(value="/users", method=RequestMethod.DELETE)
	public String deleteUser(UserVO vo) {
		vo.setId((long)session.getAttribute("id"));
		
		userService.deleteUser(vo);
		session.invalidate();

		common.alert.setStr("회원탈퇴가 완료되었습니다.");
		common.alert.setPath("/store/main");
		common.alert.setFlag(true);
		
		return "redirect:/common";
	}
	
	// 회원 조회
	@RequestMapping(value = "/users", method=RequestMethod.GET)
	public String getUser(String path, UserVO vo, Model model) {
		vo.setId((long)session.getAttribute("id"));
		model.addAttribute("user", userService.getUser(vo).get());
		
		if(path.equals("info"))	return "/my/user-modify";
		else return "/my/user-pwd-modify";
	}
	
	
	// 유효성 검사
	// 로그인 성공 유무 검사(signin-modal.jsp)
	@RequestMapping(value = "/validation/signin", method=RequestMethod.POST)
	@ResponseBody
	public boolean validateSignin(UserVO vo) {
		return userService.validateSignin(vo);
	}
	
	// 이메일 중복 검사(signup-modal.jsp)
	@RequestMapping(value = "/validation/email", method=RequestMethod.GET)
	@ResponseBody
	public boolean validateEmail(UserVO vo) {
		return userService.validateEmail(vo);
	}
	
	// url 중복 검사(signup-modal.jsp, user-modify.jsp, store-management.jsp)
	@RequestMapping(value = "/validation/url", method=RequestMethod.GET)
	@ResponseBody
	public boolean validateURL(UserVO vo) {
		return userService.validateURL(vo);
	}
	
	// 기존 비밀번호 체크(user-pwd-modify.jsp)
	@RequestMapping(value = "/validation/pwd", method=RequestMethod.POST)
	@ResponseBody
	public boolean validateUserPwd(@RequestParam("old_password") String password, UserVO vo) {
		vo.setId((long)session.getAttribute("id"));

		return (password.equals(userService.getUser(vo).get().getPassword()));
	}
	
	
	//---------------------------------------------------
	// 프로필 
	
	// 프로필&배경 이미지 수정
	@RequestMapping(value="/users/profile-img", method=RequestMethod.PUT)
	public String updateProfileImage(UserVO vo, @RequestParam("folder") String folder, @RequestParam("chooseFile") MultipartFile chooseFile, HttpServletRequest req) throws IllegalStateException, IOException {
		vo = (UserVO) session.getAttribute("user");
		if (!chooseFile.isEmpty()) {
			if(folder.equals("profile")) {			// 프로필 수정
				
				if(!vo.getProfile_img().contains("basic")) {		// 기본 프로필 사진이 아닌 경우 삭제 시도
					deleteFile("profile/", vo.getProfile_img(), req);
				}
				vo.setProfile_img(saveFile(chooseFile, "profile/", vo.getId(), req));			
	
				userService.updateProfileImage(vo);
			}
			else {		// 배경 이미지 수정
				System.out.println("배경이미지: "+vo.getBg_img());
				if(!vo.getBg_img().contains("basic")) {			// 배경 사진이 기본 배경이 아닌 경우 삭제 시도
					deleteFile("background/", vo.getBg_img(), req);
				}
				vo.setBg_img(saveFile(chooseFile, "background/", vo.getId(), req));			
				
				userService.updateBackgorundImage(vo);
			}
		}
		
		return "redirect:/profiles/"+vo.getUrl();
	}
	
	
	
	// 프로필 관련 이미지 저장 로직  
	// 임시로 파일도 일단 여기에 저장
    private String saveFile(MultipartFile file, String type, long id, HttpServletRequest req) throws IllegalStateException, IOException {    	    	
    	String tmpPath = req.getServletContext().getRealPath("/resources/profilefile/");		// 위치 생각해 볼 것
       
    	String original = file.getOriginalFilename();
    	String mime = original.substring(original.indexOf('.'));
    	
    	long now = System.currentTimeMillis(); 
        String fileName = now+"-"+id+mime;		// 저장되는 파일 이름: (날짜-유저아이디.확장자)
        
		File uploadFile = new File(tmpPath+type+fileName);
		file.transferTo(uploadFile);
		
        // 파일 저장하고 파일명 반환
        return "/resources/profilefile/"+type+fileName;
    }
    
    // 프로필 관련 이미지 삭제 로직
    private void deleteFile(String type, String filename, HttpServletRequest req) throws IllegalStateException, IOException {   
    	String tmpPath = req.getServletContext().getRealPath("");		// 위치 생각해 볼 것		

		File deleteFile = new File(tmpPath+filename);
		
		// 파일 삭제
		deleteFile.delete();
    }
}