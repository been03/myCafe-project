package com.project.mycafe.article.controller;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.mycafe.admin.category.service.CategoryService;
import com.project.mycafe.admin.category.vo.CategoryVO;
import com.project.mycafe.admin.member.vo.LevelVO;
import com.project.mycafe.article.service.ArticleService;
import com.project.mycafe.article.vo.ArticleVO;
import com.project.mycafe.article.vo.AttendanceVO;
import com.project.mycafe.article.vo.CommentVO;
import com.project.mycafe.article.vo.EventVO;
import com.project.mycafe.board.service.BoardService;
import com.project.mycafe.board.vo.BoardVO;
import com.project.mycafe.member.service.MemberService;
import com.project.mycafe.member.vo.MemberVO;

@Controller
public class ArticleController {
	@Autowired
	private ArticleService articleService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private BoardService boardService;
	@Autowired
	private MemberService memberService;

	// 게시글 보기
	@RequestMapping(value = "/member/articleDetail.do", method = RequestMethod.GET)
	public String getBoardDetail(@RequestParam("articleId") int articleId, @RequestParam("boardId") int boardId,
			@RequestParam(required = false) Integer pageNum, @RequestParam(required = false) Integer curBlock,
			ModelMap model, HttpSession session) throws Exception {
		// 게시글 정보
		ArticleVO article = articleService.selectArticle(articleId);
		// 게시판 작성자 정보
		MemberVO articleMember = memberService.selectMemberInfo(article.getMemberId());
		model.addAttribute("articleMember",articleMember);
		// 해당 글의 조회수 올리기
		articleService.increaseReadCnt(articleId);
		// 해당 게시글이 속한 게시판 정보
		BoardVO board = boardService.selectOneBoardId(boardId);
		// 게시판의 상세 정보를 갖고있는 게시판 메뉴 정보 불러오기 (읽기권한, 쓰기권한 정보 갖고오기)
		CategoryVO category = categoryService.selectOneCategory(board.getCtgId());
		
		// 사용자 정보
		MemberVO mem = new MemberVO();
		if (session.getAttribute("member") != null) {
			mem = (MemberVO) session.getAttribute("member");
			//출석부, 이벤트게시판, 캘린더, 베스트 게시글, 공지게시판이 아닌 게시판들
			//베스트 게시글과 공지게시판은 회원이라면 모두 접근가능
			if (category.getCtgReadLevel() > 0 && category.getCtgReadLevel() < 7) {
				if (!mem.getRole().equals("ADMIN") && mem.getMemberLevel() < category.getCtgReadLevel()) {
					return "redirect:/member/levelCheck.do";
				}
			}else if(category.getCtgReadLevel() == 0) {
				if(!mem.getRole().equals("ADMIN")) {
					return "redirect:/member/levelCheck.do";
				}
			}
		} else {
			//혹시 로그인 세션이 풀렸는데 있는 게시판이 비회원 조회 불가인 게시판이라면
			if (category.getCtgReadLevel() >= 2) {
				return "redirect:/member/loginForm.do";
			} else {
				mem.setMemberId("guest");
				mem.setMemberLevel(1);
				mem.setLevelName("손님");
				mem.setLoginCnt(0);
				mem.setArticleCnt(0);
				mem.setCommentCnt(0);
				mem.setImageId("basic");
				mem.setRole("GUEST");
				mem.setImageId("basic");
				mem.setNickName("익명의 사용자");
			}
		}

		// 게시글에 좋아요를 누른 사용자들 정보
		List<ArticleVO> likeInfo = articleService.selectLikeInfo(articleId);
		boolean likeCheck = false;
		if (mem.getMemberId() != "guest") {
			for (int i = 0; i < likeInfo.size(); i++) {
				if (mem.getMemberId().equals(likeInfo.get(i).getMemberId())) {
					likeCheck = true;
				}
			}
		}

		// 답글 조회시
		if (article.getParentId() > 0) {
			ArticleVO parentArticle = articleService.selectArticle(article.getParentId());
			model.addAttribute("parentArticle", parentArticle);
		}

		// 이전글, 다음글 글번호 계산하기
		int nextId = 0, prevId = 0;
		List<ArticleVO> articles = articleService.selectAllArticles(boardId);
		for (int i = 0; i < articles.size(); i++) {
			if (articles.get(i).getParentId() == 0) {
				if (article.getArticleId() < articles.get(i).getArticleId()) {
					nextId = articles.get(i).getArticleId();
					ArticleVO nextArticle = articleService.selectArticle(nextId);
					model.addAttribute("nextArticle", nextArticle);
				} else if (article.getArticleId() > articles.get(i).getArticleId()) {
					prevId = articles.get(i).getArticleId();
					ArticleVO prevArticle = articleService.selectArticle(prevId);
					model.addAttribute("prevArticle", prevArticle);
					break;
				}
			}
		}
		// 해당 게시글 태그 갖고오기
		if (article.getTag() != "NONE_TAG") {
			String[] tags = article.getTag().replace("[", "").replace("]", "").split(", ");
			List<String> tagList = new ArrayList<String>();
			for (int i = 0; i < tags.length; i++) {
				tagList.add(tags[i].toString());
			}
			model.addAttribute("tagList", tagList);
		}
		// 해당 게시글의 댓글 불러오기
		List<CommentVO> comment = articleService.selectComments(articleId);

		// 목록으로 돌아갈 때 이전페이지로 돌아갈 수 있도록
		if (pageNum != null) {
			model.addAttribute("pageNum", pageNum);
			model.addAttribute("curBlock", curBlock);
		} else {
			model.addAttribute("pageNum", 0);
			model.addAttribute("curBlock", 0);
		}
		
		model.addAttribute("board", board);
		model.addAttribute("category", category);
		model.addAttribute("nextId", nextId);
		model.addAttribute("prevId", prevId);
		model.addAttribute("articles", articles);
		model.addAttribute("member", mem);
		model.addAttribute("comment", comment);
		model.addAttribute("article", article);
		model.addAttribute("likeInfo", likeCheck);
		
//		Side Menu에 들어갈 값들
		List<CategoryVO> list = categoryService.selectCategoryList();
		List<BoardVO> boardList = boardService.selectBoardList();
		model.addAttribute("boards", boardList);
		model.addAttribute("categories", list);
		
		//통계 차트를 위한 정보들 갖고오기
		List<MemberVO> chart = memberService.chartLogin();
		List<Integer> visitCnt = new ArrayList<Integer>();
		for (int i = 0; i < chart.size(); i++) {
			visitCnt.add(chart.get(i).getLoginCnt());
		}
		// 회원가입 리스트 추가
		List<MemberVO> chart2 = memberService.chartRegister();
		List<Integer> newCnt = new ArrayList<Integer>();
		for (int i = 0; i < chart2.size(); i++) {
			newCnt.add(chart2.get(i).getJoinCnt());
		}
		
		//최신글 갖고오기
		List<ArticleVO> recentArticles = articleService.selectRecentArticles();
		model.addAttribute("recentArticles", recentArticles);

		model.addAttribute("chart", chart);
		model.addAttribute("visitCnt", visitCnt);
		model.addAttribute("chart2", chart2);
		model.addAttribute("newCnt", newCnt);

		return "/article/articleDetail";
	}

	// 새로운 게시글 / 답글 쓰기 페이지
	@RequestMapping(value = "/member/articleNew.do", method = RequestMethod.GET)
	public String getArticleNew(@RequestParam(required = false) Integer articleId, @RequestParam Integer boardId,
			ModelMap model, HttpSession session) throws Exception {
		//현재 시간을 보내주기 위해서
		Date date = new Date();
		SimpleDateFormat sim = new SimpleDateFormat("yyyy.MM.dd. HH:mm");
		String cur_date = sim.format(date);

		// 답글쓰기
		if (articleId != null) {
			ArticleVO article = articleService.selectArticle(articleId);
			model.addAttribute("article", article);
			if (article.getTag() != "NONE_TAG") {
				String[] tags = article.getTag().replace("[", "").replace("]", "").split(", ");
				List<String> tagList = new ArrayList<String>();
				for (int i = 0; i < tags.length; i++) {
					tagList.add(tags[i].toString());
				}
				model.addAttribute("tagList", tagList);
			}
			model.addAttribute("parentId", articleId);
		}
		
		//게시글 작성할 때 필요한 현재 게시판 정보 및 게시판들 불러오기
		BoardVO boardInfo = boardService.selectOneBoardId(boardId);
		CategoryVO category = categoryService.selectOneCategory(boardInfo.getCtgId());
		List<BoardVO> boardList = boardService.selectBoardList();
		
		//게시글 작성자 정보
		MemberVO mem = new MemberVO();
		if (session.getAttribute("member") != null) {
			mem = (MemberVO) session.getAttribute("member");
			MemberVO newMem = memberService.selectMemberInfo(mem.getMemberId());
			mem = newMem;
		} else {
			return "redirect:/member/loginForm.do";
		}
		//게시판 선택지는 현재 게시글 작성자의 쓰기 권한에 따라서 다르게 보여줘야 함
		List<BoardVO> boardListUser = boardService.selectPermittedBoard(mem.getMemberLevel());

		model.addAttribute("boardInfo", boardInfo);
		model.addAttribute("boardList", boardList);
		model.addAttribute("category", category);
		model.addAttribute("boardListUser", boardListUser);
		model.addAttribute("member", mem);
		model.addAttribute("date", cur_date);

//		side menu에 들어갈 값들
		List<CategoryVO> list = categoryService.selectCategoryList();
		model.addAttribute("boards", boardList);
		model.addAttribute("categories", list);

		List<MemberVO> chart = memberService.chartLogin();
		List<Integer> visitCnt = new ArrayList<Integer>();
		for (int i = 0; i < chart.size(); i++) {
			visitCnt.add(chart.get(i).getLoginCnt());
		}
		// 회원가입 리스트 추가
		List<MemberVO> chart2 = memberService.chartRegister();
		List<Integer> newCnt = new ArrayList<Integer>();
		for (int i = 0; i < chart2.size(); i++) {
			newCnt.add(chart2.get(i).getJoinCnt());
		}

		List<ArticleVO> recentArticles = articleService.selectRecentArticles();
		model.addAttribute("recentArticles", recentArticles);

		model.addAttribute("chart", chart);
		model.addAttribute("visitCnt", visitCnt);
		model.addAttribute("chart2", chart2);
		model.addAttribute("newCnt", newCnt);

		return "/article/articleNew";
	}

	//게시글 수정 페이지
	@RequestMapping(value = "/member/articleModify.do", method = RequestMethod.GET)
	public String getBoardModify(@RequestParam("articleId") int articleId, @RequestParam("boardId") int boardId,
			ModelMap model, HttpSession session) throws Exception {
		//게시글 수정하는 사용자의 정보
		MemberVO member = new MemberVO();
		if (session.getAttribute("member") != null) {
			member = (MemberVO) session.getAttribute("member");
			MemberVO newMem = memberService.selectMemberInfo(member.getMemberId());
			member = newMem;
		} else {
			return "redirect:/member/loginForm.do";
		}
		//게시판 정보 등 게시글 수정할 때 필요한 정보들 갖고오기
		BoardVO boardInfo = boardService.selectOneBoardId(boardId);
		List<BoardVO> boardList = boardService.selectBoardList();
		List<BoardVO> boardListUser = boardService.selectPermittedBoard(member.getMemberLevel());
		
		//게시판 태그 정보 갖고오기
		ArticleVO article = articleService.selectArticle(articleId);
		if (!article.getTag().equals("NONE_TAG")) {
			String[] tags = article.getTag().replace("[", "").replace("]", "").split(", ");
			List<String> tagList = new ArrayList<String>();
			for (int i = 0; i < tags.length; i++) {
				tagList.add(tags[i].toString());
			}
			model.addAttribute("tagList", tagList);
		}

		SimpleDateFormat sim = new SimpleDateFormat("yyyy.MM.dd. HH:mm");
		String date = sim.format(article.getArticleDate());

		model.addAttribute("boardInfo", boardInfo);
		model.addAttribute("boardList", boardList);
		model.addAttribute("boardListUser", boardListUser);

		model.addAttribute("member", member);
		model.addAttribute("article", article);
		model.addAttribute("date", date);

//		side menu에 들어갈 값들
		List<CategoryVO> list = categoryService.selectCategoryList();
		model.addAttribute("boards", boardList);
		model.addAttribute("categories", list);

		List<MemberVO> chart = memberService.chartLogin();
		List<Integer> visitCnt = new ArrayList<Integer>();
		for (int i = 0; i < chart.size(); i++) {
			visitCnt.add(chart.get(i).getLoginCnt());
		}
		// 회원가입 리스트 추가
		List<MemberVO> chart2 = memberService.chartRegister();
		List<Integer> newCnt = new ArrayList<Integer>();
		for (int i = 0; i < chart2.size(); i++) {
			newCnt.add(chart2.get(i).getJoinCnt());
		}

		List<ArticleVO> recentArticles = articleService.selectRecentArticles();
		model.addAttribute("recentArticles", recentArticles);

		model.addAttribute("chart", chart);
		model.addAttribute("visitCnt", visitCnt);
		model.addAttribute("chart2", chart2);
		model.addAttribute("newCnt", newCnt);

		return "/article/articleModify";
	}
	
	//게시글 작성 처리
	@RequestMapping(value = "/member/submit.do", method = RequestMethod.POST)
	public String submit(@RequestParam Map<String, String> ArticleMap, HttpSession session) throws Exception {
		ArticleVO article = new ArticleVO();
		int boardId = 1;
		article.setArticleContent(ArticleMap.get("smarteditor"));
		article.setArticleTitle(ArticleMap.get("articleTitle"));
		article.setNickName(ArticleMap.get("articleWriter"));
		article.setArticleHead(ArticleMap.get("articleHead"));
		
		//parentId=0 => 새로운 게시글 작성
		if (Integer.parseInt(ArticleMap.get("parentId")) == 0) {
			if (ArticleMap.get("boardName") != ArticleMap.get("boardId")) {
				//System.out.println("다른 게시판");
				article.setBoardId(Integer.parseInt(ArticleMap.get("boardName")));
				boardId = Integer.parseInt(ArticleMap.get("boardName"));
			} else {
				//System.out.println("동일한 게시판");
				article.setBoardId(Integer.parseInt(ArticleMap.get("boardId")));
				boardId = Integer.parseInt(ArticleMap.get("boardId"));
			}
		//답글 작성하기
		} else {
			article.setBoardId(Integer.parseInt(ArticleMap.get("boardId")));
			boardId = Integer.parseInt(ArticleMap.get("boardId"));
		}
		
		//작성한 태그 처리하기
		List<String> tag = new ArrayList<String>();
		int count = 0;
		for (int i = 0; i < ArticleMap.size(); i++) {
			if (ArticleMap.containsKey("articleTag" + i)) {
				tag.add(ArticleMap.get("articleTag" + i));
				count += 1;
			}
		}
		if (count == 0) {
			tag.add("NONE_TAG");
		}
		
		article.setTag(tag.toString());
		article.setArticleBoard(ArticleMap.get("boardName"));
		article.setArticleDate(new Date());
		article.setParentId(Integer.parseInt(ArticleMap.get("parentId")));
		//게시글 추가
		articleService.insertArticle(article);
		//작성자의 총 게시글 수 올려주기
		MemberVO member = (MemberVO) session.getAttribute("member");
		memberService.updateArticleCnt(member.getMemberId());
		member = memberService.selectMemberInfo(member.getMemberId());
		List<LevelVO> level = memberService.selectLevelList();
		//자동 등업 확인
		for (int i=0; i<level.size(); i++) {
			if (level.get(i).getLevelNo() == member.getMemberLevel() && member.getMemberLevel() < 6) {
				LevelVO nextLevel = level.get(i+1);
				if (nextLevel.getArticleCnt() <= (member.getArticleCnt()+1) && nextLevel.getVisitCnt() <= member.getLoginCnt() &&
						nextLevel.getCommentCnt() <= member.getCommentCnt()) {
					System.out.println("levelUp");
					member.setMemberLevel(nextLevel.getLevelNo());
					memberService.updateLevel(member);
					session.setAttribute("levelUP", true);
				}
			}
		}
		//업데이트된 회원정보를 세션에 저장하기
		MemberVO newInfo = new MemberVO();
		newInfo = memberService.selectMemberInfo(member.getMemberId());
		session.setAttribute("member", newInfo);
		System.out.println("updated member info" + newInfo.toString());

		return "redirect:/member/boardMain.do?boardId=" + boardId;
	}
	
	//게시글 수정
	@RequestMapping(value = "/member/modify.do", method = RequestMethod.POST)
	public String modify(@RequestParam Map<String, String> ArticleMap, HttpSession session) {
		//initialize
		ArticleVO article = new ArticleVO();
		int boardId = 1; 
		
		article.setArticleId(Integer.parseInt(ArticleMap.get("articleId")));
		article.setArticleContent(ArticleMap.get("smarteditor"));
		article.setArticleTitle(ArticleMap.get("articleTitle"));
		article.setArticleHead(ArticleMap.get("articleHead"));
		
		if (ArticleMap.get("boardName") != ArticleMap.get("boardId")) {
			//System.out.println("다른 게시판");
			article.setBoardId(Integer.parseInt(ArticleMap.get("boardName")));
			boardId = Integer.parseInt(ArticleMap.get("boardName"));
		} else {
			//System.out.println("동일한 게시판");
			article.setBoardId(Integer.parseInt(ArticleMap.get("boardId")));
			boardId = Integer.parseInt(ArticleMap.get("boardId"));
		}
		
		//수정된 태그 처리하기
		List<String> tag = new ArrayList<String>();
		int count = 0;
		for (int i = 0; i < ArticleMap.size(); i++) {
			if (ArticleMap.containsKey("articleTag" + i)) {
				tag.add(ArticleMap.get("articleTag" + i));
				count += 1;
			}
		}

		if (count == 0) {
			tag.add("NONE_TAG");
		}
		article.setTag(tag.toString());
		article.setArticleDate(new Date());
		//게시글 수정하기
		articleService.updateArticle(article);

		return "redirect:/member/boardMain.do?boardId=" + boardId;
	}
	
	//게시글 삭제
	@RequestMapping(value = "/member/delete.do", method = RequestMethod.DELETE)
	@ResponseBody
	public String delete(@RequestParam int articleId) {
		articleService.deleteArticle(articleId);
		return "delete_success";
	}
	
	//게시글에 댓글추가
	@RequestMapping(value = "/member/insertComment.do", method = RequestMethod.POST, produces = "text/html; charset=utf8")
	@ResponseBody
	public String insertComment(@RequestParam Map<String, String> commentMap, ModelMap model, HttpSession session)
			throws Exception {
		CommentVO comment = new CommentVO();
		comment.setCommentContent(commentMap.get("commentContent"));
		comment.setCommentDate(new Date());
		comment.setArticleId(Integer.parseInt(commentMap.get("articleId")));
		comment.setNickName(commentMap.get("nickName"));
		
		//댓글 추가하기
		articleService.insertComment(comment);
		//게시글의 총 댓글 수 업데이트 하기
		articleService.increaseCommentCnt(Integer.parseInt(commentMap.get("articleId")));
		
		MemberVO member = (MemberVO) session.getAttribute("member");
		memberService.updateCommentCnt(member.getMemberId());
		
		//자동 등업 확인
		List<LevelVO> level = memberService.selectLevelList();
		for (int i=0; i<level.size(); i++) {
			if (level.get(i).getLevelNo() == member.getMemberLevel() && member.getMemberLevel() < 6) {
				LevelVO nextLevel = level.get(i+1);
				System.out.println("nextLevel" + nextLevel);
				if (nextLevel.getArticleCnt() <= member.getArticleCnt() && nextLevel.getVisitCnt() <= member.getLoginCnt() &&
						nextLevel.getCommentCnt() <= (member.getCommentCnt()+1)) {
					System.out.println("levelup");
					member.setMemberLevel(nextLevel.getLevelNo());
					memberService.updateLevel(member);
					
					member = memberService.selectMemberInfo(member.getMemberId());
					MemberVO newInfo = new MemberVO();
					newInfo = memberService.selectMemberInfo(member.getMemberId());
					session.setAttribute("member", newInfo);
					
					return "insert_success&update";
				}
			}
		}
		//업데이트된 회원정보를 세션에 저장하기
		MemberVO newInfo = new MemberVO();
		newInfo = memberService.selectMemberInfo(member.getMemberId());
		session.setAttribute("member", newInfo);
		System.out.println("updated member info" + newInfo.toString());

		return "insert_success";
	}
	
	//게시글 댓글 삭제
	@RequestMapping(value = "/member/deleteComment.do", method = RequestMethod.PUT)
	@ResponseBody
	public String deleteComment(@RequestParam int commentId) {
		articleService.deleteComment(commentId);
		return "delete_success";
	}
	
	//게시글 댓글 스팸처리/신고처리
	@RequestMapping(value = "/member/banComment.do", method = RequestMethod.PUT)
	@ResponseBody
	public String banComment(@RequestParam int commentId) {
		articleService.banComment(commentId);
		return "ban_success";
	}
	
	//댓글에 답글 작성
	@RequestMapping(value = "/member/replyComment.do", method = RequestMethod.POST, produces = "text/html; charset=utf8")
	@ResponseBody
	public String replyComment(@RequestParam Map<String, String> commentMap, HttpSession session) throws Exception {
		CommentVO comment = new CommentVO();
		comment.setCommentContent(commentMap.get("commentContent"));
		comment.setCommentDate(new Date());
		comment.setArticleId(Integer.parseInt(commentMap.get("articleId")));
		comment.setNickName(commentMap.get("nickName"));
		comment.setParentId(Integer.parseInt(commentMap.get("parentId")));
		//댓글 추가하기
		articleService.insertReplyComment(comment);
		//게시글의 총 댓글 수 올려주기
		articleService.increaseCommentCnt(Integer.parseInt(commentMap.get("articleId")));
		
		//회원의 총 댓글 수 올려주기
		MemberVO member = (MemberVO) session.getAttribute("member");
		memberService.updateCommentCnt(member.getMemberId());
		
		//자동 등업 조건 확인
		List<LevelVO> level = memberService.selectLevelList();
		for (int i=0; i<level.size(); i++) {
			if (level.get(i).getLevelNo() == member.getMemberLevel() && member.getMemberLevel() < 6) {
				LevelVO nextLevel = level.get(i+1);
				System.out.println("nextLevel"+nextLevel.toString());
				if (nextLevel.getArticleCnt() <= member.getArticleCnt() && nextLevel.getVisitCnt() <= member.getLoginCnt() &&
						nextLevel.getCommentCnt() <= (member.getCommentCnt()+1)) {
					member.setMemberLevel(nextLevel.getLevelNo());
					memberService.updateLevel(member);
					
					//업데이트된 회원정보 세션에 저장하기
					MemberVO newInfo = new MemberVO();
					newInfo = memberService.selectMemberInfo(member.getMemberId());
					session.setAttribute("member", newInfo);
					
					return "reply_success&update";
				}
			}
		}
		
		//업데이트된 회원정보 세션에 저장하기
		MemberVO newInfo = new MemberVO();
		newInfo = memberService.selectMemberInfo(member.getMemberId());
		session.setAttribute("member", newInfo);
		System.out.println("updated member info" + newInfo.toString());
		
		return "reply_success";
	}

	//좋아요 수 증가시키기
	@RequestMapping(value = "/member/increaseLikeCnt.do", method = RequestMethod.PUT)
	@ResponseBody
	public String increaseLikeCnt(@RequestParam Integer articleId, @RequestParam String memberId) {
		articleService.increaseLikeCnt(articleId);
		articleService.insertLikeInfo(articleId, memberId);
		return "success";
	}
	
	
	//카페 캘린더 
	@RequestMapping("/member/articleCalendar.do")
	public String articleCalendar(@RequestParam(required = false) String eventDate, ModelMap model, HttpSession session)
			throws Exception {
		
		SimpleDateFormat s1 = new SimpleDateFormat("yyyy년 M월 d일");
		SimpleDateFormat s2 = new SimpleDateFormat("yy/MM/dd");
		SimpleDateFormat s3 = new SimpleDateFormat("d");
		//달력에서 날짜를 눌렀을 때
		if (eventDate != null) {
			Date eventD = s1.parse(eventDate);
			eventDate = s2.format(eventD);
			//날짜를 yy/MM/dd형식으로 변환시키고 그 날짜에 해당되는 이벤트 목록 불러오기
			List<EventVO> events = articleService.selectSelectedEvents(eventDate);
			model.addAttribute("date", s1.format(eventD));
			model.addAttribute("events", events);
			model.addAttribute("day", s3.format(eventD));
		//처음 화면을 위해서
		} else {
			//오늘 날짜에 해당되는 이벤트 목록 가져오기
			eventDate = s2.format(new Date());
			List<EventVO> events = articleService.selectSelectedEvents(eventDate);
			eventDate = s1.format(s2.parse(eventDate));
			model.addAttribute("date", eventDate);
			model.addAttribute("events", events);
			model.addAttribute("day", s3.format(s1.parse(eventDate)));
		}
		
		MemberVO member = new MemberVO();
		if (session.getAttribute("member") != null) {
			member = (MemberVO) session.getAttribute("member");
		} else {
			//side에 나타나는 회원 정보를 위해서
			member.setMemberId("guest");
			member.setRole("GUEST");
			member.setImageId("basic");
			member.setMemberLevel(1);
			member.setLevelName("손님");
			member.setLoginCnt(0);
			member.setArticleCnt(0);
			member.setCommentCnt(0);
			member.setImageId("basic");
			member.setNickName("익명의 사용자");
		}

//		side menu에 들어갈 값들
		List<CategoryVO> list = categoryService.selectCategoryList();
		List<BoardVO> boardList = boardService.selectBoardList();
		model.addAttribute("boards", boardList);
		model.addAttribute("categories", list);

		List<MemberVO> chart = memberService.chartLogin();
		List<Integer> visitCnt = new ArrayList<Integer>();
		for (int i = 0; i < chart.size(); i++) {
			visitCnt.add(chart.get(i).getLoginCnt());
		}
		// 회원가입 리스트 추가
		List<MemberVO> chart2 = memberService.chartRegister();
		List<Integer> newCnt = new ArrayList<Integer>();
		for (int i = 0; i < chart2.size(); i++) {
			newCnt.add(chart2.get(i).getJoinCnt());
		}

		model.addAttribute("chart", chart);
		model.addAttribute("visitCnt", visitCnt);
		model.addAttribute("chart2", chart2);
		model.addAttribute("newCnt", newCnt);
		
		List<ArticleVO> recentArticles = articleService.selectRecentArticles();
		model.addAttribute("recentArticles", recentArticles);

		return "/article/articleCalendar";
	}
	
	//출석부
	@RequestMapping("/member/articleAttendance.do")
	public String articleAttendance(ModelMap model, @RequestParam(required = false) Integer day,
			@RequestParam(required = false) Integer month, HttpSession session) throws Exception {

		Calendar currentCalendar = Calendar.getInstance();
		DecimalFormat df = new DecimalFormat("00");
		//날짜 계산을 위한
		int cur_month = 0, today = 0, dayLength = 0, cur_year = 0;
		cur_year = currentCalendar.get(Calendar.YEAR);
		cur_month = currentCalendar.get(Calendar.MONTH) + 1;
		if (month == null) {
			month = cur_month;
		}
		//오늘 날짜
		today = currentCalendar.get(Calendar.DATE);
		//한달의 길이 구하기
		dayLength = currentCalendar.getActualMaximum(Calendar.DAY_OF_MONTH);

		// 날짜만 변경
		// 이번달의 다른 날짜를 선택했을 경우
		if (day != null) {
			model.addAttribute("today", currentCalendar.get(Calendar.DATE));
			model.addAttribute("selected_date", day);

			String yr = Integer.toString(cur_year).substring(2);
			String attendanceDate = yr + "/" + df.format(month) + "/" + df.format(day);

			model.addAttribute("cur_month", currentCalendar.get(Calendar.MONTH) + 1);
			model.addAttribute("month", month);
			//선택된 날짜에 해당되는 출석부 갖고오기
			
			List<AttendanceVO> attendanceList = articleService.selectAttendanceByDate(attendanceDate);
			model.addAttribute("attendanceList", attendanceList);
			model.addAttribute("prev_month", month - 1);
			model.addAttribute("next_month", month + 1);

		// 이전 혹은 다음을 통해서 월만 변경했을 경우
		} else if (month != null && day == null && cur_month != month) {
			String date = Integer.toString(currentCalendar.get(Calendar.YEAR)) + Integer.toString(month)
					+ Integer.toString(1);
			SimpleDateFormat changeDate = new SimpleDateFormat("yyyyMd");
			Date tdate = changeDate.parse(date);
			Calendar cal = Calendar.getInstance();
			cal.setTime(tdate);
			dayLength = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

			model.addAttribute("cur_month", currentCalendar.get(Calendar.MONTH) + 1);
			model.addAttribute("month", month);
			model.addAttribute("prev_month", month - 1);
			model.addAttribute("next_month", month + 1);
			model.addAttribute("today", 1);

		// 오늘의 출석부 가져오기
		} else if (month == cur_month) {
			String yr = Integer.toString(cur_year).substring(2);
			String attendanceDate = yr + "/" + df.format(cur_month) + "/" + df.format(today);

			List<AttendanceVO> attendanceList = articleService.selectAttendanceByDate(attendanceDate);
			model.addAttribute("attendanceList", attendanceList);
			model.addAttribute("today", today);
			model.addAttribute("cur_month", cur_month);
			model.addAttribute("month", cur_month);
			model.addAttribute("selected_date", today);
		}

		MemberVO mem = new MemberVO();
		if (session.getAttribute("member") != null) {
			mem = (MemberVO) session.getAttribute("member");
		} else {
			//side에 나타나는 회원 정보를 위해서
			mem.setMemberId("guest");
			mem.setImageId("basic");
			mem.setRole("GUEST");
			mem.setMemberLevel(1);
			mem.setLevelName("손님");
			mem.setLoginCnt(0);
			mem.setArticleCnt(0);
			mem.setCommentCnt(0);
			mem.setImageId("basic");
			mem.setNickName("익명의 사용자");
		}
		model.addAttribute("member", mem);
		model.addAttribute("cur_year", cur_year);
		model.addAttribute("dayLength", dayLength);

//		side menu에 들어갈 값들
		List<CategoryVO> list = categoryService.selectCategoryList();
		List<BoardVO> boardList = boardService.selectBoardList();
		model.addAttribute("boards", boardList);
		model.addAttribute("categories", list);

		List<MemberVO> chart = memberService.chartLogin();
		List<Integer> visitCnt = new ArrayList<Integer>();
		for (int i = 0; i < chart.size(); i++) {
			visitCnt.add(chart.get(i).getLoginCnt());
		}
		// 회원가입 리스트 추가
		List<MemberVO> chart2 = memberService.chartRegister();
		List<Integer> newCnt = new ArrayList<Integer>();
		for (int i = 0; i < chart2.size(); i++) {
			newCnt.add(chart2.get(i).getJoinCnt());
		}
		model.addAttribute("chart", chart);
		model.addAttribute("visitCnt", visitCnt);
		model.addAttribute("chart2", chart2);
		model.addAttribute("newCnt", newCnt);

		List<ArticleVO> recentArticles = articleService.selectRecentArticles();
		model.addAttribute("recentArticles", recentArticles);

		return "/article/articleAttendance";
	}
	
	//출석 정보 입력하기
	@RequestMapping("/member/insertAttendance.do")
	public String insertAttendance(@RequestParam Map<String, String> atdMap) {
		AttendanceVO atd = new AttendanceVO();
		atd.setContent(atdMap.get("content"));
		atd.setNickName(atdMap.get("nickName"));
		articleService.insertAttendance(atd);
		
		return "redirect:/member/articleAttendance.do";
	}
	
	//이벤트/행사 게시판
	@RequestMapping(value = "/member/articleEvent.do", method = RequestMethod.GET)
	public String articleEvent(ModelMap model, @RequestParam(required = false) Integer page, HttpSession session)
			throws Exception {
		int start = 1, end = 20; //한번에 최대 20개씩 갖고오기

		List<EventVO> eventList = articleService.selectAllEvents(start, end);
		//각 이벤트에 등록된 이미지를 갖고오기
		for (int i = 0; i < eventList.size(); i++) {
			if (!eventList.get(i).getEventImage().equals("NONE_IMAGE")) {
				String[] images = eventList.get(i).getEventImage().replace("[", "").replace("]", "").split(", ");
				List<String> imageList = new ArrayList<String>();
				for (int j = 0; j < images.length; j++) {
					System.out.println(images[j]);
					imageList.add(images[j].toString());
				}
				eventList.get(i).setImageList(imageList);
			}
		}
		model.addAttribute("eventList", eventList);

		MemberVO mem = new MemberVO();
		if (session.getAttribute("member") != null) {
			mem = (MemberVO) session.getAttribute("member");
		} else {
			mem.setMemberId("guest");
			mem.setRole("GUEST");
			mem.setMemberLevel(1);
			mem.setLevelName("손님");
			mem.setLoginCnt(0);
			mem.setArticleCnt(0);
			mem.setCommentCnt(0);
			mem.setImageId("basic");
			mem.setNickName("익명의 사용자");
		}
		model.addAttribute("member", mem);

//		side menu에 들어갈 값들
		List<CategoryVO> list = categoryService.selectCategoryList();
		List<BoardVO> boardList = boardService.selectBoardList();
		model.addAttribute("boards", boardList);
		model.addAttribute("categories", list);

		List<MemberVO> chart = memberService.chartLogin();
		List<Integer> visitCnt = new ArrayList<Integer>();
		for (int i = 0; i < chart.size(); i++) {
			visitCnt.add(chart.get(i).getLoginCnt());
		}
		List<MemberVO> chart2 = memberService.chartRegister();
		List<Integer> newCnt = new ArrayList<Integer>();
		for (int i = 0; i < chart2.size(); i++) {
			newCnt.add(chart2.get(i).getJoinCnt());
		}
		model.addAttribute("chart", chart);
		model.addAttribute("visitCnt", visitCnt);
		model.addAttribute("chart2", chart2);
		model.addAttribute("newCnt", newCnt);
		
		List<ArticleVO> recentArticles = articleService.selectRecentArticles();
		model.addAttribute("recentArticles", recentArticles);

		return "/article/articleEvent";
	}

	@RequestMapping(value = "/article/articleEvent.do", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	@ResponseBody
	public List<EventVO> articleEventMore(ModelMap model, @RequestParam(required = false) Integer page) {
		List<EventVO> eventList = new ArrayList<EventVO>();
		//20개씩 이벤트 불러오기
		int start = 1, end = 20;
		try {
			if (page == null) {
				start = 1;
				end = 20; // 데이터를 20개씩 가져오기
			} else {
				start = page + (19 * (page - 1));
				end = page * 20; 	// 20, 40, 60
			}
			eventList = articleService.selectAllEvents(start, end);
			
			for (int i = 0; i < eventList.size(); i++) {
				SimpleDateFormat sim = new SimpleDateFormat("yyyy년 M월 d일");
				eventList.get(i).setFormattedStartDate(sim.format(eventList.get(i).getEventStartDate()));
				eventList.get(i).setFormattedEndDate(sim.format(eventList.get(i).getEventEndDate()));
			}

			for (int i = 0; i < eventList.size(); i++) {
				if (!eventList.get(i).getEventImage().equals("NONE_IMAGE")) {
					List<String> imageList = new ArrayList<String>();
					String[] images = eventList.get(i).getEventImage().replace("[", "").replace("]", "").split(", ");
					for (int j = 0; j < images.length; j++) {
						imageList.add(images[j].toString());
						eventList.get(i).setImageList(imageList);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return eventList;
	}

	//게시글 검색
	@RequestMapping("/member/articleSearch.do")
	public String articleSearch(ModelMap model, @RequestParam(required = false) Map<String, String> searchMap,
			@RequestParam(required = false) Integer pageNum, HttpSession session,
			@RequestParam(required = false) Integer curBlock, @RequestParam(required = false) String prev)
			throws Exception {
		List<ArticleVO> list = new ArrayList<ArticleVO>();
		List<BoardVO> boards = boardService.selectBoardList();
		int articleSize = 0;

		//게시글 검색어가 있다면
		if (!searchMap.get("searchInput").isEmpty()) {
			System.out.println("검색 시작");
			list = articleService.search(searchMap);
			articleSize = list.size();
			model.addAttribute("articles", list);
			model.addAttribute("searchInput", searchMap.get("searchInput"));
			model.addAttribute("searchCondition", searchMap.get("searchCondition"));
			model.addAttribute("articleBoard", searchMap.get("articleCategory"));
			
			//검색어 + 정렬
			int sortNum = 10;
			if (searchMap.containsKey("sortNum")) {
				sortNum = Integer.parseInt(searchMap.get("sortNum"));
			}
			
			//페이지 번호 계산하기
			int start = 0, end = sortNum;
			int pageStart = 0, pageEnd = sortNum * 10; //한 번에 10개씩 가져와서

			int totalCnt = articleSize; //만약 100개의 게시글이 조회되면
			int pageCount = totalCnt / sortNum;	//페이지 번호의 수는 10개
			if(totalCnt % 10 > 0)
				pageCount++;
			//System.out.println(totalCnt + "" + pageCount);
			model.addAttribute("totalCnt", totalCnt);
			model.addAttribute("pageCount", pageCount);
			
			//검색어 + 페이지 이동
			if (pageNum != null) {
				int pageCnt = pageNum / sortNum;
				if(pageNum % sortNum > 0)
					pageCnt++;
				for (int i = 0; i <= pageCnt; i++) {
					if (pageNum == i * sortNum) {
						start += i * sortNum;
						end = end + start;
					}
				}
			}
			//현재 페이지 그룹 (1-10) = 0 
			//(11-20) = 1
			if (curBlock == null || curBlock == 0) {
				curBlock = 0;
			} else if (curBlock > 0) {
				System.out.println("다음");
				if (pageNum != null) {
					start = pageNum;
					end = start + sortNum;
					pageEnd = (curBlock + 1) * sortNum * 10;
					pageStart = pageEnd - (sortNum * 11);
					//System.out.println(pageNum);
					//System.out.println(pageEnd + "" + pageStart);
					//System.out.println("다음" + start + "" + end);
				}
			} else if (prev != null) {
				System.out.println("이전");
				if (pageNum != null) {
					if (totalCnt > pageNum) {
						start = pageNum;
						end = start + sortNum;
						pageStart -= sortNum;
						pageEnd -= (sortNum * 10);
					}
					//System.out.println(pageNum);
					//System.out.println(pageEnd + "" + pageStart);
					//System.out.println("이전" + start + "" + end);
				}
			}

			//System.out.println(curBlock);
			//System.out.println(start + "" + end);
			BoardVO board = boardService.selectOneBoardByName(searchMap.get("articleCategory"));
			if (!searchMap.get("articleCategory").equals("all")) {
				CategoryVO category = categoryService.selectOneCategory(board.getCtgId());
				model.addAttribute("category", category);
			}

			model.addAttribute("begin", start);
			model.addAttribute("end", end);
			model.addAttribute("pageNum", pageNum);
			model.addAttribute("pageEnd", pageEnd);
			model.addAttribute("pageStart", pageStart);
			model.addAttribute("curBlock", curBlock);
			model.addAttribute("sortNum", sortNum);
			model.addAttribute("articleCategory", searchMap.get("articleCategory"));
			model.addAttribute("boardList", boards);
		}

		MemberVO member = (MemberVO) session.getAttribute("member");
		if (member != null) {
			model.addAttribute("member", member);
		} else {
			member = new MemberVO();
			member.setMemberLevel(1);
			member.setLevelName("손님");
			member.setLoginCnt(0);
			member.setArticleCnt(0);
			member.setCommentCnt(0);
			member.setMemberId("guest");
			member.setNickName("익명의 사용자");
			member.setRole("GUEST");
			member.setImageId("basic");
			model.addAttribute("member", member);
		}

//		side menu에 들어갈 값들
		List<CategoryVO> ctgList = categoryService.selectCategoryList();
		List<BoardVO> boardList = boardService.selectBoardList();
		model.addAttribute("boards", boardList);
		model.addAttribute("categories", ctgList);

		List<MemberVO> chart = memberService.chartLogin();
		List<Integer> visitCnt = new ArrayList<Integer>();
		for (int i = 0; i < chart.size(); i++) {
			visitCnt.add(chart.get(i).getLoginCnt());
		}
		// 회원가입 리스트 추가
		List<MemberVO> chart2 = memberService.chartRegister();
		List<Integer> newCnt = new ArrayList<Integer>();
		for (int i = 0; i < chart2.size(); i++) {
			newCnt.add(chart2.get(i).getJoinCnt());
		}
		model.addAttribute("chart", chart);
		model.addAttribute("visitCnt", visitCnt);
		model.addAttribute("chart2", chart2);
		model.addAttribute("newCnt", newCnt);
		
		List<ArticleVO> recentArticles = articleService.selectRecentArticles();
		model.addAttribute("recentArticles", recentArticles);

		return "/article/articleSearch";
	}

}
