package com.teamproject.trackers.biz.reviewInquiry;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.teamproject.trackers.biz.product.CreatorListRepository;
import com.teamproject.trackers.biz.product.ProductListRepository;
import com.teamproject.trackers.biz.product.ProductPageRepository;
import com.teamproject.trackers.biz.product.ProductPageVO;
import com.teamproject.trackers.biz.product.ProductRepository;
import com.teamproject.trackers.biz.product.categoryDetail.DesignCategoryRepository;
import com.teamproject.trackers.biz.product.categoryDetail.PageCategoryRepository;
import com.teamproject.trackers.biz.product.categoryDetail.ProductDetailRepository;


@Service
public class InquiryService {

	private InquiryRepository inquiryRepository;
	private ProductPageRepository productPageRepository;
	
	@Autowired
	public InquiryService(InquiryRepository inquiryRepository,
			ProductPageRepository productPageRepository) {
		
		this.inquiryRepository = inquiryRepository;
		this.productPageRepository = productPageRepository;
	}

	// 상품 정보 조회
	public ProductPageVO getProductInfo(long pid) {
		return productPageRepository.findByPid(pid);
	}
	
	// 상품문의 작성
	public void insertInquiry(InquiryVO vo) {
		inquiryRepository.save(vo);
	}
	
	// 상품 상세 페이지 상품 문의 조회
	public List<InquiryVO> getInquiryList(long pid){
		return inquiryRepository.findAllByPidOrderByCreDateDesc(pid);
	}
	
	// 상품 문의 상세 내용 조회
	public Optional<InquiryVO> getInquiry(long inquiry_id){
		return inquiryRepository.findById(inquiry_id);
	}
	
	// 사용자별 상품 문의 조회
	public Page<InquiryVO> getUserInquiryList(long id, Pageable pageable){
		return inquiryRepository.findAllById(id, pageable);
	}
	
	// 크리에이터별 상품 문의 조회
	public Page<InquiryVO> getCreatorInquiryList(long cid, Pageable pageable){
		return inquiryRepository.findAllByCId(cid, pageable);
	}
	
	// 크리에이터 상품 문의 답변 저장
	public void updateInquiryComment(InquiryVO vo) {
		inquiryRepository.updateInquiryComment(vo.getAnswer(), vo.getAnswer_date(), vo.getInquiryId());
	}
}
