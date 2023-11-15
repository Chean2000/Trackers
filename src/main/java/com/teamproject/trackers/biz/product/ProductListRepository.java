package com.teamproject.trackers.biz.product;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ProductListRepository extends JpaRepository<ProductListVO, Long> {
	
	// 베스트 상품 5
	List<ProductListVO> findTop5ByOrderByPopularityDescCreDateDesc();
	
	// 최신 상품 5
	List<ProductListVO> findTop5ByOrderByCreDateDescPidDesc();
	
	
	// 카테고리 분류 x, 검색 o
	Page<ProductListVO> findByPnameContaining(String keyword, Pageable pageable);
	
	// 카테고리 분류 o, 검색 o/x
	@Query(value = "SELECT * FROM productlist p WHERE p.whole=1 and p.p_name like %:keyword%", nativeQuery = true)
	Page<ProductListVO> getCategoryWhole(@Param("keyword") String keyword, Pageable pageable);
	
	@Query(value = "SELECT * FROM productlist p WHERE p.monthly=1 and p.p_name like %:keyword%", nativeQuery = true)
	Page<ProductListVO> getCategoryMonthly(@Param("keyword") String keyword, Pageable pageable);
	
	@Query(value = "SELECT * FROM productlist p WHERE p.weekly=1 and p.p_name like %:keyword%", nativeQuery = true)
	Page<ProductListVO> getCategoryWeekly(@Param("keyword") String keyword, Pageable pageable);
	
	@Query(value = "SELECT * FROM productlist p WHERE p.habit=1 and p.p_name like %:keyword%", nativeQuery = true)
	Page<ProductListVO> getCategoryHabit(@Param("keyword") String keyword, Pageable pageable);
	
	@Query(value = "SELECT * FROM productlist p WHERE p.mood=1 and p.p_name like %:keyword%", nativeQuery = true)
	Page<ProductListVO> getCategoryMood(@Param("keyword") String keyword, Pageable pageable);
	
	@Query(value = "SELECT * FROM productlist p WHERE p.reading=1 and p.p_name like %:keyword%", nativeQuery = true)
	Page<ProductListVO> getCategoryReading(@Param("keyword") String keyword, Pageable pageable);
	
	@Query(value = "SELECT * FROM productlist p WHERE p.expense=1 and p.p_name like %:keyword%", nativeQuery = true)
	Page<ProductListVO> getCategoryExpense(@Param("keyword") String keyword, Pageable pageable);
	
	@Query(value = "SELECT * FROM productlist p WHERE p.study=1 and p.p_name like %:keyword%", nativeQuery = true)
	Page<ProductListVO> getCategoryStudy(@Param("keyword") String keyword, Pageable pageable);
	
	@Query(value = "SELECT * FROM productlist p WHERE p.sticker=1 and p.p_name like %:keyword%", nativeQuery = true)
	Page<ProductListVO> getCategorySticker(@Param("keyword") String keyword, Pageable pageable);
	
	@Query(value = "SELECT * FROM productlist p WHERE p.etc=1 and p.p_name like %:keyword%", nativeQuery = true)
	Page<ProductListVO> getCategoryEtc(@Param("keyword") String keyword, Pageable pageable);
	
	@Query(value = "SELECT * FROM productlist p WHERE p.minimal=1 and p.p_name like %:keyword%", nativeQuery = true)
	Page<ProductListVO> getCategoryMinimal(@Param("keyword") String keyword, Pageable pageable);
	
	@Query(value = "SELECT * FROM productlist p WHERE p.illustration=1 and p.p_name like %:keyword%", nativeQuery = true)
	Page<ProductListVO> getCategoryIllustration(@Param("keyword") String keyword, Pageable pageable);
	
	@Query(value = "SELECT * FROM productlist p WHERE p.photo=1 and p.p_name like %:keyword%", nativeQuery = true)
	Page<ProductListVO> getCategoryPhoto(@Param("keyword") String keyword, Pageable pageable);
	
	
	
	
	// 크리에이터별 상품 전체조회
	Page<ProductListVO> findAllById(long id, Pageable pageable);
	
	
}