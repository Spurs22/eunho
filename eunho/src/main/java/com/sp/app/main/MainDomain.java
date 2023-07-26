package com.sp.app.main;

import org.springframework.web.multipart.MultipartFile;

public class MainDomain {
	private Long categoryNum;
	private Long memberNum;
	private String category;
	private Integer enabled;
	
	private Long main_img_num;
	private String main_img_name;
	
	private Long articleNum;
	private String subject;
	private String content;
	private String reg_date;
	private Integer point;
	
	private String article_img_name;
	
	private MultipartFile selectFile;
	
	public String getArticle_img_name() {
		return article_img_name;
	}
	public void setArticle_img_name(String article_img_name) {
		this.article_img_name = article_img_name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public MultipartFile getSelectFile() {
		return selectFile;
	}
	public void setSelectFile(MultipartFile selectFile) {
		this.selectFile = selectFile;
	}
	public Long getCategoryNum() {
		return categoryNum;
	}
	public void setCategoryNum(Long categoryNum) {
		this.categoryNum = categoryNum;
	}
	public Long getMemberNum() {
		return memberNum;
	}
	public void setMemberNum(Long memberNum) {
		this.memberNum = memberNum;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public Integer getEnabled() {
		return enabled;
	}
	public void setEnabled(Integer enabled) {
		this.enabled = enabled;
	}
	public Long getMain_img_num() {
		return main_img_num;
	}
	public void setMain_img_num(Long main_img_num) {
		this.main_img_num = main_img_num;
	}
	public String getMain_img_name() {
		return main_img_name;
	}
	public void setMain_img_name(String main_img_name) {
		this.main_img_name = main_img_name;
	}
	public Long getArticleNum() {
		return articleNum;
	}
	public void setArticleNum(Long articleNum) {
		this.articleNum = articleNum;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public Integer getPoint() {
		return point;
	}
	public void setPoint(Integer point) {
		this.point = point;
	}
	
	
}
