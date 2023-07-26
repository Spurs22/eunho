package com.sp.app.mypage;

import com.sp.app.member.Member;

public interface MyPageService {
   // 사진 등록
   public void insertImage(Member dto, String pathname) throws Exception;
   
   // 사진 삭제
   public void deleteImage(Long memberNum) throws Exception;

}
