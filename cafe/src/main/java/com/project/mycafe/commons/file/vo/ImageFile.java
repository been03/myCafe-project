package com.project.mycafe.commons.file.vo;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class ImageFile {
	//photo_uploader.html페이지의 form태그내에 존재하는 file 태그의 name명과 일치시켜줌
    private MultipartFile Filedata;
    //callback URL
    private String callback;
    //콜백함수
    private String callback_func;
 
    public MultipartFile getFiledata() {
        return Filedata;
    }
 
    public void setFiledata(MultipartFile filedata) {
        Filedata = filedata;
    }
 
    public String getCallback() {
        return callback;
    }
 
    public void setCallback(String callback) {
        this.callback = callback;
    }
 
    public String getCallback_func() {
        return callback_func;
    }
 
    public void setCallback_func(String callback_func) {
        this.callback_func = callback_func;
    }
    
    private int eventId;
	private int imageId;
	private String imageFileName;
	private String fileType;
	private String memberId;
	public ImageFile() {
		super();
	}

	public ImageFile(MultipartFile filedata, String callback, String callback_func, int eventId, int imageId,
			String imageFileName, String fileType, String memberId) {
		super();
		Filedata = filedata;
		this.callback = callback;
		this.callback_func = callback_func;
		this.eventId = eventId;
		this.imageId = imageId;
		this.imageFileName = imageFileName;
		this.fileType = fileType;
		this.memberId = memberId;
	}

	public int getEventId() {
		return eventId;
	}

	public void setEventId(int eventId) {
		this.eventId = eventId;
	}

	public int getImageId() {
		return imageId;
	}

	public void setImageId(int imageId) {
		this.imageId = imageId;
	}

	public String getImageFileName() {
		return imageFileName;
	}

	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}

	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	@Override
	public String toString() {
		return "ImageFile [Filedata=" + Filedata + ", callback=" + callback + ", callback_func=" + callback_func
				+ ", eventId=" + eventId + ", imageId=" + imageId + ", imageFileName=" + imageFileName + ", fileType="
				+ fileType + ", memberId=" + memberId + "]";
	}

}
