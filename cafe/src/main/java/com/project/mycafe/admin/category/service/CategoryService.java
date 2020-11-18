package com.project.mycafe.admin.category.service;

import java.util.List;
import java.util.Map;

import com.project.mycafe.admin.category.vo.CategoryVO;
import com.project.mycafe.board.vo.BoardVO;

public interface CategoryService {
	public List<CategoryVO> selectCategoryList();

	public CategoryVO selectOneCategory(int ctgId);

	public void insertCtg(CategoryVO category);

	public void insertBoard(BoardVO board);

	public void updateCategory(Map<String, String> categoryMap);

	public CategoryVO selectOneCategory(String ctgName);

}
