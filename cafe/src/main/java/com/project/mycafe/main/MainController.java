package com.project.mycafe.main;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.mycafe.admin.category.service.CategoryService;
import com.project.mycafe.admin.category.vo.CategoryVO;
import com.project.mycafe.article.service.ArticleService;
import com.project.mycafe.article.vo.ArticleVO;
import com.project.mycafe.board.service.BoardService;
import com.project.mycafe.board.vo.BoardVO;
import com.project.mycafe.member.service.MemberService;
import com.project.mycafe.member.vo.MemberVO;

@Controller
public class MainController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private BoardService boardService;
	@Autowired
	private ArticleService articleService;

	@RequestMapping("/")
	public String mainPage(Model model, HttpSession session) throws Exception {
		List<CategoryVO> list = categoryService.selectCategoryList();
		List<BoardVO> boardList = boardService.selectBoardList();
		List<ArticleVO> recentArticles = articleService.selectRecentArticles();
		model.addAttribute("recentArticles", recentArticles);
		List<ArticleVO> announcements = articleService.selectAnnouncements();
		model.addAttribute("announcements", announcements);
		
		MemberVO member = new MemberVO();
		MemberVO newInfo = new MemberVO();
		if (session.getAttribute("member") != null) {
			member = (MemberVO) session.getAttribute("member");
			newInfo = memberService.selectMemberInfo(member.getMemberId());
			member = newInfo;
			System.out.println("newMemberInfo"+member.toString());
		} else {
			member.setMemberId("guest");
			member.setNickName("익명의 사용자");
			member.setRole("GUEST");
			member.setMemberLevel(1);
			member.setLevelName("손님");
			member.setLoginCnt(0);
			member.setArticleCnt(0);
			member.setCommentCnt(0);
			member.setImageId("basic");
		}
		
		model.addAttribute("member", member);
		model.addAttribute("boards", boardList);
		model.addAttribute("categories", list);

		List<MemberVO> chart = memberService.chartLogin();
		List<Integer> visitCnt = new ArrayList<Integer>();

		// 회원가입 리스트 추가
		List<MemberVO> chart2 = memberService.chartRegister();
		List<Integer> newCnt = new ArrayList<Integer>();

		for (int i = 0; i < chart.size(); i++) {
			visitCnt.add(chart.get(i).getLoginCnt());
		}

		// 회원가입에대한 for문 add
		for (int i = 0; i < chart2.size(); i++) {
			newCnt.add(chart2.get(i).getJoinCnt());
		}

		model.addAttribute("chart", chart);
		model.addAttribute("visitCnt", visitCnt);

		model.addAttribute("chart2", chart2);
		model.addAttribute("newCnt", newCnt);

		return "/main/index";
	}
}
