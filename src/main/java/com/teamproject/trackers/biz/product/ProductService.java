package com.teamproject.trackers.biz.product;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.teamproject.trackers.biz.product.categoryDetail.DesignCategoryRepository;
import com.teamproject.trackers.biz.product.categoryDetail.DesignCategoryVO;
import com.teamproject.trackers.biz.product.categoryDetail.PageCategoryRepository;
import com.teamproject.trackers.biz.product.categoryDetail.PageCategoryVO;
import com.teamproject.trackers.biz.product.categoryDetail.ProductDetailRepository;
import com.teamproject.trackers.biz.product.categoryDetail.ProductDetailVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ProductService {
	
	private ProductRepository productRepository;
	private ProductListRepository productlistRepository;
	private DesignCategoryRepository designCategoryRepository;
	private PageCategoryRepository pageCategoryRepository;	
	private ProductDetailRepository productDetailRepository;
	private CreatorListRepository creatorlistRepository;
	private ProductPageRepository productPageRepository;
	
	@Autowired
	public ProductService(ProductRepository productRepository,
			ProductListRepository productlistRepository,
			DesignCategoryRepository designCategoryRepository,
			PageCategoryRepository pageCategoryRepository,
			ProductDetailRepository productDetailRepository,
			CreatorListRepository creatorlistRepository,
			ProductPageRepository productPageRepository) {
		
		this.productRepository= productRepository;
		this.productlistRepository = productlistRepository;
		this.designCategoryRepository = designCategoryRepository;
		this.pageCategoryRepository = pageCategoryRepository;
		this.productDetailRepository = productDetailRepository;
		this.creatorlistRepository = creatorlistRepository;
		this.productPageRepository = productPageRepository;
	}
	
	
	/* st-main 베스트 상품 조회 */
	public List<ProductListVO> getBestProduct() {
		return productlistRepository.findTop5ByOrderByPopularityDescCreDateDesc();
	}
	
	/* st-main 최신 상품 조회 */
	public List<ProductListVO> getRecentProduct() {
		return productlistRepository.findTop5ByOrderByCreDateDescPidDesc();
	}
	
	/* st-main 인기 크리에이터 조회 */
	public List<CreatorListVO> getBestCreator() {
		return creatorlistRepository.findTop5ByOrderByPopularityDescSaleDesc();
	}
	
	/* st-main 인기 크리에이터 대표 상품 조회 */
	public ProductVO getBestSignature(long id) {
		return productRepository.findTopByIdAndSignatureOrderByRatingDescCreDateDesc(id, true);
	}
	
	
	/* p_id 로 특정 상품 조회 */
	public ProductVO getProduct(long pId) {
		return productRepository.findByPid(pId);
	}
	
	/* 파일 이름으로 특정 상품 조회 */
	public ProductVO getProductByFile(String file) {
		return productRepository.findByFile(file);
	}
	
	/* p_id 로 상품 디테일 조회 */
	public ProductDetailVO getProductDetail(long pid) {
		return productDetailRepository.findByPid(pid);
	}
	
	/* p_id 로 상품 상세정보 모두 조회 */
	public ProductPageVO getProductPage(long pid) {
		return productPageRepository.findByPid(pid);
	}
	
	
	
	/* 상품 등록 */
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
	

	
	/* 상품 전체 조회(검색 x) */
	public Page<ProductListVO> getProductList(Pageable pageable) {
		return productlistRepository.findAll(pageable);
	}
	
	/* 상품 전체 조회(검색 o) */
	public Page<ProductListVO> getSearchProductList(String keyword, Pageable pageable) {
		return productlistRepository.findByPnameContaining(keyword, pageable);
	}

	/* 상품 필터링 */
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
	
	
	/* 스토어(크리에이터) 조회(검색 x) */
	public Page<CreatorListVO> getCreatorList(Pageable pageable) {
		return creatorlistRepository.findAll(pageable);

	}
	
	/* 스토어(크리에이터) 조회(검색 o) */
	public Page<CreatorListVO> getSearchCreatorList(String keyword, Pageable pageable) {
		return creatorlistRepository.findBystoreNameContaining(keyword, pageable);
	}
	
	/* 스토어(크리에이터) 대표 상품 리스트 */
	public List<ProductVO> getCreatorSignatureList(long id){
		return productRepository.getCreatorSignatureList(id);
	}
	
	
	/* 크리에이터 상품 전체조회 */
	public Page<ProductListVO> getCreatorProductList(long id, Pageable pageable) {
		return productlistRepository.findAllById(id, pageable);
	}
	
	//-----------------------------------------------정희
	
		/* 상품 삭제 */
		public void deleteProduct(long p_id) {
	        // 상품 삭제 로직을 여기에 작성합니다.
	        // 상품 ID로 상품을 조회하고, 조회된 상품을 삭제합니다.
	        productRepository.deleteById(p_id);
	    }
		
		// 판매자 ID로 상품 목록 조회
	    public List<ProductVO> getProductListBySellerId(long id) {
	        return productRepository.findBySellerId(id);
	    }

	    /* 삭제된 상품 ID 목록 조회 */
	    public List<Long> getDeletedProductIds() {
	        List<Long> deletedProductIds = new ArrayList<>();
	        // 삭제된 상품 ID 목록 조회 로직을 추가합니다.
	        // 예를 들어, 삭제 상태를 나타내는 컬럼을 가진 테이블에서 삭제 상태인 상품들의 ID를 조회하는 쿼리를 실행합니다.
	        // 또는 삭제 상태를 나타내는 특정 필드를 가진 객체들을 가져와서 해당 ID들을 추출합니다.
	        // 이 예시에서는 빈 리스트를 반환합니다. 실제 로직에 맞게 수정해주세요.

	        // 예시로 직접 목록을 추가하는 코드입니다.
	        deletedProductIds.add(1L);
	        deletedProductIds.add(2L);
	        deletedProductIds.add(3L);
	        // ... 삭제된 상품 ID들을 추가로 조회하는 로직을 구현합니다 ...

	        return deletedProductIds;
	    }

	    
	    // 상품 정보 조회
	    public ProductVO getProductById(long p_id) {
	        return productRepository.findByPid(p_id);
	    }
	    	    
	    // 상품 정보 수정
	    public void updateProduct(ProductVO product) {
	        ProductVO existingProduct = productRepository.findByPid(product.getPid());
	        if (existingProduct != null) {
	            existingProduct.setP_name(product.getP_name());
	            existingProduct.setPrice(product.getPrice());
	            existingProduct.setThumbnail(product.getThumbnail());
	            existingProduct.setFile(product.getFile());
	            productRepository.save(existingProduct);
	        } else {
	            // 해당 pid의 상품이 존재하지 않을 경우 예외 처리
	            throw new RuntimeException("존재하지 않는 상품입니다.");
	        }
	    }
		
		
	    
	// 대표상품 등록/해제
	public void updateProductSignature(ProductVO vo) {
		productRepository.save(vo);
	}
}
