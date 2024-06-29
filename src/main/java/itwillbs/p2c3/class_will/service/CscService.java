package itwillbs.p2c3.class_will.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import itwillbs.p2c3.class_will.mapper.CscMapper;

@Service
public class CscService {
	
	@Autowired
	private CscMapper cscMapper;

	public Map<String, String> getBoardDetail(Map<String, Object> params) {
		return cscMapper.selectBoardDetail(params);
	}

	public Integer getPagingNum(int code, String searchType) {
		return cscMapper.searchPaging(code, searchType);
	}

	public List<Map<String, String>> getBoardCategoryHide(String code) {
		return cscMapper.selectBoardCategoryHide(code);
	}

	public int getBoardCountHide(String type) {
		return cscMapper.selectBoardCountHide(type);
	}
}
