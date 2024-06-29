package itwillbs.p2c3.class_will.service;

import org.springframework.stereotype.Service;

import itwillbs.p2c3.class_will.handler.SendMailClient;
import itwillbs.p2c3.class_will.vo.MemberVO;

@Service
public class MailService {

	public void sendAuthMail(MemberVO member) {
		String subject = "[클래스윌] 비밀번호 변경 안내입니다.";
		String info = "비밀번호를 변경하시려면 링크를 클릭하세요.";
		String content = "<a href='http://localhost:8081/class_will/reset-passwd?email=" + member.getMember_email() +  "'>" + info +"</a>";
		SendMailClient mailClient = new SendMailClient();
		
		new Thread(new Runnable() {
			@Override
			public void run() {
				mailClient.sendMail(member.getMember_email(), subject, content);
			}
		}).start();
		
		
		
	}
	
	
	


}
