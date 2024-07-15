package itwillbs.p2c3.class_will.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import itwillbs.p2c3.class_will.service.ChatService;
import itwillbs.p2c3.class_will.vo.MemberVO;

@Controller
public class ChatController {
	
	@Autowired 
	private HttpSession session;
	
	@Autowired
	private ChatService chatservice;
	
	
	
	@GetMapping("user-chat-list")
	public String userChatList(MemberVO member, Model model, HttpServletRequest request) {
		
		return "user_chat/user_chat_list";
		
	} // userChatList()
	
	@GetMapping("user-chat-room")
	public String userChatRoom(MemberVO member, Model model, @RequestParam(defaultValue = "") int receiver_code, HttpServletRequest request) {
		
		MemberVO receiverInfo = chatservice.selectMemberInfo(receiver_code);
		
		model.addAttribute("receiverInfo", receiverInfo);
		
		return "user_chat/user_chat_room";
		
	} // userChatList()
	
	
	
	
	
}
