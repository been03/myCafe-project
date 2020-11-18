package com.project.mycafe.commons.file.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.mycafe.commons.file.vo.ImageFile;

@Repository("fileDAO")
public class FileDAO {
	@Autowired
	SqlSession sqlSession;
	
	public void insertImages(ImageFile image) {
		System.out.println("image insert");
		sqlSession.insert("mapper.image.insertImages", image);
	}
	
	public List<ImageFile> selectImages(int start, int end){
		Map<String, Integer> map = new HashMap<String,Integer>();
		map.put("start", start);
		map.put("end", end);
		System.out.println("image 갖고오기");
		List<ImageFile> list = (ArrayList)sqlSession.selectList("mapper.image.selectImages", map);
		return list;
	}
}
