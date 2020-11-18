package com.project.mycafe.article.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.mycafe.article.vo.ArticleVO;
import com.project.mycafe.article.vo.AttendanceVO;
import com.project.mycafe.article.vo.CommentVO;
import com.project.mycafe.article.vo.EventVO;

@Repository("articleDAO")
public class ArticleDAO {
	@Autowired
	private SqlSession sqlSession;

	public List<ArticleVO> selectAllArticles(int boardId) {
		System.out.println("모든 게시글 불러오기");
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("boardId", boardId);
		List<ArticleVO> articleList = (ArrayList) sqlSession.selectList("mapper.article.selectArticle", map);
		return articleList;
	}
	
	public List<ArticleVO> selectTopArticles(int boardId, int articleLikeCnt){
		System.out.println("인기글 갖고오기");
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("boardId", boardId);
		map.put("articleLikeCnt", articleLikeCnt);
		List<ArticleVO> articleList = (ArrayList)sqlSession.selectList("mapper.article.selectTopArticles", map);
		return articleList;
	}

	public List<ArticleVO> selectArticles() {
		System.out.println("모든 게시글 불러오기");
		List<ArticleVO> articleList = (ArrayList) sqlSession.selectList("mapper.article.selectAllArticles");
		return articleList;
	}

	public ArticleVO selectArticle(int articleId) {
		System.out.println("게시글 하나 불러오기");
		ArticleVO article = (ArticleVO) sqlSession.selectOne("mapper.article.selectOneArticle", articleId);
		return article;
	}
	
	public List<ArticleVO> selectAnnouncements(){
		System.out.println("공지 불러오기");
		List<ArticleVO> articleList = (ArrayList)sqlSession.selectList("mapper.article.selectAnnouncements" );
		return articleList;
	}

	public int selectCount(int boardId) {
		System.out.println("게시글 수 갖고오기");
		int count = (int) sqlSession.selectOne("mapper.article.selectCount", boardId);
		return count;
	}

	public void insertArticle(ArticleVO article) {
		System.out.println("insert 성공");
		sqlSession.insert("mapper.article.insertNewArticle", article);
	}

	public void updateArticle(ArticleVO article) {
		System.out.println("update 성공");
		sqlSession.update("mapper.article.updateArticle", article);
	}

	public void deleteArticle(int articleId) {
		System.out.println("게시글 삭제 성공");
		sqlSession.update("mapper.article.deleteArticle", articleId);
	}

	public List<CommentVO> selectComments(int articleId) {
		System.out.println("댓글 가져오기");
		List<CommentVO> comments = (ArrayList) sqlSession.selectList("mapper.article.selectComments", articleId);
		return comments;
	}

	public void insertComment(CommentVO comment) {
		System.out.println("댓글 insert");
		sqlSession.insert("mapper.article.insertNewComment", comment);
	}

	public void insertReplyComment(CommentVO comment) {
		System.out.println("댓글 답변");
		sqlSession.insert("mapper.article.insertReplyComment", comment);
	}

	public void increaseReadCnt(int articleId) {
		sqlSession.update("mapper.article.increaseReadCnt", articleId);
		System.out.println("방문자수 increase");
	}

	public void increaseLikeCnt(int articleId) {
		System.out.println("좋아요수 increase");
		sqlSession.update("mapper.article.increaseLikeCnt", articleId);
	}

	public void increaseCommentCnt(int articleId) {
		System.out.println("댓글수  increase");
		sqlSession.update("mapper.article.increaseCommentCnt", articleId);
	}

	public void deleteComment(int commentId) {
		System.out.println("댓글 삭제");
		sqlSession.update("mapper.article.deleteComment", commentId);
	}
	
	public List<EventVO> selectSelectedEvents(String eventDate){
		System.out.println("특정한 날짜에 등록된 행사 불러오기");
		Map<String,String> map = new HashMap<String,String>();
		map.put("eventDate", eventDate);
		List<EventVO> list = (ArrayList)sqlSession.selectList("mapper.article.selectSelectedEvents", map);
		return list;
	}
	
	public EventVO selectEvent(int eventId) {
		System.out.println("선택된 이벤트 갖고오기");
		EventVO event = (EventVO)sqlSession.selectOne("mapper.article.selectEvent", eventId);
		return event;
	}
	
	public List<EventVO> selectAllEvents(int start, int end){
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", start);
		map.put("end", end);
		List<EventVO> list = (ArrayList)sqlSession.selectList("mapper.article.selectAllEvents", map);
		return list;
	}
	
	public List<ArticleVO> search(Map<String, String> searchMap) {
		List<ArticleVO> list = (ArrayList) sqlSession.selectList("mapper.article.searchArticle", searchMap);
		System.out.println("검색 조회");
		return list;
	}
	
	public List<CommentVO> searchComment(Map<String, String> searchMap) {
		List<CommentVO> list = (ArrayList) sqlSession.selectList("mapper.article.searchComment", searchMap);
		System.out.println("검색 조회");
		return list;
	}
	
	public List<AttendanceVO> selectAttendanceByDate (String today){
		System.out.println("선택된 날짜 출석부 가져오기");
		Map<String,String> map = new HashMap<String, String>();
		map.put("attendanceDate", today);
		List<AttendanceVO> list = (ArrayList)sqlSession.selectList("mapper.article.selectAttendanceByDate", map);
		return list;
	}
	
	public void insertAttendance(AttendanceVO atd) {
		sqlSession.insert("mapper.article.insertAttendance", atd);
	}

	public int selectCntEvents() {
		int count = (int)sqlSession.selectOne("mapper.article.selectCntEvents");
		return count;
	}
	
	public List<ArticleVO> selectRecentArticles(){
		List<ArticleVO> list = (ArrayList)sqlSession.selectList("mapper.article.selectRecentArticles");
		return list;
	}
	
	public List<ArticleVO> selectBestArticles(){
		List<ArticleVO> list = (ArrayList)sqlSession.selectList("mapper.article.selectBestArticles");
		return list;
	}

	public void insertLikeInfo(Integer articleId, String memberId) {
		Map map = new HashMap();
		map.put("articleId", articleId);
		map.put("memberId", memberId);
		sqlSession.insert("mapper.article.insertLikeInfo", map);
	}

	public List<ArticleVO> selectLikeInfo(int articleId) {
		List<ArticleVO> list = (ArrayList)sqlSession.selectList("mapper.article.selectLikeInfo", articleId);
		return list;
	}

	public void banComment(int commentId) {
		sqlSession.update("mapper.article.banComment", commentId);
	}

}
