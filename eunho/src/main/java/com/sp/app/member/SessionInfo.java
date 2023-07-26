package com.sp.app.member;

// 세션에 저장할 정보(아이디, 이름, 권한 등)
public class SessionInfo {
	private Long memberNum;
	private String userId;
	private String name;
	
	public Long getMemberNum() {
		return memberNum;
	}
	public void setMemberNum(Long memberNum) {
		this.memberNum = memberNum;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

}
