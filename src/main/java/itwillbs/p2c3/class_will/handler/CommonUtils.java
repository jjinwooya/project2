package itwillbs.p2c3.class_will.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import itwillbs.p2c3.class_will.service.AdminService;

@Component
public class CommonUtils {
	
	@Autowired
	private AdminService adminService;
	
	public List<Map<String, Object>> commonProcess(String tableName) {
		List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
		List<String> columnNames = adminService.getColumnNames(tableName);
		
		for(int i = 0; i < columnNames.size();i++) {
			String common1_code = adminService.getCommonCode(columnNames.get(i));
			if(common1_code == null) {
				continue;
			}
			Map<String, Object> map = new HashMap<String, Object>();
			map.put(columnNames.get(i), common1_code);
			mapList.add(map);
		}
		
		return mapList;
	}

	public Map<String, Object> commonProcess(String tableName, Object... param) {
		// 테이블명에 해당하는 컬럼명들 추출
		List<String> columnNames = adminService.getColumnNames(tableName);
		
		Map<String, Object> map = new HashMap<String, Object>();
		for(int i = 0; i < columnNames.size();i++) {
			String common1_code = adminService.getCommonCode(columnNames.get(i));
			if(common1_code == null) {
				continue;
			}
			map.put(columnNames.get(i), common1_code);
		}
		for(int i = 0; i < param.length;i++) {
			map.put("param" + (i + 1) , param[i]);
		}
		return map;
	}
}
