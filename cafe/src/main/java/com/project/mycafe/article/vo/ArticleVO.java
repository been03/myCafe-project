package com.project.mycafe.article.vo;

import java.util.Date;

import org.springframework.stereotype.Component;

@Component("articleVO")
public class ArticleVO {
	private int articleId; // 게시글 번호
	private int parentId; // 답글
	private int boardId; // 게시판 아이디
	private String imageId; // 게시글 작성자의 프로필 이미지 아이디
	private String memberId; // 게시글 작성자 아이디
	private String nickName; // 게시글 작성자 닉네임/별명
	private String articleTitle; // 게시글 제목
	private String articleContent; // 게시글 내용
	private Date articleDate; // 게시글 작성일자

	private String articleCategory; // 게시글 카테고리이름
	private String articleBoard; // 게시글 게시판 이름
	private int articleLevel; // 답글인지 아닌지 확인을 위한 변수
	private String articleHead;
	private String tag;
	private int articleCommentCnt; // 게시글 댓글 수
	private int articleReadCnt; // 게시글 조회 수
	private int articleLikeCnt; // 게시글 좋아요 수
	private String articleStatus; // 게시글 상태(삭제/TRUE, 일반/FALSE, 스팸/BLOCK)

	private String formattedDate;
	private String imageName;	//앨범형게시판때 쓰이는 변수
	private String role;		//게시글 관리페이지에서 쓰이는 변수

	public ArticleVO() {
		super();
	}

	public ArticleVO(int articleId, int parentId, int boardId, String imageId, String memberId, String nickName,
			String articleTitle, String articleContent, Date articleDate, String articleCategory, String articleBoard,
			int articleLevel, int articleCommentCnt, int articleReadCnt, int articleLikeCnt, String articleStatus,
			String formattedDate, String articleHead, String tag) {
		super();
		this.articleId = articleId;
		this.parentId = parentId;
		this.boardId = boardId;
		this.imageId = imageId;
		this.memberId = memberId;
		this.nickName = nickName;
		this.articleTitle = articleTitle;
		this.articleContent = articleContent;
		this.articleDate = articleDate;
		this.articleCategory = articleCategory;
		this.articleBoard = articleBoard;
		this.articleLevel = articleLevel;
		this.articleCommentCnt = articleCommentCnt;
		this.articleReadCnt = articleReadCnt;
		this.articleLikeCnt = articleLikeCnt;
		this.articleStatus = articleStatus;
		this.formattedDate = formattedDate;
		this.articleHead = articleHead;
		this.tag = tag;
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

	public int getBoardId() {
		return boardId;
	}

	public void setBoardId(int boardId) {
		this.boardId = boardId;
	}

	public String getImageId() {
		return imageId;
	}

	public void setImageId(String imageId) {
		this.imageId = imageId;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getArticleTitle() {
		return articleTitle;
	}

	public void setArticleTitle(String articleTitle) {
		this.articleTitle = articleTitle;
	}

	public String getArticleContent() {
		return articleContent;
	}

	public void setArticleContent(String articleContent) {
		this.articleContent = articleContent;
	}

	public Date getArticleDate() {
		return articleDate;
	}

	public void setArticleDate(Date articleDate) {
		this.articleDate = articleDate;
	}

	public String getArticleCategory() {
		return articleCategory;
	}

	public void setArticleCategory(String articleCategory) {
		this.articleCategory = articleCategory;
	}

	public String getArticleBoard() {
		return articleBoard;
	}

	public void setArticleBoard(String articleBoard) {
		this.articleBoard = articleBoard;
	}

	public int getArticleLevel() {
		return articleLevel;
	}

	public void setArticleLevel(int articleLevel) {
		this.articleLevel = articleLevel;
	}

	public int getArticleCommentCnt() {
		return articleCommentCnt;
	}

	public void setArticleCommentCnt(int articleCommentCnt) {
		this.articleCommentCnt = articleCommentCnt;
	}

	public int getArticleReadCnt() {
		return articleReadCnt;
	}

	public void setArticleReadCnt(int articleReadCnt) {
		this.articleReadCnt = articleReadCnt;
	}

	public int getArticleLikeCnt() {
		return articleLikeCnt;
	}

	public void setArticleLikeCnt(int articleLikeCnt) {
		this.articleLikeCnt = articleLikeCnt;
	}

	public String getArticleStatus() {
		return articleStatus;
	}

	public void setArticleStatus(String articleStatus) {
		this.articleStatus = articleStatus;
	}

	public String getFormattedDate() {
		return formattedDate;
	}

	public void setFormattedDate(String formattedDate) {
		this.formattedDate = formattedDate;
	}

	public String getImageName() {
		return imageName;
	}

	public void setImageName(String imageName) {
		this.imageName = imageName;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getArticleHead() {
		return articleHead;
	}

	public void setArticleHead(String articleHead) {
		this.articleHead = articleHead;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	@Override
	public String toString() {
		return "ArticleVO [articleId=" + articleId + ", parentId=" + parentId + ", boardId=" + boardId + ", imageId="
				+ imageId + ", memberId=" + memberId + ", nickName=" + nickName + ", articleTitle=" + articleTitle
				+ ", articleContent=" + articleContent + ", articleDate=" + articleDate + ", articleCategory="
				+ articleCategory + ", articleBoard=" + articleBoard + ", articleLevel=" + articleLevel
				+ ", articleCommentCnt=" + articleCommentCnt + ", articleReadCnt=" + articleReadCnt
				+ ", articleLikeCnt=" + articleLikeCnt + ", articleStatus=" + articleStatus + ", formattedDate="
				+ formattedDate + ", articleHead=" + articleHead + ", tag=" + tag + "]";
	}

}
