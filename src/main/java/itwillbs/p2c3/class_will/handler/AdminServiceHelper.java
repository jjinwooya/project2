package itwillbs.p2c3.class_will.handler;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Component;

import itwillbs.p2c3.class_will.service.AdminService;
import itwillbs.p2c3.class_will.vo.GroupedData;

@Component
public class AdminServiceHelper {
	
    private final AdminService adminService;

    public AdminServiceHelper(AdminService adminService) {
        this.adminService = adminService;
    }

    public void processRows(List<Map<String, Object>> rows, String action) throws Exception {
        Map<String, List<Map<String, Object>>> groupedData = rows.stream()
                .collect(Collectors.groupingBy(row -> (String) row.get("largeCategory")));
        
        List<GroupedData> sortedData = groupedData.entrySet().stream()
                .sorted(Map.Entry.comparingByKey())
                .map(entry -> new GroupedData(entry.getKey(), entry.getValue()))
                .collect(Collectors.toList());
        
        for (GroupedData gd : sortedData) {
            Integer common2_code = adminService.getCommon2Code("CLC", gd.getLargeCategory());
            for (Map<String, Object> rowMap : gd.getRows()) {
                rowMap.put("common2_code", common2_code);
                if ("update".equals(action)) {
                    adminService.updateCategoryData(rowMap);
                } else if ("insert".equals(action)) {
                    int max_code = adminService.getMaxCommon3Code(common2_code);
                    rowMap.put("max_code", max_code);
                    adminService.insertCategoryData(rowMap);
                } else if ("delete".equals(action)) {
                    adminService.deleteCategoryData(rowMap);
                }
            }
        }
    }
}
