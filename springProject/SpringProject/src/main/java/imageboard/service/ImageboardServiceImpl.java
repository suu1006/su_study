package imageboard.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import imageboard.bean.ImageboardDTO;
import imageboard.bean.ImageboardPaging;
import imageboard.dao.ImageboardDAO;

@Service
public class ImageboardServiceImpl implements ImageboardService {
	
	@Autowired
	private ImageboardDAO imageboardDAO;
	
	@Autowired
	private ImageboardPaging imageboardPaging; 

	@Override
	public void imageboardWrite(ImageboardDTO imageboardDTO) {
		imageboardDAO.imageboardWrite(imageboardDTO);
		
	}

	@Override
	public Map<String, Object> getImageboardList(String pg) {
		//1페이지당 3개씩
		int endNum = Integer.parseInt(pg) * 3;
		int startNum = endNum -2;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startNum",startNum);
		map.put("endNum",endNum);
		
		List<ImageboardDTO> list = imageboardDAO.getImageboardList(map);
		
		//페이징 처리
		int totalA = imageboardDAO.getImageboardTotalA(); //총글 수
		
		imageboardPaging.setCurrentPage(Integer.parseInt(pg));
		imageboardPaging.setPageBlock(3);
		imageboardPaging.setPageSize(3);
		imageboardPaging.setTotalA(totalA);
		imageboardPaging.makePagingHTML(); //페이지를 만드는 애가 얘임!!
		
		Map<String, Object> sendMap = new HashMap<String, Object>();
		sendMap.put("list", list);
		sendMap.put("imageboardPaging", imageboardPaging);
		return sendMap;
	}

	@Override
	public void imageboardDelete(String[] check) {
		Map<String, String[]> map = new HashMap<String, String[]>();
		map.put("check", check);
		imageboardDAO.imageboardDelete(map); // 매퍼파일에서 맵으로 하고 있다. 
		
		
		
	}
	
}
