package com.project.mycafe.member.controller;

import java.io.File;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.mycafe.admin.category.service.CategoryService;
import com.project.mycafe.admin.category.vo.CategoryVO;
import com.project.mycafe.admin.member.service.AdminMemberService;
import com.project.mycafe.admin.member.vo.LevelVO;
import com.project.mycafe.admin.member.vo.MessageVO;
import com.project.mycafe.article.service.ArticleService;
import com.project.mycafe.article.vo.ArticleVO;
import com.project.mycafe.article.vo.CommentVO;
import com.project.mycafe.board.service.BoardService;
import com.project.mycafe.board.vo.BoardVO;
import com.project.mycafe.member.service.MemberService;
import com.project.mycafe.member.vo.MemberVO;

@Controller
@RequestMapping("/member/*")
public class MemberController {

	@Autowired
	private MemberService memberService;
	@Autowired
	private AdminMemberService adminMemberService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private BoardService boardService;
	@Autowired
	private ArticleService articleService;

	// 회원 가입 폼 이동
	@RequestMapping(value = "/memberJoinForm.do")
	public String memberJoinForm(Model model) throws Exception {

		MemberVO member = new MemberVO();
		member.setMemberId("guest");
		member.setNickName("익명의 사용자");
		member.setRole("GUEST");
		member.setMemberLevel(1);
		member.setLevelName("손님");
		member.setLoginCnt(0);
		member.setArticleCnt(0);
		member.setCommentCnt(0);
		member.setImageId("basic");
		model.addAttribute("member", member);

		List<CategoryVO> list = categoryService.selectCategoryList();
		List<BoardVO> boardList = boardService.selectBoardList();
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

		List<ArticleVO> recentArticles = articleService.selectRecentArticles();
		model.addAttribute("recentArticles", recentArticles);
		System.out.println(recentArticles);

		model.addAttribute("chart", chart);
		model.addAttribute("visitCnt", visitCnt);

		model.addAttribute("chart2", chart2);
		model.addAttribute("newCnt", newCnt);

		return "/member/memberForm";
	}

	// 아이디 중복 검사(AJAX)
	@RequestMapping(value = "/checkId.do", method = RequestMethod.POST)
	public void checkId(@RequestParam("memberId") String memberId, HttpServletResponse response) throws Exception {
		PrintWriter out = response.getWriter();
		out.println(memberService.checkId(memberId));
		out.close();
	}

	// 이메일 중복 검사(AJAX)
	@RequestMapping(value = "/checkEmail.do", method = RequestMethod.POST)
	public void checkEmail(@RequestParam("email") String email, HttpServletResponse response) throws Exception {
		PrintWriter out = response.getWriter();
		out.println(memberService.checkEmail(email));
		out.close();
	}

	// 닉네임 중복검사(AJAX)
	@RequestMapping(value = "/checkNickName.do", method = RequestMethod.POST)
	public void checkNickName(@RequestParam("nickName") String nickName, HttpServletResponse response)
			throws Exception {
		PrintWriter out = response.getWriter();
		out.print(memberService.checkNickName(nickName));
		out.close();
	}

	// 회원 가입
	@RequestMapping(value = "/joinMember.do", method = RequestMethod.POST)
	public String joinMember(@RequestParam Map<String, String> register, RedirectAttributes rttr,
			HttpServletResponse response) throws Exception {
		MemberVO member = new MemberVO();
		member.setMemberName(register.get("memberName"));
		member.setMemberId(register.get("memberId"));
		member.setMemberPwd(register.get("memberPwd"));
		member.setEmail(register.get("email"));
		member.setNickName(register.get("nickName"));
		member.setTelNum(register.get("telNum"));

		Integer result = 0;

		// 인증키 set
		member.setApproval_key(memberService.createKey());
		// 인증메일 발송
		memberService.sendMail(member, "join");
		result = 1;

		if (result.equals(1)) {
			memberService.joinMember(member);
			memberService.insertLoginData(member);
		}
		rttr.addFlashAttribute("result", result);
		return "redirect:/";
	}

	// 회원 인증
	@RequestMapping(value = "/approvalMember.do", method = RequestMethod.POST)
	public void approvalMember(@ModelAttribute MemberVO member, HttpServletResponse response) throws Exception {

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		if (memberService.approvalMember(member) == 0) { // 이메일 인증에 실패하였을 경우
			out.println("<script>");
			out.println("alert('잘못된 접근입니다.');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
		} else { // 이메일 인증을 성공하였을 경우
			out.println("<script>");
			out.println("alert('인증이 완료되었습니다. 로그인 후 이용하세요.');");
			out.println("location.href='loginForm.do';");
			out.println("</script>");
			out.close();
		}

	}

	// 로그인 폼 이동
	@RequestMapping(value = "/loginForm.do", method = RequestMethod.GET)
	public String loginForm(Model model) throws Exception {
		System.out.println("로그인창까지는 들어옴");
		return "/member/loginForm";
	}

	// 로그인
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public String login(@ModelAttribute MemberVO member, HttpSession session, HttpServletResponse response)
			throws Exception {
		System.out.println("member=" + member);
		System.out.println("");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		// 등록된 아이디가 없으면
		if (memberService.checkId(member.getMemberId()) == 0) {
			out.println("<script>");
			out.println("alert('등록된 아이디가 없습니다.');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
			return null;
		} else {
			MemberVO m = memberService.selectMemberStatus(member.getMemberId());
			member.setStatus(m.getStatus());
			int n = memberService.selectLoginCnt(member.getMemberId());
			member.setLoginCnt(n);

			String memberPwd = member.getMemberPwd();
			member = memberService.login(member);
			// 비밀번호가 다를 경우
			if (!member.getMemberPwd().equals(memberPwd)) {
				out.println("<script>");
				out.println("alert('비밀번호가 다릅니다.');");
				out.println("history.go(-1);");
				out.println("</script>");
				out.close();
				return null;
			} else if (m.getStatus().equals("waiting")) {
				System.out.println("m.getStatus" + m.getStatus());
				out.println("<script>");
				out.println("alert('가입승인 전입니다. 관리자가 가입승인 후 로그인 가능합니다.');");
				out.println("history.go(-1);");
				out.println("</script>");
				out.close();
				return null;
			} else if (!member.getApproval_status().equals("true")) {
				out.println("<script>");
				out.println("alert('이메일 인증 전입니다. 이메일을 확인해 주세요');");
				out.println("history.go(-1);");
				out.println("</script>");
				out.close();
				return null;
				// 회원정보 리턴
			} else if (m.getStatus().equals("drop")) {
				out.println("<script>");
				out.println("alert('탈퇴한 회원입니다. 30일간 같은 이메일,아이디,닉네임으로의 가입이 제한됩니다.');");
				out.println("history.go(-1);");
				out.println("</script>");
				out.close();
				return null;
			} else if (m.getStatus().equals("inactive")) {
				out.println("<script>");
				out.println("alert('활동정지된 회원입니다. 관리자에게 문의해주세요');");
				out.println("history.go(-1);");
				out.println("</script>");
				out.close();
				return null;
			} else {
				session.setAttribute("member", member);
				Calendar cal = Calendar.getInstance();
				cal.setTime(new Date());
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				System.out.println("현재 날짜: " + df.format(cal.getTime()));
				String today = df.format(cal.getTime());
				MemberVO mem = memberService.selectLoginTime(member.getMemberId());
				String d = df.format(mem.getLoginTime());
				System.out.println("mem.getLoginTime()=" + mem.getLoginTime());
				if (!today.equals(d)) {
					System.out.println("시작 loginTime 변경, loginCnt++");
					memberService.updateLoginCnt(member); // loginTime도 update
					System.out.println("끝 loginTime 변경, loginCnt++");
				}
				String level = levelUp(member.getMemberId(), session, response);
				if (level.equals("levelup")) {
					return null;
				}
			}
		}
		System.out.println("로그인 버튼이 눌림");
		return "redirect:/";
	}

	// 등업 조건에 부합하는지 확인
	public String levelUp(String memberId, HttpSession session, HttpServletResponse response) throws Exception {
		List<LevelVO> level = memberService.selectLevelList();
		MemberVO member = memberService.selectMemberInfo(memberId);

		int i = memberService.selectArticleCnt(memberId);
		member.setArticleCnt(i);
		i = memberService.selectCommentCnt(memberId);
		member.setCommentCnt(i);
		i = memberService.selectLoginCnt(memberId);
		member.setLoginCnt(i);

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();

		if (member.getMemberLevel() != 0) {
			for (int j = member.getMemberLevel() + 1; j < level.size(); j++) {
				LevelVO lv = memberService.selectLevelOne(j);
				System.out.println("lv = " + lv);
				if ((member.getArticleCnt() >= lv.getArticleCnt()) && (member.getCommentCnt() >= lv.getCommentCnt())
						&& (member.getLoginCnt() >= lv.getVisitCnt())) {
					if (member.getMemberLevel() < j) {
						member.setMemberLevel(j);
						memberService.updateLevel(member);
						MemberVO newInfo = memberService.selectMemberInfo(member.getMemberId());
						session.setAttribute("member", newInfo);
						out.println("<script>");
						out.println("alert('등업되셨습니다.');");
						out.println("location.href='myPageMain.do?memberId=" + memberId + "';");
						out.println("</script>");
						out.close();
						return "levelup";
					}
				}
			}
		}
		return "none";
	}

	// 로그아웃
	@RequestMapping(value = "/logout.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void logout(HttpSession session, HttpServletResponse response) throws Exception {
		System.out.println("로그아웃창 진입");
		session.invalidate();

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("location.href='/mycafe/';");
		out.println("</script>");
		out.close();

	}

	// 아이디 찾기 폼
	@RequestMapping(value = "/findIdForm.do")
	public String findIdForm() throws Exception {
		System.out.println("아이디 찾기창 진입");
		return "/member/findIdForm";
	}

	// 아이디 찾기
	@RequestMapping(value = "/findId.do", method = { RequestMethod.POST, RequestMethod.GET })
	public String findId(HttpServletResponse response, @RequestParam("email") String email, Model md) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();

		if (email != null) {
			String id = memberService.findId(email);
			if (id == null) {

				out.println("<script>");
				out.println("alert('가입된 아이디가 없습니다.');");
				out.println("history.go(-1);");
				out.println("</script>");
				out.close();
				return null;
			} else {
				// return id;
				md.addAttribute("memberId", id);
			}
		}
		System.out.println("아이디 찾기 페이지 들어옴");
		return "/member/findId";
	}

	// 비밀번호 찾기 폼
	@RequestMapping(value = "/findPwForm.do")
	public String findPwForm() throws Exception {
		System.out.println("비밀번호찾기 폼까지 들어옴");
		return "/member/findPwForm";
	}

	// 마이페이지 이동
	@RequestMapping(value = "/myPage.do")
	public String myPage(Model model, HttpSession session) throws Exception {

		MemberVO loginMember = (MemberVO) session.getAttribute("member");
		if (loginMember == null) {
			return "redirect:/member/loginForm.do";
		} else {
			loginMember = memberService.selectMemberInfo(loginMember.getMemberId());
		}

		List<CategoryVO> list = categoryService.selectCategoryList();
		List<BoardVO> boardList = boardService.selectBoardList();
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

		List<ArticleVO> recentArticles = articleService.selectRecentArticles();
		model.addAttribute("recentArticles", recentArticles);
		System.out.println(recentArticles);

		System.out.println("마이페이지로 이동");
		return "/member/myPage";
	}

	// 비밀번호 찾기
	@RequestMapping(value = "/findPw.do", method = RequestMethod.POST)
	public void findPw(@ModelAttribute MemberVO member, HttpServletResponse response) throws Exception {

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		// 아이디가 없으면
		if (memberService.checkId(member.getMemberId()) == 0) {
			out.print("없는 아이디입니다.");
			out.close();
		}
		// 가입에 사용한 이메일이 아니면
		else if (!member.getEmail().equals(memberService.login(member).getEmail())) {
			out.print("잘못된 이메일 입니다.");
			out.close();
		} else {
			// 임시 비밀번호 생성
			String pw = "";
			for (int i = 0; i < 12; i++) {
				pw += (char) ((Math.random() * 26) + 97);
			}
			member.setMemberPwd(pw);
			// 비밀번호 변경
			memberService.findPw(member);
			// 비밀번호 변경 메일 발송

			memberService.sendMail(member, "find_pw"); // 메일이 안되서 일단 확인용 메일되면은 밑에 주석으로 대체

			out.print("이메일로 임시 비밀번호를 발송하였습니다.");
			out.close();
		}

	}

	// otherMyPageMain
	@RequestMapping(value = "/otherMyPage.do", method = { RequestMethod.POST, RequestMethod.GET })
	public String otherMyPage(@RequestParam(defaultValue = "1", required = false) int tabNum,
			@RequestParam(required = false) String nickName, @RequestParam(required = false) String memberId, 
			Model model, HttpSession session, @RequestParam(defaultValue = "0") Integer pageNum) throws Exception {
		List<CategoryVO> list = categoryService.selectCategoryList();
		List<BoardVO> boardList = boardService.selectBoardList();
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

		List<ArticleVO> recentArticles = articleService.selectRecentArticles();
		model.addAttribute("recentArticles", recentArticles);
		System.out.println(recentArticles);

		model.addAttribute("chart", chart);
		model.addAttribute("visitCnt", visitCnt);

		model.addAttribute("chart2", chart2);
		model.addAttribute("newCnt", newCnt);

		System.out.println("/member/otherMyPage.do");
		System.out.println("nickName = " + nickName);
		System.out.println("memberId = " + memberId);
		MemberVO member = new MemberVO();
		if (nickName != null && memberId == null) {
			member = memberService.selectMemberInfoNickName(nickName);
		} else if (memberId != null && nickName == null) {
			member = memberService.selectMemberInfo(memberId);
		}
		//member = memberService.selectMemberInfoNickName(nickName);
		System.out.println("member = " + member);
		MemberVO loginMember = (MemberVO) session.getAttribute("member");
		System.out.println("loginMember = " + loginMember);
		if (loginMember == null) {
			return "redirect:/member/loginForm.do";
		}
//		} else {
//			//member = (MemberVO) session.getAttribute("member");
//			loginMember = memberService.selectMemberInfo(member.getMemberId());
//		}
		List<ArticleVO> article = memberService.selectMemberWroteArticle(member.getMemberId());
		List<CommentVO> comment = memberService.selectMemberWroteComment(member.getMemberId());
		System.out.println("tabNum = " + tabNum);
		System.out.println("member=" + member);
		System.out.println("article=" + article);
		System.out.println("comment=" + comment.toString());

		if (tabNum == 3) {
			article = memberService.selectMemberWroteArticleLikeCnt(member.getMemberId());
			System.out.println("tabNum=3 article = " + article);
		}

		List<CommentVO> commentList = new ArrayList<CommentVO>();
		for (int i = 0; i < comment.size(); i++) {
			CommentVO c = memberService.selectOneComment(comment.get(i).getCommentId());
			ArticleVO a = articleService.selectArticle(c.getArticleId());
			System.out.println("a =" + a);
			if (a != null && a.getArticleStatus().equals("FALSE")) {
				int boardId = a.getBoardId();
				c.setBoardId(boardId);
				commentList.add(c);
			}

		}
		int i = 0;
		String str = memberService.selectLevelName(member.getMemberLevel());
		member.setLevelName(str);
		i = memberService.selectArticleCnt(member.getMemberId());
		member.setArticleCnt(i);
		i = memberService.selectCommentCnt(member.getMemberId());
		member.setCommentCnt(i);
		i = memberService.selectLoginCnt(member.getMemberId());
		member.setLoginCnt(i);

		System.out.println("데이터 추가 후 member=" + member);

		int start = 0, end = 8;
		int totalCnt = 0;
		if (tabNum == 1 || tabNum == 3) {
			totalCnt = article.size();
		} else if (tabNum == 2) {
			totalCnt = commentList.size();
		}
		int pageCount = totalCnt / 8;

		if (totalCnt % 8 > 0) {
			pageCount++;
		}

		if (pageNum != null) {
			pageCount = pageNum / 8;
			if (pageNum % 8 > 0) {
				pageCount++;
			}
			for (int j = 0; j <= pageCount; j++) {
				if (pageNum == j * 8) {
					start += j * 8;
					end = end + start;
					model.addAttribute("curPage", j);
				}
			}
		}

		model.addAttribute("begin", start);
		model.addAttribute("end", end);
		model.addAttribute("totalNum", totalCnt);
		model.addAttribute("pageNum", pageNum);

		model.addAttribute("member", loginMember);
		model.addAttribute("infoMember", member);
		model.addAttribute("article", article);
		model.addAttribute("comment", commentList);
		model.addAttribute("tabNum", tabNum);

		return "member/otherMyPage";
	}

	// myPageMain
	@RequestMapping(value = "/myPageMain.do", method = { RequestMethod.POST, RequestMethod.GET })
	public String myPageMain(@RequestParam(defaultValue = "1", required = false) int tabNum,
			@RequestParam(required = false) String memberId, @RequestParam(required = false) String mini, Model model,
			HttpSession session, @RequestParam(defaultValue = "15") Integer sortNum,
			@RequestParam(defaultValue = "0") Integer pageNum) throws Exception {
		List<CategoryVO> list = categoryService.selectCategoryList();
		List<BoardVO> boardList = boardService.selectBoardList();
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

		List<ArticleVO> recentArticles = articleService.selectRecentArticles();
		model.addAttribute("recentArticles", recentArticles);

		model.addAttribute("chart", chart);
		model.addAttribute("visitCnt", visitCnt);
		model.addAttribute("chart2", chart2);
		model.addAttribute("newCnt", newCnt);

		System.out.println("/member/myPageMain.do");
		MemberVO member = memberService.selectMemberInfo(memberId);
		MemberVO loginMember = (MemberVO) session.getAttribute("member");
		if (loginMember == null) {
			return "redirect:/member/loginForm.do";
		} else {
			loginMember = memberService.selectMemberInfo(member.getMemberId());
		}
		List<ArticleVO> article = memberService.selectMemberWroteArticle(member.getMemberId());
		List<CommentVO> comment = memberService.selectMemberWroteComment(member.getMemberId());
		System.out.println("tabNum = " + tabNum);
		System.out.println("member=" + member);
		System.out.println("article=" + article);
		System.out.println("comment=" + comment.toString());

		if (tabNum == 3) {
			article = memberService.selectMemberWroteArticleLikeCnt(member.getMemberId());
			System.out.println("tabNum=3 article = " + article);
		}

		List<CommentVO> commentList = new ArrayList<CommentVO>();
		for (int i = 0; i < comment.size(); i++) {
			CommentVO c = memberService.selectOneComment(comment.get(i).getCommentId());
			ArticleVO a = articleService.selectArticle(c.getArticleId());
			System.out.println("a =" + a);
			if (a != null && a.getArticleStatus().equals("FALSE")) {
				int boardId = a.getBoardId();
				c.setBoardId(boardId);
				commentList.add(c);
			}

		}
		int i = 0;
		String str = memberService.selectLevelName(member.getMemberLevel());
		member.setLevelName(str);
		i = memberService.selectArticleCnt(member.getMemberId());
		member.setArticleCnt(i);
		i = memberService.selectCommentCnt(member.getMemberId());
		member.setCommentCnt(i);
		i = memberService.selectLoginCnt(memberId);
		member.setLoginCnt(i);

		System.out.println("데이터 추가 후 member=" + member);

		int start = 0, end = sortNum;
		int totalCnt = 0;
		if (tabNum == 1 || tabNum == 3) {
			totalCnt = article.size();
		} else if (tabNum == 2) {
			totalCnt = commentList.size();
		}
		int pageCount = totalCnt / sortNum;

		if (totalCnt % sortNum > 0) {
			pageCount++;
		}

		if (pageNum != null) {
			pageCount = pageNum / sortNum;
			if (pageNum % sortNum > 0) {
				pageCount++;
			}
			for (int j = 0; j <= pageCount; j++) {
				if (pageNum == j * sortNum) {
					start += j * sortNum;
					end = end + start;
					model.addAttribute("curPage", j);
				}
			}
		}

		model.addAttribute("begin", start);
		model.addAttribute("end", end);
		model.addAttribute("totalNum", totalCnt);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("sortNum", sortNum);

		model.addAttribute("member", loginMember);
		model.addAttribute("infoMember", member);
		model.addAttribute("article", article);
		model.addAttribute("comment", commentList);
		model.addAttribute("tabNum", tabNum);
		model.addAttribute("mini", mini);

		return "/member/myPageMain";
	}

	// myPageMain 글,댓글 삭제
	@RequestMapping(value = "/member/deleteArticleComment.do", method = RequestMethod.POST)
	@ResponseBody
	public String updateStatusDrop(@RequestParam(value = "chbox[]") List<Integer> chArr,
			@RequestParam(required = false) int tabNum) throws Exception {
		System.out.println("myPageMain 글,댓글 삭제");
		String result = "0"; // 로그인이 안되어 있을 떄 작동하지 않게 하기 위한 변수
		if (tabNum == 1 || tabNum == 3) {
			if (chArr != null) {
				for (int i : chArr) {
					memberService.deleteArticle(i);
				}
				result = "1";
			}
		} else if (tabNum == 2) {
			if (chArr != null) {
				for (int i : chArr) {
					memberService.deleteComment(i);
				}
				result = "1";
			}
		}
		return result;
	}

	// myPage 내 정보 수정
	@RequestMapping(value = "/updateMyPage.do", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> updateMyPage(MultipartHttpServletRequest multipartRequest, HttpServletResponse response,
			HttpSession session) throws Exception {
		multipartRequest.setCharacterEncoding("utf-8");
		Map<String, String> articleMap = new HashMap<String, String>();
		Enumeration enu = multipartRequest.getParameterNames();
		MemberVO member = new MemberVO();
		while (enu.hasMoreElements()) {
			String name = (String) enu.nextElement();
			String value = multipartRequest.getParameter(name);
			articleMap.put(name, value);
		}
		System.out.println("updateMyPage");
		System.out.println("MeberVO member = " + articleMap.toString());
		String imageId = upload(multipartRequest);

		String memberid = articleMap.get("memberId");
		String originalImageId = articleMap.get("originalImageId");

		member.setMemberId(memberid);
		member.setImageId(imageId);
		member.setNickName(articleMap.get("nickName"));
		member.setTelNum(articleMap.get("telNum"));
		member.setMemberName(articleMap.get("memberName"));

		MemberVO m = memberService.selectMemberInfo(memberid);

		String message;
		ResponseEntity<String> resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		String dftFilePath = multipartRequest.getSession().getServletContext().getRealPath("/");
		System.out.println(dftFilePath);
		String filePath = dftFilePath + File.separator + "resources" + File.separator + "upload" + File.separator
				+ "photo_profile";
		System.out.println(filePath);
		try {
			member = memberService.updateMyPage(member);
			System.out.println("member = " + member.toString());
			if (imageId != null && imageId.length() != 0 && !imageId.equals(m.getImageId())) {
				File srcFile = new File(filePath + "\\" + "temp" + "\\" + imageId);
				File destDir = new File(filePath + "\\" + memberid);
				if (srcFile.exists()) {
					FileUtils.moveFileToDirectory(srcFile, destDir, true);

					File oldFile = new File(filePath + "\\" + memberid + "\\" + originalImageId);
					oldFile.delete();
				}
				session.setAttribute("member", member);
			}
			message = "<script>";
			message += " alert('수정했습니다.');";
			message += " location.href='" + multipartRequest.getContextPath() + "/member/myPage.do" + "';";
			message += " </script>";
			resEnt = new ResponseEntity<String>(message, responseHeaders, HttpStatus.CREATED);
		} catch (Exception e) {
			e.printStackTrace();
			File srcFile = new File(filePath + "\\" + "temp" + "\\" + imageId);
			srcFile.delete();

			message = "<script>";
			message += " alert('오류가 발생했습니다. 다시 수정해 주세요');";
			message += " location.href='" + multipartRequest.getContextPath() + "/member/myPage.do" + "';";
			message += " </script>";
			resEnt = new ResponseEntity<String>(message, responseHeaders, HttpStatus.CREATED);
		}

		return resEnt;
	}

	// 한개 이미지 업로드 하기
	private String upload(MultipartHttpServletRequest multipartRequest) throws Exception {
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
		System.out.println("현재 날짜: " + df.format(cal.getTime()));
		String today = df.format(cal.getTime());

		String imageId = null;
		Iterator<String> fileNames = multipartRequest.getFileNames();
		HttpSession session = multipartRequest.getSession();
		MemberVO member = (MemberVO) session.getAttribute("member");
		String nickName = member.getNickName();

		String dftFilePath = multipartRequest.getSession().getServletContext().getRealPath("/");
		System.out.println(dftFilePath);
		String filePath = dftFilePath + File.separator + "resources" + File.separator + "upload" + File.separator
				+ "photo_profile";
		System.out.println(filePath);

		while (fileNames.hasNext()) {
			String fileName = fileNames.next();
			MultipartFile mFile = multipartRequest.getFile(fileName);
			System.out.println("mFile.getOriginalFilename()= " + mFile.getOriginalFilename());
			String oriImageId = member.getImageId();
			if (mFile.getOriginalFilename() == "") {
				imageId = oriImageId;
				System.out.println("null if문 imageId=" + imageId);
			} else {
				imageId = nickName + "_" + today + "_" + mFile.getOriginalFilename();
				System.out.println("else imageId= " + imageId);
			}
			System.out.println(imageId);

			File file = new File(filePath + "\\" + imageId);
			File temp = new File(filePath + "\\" + "temp" + "\\");
			if (mFile.getSize() != 0) { // File Null Check
				if (!file.exists()) { // 경로상에 파일이 존재하지 않을 경우
					if (file.getParentFile().mkdirs()) { // 경로에 해당하는 디렉터리 생성
						file.createNewFile(); // 이후 파일 생성
					}
				}
				if (!temp.exists()) {
					temp.mkdirs();
				}
				if (mFile.getOriginalFilename() != "") {
					mFile.transferTo(new File(filePath + "\\" + "temp" + "\\" + imageId)); // 임시로 저장된 multipartFile을 실제
																							// 파일로 전송
				}
			}
		}
		return imageId;
	}

	// 비밀번호 변경
	@RequestMapping(value = "/updatePw.do", method = RequestMethod.POST)
	public String updatePw(@ModelAttribute MemberVO member, @RequestParam("old_pw") String old_pw, HttpSession session,
			HttpServletResponse response) throws Exception {

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		if (!old_pw.equals(memberService.login(member).getMemberPwd())) {
			out.println("<script>");
			out.println("alert('기존 비밀번호와 다릅니다.');");
			out.println("location.href = 'myPage.do';");
			out.println("</script>");
			out.close();
			return null;
		} else if (old_pw.equals(member.getMemberPwd())) {
			out.println("<script>");
			out.println("alert('기존 비밀번호와 같은 비밀번호로는 변경할 수 없습니다.');");
			out.println("location.href = 'myPage.do';");
			out.println("</script>");
			out.close();
			return null;
		} else {
			member = memberService.updatePw(member, old_pw);
		}

		session.setAttribute("member", member);
		return "redirect:/member/myPageMain.do?memberId=" + member.getMemberId();
	}

	// 회원탈퇴
	@RequestMapping(value = "/withdrawal.do", method = RequestMethod.POST)
	public String withdrawalForm(@ModelAttribute MemberVO member, @RequestParam("memberPwd") String memberPwd,
			HttpSession session, HttpServletResponse response) throws Exception {

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		String pwd = memberService.selectMemberInfo(member.getMemberId()).getMemberPwd();
		System.out.println("pwd=" + pwd);
		System.out.println("memberPwd=" + memberPwd);
		if (!pwd.equals(memberPwd)) {
			out.println("<script>");
			out.println("alert('탈퇴 실패! 등록된 비밀번호와 다른 비밀번호입니다. 비밀번호를 확인해 주세요');");
			out.println("location.href = 'myPage.do';");
			out.println("</script>");
			out.close();
		} else {
			memberService.updateStatusDrop(member.getMemberId()); // 회원 상태 drop으로 변경
			out.println("<script>");
			out.println("alert('탈퇴처리 되었습니다. 회원님의 정보는 탈퇴 후 30일간 보관되며 같은 이메일로의 가입이 제한됩니다.');");
			out.println("location.href = '/mycafe/';");
			out.println("</script>");
			out.close();
			session.invalidate();
		}

		return "/";
	}

	@RequestMapping(value = "/memberMessageList.do")
	public String messageList(@RequestParam(defaultValue = "1") int tabNum, Model model, HttpSession session,
			@RequestParam(required = false) Map<String, String> searchMap,
			@RequestParam(defaultValue = "15") Integer sortNum, @RequestParam(defaultValue = "0") Integer pageNum)
			throws Exception {
		System.out.println("member/messageList.do");
		MemberVO loginMember = (MemberVO) session.getAttribute("member");
		if (loginMember == null) {
			return "redirect:/member/loginForm.do";
		} else {
			loginMember = memberService.selectMemberInfo(loginMember.getMemberId());
		}
		System.out.println("loginMember = " + loginMember);
		memberService.updateNickName();
		memberService.updateSenderNickName();
		List<MessageVO> message = new ArrayList<MessageVO>();
		if (tabNum == 1) {
			message = memberService.selectMemberMessage(loginMember.getMemberId());
			for (int i = 0; i < message.size(); i++) {
				MemberVO m = memberService.selectMemberInfo(message.get(i).getSenderMemberId());
				if (m.getRole().equals("ADMIN")) {
					message.get(i).setSenderNickName("관리자");
				}
			}
		} else if (tabNum == 2) {
			message = memberService.selectSendMemberMessage(loginMember.getMemberId());
		}
		model.addAttribute("message", message);
		model.addAttribute("loginMember", loginMember);

		System.out.println("searchMap = " + searchMap);
		System.out.println(searchMap.toString());
		System.out.println("check" + searchMap.containsKey("searchCondition"));
		if (searchMap.containsKey("searchCondition") && !searchMap.get("searchCondition").equals("")) {
			System.out.println("not null searchCondition");
			model.addAttribute("searchCondition", searchMap.get("searchCondition"));
		}

		if (searchMap.containsKey("searchInput") && !searchMap.get("searchInput").equals("")) {
			System.out.println("not null searchInput");
			if (searchMap.get("searchInput") != null) {
				message.clear();
				List<MessageVO> msg = adminMemberService.searchMessage(searchMap);
				System.out.println("msg" + msg);
				if (tabNum == 1) {
					for (int i = 0; i < msg.size(); i++) {
						MessageVO m = adminMemberService.selectOneMessage(msg.get(i).getMessageNo());
						if (!m.getSenderNickName().equals(loginMember.getNickName())
								&& m.getNickName().equals(loginMember.getNickName())) {
							MemberVO memberVO = adminMemberService.selectMemberInfo(m.getSenderMemberId());
							if (memberVO.getRole().equals("ADMIN")) {
								m.setSenderNickName("관리자");
							}
							message.add(m);
						}
					}
					if (searchMap.get("searchCondition").equals("senderNickName")) {
						if (searchMap.get("searchInput").equals("관리자")) {
							for (int i = 0; i < message.size(); i++) {
								MessageVO m = adminMemberService.selectOneMessage(message.get(i).getMessageNo());
								if (!m.getSenderNickName().equals(loginMember.getNickName())
										&& m.getNickName().equals(loginMember.getNickName())) {
									MemberVO memberVO = adminMemberService.selectMemberInfo(m.getSenderMemberId());
									if (!memberVO.getRole().equals("ADMIN")) {
										message.remove(i);
									}
								}
							}
						} else {
							for (int i = 0; i < message.size(); i++) {
								MessageVO m = adminMemberService.selectOneMessage(message.get(i).getMessageNo());
								if (!m.getSenderNickName().equals(loginMember.getNickName())
										&& m.getNickName().equals(loginMember.getNickName())) {
									MemberVO memberVO = adminMemberService.selectMemberInfo(m.getSenderMemberId());
									if (memberVO.getRole().equals("ADMIN")) {
										message.remove(i);
									}
								}
							}
						}
					}
				} else if (tabNum == 2) {
					for (int i = 0; i < msg.size(); i++) {
						MessageVO m = adminMemberService.selectOneMessage(msg.get(i).getMessageNo());
						if (m.getSenderNickName().equals(loginMember.getNickName())) {
							message.add(m);
						}
					}
				}
				System.out.println("message = " + message);
			}
			model.addAttribute("searchInput", searchMap.get("searchInput"));
		}

		int start = 0, end = sortNum, totalCnt = message.size();
		int pageCount = totalCnt / sortNum;

		if (totalCnt % sortNum > 0) {
			pageCount++;
		}

		if (pageNum != null) {
			pageCount = pageNum / sortNum;
			if (pageNum % sortNum > 0) {
				pageCount++;
			}
			for (int i = 0; i <= pageCount; i++) {
				if (pageNum == i * sortNum) {
					start += i * sortNum;
					end = end + start;
					model.addAttribute("curPage", i);
				}
			}
		}
		System.out.println(totalCnt + " " + "start" + start + "end" + end);

		model.addAttribute("begin", start);
		model.addAttribute("end", end);
		model.addAttribute("totalNum", totalCnt);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("sortNum", sortNum);

		List<CategoryVO> list = categoryService.selectCategoryList();
		List<BoardVO> boardList = boardService.selectBoardList();
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

		List<ArticleVO> recentArticles = articleService.selectRecentArticles();
		model.addAttribute("recentArticles", recentArticles);
		System.out.println(recentArticles);

		model.addAttribute("chart", chart);
		model.addAttribute("visitCnt", visitCnt);

		model.addAttribute("tabNum", tabNum);
		model.addAttribute("chart2", chart2);
		model.addAttribute("newCnt", newCnt);

		return "/member/memberMessageList";
	}

	@RequestMapping(value = "/member/messageSend.do", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public String messageSend(@RequestParam(required = false) Map<String, String> message, HttpSession session)
			throws Exception {
		System.out.println("messageSend");
		System.out.println(message);
		MemberVO loginMember = (MemberVO) session.getAttribute("member");
		String result = "0"; // 로그인이 안되어 있을 떄 작동하지 않게 하기 위한 변수
		String member = message.get("member");
		String title = message.get("title");
		String content = message.get("content");
		/*
		 * String[] memberList = {}; if (member.contains(",")) { memberList =
		 * member.split(","); }else { memberList = member.split(" "); }
		 */
		MemberVO m = adminMemberService.selectMemberInfo(member);
		System.out.println("m = " + m);
		MessageVO messageVO = new MessageVO();
		messageVO.setMemberId(m.getMemberId());
		messageVO.setNickName(m.getNickName());
		messageVO.setMessageTitle(title);
		messageVO.setMessageContent(content);
		messageVO.setSenderNickName(loginMember.getNickName());
		messageVO.setSenderMemberId(loginMember.getMemberId());
		System.out.println("messageVO = " + messageVO);
		adminMemberService.insertMessage(messageVO);
		result = "1";
		return result;
	}

	@RequestMapping(value = "/messageDetail.do")
	public String messageDetail(@RequestParam(required = false) int messageNo, Model model, HttpSession session)
			throws Exception {
		System.out.println("쪽지 자세히 보기");
		MessageVO messageVO = memberService.selectOneMessage(messageNo);
		MemberVO loginMember = (MemberVO) session.getAttribute("member");
		if (loginMember == null) {
			return "redirect:/member/loginForm.do";
		} else {
			loginMember = memberService.selectMemberInfo(loginMember.getMemberId());
		}
		System.out.println(messageVO);
		if (messageVO.getMessageStatus().equals("noRead")
				&& messageVO.getNickName().equals(loginMember.getNickName())) {
			memberService.updateMessageStatus(messageNo);
		}
		MemberVO m = memberService.selectMemberInfo(messageVO.getSenderMemberId());
		if (m.getRole().equals("ADMIN")) {
			messageVO.setSenderNickName("관리자");
		}
		model.addAttribute("msg", messageVO);
		model.addAttribute("loginMember", loginMember);
		return "/admin/member/messageForm";
	}

	@RequestMapping(value = "/messageForm.do")
	public String messageForm(HttpSession session, Model model, @RequestParam(required = false) Integer messageNo)
			throws Exception {
		System.out.println("messageForm");
		MessageVO message = new MessageVO();
		if (messageNo != null) {
			message = memberService.selectOneMessage(messageNo);
			return "redirect:/member/messageForm.do?nickName=" + message.getNickName();
		}
		MemberVO loginMember = (MemberVO) session.getAttribute("member");
		model.addAttribute("loginMember", loginMember);
		return "/admin/member/messageForm";
	}

	// 쪽지 삭제
	@RequestMapping(value = "/deleteMessage.do", method = { RequestMethod.POST,
			RequestMethod.GET }, produces = "text/html; charset=UTF-8")
	@ResponseBody
	public String deleteMessage(@RequestParam(value = "chbox[]", required = false) List<Integer> chArr,
			@RequestParam(required = false) int tabNum) throws Exception {
		System.out.println("deleteMessage");
		System.out.println(chArr);
		String result = "0";

		if (tabNum == 1) {
			if (chArr != null) {
				for (int i : chArr) {
					MessageVO messageVO = adminMemberService.selectOneMessage(i);
					System.out.println(messageVO);
					MemberVO m = adminMemberService.selectMemberInfo(messageVO.getSenderMemberId());
					System.out.println("관리자가보낸 쪽지");
					if (m.getRole().equals("ADMIN")) {
						System.out.println("읽은 쪽지인지 확인");
						if (messageVO.getMessageStatus().equals("read")) {
							result = "3";
						}
					}
				}
			}
			if (result != "3") {
				for (int i : chArr) {
					MessageVO messageVO = adminMemberService.selectOneMessage(i);
					System.out.println(messageVO);
					System.out.println("쪽지 삭제");
					adminMemberService.deleteMessage(messageVO.getMessageNo());
				}
				result = "1";
			}
		} else {
			if (chArr != null) {
				for (int i : chArr) {
					MessageVO messageVO = adminMemberService.selectOneMessage(i);
					System.out.println(messageVO);
					System.out.println("읽은 쪽지인지 확인");
					if (messageVO.getMessageStatus().equals("read")) {
						result = "2";
					}
				}
				if (result != "2") {
					for (int i : chArr) {
						MessageVO messageVO = adminMemberService.selectOneMessage(i);
						System.out.println(messageVO);
						System.out.println("안 읽은 쪽지 삭제");
						adminMemberService.deleteMessage(messageVO.getMessageNo());
					}
					result = "1";
				}
			}
		}
		System.out.println("result = " + result);
		return result;
	}

	@RequestMapping(value = "/member/levelCheck.do", method = { RequestMethod.POST, RequestMethod.GET })
	public String levelCheck(@RequestParam(required = false) Integer boardId,
			@RequestParam(required = false) String mini, Model model, HttpSession session) throws Exception {
		System.out.println("/member/levelCheck.do");
		List<LevelVO> levelAll = memberService.selectLevelList();

		MemberVO member = new MemberVO();
		if (boardId != null) {
			BoardVO board = boardService.selectOneBoardId(boardId);
			CategoryVO category = categoryService.selectOneCategory(board.getCtgId());
			String readLevelName = memberService.selectLevelName(category.getCtgReadLevel());
			String writeLevelName = memberService.selectLevelName(category.getCtgWriteLevel());
			System.out.println(readLevelName + " " + writeLevelName);
			if (boardId == 2) {
				model.addAttribute("readLevelName", "일반멤버");
				model.addAttribute("writeLevelName", "none");
			} else {
				model.addAttribute("readLevelName", readLevelName);
				model.addAttribute("writeLevelName", writeLevelName);
			}
			model.addAttribute("boardInfo", board);
		}

		if (session.getAttribute("member") == null) {
			member.setNickName("guest");
			member.setLevelName(memberService.selectLevelName(1));
		}

		if (session.getAttribute("member") != null) {
			member = (MemberVO) session.getAttribute("member");
			member = memberService.selectMemberInfo(member.getMemberId());
			System.out.println("loginMember = " + member);
			int i = 0;
			String str = memberService.selectLevelName(member.getMemberLevel());
			member.setLevelName(str);
			i = memberService.selectArticleCnt(member.getMemberId());
			member.setArticleCnt(i);
			i = memberService.selectCommentCnt(member.getMemberId());
			member.setCommentCnt(i);
			i = memberService.selectLoginCnt(member.getMemberId());
			member.setLoginCnt(i);
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
		model.addAttribute("level", levelAll);
		model.addAttribute("mini", mini);

		List<CategoryVO> list = categoryService.selectCategoryList();
		List<BoardVO> boardList = boardService.selectBoardList();
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

		List<ArticleVO> recentArticles = articleService.selectRecentArticles();
		model.addAttribute("recentArticles", recentArticles);

		model.addAttribute("chart", chart);
		model.addAttribute("visitCnt", visitCnt);

		model.addAttribute("chart2", chart2);
		model.addAttribute("newCnt", newCnt);
		if (mini != null) {
			return "/member/levelCheckPopUpVersion";
		}
		return "/member/levelCheck";
	}
}
