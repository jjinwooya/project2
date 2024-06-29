package itwillbs.p2c3.class_will.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class EventController {
	
	@GetMapping("event")
	public String eventMain() {
		return "event/event_main";
	}
	
	@GetMapping("eventDetail")
	public String eventDetail() {
		return "event/event_detail";
	}
}
