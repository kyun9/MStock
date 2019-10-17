package dao;

import java.util.*;
import org.apache.ibatis.session.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import vo.*;

@Repository
public class HistoryDAO {
	@Autowired
	SqlSession session = null;
	
	public boolean insertHistory(HistoryVO vo) {
		String statement = "resource.HistoryMapper.insertSellHistory";
		if (session.insert(statement, vo) != 1)
			return false;
		return true;
	}
	
	public int getHistoryCnt(int account_id) {
		int cnt = 0;
		String statement = "resource.HistoryMapper.getHistoryCnt";
		cnt = session.selectOne(statement, account_id);
		return cnt;
	}
	
	public List<HistoryVO> getHistoryList(int account_id, int startIndex){
		List<HistoryVO> list = null;
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("account_id", account_id);
		map.put("startIndex", startIndex);
		String statement = "resource.HistoryMapper.getHistoryList";
		list = session.selectList(statement, map);
		return list;
	}
	
}
