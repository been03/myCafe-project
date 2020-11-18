package com.project.mycafe.article.service;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.mycafe.article.dao.ArticleDAO;
import com.project.mycafe.article.vo.ArticleVO;
import com.project.mycafe.article.vo.AttendanceVO;
import com.project.mycafe.article.vo.CommentVO;
import com.project.mycafe.article.vo.EventVO;

@Service("articleService")
@Transactional(propagation = Propagation.REQUIRED)
public class ArticleService {
	@Autowired
	ArticleDAO articleDAO;

	public List<ArticleVO> selectAllArticles(int boardId) {
		return articleDAO.selectAllArticles(boardId);
	}

	public List<ArticleVO> selectArticles() {
		return articleDAO.selectArticles();
	}

	public ArticleVO selectArticle(int articleId) {
		return articleDAO.selectArticle(articleId);
	}

	public List<ArticleVO> selectAnnouncements() {
		return articleDAO.selectAnnouncements();
	}

	public int selectCount(int boardId) {
		return articleDAO.selectCount(boardId);
	}

	public void insertArticle(ArticleVO article) {
		articleDAO.insertArticle(article);
	}

	public void updateArticle(ArticleVO article) {
		articleDAO.updateArticle(article);
	}

	public void deleteArticle(int articleId) {
		articleDAO.deleteArticle(articleId);
	}

	public List<CommentVO> selectComments(int articleId) {
		return articleDAO.selectComments(articleId);
	}

	public void insertComment(CommentVO comment) {
		articleDAO.insertComment(comment);
	}

	public void insertReplyComment(CommentVO comment) {
		articleDAO.insertReplyComment(comment);
	}

	public void increaseReadCnt(int articleId) {
		articleDAO.increaseReadCnt(articleId);
	}

	public void increaseLikeCnt(int articleId) {
		articleDAO.increaseLikeCnt(articleId);
	}

	public void increaseCommentCnt(int articleId) {
		articleDAO.increaseCommentCnt(articleId);
	}

	public void deleteComment(int commentId) {
		articleDAO.deleteComment(commentId);
	}

	public List<ArticleVO> selectTopArticles(int boardId, int articleLikeCnt) {
		return articleDAO.selectTopArticles(boardId, articleLikeCnt);
	}

	public List<EventVO> selectSelectedEvents(String eventDate) {
		return articleDAO.selectSelectedEvents(eventDate);
	}

	public EventVO selectEvent(int eventId) {
		return articleDAO.selectEvent(eventId);
	}

	public List<EventVO> selectAllEvents(int start, int end) {
		return articleDAO.selectAllEvents(start, end);
	}

	public List<AttendanceVO> selectAttendanceByDate(String today) {
		return articleDAO.selectAttendanceByDate(today);
	}

	public void insertAttendance(AttendanceVO atd) {
		articleDAO.insertAttendance(atd);
	}

	public int selectCntEvents() {
		return articleDAO.selectCntEvents();
	}

	public List<ArticleVO> search(Map<String, String> searchMap) throws ParseException {
		return articleDAO.search(searchMap);
	}

	public List<CommentVO> searchComment(Map<String, String> searchMap) {
		System.out.println("댓글 검색");
		System.out.println(searchMap.toString());
		return articleDAO.searchComment(searchMap);
	}

	public List<ArticleVO> selectRecentArticles() {
		System.out.println("최신글 갖고오기");
		return articleDAO.selectRecentArticles();
	}

	public List<ArticleVO> selectBestArticles() {
		System.out.println("베스트 글 갖고오기");
		return articleDAO.selectBestArticles();
	}

	public void insertLikeInfo(Integer articleId, String memberId) {
		System.out.println("좋아요 누른 사람에 대한 정보 기록");
		articleDAO.insertLikeInfo(articleId, memberId);
	}

	public List<ArticleVO> selectLikeInfo(int articleId) {
		System.out.println("게시글 좋아요 정보 갖고오기");
		return articleDAO.selectLikeInfo(articleId);
	}

	public void banComment(int commentId) {
		articleDAO.banComment(commentId);
	}

}
