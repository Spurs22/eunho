package com.sp.app.main;

import java.util.List;
import java.util.Map;

public interface MainService {
	
	// 카테고리 추가
	public void addCategory(Map<String, Object> map) throws Exception;
	
	// 카테고리 삭제
	public void deleteCategory(Long categoryNum) throws Exception;
	
	// 마지막 카테고리
	public Long lastCategory(Long memberNum);
	
	// 카테고리 리스트
	public List<MainDomain> categoryList(Long memberNum);
	
	// 카테고리 정보
	public MainDomain categoryInfo(Long categoryNum);
	
	// 첫번째 카테고리
	public MainDomain startCategory(Long memberNum);
	
	// 글 저장
	public void writeArticle(MainDomain dto, String pathname) throws Exception;
	
	// 글 수정
	public void updateArticle(MainDomain dto, String pathname) throws Exception;
	
	// 글 삭제
	public void deleteArticle(Long articleNum) throws Exception;
	
	// 글 리스트
	public List<MainDomain> articleList(Long categoryNum);
	
	// 글 상세 정보
	public MainDomain article(Map<String, Object> map);
	
	// 상단고정
	public boolean insertLike(Map<String, Object> map) throws Exception;
	
	// 상단고정 여부
	public boolean isLike(Map<String, Object> map);
}
