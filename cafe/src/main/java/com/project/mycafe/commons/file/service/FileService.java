package com.project.mycafe.commons.file.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.mycafe.commons.file.dao.FileDAO;
import com.project.mycafe.commons.file.vo.ImageFile;

@Service("fileService")
@Transactional(propagation=Propagation.REQUIRED)
public class FileService {
	@Autowired
	FileDAO fileDAO;
	
	public void insertImages(ImageFile image) {
		fileDAO.insertImages(image);
	}
	
	public List<ImageFile> selectImages(int start, int end){
		return fileDAO.selectImages(start, end);
	}
}
