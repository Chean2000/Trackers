package com.teamproject.trackers.biz.product;

import java.awt.print.Pageable;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.teamproject.trackers.biz.purchase.PurchaseVO;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface ProductRepository extends JpaRepository<ProductVO, Long> {
	
	
	// p_id로 특정 상품 조회
	ProductVO findByPid(long pid);
	
	// 파일이름으로 특정 상품 조회
	ProductVO findByFile(String file);
	
	// 크리에이터별 대표상품 조회
	@Query(value = "SELECT * FROM products p WHERE p.id=:id and p.signature=1 ORDER BY p.cre_date", nativeQuery = true)
	List<ProductVO> getCreatorSignatureList(@Param("id") long id);	
	
	// 인기 크리에이터 대표 상품 조회
	ProductVO findTopByIdAndSignatureOrderByRatingDescCreDateDesc(long id, boolean signature);
	
	//-------------------------------------정희	
		// 상품 삭제
	    void deleteProductById(long pid);
	    
	    // 판매자 ID로 상품 목록 조회
		@Query(value = "SELECT * FROM products p WHERE p.id=:sellerId", nativeQuery = true)
		List<ProductVO> findBySellerId(@Param("sellerId") long sellerId);
		
		// 업데이트 메서드 추가
		ProductVO save(ProductVO product);
		
		// 상품 수정
		ProductVO getProductById(long p_id);
		
		// 상품 정보 수정
	    @Modifying
	    @Transactional
	    @Query("UPDATE ProductVO p SET p.p_name = :p_name, p.price = :price, p.thumbnail = :thumbnail, p.file = :file WHERE p.pid = :pid")
	    void updateProduct(@Param("pid") long pid, @Param("p_name") String p_name, @Param("price") int price, @Param("thumbnail") String thumbnail, @Param("file") String file);


}