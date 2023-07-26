package com.sp.app.member;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sp.app.main.MainDomain;
import com.sp.app.main.MainService;

@Controller("member.memberController")
@RequestMapping("/member/*")
public class MemberController {
	@Autowired
	private MemberService service;
	
	@Autowired
	private MainService mainService;
	
	@RequestMapping(value = "member", method = RequestMethod.GET)
	public String memberForm(Model model) {
		model.addAttribute("mode", "member");
		return ".member.member";
	}

	@RequestMapping(value = "member", method = RequestMethod.POST)
	public String memberSubmit(Member dto, final RedirectAttributes reAttr, Model model) {

		try {
			service.insertMember(dto);
		} catch (DuplicateKeyException e) {
			// 기본키 중복에 의한 제약 조건 위반
			model.addAttribute("mode", "member");
			model.addAttribute("message", "아이디 중복으로 회원가입이 실패했습니다.");
			return ".member.member";
		} catch (DataIntegrityViolationException e) {
			// 데이터형식 오류, 참조키, NOT NULL 등의 제약조건 위반
			model.addAttribute("mode", "member");
			model.addAttribute("message", "제약 조건 위반으로 회원가입이 실패했습니다.");
			return ".member.member";
		} catch (Exception e) {
			model.addAttribute("mode", "member");
			model.addAttribute("message", "회원가입이 실패했습니다.");
			return ".member.member";
		}

		StringBuilder sb = new StringBuilder();
		sb.append(dto.getName() + "님의 회원가입이 완료되었습니다.<br>");
		sb.append("메인화면으로 이동하여 로그인 바랍니다.<br>");

		// 리다이렉트된 페이지에 값 넘기기
		reAttr.addFlashAttribute("message", sb.toString());
		reAttr.addFlashAttribute("title", "회원 가입");

		return "redirect:/member/complete";
	}

	@RequestMapping(value = "complete")
	public String complete(@ModelAttribute("message") String message) throws Exception {

		return ".member.complete";
	}

	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String loginSubmit(
				@RequestParam String userId,
				@RequestParam String userPwd, 
				HttpSession session,
				Model model) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("userId", userId);
		map.put("userPwd", userPwd);
		
		try {
			Member dto = service.loginMember(map);
			
			if(dto == null) {
				model.addAttribute("message", "아이디 또는 패스워드가 일치하지 않습니다.");
				return ".home";
			}
			
			// 세션에 로그인 정보 저장
			SessionInfo info = new SessionInfo();
			info.setMemberNum(dto.getMemberNum());
			info.setUserId(dto.getUserId());
			info.setName(dto.getName());

			session.setMaxInactiveInterval(30 * 60); // 세션유지시간 30분, 기본:30분

			session.setAttribute("member", info);

			// 로그인 이전 URI로 이동
			String uri = (String) session.getAttribute("preLoginURI");
			session.removeAttribute("preLoginURI");
			if (uri == null) {
				uri = "redirect:/";
			} else {
				uri = "redirect:" + uri;
			}
			
			service.updateLastLogin(info.getUserId());
			
			MainDomain main = mainService.startCategory(info.getMemberNum());
			
			Member dto2 = service.readMember(info.getMemberNum());
			
			List<MainDomain> categoryList = new ArrayList<MainDomain>();
			categoryList = mainService.categoryList(info.getMemberNum());
			
			List<MainDomain> articleList = new ArrayList<MainDomain>();
			articleList = mainService.articleList(main.getCategoryNum());

			model.addAttribute("articleList", articleList);
			model.addAttribute("main", main);
			model.addAttribute("dto", dto2);
			model.addAttribute("categoryList", categoryList);
			
		} catch (Exception e) {
		}
		

		return ".main.main";
	}

	@RequestMapping(value = "logout")
	public String logout(HttpSession session) {
		// 세션에 저장된 정보 지우기
		session.removeAttribute("member");

		// 세션에 저장된 모든 정보 지우고, 세션초기화
		session.invalidate();

		return ".home";
	}
	
	@GetMapping("update")
	public String updateForm(HttpSession session, Model model) {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		Member dto = service.readMember(info.getMemberNum());
		
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		
		return ".member.member";
	}
	
	@PostMapping("update")
	public String updateSubmit(Member dto) {
		
		try {
			service.updateMember(dto);
		} catch (Exception e) {
		}
		
		return "redirect:/mypage/myhome";
	}
	
	@GetMapping("deleteMember")
	public String deleteMember(HttpSession session) {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			service.deleteMember(info.getMemberNum());
		} catch (Exception e) {
		}
		
		// 세션에 저장된 정보 지우기
		session.removeAttribute("member");
		
		// 세션에 저장된 모든 정보 지우고, 세션초기화
		session.invalidate();

		return ".home";
	}


}