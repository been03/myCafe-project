package com.project.mycafe.admin.article.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.mycafe.article.vo.ArticleVO;
import com.project.mycafe.article.vo.CommentVO;
import com.project.mycafe.article.vo.EventVO;

@Repository("adminArticleDAO")
public class AdminArticleDAO {

	@Autowired
	private SqlSession sqlSession;
	
	//게시글 다중 삭제
	public void deleteBatchArticle(List<ArticleVO> articles) {
		//다중 삭제를 위해서
		for (ArticleVO article : articles) {
			sqlSession.delete("mapper.article.removeArticle", article.getArticleId());
			System.out.println("게시글 삭제 성공");
		}
	}
	
	//게시글 스팸처리
	public void blockArticle(int articleId) {
		sqlSession.update("mapper.article.blockArticle", articleId);
		System.out.println("게시글 스팸처리 성공");
	}

	//게시글 다중 복구
	public void restoreArticle(List<ArticleVO> articles) {
		for (ArticleVO article : articles) {
			sqlSession.update("mapper.article.restoreArticle", article.getArticleId());
			System.out.println("게시글 복구 성공");
		}
	}
	
	//댓글 다중 삭제
	public void deleteBatchComment(List<CommentVO> comments) {
		for (CommentVO comment : comments) {
			sqlSession.delete("mapper.article.removeComment", comment.getCommentId());
			System.out.println("댓글 삭제");
		}
	}
	
	//댓글 다중 복구
	public void restoreComment(List<CommentVO> comments) {
		for (CommentVO comment : comments) {
			System.out.println("commentId" + comment.getCommentId());
			sqlSession.update("mapper.article.restoreComment", comment.getCommentId());
			System.out.println("댓글 복원");
		}
	}
	
	//게시판별 게시글 선택
	public List<ArticleVO> selectArticleByCategory(String articleCategory) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("articleCategory", articleCategory);
		System.out.println("게시판별 게시글 조회");
		List<ArticleVO> list = (ArrayList) sqlSession.selectList("mapper.article.selectArticleByCategory", map);
		return list;
	}

	//게시판별 게시글 수 
	public int selectCntByCategory(String articleCategory) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("articleCategory", articleCategory);
		int count = (int) sqlSession.selectOne("mapper.article.selectCntByCategory", map);
		return count;
	}

	//게시글의 게시판 정보 업데이트 (게시판 이동)
	//다중
	public void updateArticleCategory(List<ArticleVO> articles) {
		for (ArticleVO article : articles) {
			sqlSession.update("mapper.article.updateCategoryName", article);
			System.out.println("게시판 이동 성공");
		}
	}

	//게시글 검색
	public List<ArticleVO> search(Map<String, String> searchMap) {
		List<ArticleVO> list = (ArrayList) sqlSession.selectList("mapper.article.searchArticle", searchMap);
		System.out.println("검색 조회");
		return list;
	}

	//댓글 검색
	public List<CommentVO> searchComment(Map<String, String> searchMap) {
		List<CommentVO> list = (ArrayList) sqlSession.selectList("mapper.article.searchComment", searchMap);
		System.out.println("검색 조회");
		return list;
	}

	//삭제된 게시글 조회
	public List<ArticleVO> selectDeletedArticle() {
		List<ArticleVO> list = (ArrayList) sqlSession.selectList("mapper.article.selectDeletedArticle");
		return list;
	}

	//삭제된 댓글 조회
	public List<CommentVO> selectDeletedComment() {
		List<CommentVO> list = (ArrayList) sqlSession.selectList("mapper.article.selectDeletedComment");
		return list;
	}

	//행사/이벤트 추가
	public int insertEvent(EventVO event) {
		System.out.println("행사 추가하기");
		return sqlSession.insert("mapper.article.insertEvent", event);
	}

	//행사/이벤트 수정
	public void updateEvent(EventVO event) {
		System.out.println("행사 수정하기");
		sqlSession.update("mapper.article.updateEvent", event);
	}

}
