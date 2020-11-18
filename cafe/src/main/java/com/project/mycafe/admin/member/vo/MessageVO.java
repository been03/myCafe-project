package com.project.mycafe.admin.member.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("messageVO")
public class MessageVO {
	
	private int messageNo;
	private String memberId;
	private String nickName;
	private String messageTitle;
	private String messageContent;
	private Date sendDate;
	private String messageStatus;
	private Date readDate;
	private String senderNickName; 
	private String senderMemberId;
	
	public MessageVO() {
		// TODO Auto-generated constructor stub
	}
	
	public MessageVO(int messageNo, String memberId, String nickName, String messageTitle, String messageContent,
			Date sendDate, String messageStatus, Date readDate, String senderNickName, String senderMemberId) {
		super();
		this.messageNo = messageNo;
		this.memberId = memberId;
		this.nickName = nickName;
		this.messageTitle = messageTitle;
		this.messageContent = messageContent;
		this.sendDate = sendDate;
		this.messageStatus = messageStatus;
		this.readDate = readDate;
		this.senderNickName = senderNickName;
		this.senderMemberId = senderMemberId;
	}

	public int getMessageNo() {
		return messageNo;
	}

	public void setMessageNo(int messageNo) {
		this.messageNo = messageNo;
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

	public String getMessageTitle() {
		return messageTitle;
	}

	public void setMessageTitle(String messageTitle) {
		this.messageTitle = messageTitle;
	}

	public String getMessageContent() {
		return messageContent;
	}

	public void setMessageContent(String messageContent) {
		this.messageContent = messageContent;
	}

	public Date getSendDate() {
		return sendDate;
	}

	public void setSendDate(Date sendDate) {
		this.sendDate = sendDate;
	}

	public String getMessageStatus() {
		return messageStatus;
	}

	public void setMessageStatus(String messageStatus) {
		this.messageStatus = messageStatus;
	}

	public Date getReadDate() {
		return readDate;
	}

	public void setReadDate(Date readDate) {
		this.readDate = readDate;
	}

	public String getSenderNickName() {
		return senderNickName;
	}

	public void setSenderNickName(String senderNickName) {
		this.senderNickName = senderNickName;
	}

	public String getSenderMemberId() {
		return senderMemberId;
	}

	public void setSenderMemberId(String senderMemberId) {
		this.senderMemberId = senderMemberId;
	}

	@Override
	public String toString() {
		return "MessageVO [messageNo=" + messageNo + ", memberId=" + memberId + ", nickName=" + nickName
				+ ", messageTitle=" + messageTitle + ", messageContent=" + messageContent + ", sendDate=" + sendDate
				+ ", messageStatus=" + messageStatus + ", readDate=" + readDate + ", senderNickName=" + senderNickName
				+ ", senderMemberId=" + senderMemberId + "]";
	}
	
}
