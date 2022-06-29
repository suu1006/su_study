package board.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import board.service.BoardService;

@Controller // 어노테이션 등록하지 않으면 찾지 못함. 꼭 등록하기!!
@RequestMapping(value="/board") 
public class BoardController {
	
	@Autowired
	private BoardService boardSevice;
	
	
//	public String boardWrite(Model model) {
//		model.addAttribute("display", "/WEB-INF/board/boardWriteForm.jsp"); 
//		return "forward:/index";  // 하나하나 다 가져가야하는데 이렇게 쓰면 다 가져가짐.
//	}
	
	@GetMapping(value="boardWriteForm") // 링크타고 들어오는거면 get방식
	public ModelAndView boardWriteForm() {
	ModelAndView mav = new ModelAndView();
	mav.addObject("menu", "/WEB-INF/main/menu.jsp");
	mav.addObject("nav", "/WEB-INF/main/nav.jsp");
	mav.addObject("display", "/WEB-INF/board/boardWriteForm.jsp");
	mav.setViewName("/index"); // /springProject/WEb-INF/index.jsp -> Spring 반환하는 jsp페이지 
	return mav; 
	}
	
	@PostMapping(value="boardWrite")
	@ResponseBody
	public void boardWrite(@RequestParam Map<String, String> map) { // subject, content 만 받음 (아이디 등등 안받음.)
		boardSevice.boardWrite(map); // 원글
	}
	
	@GetMapping(value="boardList") 
	public ModelAndView boardList(@RequestParam(required = false, defaultValue = "1") String pg) { // 페이지값이 안들어올때도 있다. ㅇ그땐 1페이지로 가라!
		ModelAndView mav = new ModelAndView();
		mav.addObject("pg", pg);
		mav.addObject("menu", "/WEB-INF/main/menu.jsp");
		mav.addObject("nav", "/WEB-INF/main/nav.jsp");
		mav.addObject("display", "/WEB-INF/board/boardList.jsp");
		mav.setViewName("/index"); // /springProject/WEb-INF/index.jsp -> Spring 반환하는 jsp페이지 
		return mav; 
	}
	@PostMapping(value="getBoardList")
	@ResponseBody
	public Map<String, Object> getBoardList(@RequestParam(required=false, defaultValue = "1") String pg) {
		
		return boardSevice.getBoardList(pg);
		
	}
	
	@GetMapping(value="boardView")
	public ModelAndView boardView(@RequestParam String seq, @RequestParam String pg) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("seq", seq);
		mav.addObject("pg", pg);
		mav.addObject("menu", "/WEB-INF/main/menu.jsp");
		mav.addObject("nav", "/WEB-INF/main/nav.jsp");
		mav.addObject("display", "/WEB-INF/board/boardView.jsp");
		mav.setViewName("/index"); 
		return mav; 
	}
	@PostMapping(value="getBoardView")
	@ResponseBody
	public Map<String, Object> getBoardView (@RequestParam String seq) {
		return boardSevice.getBoardView(seq);
	}
	
}
