package board.service;

import java.util.List;
import java.util.Map;

import board.bean.BoardDTO;
import board.bean.BoardPaging;

public interface BoardService {

	public void boardWrite(Map<String, String> map);

	public Map<String, Object> getBoardList(String pg);

	public BoardPaging getBoardPaging(String pg);

	public Map<String, Object> getBoardView(String seq);

}
