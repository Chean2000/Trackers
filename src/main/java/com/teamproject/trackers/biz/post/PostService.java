package com.teamproject.trackers.biz.post;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.teamproject.trackers.biz.product.ProductListVO;
import com.teamproject.trackers.biz.userCreator.UserRepository;
import com.teamproject.trackers.biz.userCreator.UserService;
import com.teamproject.trackers.biz.userCreator.UserVO;

@Service
public class PostService {
	
	@Autowired
	@Qualifier("postRepository")
	private PostRepository postRepository;
	@Autowired
	private PostInfoListRepository postInfoListRepository;

	   
	//작성  
		public PostVO insertPost(PostVO vo) {
			return postRepository.save(vo);
		}
	//삭제
		public void deletePost(Long postId) {
			postRepository.deleteById(postId);
		}
	//상세 조회
		public Optional<PostVO> getPost(Long postId) {
			return postRepository.findById(postId);
		}
		
		public Optional<UserVO> getUser(Long postId) {
	        Optional<PostVO> postOptional = postRepository.findById(postId);
	        if (postOptional.isPresent()) {
	            PostVO postVO = postOptional.get();
	            return postRepository.findUserByUserId(postVO.getId());
	        }
	        return Optional.empty();
	    }
		
	//리스트 조회
	/*	public ArrayList<PostVO> getPostList(){
			return (ArrayList)postRepository.findAll();
		}*/
		
	//리스트 조회(전체)
	public Page<PostInfoListVO> getPostList(Pageable pageable){
		return postInfoListRepository.findAll(pageable);
	}
	// 리스트 조회(전체+검색)
	public Page<PostInfoListVO> getSearchPostList(String keyword, Pageable pageable){
		return postInfoListRepository.findByContentContaining(keyword, pageable);
	}
	// 리스트 조회(크리에이터+검색)
	public Page<PostInfoListVO> getCreatorPostList(String keyword, Pageable pageable){
		return postInfoListRepository.getCreatorPost(keyword, pageable);
	}
	// 리스트 조회(포스트 타입 선택)
	public Page<PostInfoListVO> getTypeList(String type, long id, String keyword, Pageable pageable){
		
		Page<PostInfoListVO> list = null;

		if(type.equals("follow")) list = postInfoListRepository.getFollowPost(id, keyword, pageable);
		else if(type.equals("like")) list = postInfoListRepository.getLikePost(id, keyword, pageable);
		else if(type.equals("comment")) list = postInfoListRepository.getCommontPost(id, keyword, pageable);
		
		return list;
	}
	
	
	
	/* 특정상품을 태그한 포스트 전체조회 */
	public Page<PostInfoListVO> getTagPostList(long pid, String keyword, Pageable pageable) {
		return postInfoListRepository.getTagPost(pid, keyword, pageable);
	}
	
	/* 회원 포스트 전체조회 */
	public Page<PostInfoListVO> getUserPostList(long id, Pageable pageable) {
		return postInfoListRepository.findAllById(id, pageable);
	}
	
	
	
}

