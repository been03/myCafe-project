package com.project.mycafe.board.service;

import java.util.List;
import java.util.Map;

import com.project.mycafe.board.vo.BoardVO;

public interface BoardService {
	public List<BoardVO> selectBoardList();

	public BoardVO selectOneBoardId(int boardId);

	public BoardVO selectBoardCtgId(int ctgId);

	public void updateBoard(Map<String, String> categoryMap);

	public BoardVO selectOneBoardByName(String boardName);

	public List<BoardVO> selectPermittedBoard(int ctgWriteLevel);
}
