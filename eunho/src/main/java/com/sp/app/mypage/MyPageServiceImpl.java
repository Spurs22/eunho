package com.sp.app.mypage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.FileManager;
import com.sp.app.common.dao.CommonDAO;
import com.sp.app.member.Member;

@Service("mypage.myPageService")
public class MyPageServiceImpl implements MyPageService {

	@Autowired
	private CommonDAO dao;

	@Autowired
	private FileManager filemanager;

	@Override
	public void insertImage(Member dto, String pathname) throws Exception {
		try {
			String imgFileName = filemanager.doFileUpload(dto.getSelectFile(), pathname);
			if (imgFileName != null) {
				dto.setMain_img_name(imgFileName);
			}

			dao.deleteData("mypage.deleteImage", dto.getMemberNum());
			dao.insertData("mypage.insertImage", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

	}

	@Override
	public void deleteImage(Long memberNum) throws Exception {
		try {
			dao.deleteData("mypage.deleteImage", memberNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

	}

}
