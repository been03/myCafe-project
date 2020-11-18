package com.project.mycafe.admin.member.vo;

import org.springframework.stereotype.Component;

@Component("levelVO")
public class LevelVO {
	private int levelNo;
	private String levelName;
	private int articleCnt;
	private int commentCnt;
	private int visitCnt;
	
	public LevelVO() {
		// TODO Auto-generated constructor stub
	}
	
	public LevelVO(int levelNo, String levelName, int articleCnt, int commentCnt, int visitCnt) {
		this.levelNo = levelNo;
		this.levelName = levelName;
		this.articleCnt = articleCnt;
		this.commentCnt = commentCnt;
		this.visitCnt = visitCnt;
	}

	public int getLevelNo() {
		return levelNo;
	}

	public void setLevelNo(int levelNo) {
		this.levelNo = levelNo;
	}

	public String getLevelName() {
		return levelName;
	}

	public void setLevelName(String levelName) {
		this.levelName = levelName;
	}

	public int getArticleCnt() {
		return articleCnt;
	}

	public void setArticleCnt(int articleCnt) {
		this.articleCnt = articleCnt;
	}

	public int getCommentCnt() {
		return commentCnt;
	}

	public void setCommentCnt(int commentCnt) {
		this.commentCnt = commentCnt;
	}

	public int getVisitCnt() {
		return visitCnt;
	}

	public void setVisitCnt(int visitCnt) {
		this.visitCnt = visitCnt;
	}

	@Override
	public String toString() {
		return "LevelVO [levelNo=" + levelNo + ", levelName=" + levelName + ", articleCnt=" + articleCnt
				+ ", commentCnt=" + commentCnt + ", visitCnt=" + visitCnt + "]";
	}

}
