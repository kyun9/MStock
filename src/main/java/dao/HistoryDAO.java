package dao;

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
	
}
