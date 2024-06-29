//package itwillbs.p2c3.class_will.controller;
//
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.bind.annotation.RestController;
//
//import net.nurigo.sdk.NurigoApp;
//import net.nurigo.sdk.message.model.Message;
//import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
//import net.nurigo.sdk.message.response.SingleMessageSentResponse;
//import net.nurigo.sdk.message.service.DefaultMessageService;
//
//@RestController
//public class CoolSMSController {
//	
//	final DefaultMessageService messageService;
//	
//	public CoolSMSController() {
//		this.messageService = NurigoApp.INSTANCE.initialize("NCSESYLSEBAEX3CO", "JGPZQLJ2NMBNH7FH7FNH7VM1J2WQ5H5P", "https://api.coolsms.co.kr");
//	}
//	
//	
//	@ResponseBody
//	@PostMapping("/send-one")
//    public SingleMessageSentResponse sendOne() {
//	 	
//        Message message = new Message();
//        // 발신번호 및 수신번호는 반드시 01012345678 형태로 입력되어야 합니다.
//        message.setFrom("01073034573");
//        message.setTo("01035003856");
//        message.setText("test");
//
//        SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
//        System.out.println(response);
//
//        return response;
//    }
//	
//
//}
