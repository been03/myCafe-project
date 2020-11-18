package com.project.mycafe.admin.category.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.project.mycafe.admin.category.vo.CategoryVO;
import com.project.mycafe.board.vo.BoardVO;

@Repository("categoryDAO")
public class CategoryDAO {
	@Autowired
	private SqlSession sqlSession;
	//게시판 메뉴 갖고오기
	public List<CategoryVO> selectCategoryList() throws DataAccessException {
		List<CategoryVO> categoryList = sqlSession.selectList("mappers.board.selectCtg");
		return categoryList;
	}
	//선택된 게시판 메뉴 정보 갖고오기
	public CategoryVO selectOneCategory(int ctgId) {
		CategoryVO category = sqlSession.selectOne("mappers.board.selectOneCategory", ctgId );
		return category;
	}
	
	//게시판 메뉴 추가하기
	public void insertCtg(CategoryVO category) {
		sqlSession.insert("mappers.board.insertCtg", category);
	}
	
	//게시판 추가하기
	public void insertBoard(BoardVO board) {
		sqlSession.insert("mappers.board.insertBoard", board);
	}
	
	//게시판 메뉴 수정하기
	public void updateCategory(Map<String, String> categoryMap) {
		CategoryVO category = new CategoryVO();
		category.setCtgId(Integer.parseInt(categoryMap.get("ctgId")));
		category.setCtgReadLevel(Integer.parseInt(categoryMap.get("ctgReadLevel")));
		category.setCtgWriteLevel(Integer.parseInt(categoryMap.get("ctgWriteLevel")));
		sqlSession.update("mappers.board.updateCategory", category);
	}

	//메뉴이름으로 게시판메뉴 정보 갖고오기
	public CategoryVO selectOneCategory(String ctgName) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("ctgName", ctgName);
		CategoryVO category = sqlSession.selectOne("mappers.board.selectCategoryByName", map);
		return category;
	}

}
