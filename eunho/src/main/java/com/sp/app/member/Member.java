package com.sp.app.member;

import org.springframework.web.multipart.MultipartFile;

public class Member {
	private Long memberNum;
	private String name;
	private String birth;
	private String userId;
	private String userPwd;
	private String reg_date;
	private String last_login;
	
	private Long main_img_num;
	private String main_img_name;
	
	private MultipartFile selectFile;
	
	public MultipartFile getSelectFile() {
		return selectFile;
	}
	public void setSelectFile(MultipartFile selectFile) {
		this.selectFile = selectFile;
	}
	public Long getMemberNum() {
		return memberNum;
	}
	public void setMemberNum(Long memberNum) {
		this.memberNum = memberNum;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPwd() {
		return userPwd;
	}
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getLast_login() {
		return last_login;
	}
	public void setLast_login(String last_login) {
		this.last_login = last_login;
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
	
}
