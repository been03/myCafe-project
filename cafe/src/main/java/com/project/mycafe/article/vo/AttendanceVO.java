package com.project.mycafe.article.vo;

import java.util.Date;

public class AttendanceVO {
	private int attendanceId;
	private String nickName;
	private Date attendanceDate;
	private String content;
	private String imageId;
	private String memberId;
	
	public AttendanceVO() {
		super();
	}

	public AttendanceVO(int attendanceId, String nickName, Date attendanceDate, String content) {
		super();
		this.attendanceId = attendanceId;
		this.nickName = nickName;
		this.attendanceDate = attendanceDate;
		this.content = content;
	}

	public int getAttendanceId() {
		return attendanceId;
	}

	public void setAttendanceId(int attendanceId) {
		this.attendanceId = attendanceId;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public Date getAttendanceDate() {
		return attendanceDate;
	}

	public void setAttendanceDate(Date attendanceDate) {
		this.attendanceDate = attendanceDate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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

	@Override
	public String toString() {
		return "AttendanceVO [attendanceId=" + attendanceId + ", nickName=" + nickName + ", attendanceDate="
				+ attendanceDate + ", content=" + content + "]";
	}
}
