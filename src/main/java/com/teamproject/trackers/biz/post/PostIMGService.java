package com.teamproject.trackers.biz.post;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
  
@Service
public class PostIMGService {
	
	@Autowired
	@Qualifier("postIMGRepository")
	private PostIMGRepository postIMGRepository;
	
	 
	//작성
		public void insertPostIMG(PostIMGVO vo) throws IllegalStateException, IOException {
			postIMGRepository.save(vo);
		}
	//삭제
		public void deletePostIMG(Long postId) {
			postIMGRepository.deleteByPostId(postId);
		}
	//상세 조회
		public Optional<PostIMGVO> getPostIMG(Long postId) {
			return postIMGRepository.findByPostId(postId);
		}
	//리스트 조회
		public List<PostIMGVO> getPostIMGList(){
			return postIMGRepository.findAll();
		}
		
	// 페이징에 따른 조회
		public List<PostIMGVO> getPImgList(long postId){
			return postIMGRepository.getPImgList(postId);
		}
}
