package itwillbs.p2c3.class_will.vo;

import lombok.Data;

@Data
public class ClassTimeVO {
	private String round;
	private String startTime;
	private String endTime;
	
	// --- 데이터 처리용 ---
	private String date;

}
