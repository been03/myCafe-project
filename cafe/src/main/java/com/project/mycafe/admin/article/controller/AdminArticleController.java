package com.project.mycafe.admin.article.controller;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.mycafe.admin.article.service.AdminArticleService;
import com.project.mycafe.admin.category.service.CategoryService;
import com.project.mycafe.article.service.ArticleService;
import com.project.mycafe.article.vo.ArticleVO;
import com.project.mycafe.article.vo.CommentVO;
import com.project.mycafe.article.vo.EventVO;
import com.project.mycafe.board.service.BoardService;
import com.project.mycafe.board.vo.BoardVO;

@Controller("adminArticleController")
@RequestMapping("/admin/*")
public class AdminArticleController {

	@Autowired
	ArticleService articleService;
	@Autowired
	AdminArticleService adminArticleService;
	@Autowired
	CategoryService categoryService;
	@Autowired
	BoardService boardService;

	@RequestMapping("/articleManage.do")
	public String articleManage(@RequestParam(defaultValue = "15") Integer sortNum,
			@RequestParam(required = false) Integer pageNum, ModelMap model,
			@RequestParam(required = false) Map<String, String> searchMap,
			@RequestParam(defaultValue = "all") String articleCategory) throws ParseException {

		List<ArticleVO> list = new ArrayList<ArticleVO>();
		List<ArticleVO> articleList = new ArrayList<ArticleVO>();
		List<BoardVO> boards = boardService.selectBoardList();
		int articleSize = adminArticleService.selectCntByCategory(articleCategory);

		// 검색처리 + 게시판 이동처리
		if (searchMap.get("articleCategory") != null) {
			articleCategory = searchMap.get("articleCategory");
			articleSize = adminArticleService.selectCntByCategory(articleCategory);

			// 게시판 이동
			Set<String> keys = searchMap.keySet();
			Iterator<String> keysIterator = keys.iterator();
			ArticleVO article;
			while (keysIterator.hasNext()) {
				String key = keysIterator.next().toString();
				if (key.contains("checked")) {
					article = new ArticleVO();
					article.setArticleId(Integer.parseInt(key.substring(8)));
					article.setArticleCategory(articleCategory);
					articleList.add(article);
				}
			}
			// 게시글의 게시판 업데이트
			if (!articleList.isEmpty()) {
				adminArticleService.updateArticleCategory(articleList);
			}
			// 검색 -- 전체 게시판 검색일 경우
			if (searchMap.get("searchInput").equals("") || searchMap.get("searchCondition").equals("select")) {
				list = adminArticleService.selectArticleByCategory(articleCategory);
				// 검색 -- 선택된 게시판 검색일 경우
			} else {
				list = adminArticleService.search(searchMap);
				articleSize = list.size();
				model.addAttribute("searchInput", searchMap.get("searchInput"));
			}
			model.addAttribute("searchCondition", searchMap.get("searchCondition"));
			model.addAttribute("articleCategory", searchMap.get("articleCategory"));
		}

		// 페이징 처리
		int start = 0, end = sortNum;
		int totalCnt = articleSize;
		int pageCount = totalCnt / sortNum;

		if (totalCnt % sortNum > 0) {
			pageCount++;
		}

		if (pageNum != null) {
			pageCount = pageNum / sortNum;
//			if (pageNum % sortNum > 0) {
//				pageCount++;
//			}
			for (int i = 0; i <= pageCount; i++) {
				if (pageNum == i * sortNum) {
					start += i * sortNum;
					end = end + start;
					model.addAttribute("curPage", i);
				}
			}
		}

		// 검색을 하지 않고 게시판별로 게시글 불러오기
		if (searchMap.get("searchInput") == null) {
			list = adminArticleService.selectArticleByCategory(articleCategory);
			model.addAttribute("articles", list);
			// 검색 + 게시판 게시글 불러오기
		} else {
			model.addAttribute("articles", list);
		}

		model.addAttribute("boardList", boards);
		model.addAttribute("articleCategory", articleCategory);

		model.addAttribute("begin", start);
		model.addAttribute("end", end);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("sortNum", sortNum);
		model.addAttribute("totalNum", totalCnt);

		return "/admin/article/articleManage";
	}

	// 게시글 스팸처리하기
	@RequestMapping(value = "/blockArticle.do", method = RequestMethod.PUT)
	@ResponseBody
	public String blockArticle(@RequestParam int articleId) {
		adminArticleService.blockArticle(articleId);
		return "block_success";
	}

	// 삭제/스팸처리된 글/댓글 관리
	@RequestMapping("/articleManageDeleted.do")
	public String articleManageDeleted(@RequestParam(defaultValue = "15") Integer sortNum,
			@RequestParam(defaultValue = "0") Integer pageNum, ModelMap model,
			@RequestParam(required = false) Map<String, String> searchMap,
			@RequestParam(defaultValue = "1") Integer tabId, RedirectAttributes rttr) throws Exception {

		List list = new ArrayList();
		List<ArticleVO> articleList = new ArrayList<ArticleVO>();
		List<CommentVO> commentList = new ArrayList<CommentVO>();
		int listSize = 0;

		// 모든 삭제/스팸처리된 게시글 불러오기
		if (tabId == 1) {
			list = adminArticleService.selectDeletedArticle();
			listSize = adminArticleService.selectDeletedArticle().size();
			model.addAttribute("articles", list);
			model.addAttribute("tabId", tabId);
			// 모든 삭제/스팸처리된 댓글 불러오기
		} else if (tabId == 2) {
			list = adminArticleService.selectDeletedComment();
			listSize = adminArticleService.selectDeletedComment().size();
			model.addAttribute("comments", list);
			model.addAttribute("tabId", tabId);
		}

		if (!searchMap.isEmpty()) {
			Set<String> keys = searchMap.keySet();
			Iterator<String> keysIterator = keys.iterator();
			ArticleVO article;
			CommentVO comment;

			while (keysIterator.hasNext()) {
				String key = keysIterator.next().toString();
				if (key.contains("checked") && tabId == 1) {
					article = new ArticleVO();
					article.setArticleId(Integer.parseInt(key.substring(8)));
					articleList.add(article);
				} else if (key.contains("checked") && tabId == 2) {
					comment = new CommentVO();
					comment.setCommentId(Integer.parseInt(key.substring(8)));
					commentList.add(comment);
				}
			}
		}

		// 게시글 영구삭제 / 복구
		if (!articleList.isEmpty() && searchMap.get("buttonClicked").equals("delete") && tabId == 1) {
			adminArticleService.deleteBatchArticle(articleList);
			model.addAttribute("tabId", 1);
		} else if (!articleList.isEmpty() && searchMap.get("buttonClicked").equals("restore") && tabId == 1) {
			adminArticleService.restoreArticle(articleList);
			model.addAttribute("tabId", 1);
		}

		// 댓글 영구삭제 / 복구
		if (!commentList.isEmpty() && searchMap.get("buttonClicked").equals("delete") && tabId == 2) {
			adminArticleService.deleteBatchComment(commentList);
			model.addAttribute("tabId", 2);
		} else if (!commentList.isEmpty() && searchMap.get("buttonClicked").equals("restore") && tabId == 2) {
			adminArticleService.restoreComment(commentList);
			model.addAttribute("tabId", 2);
		}

		if (searchMap.containsKey("searchSubmit")
				|| ((searchMap.containsValue("deleteMemberId") || searchMap.containsValue("deleteDate")))) {
			// 작성자로 검색
			if (searchMap.containsKey("searchInput") && !searchMap.get("searchInput").equals("")) {
				if (searchMap.get("searchInput") != null) {
					if (tabId == 1) {
						list = adminArticleService.search(searchMap);
						listSize = list.size();
					} else {
						list = adminArticleService.searchComment(searchMap);
						listSize = list.size();
					}
				}
				model.addAttribute("searchInput", searchMap.get("searchInput"));
				// 작성일로 검색
			} else if (!(searchMap.get("endDate").equals("") && searchMap.get("startDate").equals(""))) {
				if (searchMap.get("startDate") != null && !(searchMap.get("startDate").equals(""))) {
					model.addAttribute("endDate", searchMap.get("endDate"));
					model.addAttribute("startDate", searchMap.get("startDate"));

					// 받아온 작성일을 yy/MM/dd형식으로 변환하기
					SimpleDateFormat sim = new SimpleDateFormat("yyyy-MM-dd");
					SimpleDateFormat sim2 = new SimpleDateFormat("yy/MM/dd");
					searchMap.replace("startDate", searchMap.get("startDate"),
							sim2.format(sim.parse(searchMap.get("startDate"))));
					searchMap.replace("endDate", searchMap.get("endDate"),
							sim2.format(sim.parse(searchMap.get("endDate"))));

					if (tabId == 1) {
						list = adminArticleService.search(searchMap);
						listSize = list.size();
					} else {
						System.out.println(searchMap.toString());
						list = adminArticleService.searchComment(searchMap);
						listSize = list.size();
					}
				}
			}
		}
		System.out.println("결과"+list.toString());
		if (tabId == 1) {
			model.addAttribute("articles", list);
		} else {
			model.addAttribute("comments", list);
		}
		model.addAttribute("searchCondition", searchMap.get("searchCondition"));

		// 페이징
		int start = 0, end = sortNum, totalCnt = listSize;
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

		model.addAttribute("begin", start);
		model.addAttribute("end", end);
		model.addAttribute("totalNum", totalCnt);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("sortNum", sortNum);

		return "/admin/article/articleManageDeleted";
	}

	//이벤트/행사 추가/수정하기
	@RequestMapping(value = "/articleEventRegister.do", method = RequestMethod.GET)
	public String articleEventRegister(@RequestParam(required = false) Integer eventId, ModelMap model) {
		//수정할 이벤트 불러오기  
		if (eventId != null) {
			EventVO event = articleService.selectEvent(eventId);
			//이미지가 존재한다면 이미지를 list로 가져오기
			if (event.getEventImage() != "NONE_IMAGE") {
				String[] images = event.getEventImage().replace("[", "").replace("]", "").split(", ");
				List<String> imageList = new ArrayList<String>();
				for (int i = 0; i < images.length; i++) {
					imageList.add(images[i].toString());
				}
				model.addAttribute("imageList", imageList);
			}
			model.addAttribute("event", event);
		}
		
		return "/admin/article/articleEventRegister";
	}

	@RequestMapping(value = "/registerEvent.do", method = RequestMethod.POST)
	public String registerEvent(MultipartHttpServletRequest multipartRequest, ModelAndView model, ModelMap mod,
			HttpSession session, HttpServletResponse response) throws Exception {
		
		//이미지 저장 할 폴더위치
		String dftFilePath = multipartRequest.getSession().getServletContext().getRealPath("/");
		String filePath = dftFilePath + "resources" + File.separator + "upload";

		multipartRequest.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		String imageFileName = null;

		Map<String, String> eventMap = new HashMap<String, String>();
		Enumeration<String> enu = multipartRequest.getParameterNames();
		while (enu.hasMoreElements()) {
			String name = enu.nextElement();
			String value = multipartRequest.getParameter(name);
			eventMap.put(name, value);
		}

		EventVO event = new EventVO();
		event.setEventName(eventMap.get("eventName"));
		event.setEventDescription(eventMap.get("eventDescription"));
		event.setEventPlace(eventMap.get("eventPlace"));
		event.setEventStatus(eventMap.get("eventStatus"));
		event.setEventSite(eventMap.get("eventSite"));
		event.setEventRegion(eventMap.get("eventRegion"));
		SimpleDateFormat sim1 = new SimpleDateFormat("yyyy-MM-dd");
		Date formatDate = sim1.parse(eventMap.get("eventStartDate"));
		event.setEventStartDate(formatDate);
		formatDate = sim1.parse(eventMap.get("eventEndDate"));
		event.setEventEndDate(formatDate);

		List<String> imageFileList = upload(multipartRequest);

		if (eventMap.get("modify").equals("true")) {
			Iterator<String> fileNames = multipartRequest.getFileNames();
			while (fileNames.hasNext()) {
				String fileName = fileNames.next();
				MultipartFile mFile = multipartRequest.getFile(fileName);
				if (mFile.getOriginalFilename() != "") {
					System.out.println("수정 전 파일 삭제하기");
					String oldFileName = eventMap.get("ori_event_image" + fileName.substring(11));
					System.out.println("oldfilename" + oldFileName);
					eventMap.remove("ori_event_image" + fileName.substring(11));

					File oldFile = new File(filePath + "\\" + "event_image" + "\\" + oldFileName);
					System.out.println("삭제합니다" + oldFile);
					oldFile.delete();
				}
			}
		}

		for (int i = 0; i < eventMap.size(); i++) {
			if (eventMap.containsKey("ori_event_image" + i)) {
				System.out.println("남아있는 값들" + eventMap.get("ori_event_image" + i));
				imageFileList.add(eventMap.get("ori_event_image" + i));
			}
		}

		System.out.println("final_check" + imageFileList.toString());
		event.setEventImage(imageFileList.toString());
		
		//이벤트 수정
		if (eventMap.get("modify").equals("true")) {
			event.setEventId(Integer.parseInt(eventMap.get("eventId")));
			//이미지 파일이 없다면 
			if (imageFileList.isEmpty()) {
				event.setEventImage("NONE_IMAGE");
			}
			adminArticleService.updateEvent(event);
		//이벤트 추가
		}else {
			//이미지 파일이 없다면 
			if (imageFileList.isEmpty()) {
				event.setEventImage("NONE_IMAGE");
			}
			adminArticleService.insertEvent(event);
		}

		try {
			if (imageFileList != null && imageFileList.size() != 0) {
				for (String image : imageFileList) {
					imageFileName = image;
					File srcFile = new File(filePath + "\\" + "temp" + "\\" + imageFileName);
					File destDir = new File(filePath + "\\" + "event_image" + "\\");
					FileUtils.moveFileToDirectory(srcFile, destDir, true);
				}
			}
		} catch (Exception e) {
			if (imageFileList != null && imageFileList.size() != 0) {
				for (String image : imageFileList) {
					imageFileName = image;
					File srcFile = new File(filePath + "\\" + "temp" + "\\" + imageFileName);
					srcFile.delete();
				}
			}
		}
		
		return "redirect:/member/articleEvent.do";
	}
	
	//이미지 파일 처리
	protected List<String> upload(MultipartHttpServletRequest multipartRequest) throws Exception {
		List<String> fileList = new ArrayList<String>();
		Iterator<String> fileNames = multipartRequest.getFileNames();
		while (fileNames.hasNext()) {
			String fileName = fileNames.next();
			//이미지 파일 중복을 방지하기 위해 새롭게 추가할 이름부분 생성하기 (yyyyMMddHHmmss_원래이름.jpg)
			SimpleDateFormat sim = new SimpleDateFormat("yyyyMMddHHmmss");
			String newName = sim.format(new Date());

			MultipartFile mFile = multipartRequest.getFile(fileName);
			if (mFile.getOriginalFilename() != "") {
				String originalFileName = newName + "_" + mFile.getOriginalFilename();
				fileList.add(originalFileName);

				String dftFilePath = multipartRequest.getSession().getServletContext().getRealPath("/");
				String filePath = dftFilePath + "resources" + File.separator + "upload";

				File file = new File(filePath + "\\" + originalFileName);
				File temp = new File(filePath + "\\" + "temp" + "\\");
				if (mFile.getSize() != 0) { // File Null Check
					if (!file.exists()) {
						if (file.mkdirs()) {
							file.createNewFile();
						}
					}
					if (!temp.exists()) {
						temp.mkdirs();
					}
					mFile.transferTo(new File(filePath + "\\" + "temp" + "\\" + originalFileName));
					file.delete();
				}
			}
		}
		return fileList;
	}

}
