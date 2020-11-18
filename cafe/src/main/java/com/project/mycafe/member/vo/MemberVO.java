package com.project.mycafe.member.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("memberVO")
public class MemberVO {

	private int memberNO;
	private String memberId;
	private String nickName;
	private Date memberJoinDate;
	private String email;
	private String memberPwd;
	private String telNum;
	private int memberLevel;
	private String imageId;
	private String memberName;
	private Date updateDate;
	private String approval_status;
	private String approval_key;

	private int articleCnt;
	private int commentCnt;
	private int loginCnt;
	private Date loginTime;
	private String status;
	private Date updateStatusDate;
	
	private String levelName;
	private String role;
	
	private String loginTimeString;
	private String joinTimeString;
	private int joinCnt;

	public MemberVO() {
	}

	public MemberVO(int memberNO, String memberId, String nickName, Date memberJoinDate, String email, String memberPwd,
			String telNum, int memberLevel, String imageId, String memberName, Date updateDate, String approval_status,
			String approval_key, int articleCnt, int commentCnt, int loginCnt, Date loginTime, String status,
			Date updateStatusDate, String levelName, String role) {
		super();
		this.memberNO = memberNO;
		this.memberId = memberId;
		this.nickName = nickName;
		this.memberJoinDate = memberJoinDate;
		this.email = email;
		this.memberPwd = memberPwd;
		this.telNum = telNum;
		this.memberLevel = memberLevel;
		this.imageId = imageId;
		this.memberName = memberName;
		this.updateDate = updateDate;
		this.approval_status = approval_status;
		this.approval_key = approval_key;
		this.articleCnt = articleCnt;
		this.commentCnt = commentCnt;
		this.loginCnt = loginCnt;
		this.loginTime = loginTime;
		this.status = status;
		this.updateStatusDate = updateStatusDate;
		this.levelName = levelName;
		this.role = role;
	}

	public int getMemberNO() {
		return memberNO;
	}

	public void setMemberNO(int memberNO) {
		this.memberNO = memberNO;
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

	public Date getMemberJoinDate() {
		return memberJoinDate;
	}

	public void setMemberJoinDate(Date memberJoinDate) {
		this.memberJoinDate = memberJoinDate;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMemberPwd() {
		return memberPwd;
	}

	public void setMemberPwd(String memberPwd) {
		this.memberPwd = memberPwd;
	}

	public String getTelNum() {
		return telNum;
	}

	public void setTelNum(String telNum) {
		this.telNum = telNum;
	}

	public int getMemberLevel() {
		return memberLevel;
	}

	public void setMemberLevel(int memberLevel) {
		this.memberLevel = memberLevel;
	}

	public String getImageId() {
		return imageId;
	}

	public void setImageId(String imageId) {
		this.imageId = imageId;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public String getApproval_status() {
		return approval_status;
	}

	public void setApproval_status(String approval_status) {
		this.approval_status = approval_status;
	}

	public String getApproval_key() {
		return approval_key;
	}

	public void setApproval_key(String approval_key) {
		this.approval_key = approval_key;
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

	public int getLoginCnt() {
		return loginCnt;
	}

	public void setLoginCnt(int loginCnt) {
		this.loginCnt = loginCnt;
	}

	public Date getLoginTime() {
		return loginTime;
	}

	public void setLoginTime(Date loginTime) {
		this.loginTime = loginTime;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getUpdateStatusDate() {
		return updateStatusDate;
	}

	public void setUpdateStatusDate(Date updateStatusDate) {
		this.updateStatusDate = updateStatusDate;
	}

	public String getLevelName() {
		return levelName;
	}

	public void setLevelName(String levelName) {
		this.levelName = levelName;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getLoginTimeString() {
		return loginTimeString;
	}

	public void setLoginTimeString(String loginTimeString) {
		this.loginTimeString = loginTimeString;
	}

	public String getJoinTimeString() {
		return joinTimeString;
	}

	public void setJoinTimeString(String joinTimeString) {
		this.joinTimeString = joinTimeString;
	}

	public int getJoinCnt() {
		return joinCnt;
	}

	public void setJoinCnt(int joinCnt) {
		this.joinCnt = joinCnt;
	}

	@Override
	public String toString() {
		return "MemberVO [memberNO=" + memberNO + ", memberId=" + memberId + ", nickName=" + nickName
				+ ", memberJoinDate=" + memberJoinDate + ", email=" + email + ", memberPwd=" + memberPwd + ", telNum="
				+ telNum + ", memberLevel=" + memberLevel + ", imageId=" + imageId + ", memberName=" + memberName
				+ ", updateDate=" + updateDate + ", approval_status=" + approval_status + ", approval_key="
				+ approval_key + ", articleCnt=" + articleCnt + ", commentCnt=" + commentCnt + ", loginCnt=" + loginCnt
				+ ", loginTime=" + loginTime + ", status=" + status + ", updateStatusDate=" + updateStatusDate
				+ ", levelName=" + levelName + ", role=" + role + "]";
	}
	
}
