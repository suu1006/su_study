package member.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import member.bean.MemberDTO;
import member.service.MemberService;

@Controller
@RequestMapping(value="member")
public class MemberController {
	@Autowired // 자동으로 그 값을 받아와라
	private MemberService memberService;
	
	@PostMapping(value = "login")  // /springProject/index >>  value = "index" > 사용자 요청이자 브라우저에 표시되는 url
	@ResponseBody // view(.jsp)로 가지 않고 return 값(String) 그 자체를 반환함
	public String login(@RequestParam Map<String, String> map) { // map으로 뒤에서 묶을 거 알아서 미리 여기서 map으로 처리해줬음.
		// 서비스로 건너가자 
		return memberService.login(map);
	}
	@PostMapping(value="logout")
	@ResponseBody
	public void logout() {
		memberService.logout();
	}
	@GetMapping(value="writeForm")
	public ModelAndView writeForm(Model model) { 
		ModelAndView mav = new ModelAndView();
		mav.addObject("menu", "/WEB-INF/main/menu.jsp");
		mav.addObject("nav", "/WEB-INF/main/nav.jsp");
		mav.addObject("display", "/WEB-INF/member/writeForm.jsp");
		mav.setViewName("/index"); // /springProject/WEb-INF/index.jsp -> Spring 반환하는 jsp페이지 
		return mav; 
	}
	@PostMapping(value="checkId")
	@ResponseBody
	public String checkId(@RequestParam String id) {
		return memberService.checkId(id);
	}
	@PostMapping(value="write")
	@ResponseBody
	public void write(@ModelAttribute MemberDTO memberDTO) {
		memberService.write(memberDTO);
	}
	@GetMapping(value="updateForm")
	public ModelAndView updateForm() { 
		ModelAndView mav = new ModelAndView();
		mav.addObject("menu", "/WEB-INF/main/menu.jsp");
		mav.addObject("nav", "/WEB-INF/main/nav.jsp");
		mav.addObject("display", "/WEB-INF/member/updateForm.jsp");
		mav.setViewName("/index"); // /springProject/WEb-INF/index.jsp -> Spring 반환하는 jsp페이지 
		return mav; 
	}
	@PostMapping(value="getMember")
	@ResponseBody
	public MemberDTO getMember(HttpSession session) { // 세션값 이용해서 dto 받아오기 // 세션 주세요 하면 세션 줌 . 
		String id = (String) session.getAttribute("memId");
		return memberService.getMember(id);
	}
	@PostMapping(value="update")
	@ResponseBody
	public void update(@ModelAttribute MemberDTO memberDTO) { // 어떤게 수정되었는지 모르니까 dto로 보내자
		memberService.update(memberDTO);
	}
}
