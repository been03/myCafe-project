package com.project.mycafe.admin.category.vo;

import org.springframework.stereotype.Component;

@Component("categoryVO")
public class CategoryVO {
	private int ctgId;
	private String ctgName;
	private int ctgWriteLevel;
	private int ctgReadLevel;

	public CategoryVO() {
		super();
	}

	public CategoryVO(int ctgId, String ctgName, int ctgWriteLevel, int ctgReadLevel) {
		super();
		this.ctgId = ctgId;
		this.ctgName = ctgName;
		this.ctgWriteLevel = ctgWriteLevel;
		this.ctgReadLevel = ctgReadLevel;
	}

	public int getCtgId() {
		return ctgId;
	}

	public void setCtgId(int ctgId) {
		this.ctgId = ctgId;
	}

	public String getCtgName() {
		return ctgName;
	}

	public void setCtgName(String ctgName) {
		this.ctgName = ctgName;
	}

	public int getCtgWriteLevel() {
		return ctgWriteLevel;
	}

	public void setCtgWriteLevel(int ctgWriteLevel) {
		this.ctgWriteLevel = ctgWriteLevel;
	}

	public int getCtgReadLevel() {
		return ctgReadLevel;
	}

	public void setCtgReadLevel(int ctgReadLevel) {
		this.ctgReadLevel = ctgReadLevel;
	}

	@Override
	public String toString() {
		return "CategoryVO [ctgId=" + ctgId + ", ctgName=" + ctgName + ", ctgWriteLevel=" + ctgWriteLevel
				+ ", ctgReadLevel=" + ctgReadLevel + "]";
	}

}