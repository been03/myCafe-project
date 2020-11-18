package com.project.mycafe.article.vo;

import java.util.Date;

import org.springframework.stereotype.Component;

@Component("commentVO")
public class CommentVO {
	private int commentId;
	private int articleId;
	private int parentId;
	private String imageId;
	private String nickName;
	private String memberId;

	private int commentLevel;
	private String commentStatus;
	private String commentContent;
	private Date commentDate;
	private String formattedDate;

	private int boardId;

	public CommentVO() {
		super();
	}

	public CommentVO(int commentId, int articleId, int parentId, String nickName, int commentLevel,
			String commentStatus, String commentContent, Date commentDate, String formattedDate) {
		super();
		this.commentId = commentId;
		this.articleId = articleId;
		this.parentId = parentId;
		this.nickName = nickName;
		this.commentLevel = commentLevel;
		this.commentStatus = commentStatus;
		this.commentContent = commentContent;
		this.commentDate = commentDate;
		this.formattedDate = formattedDate;
	}

	public int getCommentId() {
		return commentId;
	}

	public void setCommentId(int commentId) {
		this.commentId = commentId;
	}

	public int getArticleId() {
		return articleId;
	}

	public void setArticleId(int articleId) {
		this.articleId = articleId;
	}

	public int getParentId() {
		return parentId;
	}

	public void setParentId(int parentId) {
		this.parentId = parentId;
	}

	public String getImageId() {
		return imageId;
	}

	public void setImageId(String imageId) {
		this.imageId = imageId;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public int getCommentLevel() {
		return commentLevel;
	}

	public void setCommentLevel(int commentLevel) {
		this.commentLevel = commentLevel;
	}

	public String getCommentStatus() {
		return commentStatus;
	}

	public void setCommentStatus(String commentStatus) {
		this.commentStatus = commentStatus;
	}

	public String getCommentContent() {
		return commentContent;
	}

	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}

	public Date getCommentDate() {
		return commentDate;
	}

	public void setCommentDate(Date commentDate) {
		this.commentDate = commentDate;
	}

	public String getFormattedDate() {
		return formattedDate;
	}

	public void setFormattedDate(String formattedDate) {
		this.formattedDate = formattedDate;
	}

	public int getBoardId() {
		return boardId;
	}

	public void setBoardId(int boardId) {
		this.boardId = boardId;
	}

	@Override
	public String toString() {
		return "CommentVO [commentId=" + commentId + ", articleId=" + articleId + ", parentId=" + parentId
				+ ", nickName=" + nickName + ", commentLevel=" + commentLevel + ", commentStatus=" + commentStatus
				+ ", commentContent=" + commentContent + ", commentDate=" + commentDate + ", formattedDate="
				+ formattedDate + "]";
	}

}
