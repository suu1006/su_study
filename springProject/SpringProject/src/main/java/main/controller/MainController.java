package main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MainController {
	
	@RequestMapping(value = "/index", method = RequestMethod.GET)  // /springProject/index >>  value = "index" > 사용자 요청이자 브라우저에 표시되는 url
	public ModelAndView index() {
		ModelAndView mav = new ModelAndView();
		mav.addObject("menu", "/WEB-INF/main/menu.jsp");
		mav.addObject("nav", "/WEB-INF/main/nav.jsp");
		mav.setViewName("/index"); // /springProject/WEb-INF/index.jsp -> Spring 반환하는 jsp페이지 
		return mav; 
	}
}



/*
 * /springProject/WEb-INF/index.jsp > Spring 반환하는 jsp페이지 
 * /springProject/index > 사용자 요청이자 브라우저에 표시되는 url
 */