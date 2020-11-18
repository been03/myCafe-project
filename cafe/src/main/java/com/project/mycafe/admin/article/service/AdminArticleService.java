package com.project.mycafe.admin.article.service;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.mycafe.admin.article.dao.AdminArticleDAO;
import com.project.mycafe.article.vo.ArticleVO;
import com.project.mycafe.article.vo.CommentVO;
import com.project.mycafe.article.vo.EventVO;

@Service("adminArticleService")
public class AdminArticleService {

	@Autowired
	AdminArticleDAO adminArticleDAO;

	public void deleteBatchArticle(List<ArticleVO> articles) {
		adminArticleDAO.deleteBatchArticle(articles);
	}

	public void blockArticle(int articleId) {
		adminArticleDAO.blockArticle(articleId);
	}

	public void restoreArticle(List<ArticleVO> articles) {
		adminArticleDAO.restoreArticle(articles);
	}

	public void deleteBatchComment(List<CommentVO> comments) {
		adminArticleDAO.deleteBatchComment(comments);
	}

	public void restoreComment(List<CommentVO> comments) {
		adminArticleDAO.restoreComment(comments);
	}

	public List<ArticleVO> selectArticleByCategory(String articleCategory) {
		return adminArticleDAO.selectArticleByCategory(articleCategory);
	}

	public List<ArticleVO> search(Map<String, String> searchMap) throws ParseException {
		return adminArticleDAO.search(searchMap);
	}

	public void updateArticleCategory(List<ArticleVO> ids) {
		adminArticleDAO.updateArticleCategory(ids);
	}

	public int selectCntByCategory(String articleCategory) {
		return adminArticleDAO.selectCntByCategory(articleCategory);
	}

	public List<ArticleVO> selectDeletedArticle() {
		return adminArticleDAO.selectDeletedArticle();
	}

	public List<CommentVO> selectDeletedComment() {
		return adminArticleDAO.selectDeletedComment();
	}

	public List<CommentVO> searchComment(Map<String, String> searchMap) {
		return adminArticleDAO.searchComment(searchMap);
	}
	
	public int insertEvent(EventVO event) {
		return adminArticleDAO.insertEvent(event);
	}
	
	public void updateEvent(EventVO event) {
		adminArticleDAO.updateEvent(event);
	}
}
