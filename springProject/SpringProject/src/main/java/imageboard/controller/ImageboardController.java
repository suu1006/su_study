package imageboard.controller;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import imageboard.bean.ImageboardDTO;
import imageboard.service.ImageboardService;

@Controller
@RequestMapping(value="imageboard")
public class ImageboardController {
	@Autowired
	private ImageboardService imageboardService;
	
	@GetMapping(value="imageboardWriteForm")
	public ModelAndView boardView() {
		ModelAndView mav = new ModelAndView();
		mav.addObject("menu", "/WEB-INF/main/menu.jsp");
		mav.addObject("nav", "/WEB-INF/main/nav.jsp");
		mav.addObject("display", "/WEB-INF/imageboard/imageboardWriteForm.jsp");
		mav.setViewName("/index"); 
		return mav; 
	}
	
	@PostMapping(value="imageboardWrite")
	@ResponseBody
	public void imageboardWrite(@ModelAttribute ImageboardDTO imageboardDTO, // 모든 것들이 dto로 넘어와버리기때문에 multipart로 가지 않는다!! 
										@RequestParam MultipartFile img, 
										HttpSession session) {
		
		//실제 폴더 (가상폴더에는 보이지 않음.)
		String filePath = session.getServletContext().getRealPath("/WEB-INF/storage");
		String fileName = img.getOriginalFilename();
		
		File file = new File(filePath, fileName); // 파일 경로, 파일 이름 설정
		
		try {
			img.transferTo(file); // 업로드
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		imageboardDTO.setImage1(fileName); // 업로드하고나서 dto에 저장
		
		imageboardService.imageboardWrite(imageboardDTO);
		//DB
	}
		@GetMapping(value="imageboardList")
		@ResponseBody
		public ModelAndView imageboardList(@RequestParam(required=false, defaultValue="1") String pg) { // pg가 안들어올 수도 있으니까 안들어오면 1페이지로 기본값을 설정
			ModelAndView mav = new ModelAndView();
			mav.addObject("pg", pg);
			mav.addObject("menu", "/WEB-INF/main/menu.jsp");
			mav.addObject("nav", "/WEB-INF/main/nav.jsp");
			mav.addObject("display", "/WEB-INF/imageboard/imageboardList.jsp");
			mav.setViewName("/index"); 
			return mav; 
		}
		@PostMapping(value="getImageboardList")
		@ResponseBody // json으로 변환이되어서 list.jsp의 success 의 function(data)에 들어간다.
		public Map<String, Object> getImageboardList(@RequestParam String pg) {
			return imageboardService.getImageboardList(pg);
		}
		
		@GetMapping(value="imageboardDelete")
		public ModelAndView imageboardDelete(@RequestParam String[] check) {
			imageboardService.imageboardDelete(check);
			return new ModelAndView("redirect:/imageboard/imageboardList");  
		}
	
	
}
