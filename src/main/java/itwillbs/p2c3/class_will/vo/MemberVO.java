package itwillbs.p2c3.class_will.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MemberVO {
	private int member_code;
	private String member_email;
	private String member_name;
	private String member_img;
	private MultipartFile member_imageFile;
	private String member_tel;
	private String member_pwd;
	private String member_social;
	private String member_marketing1;
	private String member_marketing2;
	private String member_status;
	private String member_addr;
	private String member_nickname;
	private String member_credit;
	private String member_type;
	private String member_reg_date;
	//회원가입할 때 주소때문에 필요함.. 
	private String member_post_code;
	private String member_address1;
	private String member_address2;
}
