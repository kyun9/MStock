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
		String statement = "resource.HistoryMapper.insertHistory";
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
	
	public List<HistoryVO> getHistoryList(int startIndex){
		List<HistoryVO> list = null;
		String statement = "resource.HistoryMapper.getHistoryList";
		list = session.selectList(statement, startIndex);
		return list;
	}
	
}
