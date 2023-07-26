package com.sp.app.member;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.dao.CommonDAO;

@Service("member.memberService")
public class MemberServiceImpl implements MemberService {
	@Autowired
	private CommonDAO dao;

	@Override
	public Member loginMember(Map<String, Object> map) {
		Member dto = null;
		
		try {
			dto = dao.selectOne("member.loginMember", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void insertMember(Member dto) throws Exception {
		try {
			dao.insertData("member.insertMember", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void updateLastLogin(String userId) throws Exception {
		try {
			dao.updateData("member.updateLastLogin", userId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void updateMember(Member dto) throws Exception {
		try {
			dao.updateData("member.updateMember", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public Member readMember(Long memberNum) {
		Member dto = null;
		
		try {
			dto = dao.selectOne("member.readMember", memberNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void deleteMember(Long memberNum) throws Exception {
		try {
			dao.updateData("member.deleteMember", memberNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
}
