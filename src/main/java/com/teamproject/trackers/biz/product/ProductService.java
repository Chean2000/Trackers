package com.teamproject.trackers.biz.product;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

@Service
public class ProductService {
	
	private ProductRepository productRepository;
	@Autowired
	private ProductListRepository productlistRepository;
	@Autowired
	private DesignCategoryRepository designCategoryRepository;
	private PageCategoryRepository pageCategoryRepository;	
	private ProductDetailRepository productDetailRepository;
	private CreatorListRepository creatorlistRepository;
	
	@Autowired
	public ProductService(ProductRepository productRepository,
			DesignCategoryRepository designCategoryRepository,
			PageCategoryRepository pageCategoryRepository,
			ProductDetailRepository productDetailRepository,
			CreatorListRepository creatorlistRepository) {
		
		this.productRepository= productRepository;
		this.designCategoryRepository = designCategoryRepository;
		this.pageCategoryRepository = pageCategoryRepository;
		this.productDetailRepository = productDetailRepository;
		this.creatorlistRepository = creatorlistRepository;
	}
	
	
	
	/* p_id 로 특정 상품 조회 */
	public ProductVO getProduct(long pId) {
		return productRepository.findByPid(pId);
	}
	
	/* 파일 이름으로 특정 상품 조회 */
	public ProductVO getProductByFile(String file) {
		return productRepository.findByFile(file);
	}
	
	
	public void insertProduct(ProductVO vo) {
		productRepository.save(vo);
	}

	/* 상품 카테고리 등록 - 디자인 */
	public void insertDesignCategory(DesignCategoryVO vo) {
		System.out.println("디자인객체 pid"+vo.getPid());
		designCategoryRepository.save(vo);
	}
	/* 상품 카테고리 등록 - 페이지 */
	public void insertPageCategory(PageCategoryVO vo) {
		System.out.println("페이지객체 pid"+vo.getPid());
		pageCategoryRepository.save(vo);
	}
	
	/* 상품 디테일 등록 */
	public void insertProductDetail(ProductDetailVO vo) {
		productDetailRepository.save(vo);
	}
	

	
	
	// 상품 전체 조회(검색 x)
	public Page<ProductListVO> getProductList(Pageable pageable) {
		return productlistRepository.findAll(pageable);
	}
	
	// 상품 전체 조회(검색 o)
	public Page<ProductListVO> getSearchProductList(String keyword, Pageable pageable) {
		return productlistRepository.findByPnameContaining(keyword, pageable);
	}

	// 상품 필터링
	public Page<ProductListVO> getCategorList(String category, String keyword, Pageable pageable) {
		
		Page<ProductListVO> list = null;
		
		if(category.equals("whole")) list = productlistRepository.getCategoryWhole(keyword, pageable);
		else if(category.equals("monthly")) list = productlistRepository.getCategoryMonthly(keyword, pageable);
		else if(category.equals("weekly")) list = productlistRepository.getCategoryWeekly(keyword, pageable);
		else if(category.equals("habit")) list = productlistRepository.getCategoryHabit(keyword, pageable);
		else if(category.equals("mood")) list = productlistRepository.getCategoryMood(keyword, pageable);
		else if(category.equals("reading")) list = productlistRepository.getCategoryReading(keyword, pageable);
		else if(category.equals("expense")) list = productlistRepository.getCategoryExpense(keyword, pageable);
		else if(category.equals("study")) list = productlistRepository.getCategoryStudy(keyword, pageable);
		else if(category.equals("sticker")) list = productlistRepository.getCategorySticker(keyword, pageable);
		else if(category.equals("etc")) list = productlistRepository.getCategoryEtc(keyword, pageable);
		else if(category.equals("minimal")) list = productlistRepository.getCategoryMinimal(keyword, pageable);
		else if(category.equals("illustration")) list = productlistRepository.getCategoryIllustration(keyword, pageable);
		else if(category.equals("photo")) list = productlistRepository.getCategoryPhoto(keyword, pageable);
		
		return list;
	}
	
	
	// 스토어(크리에이터) 조회(검색 x)
	public Page<CreatorListVO> getCreatorList(Pageable pageable) {
		return creatorlistRepository.findAll(pageable);

	}
	
	// 스토어(크리에이터) 조회(검색 o)
	public Page<CreatorListVO> getSearchCreatorList(String keyword, Pageable pageable) {
		return creatorlistRepository.findBystoreNameContaining(keyword, pageable);
	}
	
	// 스토어(크리에이터) 대표 상품 리스트
	public List<ProductVO> getCreatorSignatureList(){
		return productRepository.getCreatorSignatureList();
	}
}
