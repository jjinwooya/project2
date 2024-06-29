package itwillbs.p2c3.class_will.vo;

import java.util.List;

import java.util.Map;

import lombok.Data;
@Data
public class GroupedData {
	
    private String largeCategory;
    private List<Map<String, Object>> rows;
    private Integer common2_code;

    public GroupedData(String largeCategory, List<Map<String, Object>> rows) {
        this.largeCategory = largeCategory;
        this.rows = rows;
    }

    // Getters and setters
    public String getLargeCategory() {
        return largeCategory;
    }

    public void setLargeCategory(String largeCategory) {
        this.largeCategory = largeCategory;
    }

    public List<Map<String, Object>> getRows() {
        return rows;
    }

    public void setRows(List<Map<String, Object>> rows) {
        this.rows = rows;
    }
    
}

