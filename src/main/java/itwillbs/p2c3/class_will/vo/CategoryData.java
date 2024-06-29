package itwillbs.p2c3.class_will.vo;

import java.util.List;
import java.util.Map;

public class CategoryData {
    private List<Map<String, Object>> createdRows;
    private List<Map<String, Object>> updatedRows;
    private List<Map<String, Object>> deletedRows;

    // Getters and setters
    public List<Map<String, Object>> getCreatedRows() {
        return createdRows;
    }

    public void setCreatedRows(List<Map<String, Object>> createdRows) {
        this.createdRows = createdRows;
    }

    public List<Map<String, Object>> getUpdatedRows() {
        return updatedRows;
    }

    public void setUpdatedRows(List<Map<String, Object>> updatedRows) {
        this.updatedRows = updatedRows;
    }

    public List<Map<String, Object>> getDeletedRows() {
        return deletedRows;
    }

    public void setDeletedRows(List<Map<String, Object>> deletedRows) {
        this.deletedRows = deletedRows;
    }
    
    
}