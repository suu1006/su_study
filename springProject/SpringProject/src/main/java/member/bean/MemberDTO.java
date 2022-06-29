package member.bean; //1인분 저장하기위한 도구

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class MemberDTO { // DTO 객체 만들기
	
	private String name;
	private String id;
	private String pwd;
	private String gender;
	private String email1;
	private String email2;
	private String tel1;
	private String tel2;
	private String tel3;
	private String zipcode;
	private String addr1;
	private String addr2;
	
}
