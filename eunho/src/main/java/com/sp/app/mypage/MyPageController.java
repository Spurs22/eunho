package com.sp.app.mypage;

import java.io.File;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sp.app.main.MainDomain;
import com.sp.app.main.MainService;
import com.sp.app.member.Member;
import com.sp.app.member.MemberService;
import com.sp.app.member.SessionInfo;

@Controller("mypage.myPageController")
@RequestMapping("/mypage/*")
public class MyPageController {
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MyPageService myPageService;
	
	@Autowired MainService mainService;
	
	@RequestMapping("myhome")
	public String myhome(
			HttpSession session,
			Model model
			) {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		Member dto = memberService.readMember(info.getMemberNum());
		
		MainDomain main = mainService.startCategory(info.getMemberNum());
		
		model.addAttribute("main", main);
		model.addAttribute("dto", dto);
		
		return ".mypage.mypage";
	}
	
	@PostMapping("addImage")
	public String addImage(HttpSession session,
			Member dto
			) throws Exception {
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "images";
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		dto.setMemberNum(info.getMemberNum());
		
		try {
			myPageService.insertImage(dto, pathname);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/mypage/myhome";
	}
	
	@GetMapping("deleteImage")
	public String deleteImage(HttpSession session
			) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			myPageService.deleteImage(info.getMemberNum());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/mypage/myhome";
	}
}
