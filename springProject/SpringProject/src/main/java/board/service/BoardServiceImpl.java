package board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import board.bean.BoardDTO;
import board.bean.BoardPaging;
import board.dao.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private HttpSession session;
	@Autowired
	private BoardDAO boardDAO;
	
	@Autowired
	private BoardPaging boardPaging;
	
	@Override
	public void boardWrite(Map<String, String> map) {
		String id = (String)session.getAttribute("memId");
		String name = (String)session.getAttribute("memName");
		String email = (String)session.getAttribute("memEmail");
		
		map.put("id", id);
		map.put("name", name);
		map.put("email", email);
		
		boardDAO.boardWrite(map);
	}

	@Override
	public Map<String,Object> getBoardList(String pg) {
		
		int endNum = Integer.parseInt(pg)*5;
		int startNum = endNum - 4;
		
		//DB - 1페이지당 5개씩
		Map <String, Integer> map = new HashMap<String , Integer>();
		map.put("startNum", startNum);
		map.put("endNum", endNum);
		
		List<BoardDTO> list = boardDAO.getBoardList(map);
		
		//세션
		String memId = (String) session.getAttribute("memId");
		
		//페이징 처리
		boardPaging = this.getBoardPaging(pg);
		
		//새로고침 방지
		if(session.getAttribute("memId") != null) {
			session.setAttribute("memHit", "0");
		}
		
		Map<String, Object> sendMap = new HashMap<String, Object>();
		sendMap.put("memId", memId);
		sendMap.put("list", list);
		sendMap.put("boardPaging", boardPaging);
		
		return sendMap;
	}

	@Override
	public BoardPaging getBoardPaging(String pg) {
		
		int totalA= boardDAO.getTotalA(); //총 글 수 얻어오기
		
		boardPaging.setCurrentPage(Integer.parseInt(pg));
		boardPaging.setPageBlock(3);
		boardPaging.setPageSize(5);
		boardPaging.setTotalA(totalA);;
		boardPaging.makePagingHTML();
		
		return boardPaging;
	}

	@Override
	public Map<String, Object> getBoardView(String seq) {
		
		if(session.getAttribute("memHit") != null) {
			boardDAO.setHit(seq);
			session.removeAttribute("memHit");  
		}
		
		BoardDTO boardDTO = boardDAO.getBoardView(seq);
		//세션 
		String memId = (String) session.getAttribute("memId");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memId", memId);
		map.put("boardDTO", boardDTO);
		
		return map;
	}
	
}
