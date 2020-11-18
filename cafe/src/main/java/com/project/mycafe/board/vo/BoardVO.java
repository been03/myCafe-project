package com.project.mycafe.board.vo;

import org.springframework.stereotype.Component;

@Component("boardVO")
public class BoardVO {
	private int boardId;
	private int ctgId;
	private String boardName;
	private String boardDescription;
	private String boardStatus;
	private String boardType;
	private String likeAllow;
	private int likeCnt;
	private int topArticleCnt;

	public BoardVO() {
		super();
	}

	public BoardVO(int boardId, int ctgId, String boardName, String boardDescription, String boardStatus,
			String boardType, String likeAllow, int likeCnt, int topArticleCnt) {
		super();
		this.boardId = boardId;
		this.ctgId = ctgId;
		this.boardName = boardName;
		this.boardDescription = boardDescription;
		this.boardStatus = boardStatus;
		this.boardType = boardType;
		this.likeAllow = likeAllow;
		this.likeCnt = likeCnt;
		this.topArticleCnt = topArticleCnt;
	}

	public int getBoardId() {
		return boardId;
	}

	public void setBoardId(int boardId) {
		this.boardId = boardId;
	}

	public int getCtgId() {
		return ctgId;
	}

	public void setCtgId(int ctgId) {
		this.ctgId = ctgId;
	}

	public String getBoardName() {
		return boardName;
	}

	public void setBoardName(String boardName) {
		this.boardName = boardName;
	}

	public String getBoardDescription() {
		return boardDescription;
	}

	public void setBoardDescription(String boardDescription) {
		this.boardDescription = boardDescription;
	}

	public String getBoardStatus() {
		return boardStatus;
	}

	public void setBoardStatus(String boardStatus) {
		this.boardStatus = boardStatus;
	}

	public String getBoardType() {
		return boardType;
	}

	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}

	public String getLikeAllow() {
		return likeAllow;
	}

	public void setLikeAllow(String likeAllow) {
		this.likeAllow = likeAllow;
	}

	public int getLikeCnt() {
		return likeCnt;
	}

	public void setLikeCnt(int likeCnt) {
		this.likeCnt = likeCnt;
	}

	public int getTopArticleCnt() {
		return topArticleCnt;
	}

	public void setTopArticleCnt(int topArticleCnt) {
		this.topArticleCnt = topArticleCnt;
	}

	@Override
	public String toString() {
		return "BoardVO [boardId=" + boardId + ", ctgId=" + ctgId + ", boardName=" + boardName + ", boardDescription="
				+ boardDescription + ", boardStatus=" + boardStatus + ", boardType=" + boardType + ", likeAllow="
				+ likeAllow + ", likeCnt=" + likeCnt + ", topArticleCnt=" + topArticleCnt + "]";
	}

}
