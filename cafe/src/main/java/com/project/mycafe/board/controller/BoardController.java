package com.project.mycafe.board.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.mycafe.admin.category.service.CategoryService;
import com.project.mycafe.admin.category.vo.CategoryVO;
import com.project.mycafe.article.service.ArticleService;
import com.project.mycafe.article.vo.ArticleVO;
import com.project.mycafe.board.service.BoardService;
import com.project.mycafe.board.vo.BoardVO;
import com.project.mycafe.member.service.MemberService;
import com.project.mycafe.member.vo.MemberVO;

@Controller
@RequestMapping("/member/*")
public class BoardController {
	@Autowired
	ArticleService articleService;
	@Autowired
	BoardService boardService;
	@Autowired
	CategoryService categoryService;
	@Autowired
	MemberService memberService;
	
	//게시판
	@RequestMapping("/boardMain.do")
	public String getBoardMain(@RequestParam int boardId, @RequestParam(required = false) Integer pageNum,
			@RequestParam(required = false) Integer curBlock, @RequestParam(required = false) String prev,
			ModelMap model, HttpSession session) throws Exception {
		
		//베스트게시글, 이벤트/행사 게시판, 출석부게시판, 캘린더 게시판
		switch (boardId) {
			case 2:
				if ((MemberVO) session.getAttribute("member") == null){
					return "redirect:/member/levelCheck.do?boardId="+boardId;
				}
				break;
			case 3:
				if((MemberVO) session.getAttribute("member") != null) {
					return "redirect:/member/articleCalendar.do";
				}else {
					return "redirect:/member/levelCheck.do?boardId="+boardId;
				}
				
			case 4:
				if((MemberVO) session.getAttribute("member") != null) {
					return "redirect:/member/articleAttendance.do";
				}else {
					return "redirect:/member/levelCheck.do?boardId="+boardId;
				}
			case 5:
				return "redirect:/member/articleEvent.do";
			default:
				break;
		}

		//페이징
		int start = 0, end = 10;
		int pageStart = 0, pageEnd = 100;

		int totalCnt = articleService.selectCount(boardId);
		if (boardId == 2) {
			totalCnt = articleService.selectBestArticles().size();
		}
		
		int pageCount = totalCnt / 10; 
		if (totalCnt % 10 > 0) { 
			pageCount++; 
		} 

		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageCount", pageCount);

		if (pageNum != null) { 
			int pageCnt = pageNum / 10;
			//if (pageNum % 10 > 0)
			//	pageCnt++;
			System.out.println("pageNum%10=" + pageNum % 10);
			for (int i = 0; i <= pageCnt; i++) {
				if (pageNum == i * 10) {
					start += i * 10;
					end = end + start;
				}
			}
		}
		//현재 페이지가 0 -> 1~10 페이지번호
		//현재 페이지(curBlock)이 1 -> 11~20 페이지번호
		if (curBlock == null || curBlock == 0) {
			curBlock = 0;
		} else if (curBlock > 0) {
			if (pageNum != null) { 
				start = pageNum;
				end = start + 10;
				pageEnd = (curBlock + 1) * 100;
				pageStart = pageEnd - 110;
				System.out.println("다음" + start + "" + end);
			}
		} else if (prev != null) {
			if (pageNum != null) { 
				if (totalCnt > pageNum) {
					start = pageNum;
					end = start + 10;
//					pageStart -= 10;
//					pageEnd -= 100;
					pageEnd = (curBlock - 1) * 100;
					pageStart = pageEnd - 110;
				}
				System.out.println("이전" + start + "" + end);
			}
		}
		
		//비회원도 게시판 접근은 가능해서
		MemberVO member = (MemberVO) session.getAttribute("member");
		if (member != null) {
			MemberVO newMem = memberService.selectMemberInfo(member.getMemberId());
			System.out.println("newMemInfo"+newMem.toString());
			//글 작성 후 자동 등업 확인
			if(session.getAttribute("levelUP")!=null) {
				model.addAttribute("levelUp", true);
			}
			session.setAttribute("member", newMem);
			model.addAttribute("member", newMem);
		} else {
			member = new MemberVO();
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
		}
		
		BoardVO board = boardService.selectOneBoardId(boardId);
		CategoryVO category = categoryService.selectOneCategory(board.getCtgId());
		List<ArticleVO> articles = articleService.selectAllArticles(boardId);
		List<ArticleVO> topArticles = articleService.selectTopArticles(boardId, board.getLikeCnt());
		List<ArticleVO> announcements = articleService.selectAnnouncements();
		
		//게시글 번호가 2면 베스트 게시글 조회
		if (boardId == 2) {
			articles = articleService.selectBestArticles();
		}
		
		String[] strings;
		for (int i=0; i<articles.size(); i++) {
			strings = articles.get(i).getArticleContent().split(" ");
			for (int j=0; j<strings.length; j++) {
				if(strings[j].contains("<img")) {
					String mainImage = strings[j+1].replace("src=\"", "").replace("\"", "");
					articles.get(i).setImageName(mainImage);
					break;
				}
			}
			if (articles.get(i).getImageName()==null) {
				articles.get(i).setImageName("/mycafe/resources/image/boat.jpg");
			}
		}
		
		model.addAttribute("begin", start);
		model.addAttribute("end", end);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("pageEnd", pageEnd);
		model.addAttribute("pageStart", pageStart);
		model.addAttribute("curBlock", curBlock);
		
		model.addAttribute("announcements", announcements);
		model.addAttribute("topArticles", topArticles);
		model.addAttribute("category", category);
		model.addAttribute("board", board);
		model.addAttribute("articles", articles);
		model.addAttribute("boardId", boardId);
		model.addAttribute("today", new Date());
		
//		side menu에 들어갈 값들
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
		
		if (!board.getBoardType().equals("통합게시판")) {
			return "/board/imageBoardMain";
		}
		
		return "/board/boardMain";
	}
}
