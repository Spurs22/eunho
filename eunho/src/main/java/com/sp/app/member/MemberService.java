package com.sp.app.member;

import java.util.Map;

public interface MemberService {
	// 로그인
	public Member loginMember(Map<String, Object> map);
	
	// 회원가입
	public void insertMember(Member dto) throws Exception;
	
	// 마지막 로그인 업데이트
	public void updateLastLogin(String userId) throws Exception;
	
	// 회원정보 수정
	public void updateMember(Member dto) throws Exception;
	
	// 회원정보 불러오기
	public Member readMember(Long memberNum);

	// 회원 탈퇴
	public void deleteMember(Long memberNum) throws Exception;
	
}
