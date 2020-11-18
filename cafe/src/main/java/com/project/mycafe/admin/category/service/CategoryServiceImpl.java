package com.project.mycafe.admin.category.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.mycafe.admin.category.dao.CategoryDAO;
import com.project.mycafe.admin.category.vo.CategoryVO;
import com.project.mycafe.board.vo.BoardVO;

@Service("categoryService")
@Transactional(propagation = Propagation.REQUIRED)
public class CategoryServiceImpl implements CategoryService {

	@Autowired
	CategoryDAO categoryDAO;

	@Override
	public List<CategoryVO> selectCategoryList() {
		return categoryDAO.selectCategoryList();
	}

	@Override
	public CategoryVO selectOneCategory(int ctgId) {
		return categoryDAO.selectOneCategory(ctgId);
	}

	@Override
	public void insertCtg(CategoryVO category) {
		categoryDAO.insertCtg(category);
	}

	@Override
	public void insertBoard(BoardVO board) {
		categoryDAO.insertBoard(board);
	}

	@Override
	public void updateCategory(Map<String, String> categoryMap) {
		categoryDAO.updateCategory(categoryMap);
	}

	@Override
	public CategoryVO selectOneCategory(String ctgName) {
		return categoryDAO.selectOneCategory(ctgName);
	}
}
