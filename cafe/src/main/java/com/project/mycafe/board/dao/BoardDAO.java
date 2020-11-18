package com.project.mycafe.board.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.project.mycafe.board.vo.BoardVO;

@Repository("boardDAO")
public class BoardDAO {
	@Autowired
	private SqlSession sqlSession;
	
	//게시판 리스트 가져오기
	public List<BoardVO> selectBoardList() throws DataAccessException {
		List<BoardVO> boardList = (ArrayList) sqlSession.selectList("mappers.board.selectBoard");
		return boardList;
	}
	
	//게시판 아이디로 게시판 정보 갖고오기
	public BoardVO selectBoardId(int boardId) throws DataAccessException {
		BoardVO board = sqlSession.selectOne("mappers.board.selectBoardId", boardId);
		return board;
	}

	//게시판 메뉴 아이디로 게시판 정보 갖고오기
	public BoardVO selectBoardCtgId(int ctgId) {
		BoardVO board = sqlSession.selectOne("mappers.board.selectBoardCtgId", ctgId);
		return board;
	}

	//게시판 정보 수정하기
	public void updateBoard(Map<String, String> categoryMap) {
		BoardVO board = new BoardVO();
		board.setBoardDescription(categoryMap.get("boardDescription"));
		board.setBoardId(Integer.parseInt(categoryMap.get("boardId")));
		board.setBoardName(categoryMap.get("boardName"));
		board.setLikeAllow(categoryMap.get("likeAllow"));
		board.setLikeCnt(Integer.parseInt(categoryMap.get("likeCnt")));
		board.setTopArticleCnt(Integer.parseInt(categoryMap.get("topArticleCnt")));
		board.setBoardStatus(categoryMap.get("boardStatus"));
		sqlSession.update("mappers.board.updateBoard", board);
	}

	//게시판 이름으로 게시판 정보 갖고오기
	public BoardVO selectOneBoardByName(String boardName) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("boardName", boardName);
		BoardVO board = sqlSession.selectOne("mappers.board.selectBoardByName", map);
		return board;
	}

	//쓰기권한에 따라서 게시판 갖고오기
	public List<BoardVO> selectPermittedBoard(int ctgWriteLevel) {
		List<BoardVO> list = (ArrayList) sqlSession.selectList("mappers.board.selectPermittedBoard", ctgWriteLevel);
		return list;
	}

}
