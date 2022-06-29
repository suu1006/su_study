package member.service;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import member.bean.MemberDTO;
import member.dao.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDAO memberDAO;
	@Autowired
	private HttpSession session;// 자동으로 세션의 값을 받아온다.(reqeust로부터 세션을 얻어옴 오토와이어 시켜주면 값을 가져옴.)
	
	@Override
	public String login(Map<String, String> map) {
		//DB 
		MemberDTO memberDTO = memberDAO.login(map); // 한사람 분량의 데이터를 끌고와라
		//dto가 null이 아니라면? ok 
		if (memberDTO !=null) {
			  session.setAttribute("memName", memberDTO.getName()); 
			  session.setAttribute("memId", memberDTO.getId());
			  session.setAttribute("memEmail", memberDTO.getEmail1() + "@" + memberDTO.getEmail2());
			  return "ok";
		} else {
			  return "fail";
		}
		
	}

	@Override
	public void logout() {
		
		session.invalidate(); // 세션 무효화
		
	}

	@Override
	public String checkId(String id) {
		
		MemberDTO memberDTO = memberDAO.checkId(id);
		if(memberDTO == null)
			return "non_exist"; // 사용가능
		else 
			return "exist"; //사용불가능
	}

	@Override
	public void write(MemberDTO memberDTO) {
		memberDAO.write(memberDTO);
	}

	@Override
	public MemberDTO getMember(String id) {
		return memberDAO.getMember(id);
	}

	@Override
	public void update(MemberDTO memberDTO) {
		memberDAO.update(memberDTO);
		session.invalidate(); // 세션값 무효화처리 = 로그아웃됨.
		
	}
	
}
