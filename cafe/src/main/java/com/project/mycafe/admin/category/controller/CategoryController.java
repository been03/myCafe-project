package com.project.mycafe.admin.category.controller;

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
import com.project.mycafe.board.service.BoardService;
import com.project.mycafe.board.vo.BoardVO;

@Controller("adminCategoryController")
@RequestMapping("/admin/*")
public class CategoryController {

	@Autowired
	CategoryService categoryService;

	@Autowired
	BoardService boardService;

	// 게시판 관리
	@RequestMapping(value = "/categoryManage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String categoryManage(HttpSession session, @RequestParam(required = false) Integer boardId,
			@RequestParam(required = false) Integer ctgId,
			@RequestParam(required = false) Map<String, String> newCategory, ModelMap model) {
		List<CategoryVO> list = categoryService.selectCategoryList();
		List<BoardVO> boardList = boardService.selectBoardList();

		CategoryVO category = new CategoryVO();
		BoardVO board = new BoardVO();
		// 게시판 + 게시판 메뉴 새로 만들기
		if (newCategory.size() > 2) {
			int id = 0;
			// 게시글을 추가하기 위해서 게시판을 먼저 생성
			// 만약 게시글+게시판을 만들어야 한다면 실행됨
			if (newCategory.get("group_select").equals("new_group")) {
				category.setCtgName(newCategory.get("ctgName"));
				category.setCtgReadLevel(Integer.parseInt(newCategory.get("ctgReadLevel")));
				category.setCtgWriteLevel(Integer.parseInt(newCategory.get("ctgWriteLevel")));
				categoryService.insertCtg(category);
				id = category.getCtgId();
			}

			board.setBoardName(newCategory.get("boardName"));
			// ctgId가 있다면 존재하는 게시판 메뉴에 새로운 게시판을 추가함
			if (!newCategory.get("ctgId").isEmpty()) {
				board.setCtgId(Integer.parseInt(newCategory.get("ctgId")));
				// ctgId가 없다면 게시판 메뉴를 새로 만듬
			} else {
				board.setCtgId(id);
			}
			board.setBoardDescription(newCategory.get("boardDescription"));
			board.setBoardType(newCategory.get("menu_format"));
			// 좋아요 선택을 안했다면
			if (!newCategory.containsKey("likeAllow")) {
				board.setLikeAllow("off");
				// 좋아요 선택을 했다면
			} else {
				board.setLikeAllow(newCategory.get("likeAllow"));
			}
			// 게시판 메뉴 관리 제일 마지막 설정을 안했다면
			if (!newCategory.containsKey("setting")) {
				board.setLikeCnt(0);
				board.setTopArticleCnt(0);
				// 게시판 메뉴 관리 제일 마지막 설정을 안했다면
			} else {
				board.setLikeCnt(Integer.parseInt(newCategory.get("likeCnt")));
				board.setTopArticleCnt(Integer.parseInt(newCategory.get("topArticleCnt")));
			}
			// 게시판 생성하기
			categoryService.insertBoard(board);
			// 게시판 이름을 클릭해서 게시판 정보 불러오기
		} else if (boardId != null && ctgId != null) {
			CategoryVO ctg = categoryService.selectOneCategory(ctgId);
			BoardVO boardInfo = boardService.selectOneBoardId(boardId);
			model.addAttribute("board", boardInfo);
			model.addAttribute("ctg", ctg);
		}

		model.addAttribute("boards", boardList);
		model.addAttribute("categories", list);

		return "/admin/category/categoryManage";
	}

	// 게시판 수정하기
	@RequestMapping(value = "modifyCategoryInfo.do")
	@ResponseBody
	public String modifyCategoryInfo(@RequestParam Map<String, String> categoryMap, ModelMap model) {
		if (!categoryMap.containsKey("likeAllow")) {
			categoryMap.put("likeAllow", "off");
		}
		if (!categoryMap.containsKey("setting")) {
			categoryMap.put("setting", "off");
			categoryMap.put("likeCnt", "0");
			categoryMap.put("topArticleCnt", "0");
		}
		categoryService.updateCategory(categoryMap);
		boardService.updateBoard(categoryMap);

		return "success";
	}

}
