package itwillbs.p2c3.class_will.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import itwillbs.p2c3.class_will.mapper.MainMapper;

@Service
public class MainService {
	
	@Autowired
	private MainMapper mainMapper;

	public Map<String, List<Map<String, Object>>> selectFieldCate() {
		
		Map<String, List<Map<String, Object>>> feildCateList = new HashMap<String, List<Map<String,Object>>>();
		List<Map<String, Object>> bigCategory = mainMapper.selectBigCategory();
		List<Map<String, Object>> smallCategory = mainMapper.selectSmallCategory();
		feildCateList.put("bigCategory", bigCategory);
		feildCateList.put("smallCategory", smallCategory);
		
		return feildCateList;
	}

	public List<Map<String, Object>> selectLocalCate() {
		
		return mainMapper.selectLocalCate();
	}
	
	
//	@Transactional
//	public List<Map<String, Object>> checkKeyword(String keyword, String searchDateTime) {
//		
//		mainMapper.insertKeyword(keyword, searchDateTime);
//		System.out.println("checkKeyword - insertKeyword 성공");
//		
//		List<Map<String, Object>> searchClassList = mainMapper.selectKeyword(keyword);
//		
//		return searchClassList;
//	}
	public void checkKeyword(String keyword, String searchDateTime) {
		
		if(mainMapper.insertKeyword(keyword, searchDateTime)) {
			System.out.println("checkKeyword - insertKeyword 성공");
			
		}
		
		
	}

	
	
	
	
		

	
	
	
	
	
}
