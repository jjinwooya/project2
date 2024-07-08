package itwillbs.p2c3.class_will.handler;

import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

@Component
public class WillUtils {
	
	// 상수
	
	//succes or fail
	public static final int SUCCESS = 4012031;
	public static final int FAIL = 733431;
	
	// 자식창 닫기 or 안닫기
	public static final int CLOSE = 6995443;
	public static final int NOT_CLOSE = 3042053;
	
	
	public static String checkDeleteSuccess(boolean isSuccess, Model model, String msg, boolean isClose) {
		String result = "result_process/";
		result += isSuccess ? "success" : "fail";
		model.addAttribute("msg", msg);
		if(isClose) {
			model.addAttribute("isClose", "true");
		}
		return result;
	}
	
	public static String checkDeleteSuccess(int isSuccess, Model model, String msg, int isClose) {
		if(isSuccess == 4012031) {
			model.addAttribute("msg", msg);
			
			if(isClose == 6995443) {
				model.addAttribute("isClose", "true");
			}
			return "result_process/success";
		}else {
			model.addAttribute("msg", msg);
			
			if(isClose == 6995443) {
				model.addAttribute("isClose", "true");
			}
			return "result_process/fail";
		}
		
	}
	
	public static String checkDeleteSuccess(int isSuccess, Model model, String msg, int isClose, String targetURL) {
		if(isSuccess == 4012031) {
			model.addAttribute("msg", msg);
			
			if(isClose == 6995443) {
				model.addAttribute("isClose", "true");
			}
			model.addAttribute("targetURL", targetURL);
			
			return "result_process/success";
		}else {
			model.addAttribute("msg", msg);
			
			if(isClose == 6995443) {
				model.addAttribute("isClose", "true");
			}
			model.addAttribute("targetURL", targetURL);
			
			return "result_process/success";
		}
		
	}
	public static String checkDeleteSuccess(boolean isSuccess, Model model, String msg, boolean isClose, String targetURL) {
		if(isSuccess) {
			model.addAttribute("msg", msg);
			
			if(isClose) {
				model.addAttribute("isClose", "true");
			}
			model.addAttribute("targetURL", targetURL);
			
			return "result_process/success";
		}else {
			model.addAttribute("msg", msg);
			
			if(isClose) {
				model.addAttribute("isClose", "true");
			}
			model.addAttribute("targetURL", targetURL);
			
			return "result_process/success";
		}
	}
}
