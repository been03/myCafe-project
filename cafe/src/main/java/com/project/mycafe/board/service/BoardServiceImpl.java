package com.project.mycafe.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.mycafe.board.dao.BoardDAO;
import com.project.mycafe.board.vo.BoardVO;

@Service("boardService")
@Transactional(propagation = Propagation.REQUIRED)
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardDAO boardDAO;

	@Override
	public List<BoardVO> selectBoardList() {
		List<BoardVO> list = boardDAO.selectBoardList();
		return list;
	}

	@Override
	public BoardVO selectOneBoardId(int boardId) {
		BoardVO list = boardDAO.selectBoardId(boardId);
		return list;
	}

	@Override
	public BoardVO selectBoardCtgId(int ctgId) {
		return boardDAO.selectBoardCtgId(ctgId);
	}

	@Override
	public void updateBoard(Map<String, String> categoryMap) {
		boardDAO.updateBoard(categoryMap);
	}

	@Override
	public BoardVO selectOneBoardByName(String boardName) {
		return boardDAO.selectOneBoardByName(boardName);
	}

	@Override
	public List<BoardVO> selectPermittedBoard(int ctgWriteLevel) {
		return boardDAO.selectPermittedBoard(ctgWriteLevel);
	}

}
