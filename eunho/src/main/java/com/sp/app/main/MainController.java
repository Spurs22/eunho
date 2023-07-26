package com.sp.app.main;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.member.Member;
import com.sp.app.member.MemberService;
import com.sp.app.member.SessionInfo;

@Controller("main.mainController")
@RequestMapping("/main/*")
public class MainController {
	@Autowired
	private MainService mainService;
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("main")
	public String main(
			Model model,
			HttpSession session,
			@RequestParam(value="categoryNum", required = false) Long categoryNum,
			@RequestParam(value = "page", defaultValue = "1") int current_page
			) {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(info == null) {
			return ".home";
		}
		
		int size = 10;
		int total_page = 0;
		int dataCount = 0;
		
		MainDomain main = null;
		
		List<MainDomain> categoryList = new ArrayList<MainDomain>();
		categoryList = mainService.categoryList(info.getMemberNum());
		
		if(categoryNum == null) {
			main = mainService.startCategory(info.getMemberNum());
		} else {
			main = mainService.categoryInfo(categoryNum);
		}
		Member dto = memberService.readMember(info.getMemberNum());
		
		List<MainDomain> articleList = new ArrayList<MainDomain>();
		articleList = mainService.articleList(categoryNum);

		model.addAttribute("articleList", articleList);
		model.addAttribute("main", main);
		model.addAttribute("dto", dto);
		model.addAttribute("categoryList", categoryList);
		
		return ".main.main";
	}
	
	@PostMapping("addCategory")
	public String addCategory(
			@RequestParam("category") String category,
			HttpSession session
			) {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("category", category);
		map.put("memberNum", info.getMemberNum());
		
		Long categoryNum = 0L;
		
		try {
			mainService.addCategory(map);
			categoryNum = mainService.lastCategory(info.getMemberNum());
		} catch (Exception e) {
		}
		
		return "redirect:/main/main?categoryNum=" + categoryNum;
	}
	
	@GetMapping("deleteCategory")
	public String deleteCategory(
			@RequestParam("categoryNum") Long categoryNum,
			HttpSession session
			) {
		
		try {
			mainService.deleteCategory(categoryNum);
		} catch (Exception e) {
		}
		
		return "redirect:/main/main";
	}
	
	@GetMapping("write")
	public String writeForm(@RequestParam("categoryNum") Long categoryNum,
			Model model) {
		
		MainDomain main = mainService.categoryInfo(categoryNum);
		
		model.addAttribute("main", main);
		model.addAttribute("mode", "write");
		model.addAttribute("categoryNum", categoryNum);
		
		return ".main.write";
	}
	
	@PostMapping("write")
	public String writeSubmit(
			MainDomain dto,
			HttpSession session
			) {
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "images";
		
		try {
			mainService.writeArticle(dto, pathname);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/main/main?categoryNum=" + dto.getCategoryNum();
	}
	
	@GetMapping("article")
	public String article(Model model,
			@RequestParam("articleNum") Long articleNum
			) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("articleNum", articleNum);
		
		MainDomain dto = mainService.article(map);
		
		boolean likeStatus = false;
		
		if(dto.getPoint() == 1) {
			likeStatus = true;
		}
		
		System.out.println(likeStatus+ "포인트" + dto.getPoint());
		
		model.addAttribute("likeStatus", likeStatus);
		model.addAttribute("main", dto);
		model.addAttribute("dto", dto);
		
		return ".main.article";
	}
	
	@GetMapping("update")
	public String updateArticle(@RequestParam("articleNum") Long articleNum, Model model) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("articleNum", articleNum);
		
		MainDomain dto = mainService.article(map);
		
		model.addAttribute("main", dto);
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		
		return ".main.write";
	}
	
	@PostMapping("update")
	public String updateSubmit(MainDomain dto, HttpSession session) {
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "images";
		
		try {
			mainService.updateArticle(dto, pathname);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/main/article?articleNum=" + dto.getArticleNum();
	}
	
	@GetMapping("delete")
	public String deleteArticle(@RequestParam("articleNum") Long articleNum,
			@RequestParam("categoryNum") Long categoryNum
			) {
		
		try {
			mainService.deleteArticle(articleNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/main/main?categoryNum=" + categoryNum;
	}
	
	@PostMapping("like")
	@ResponseBody
	public Map<String, Object> like (
			HttpSession session, 
			HttpServletRequest req,
			Model model) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		Long articleNum = Long.parseLong(req.getParameter("articleNum"));
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("articleNum", articleNum);
		
		boolean state = mainService.insertLike(map);
		
		resultMap.put("state", state);
		
		return resultMap;
		
	}

}
