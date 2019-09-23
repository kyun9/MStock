package dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class StockInfoDAO {
	@Autowired
	SqlSession session = null;
	
	public boolean insertStockInfo(String jongCd, String curjuka,String time) {
		boolean result= true;
		Map<String, String> parameters = new HashMap<String, String>();
		parameters.put("jongCd", jongCd);
		parameters.put("curjuka", curjuka);
		parameters.put("time", time);
		if (session.insert("StockInfoMapper.insertStockInfo", parameters) != 1) {
			result = false;
		}
		return result;
	}
	
	public boolean clearStockDB() {
		boolean result =true;
		if(session.delete("StockInfoMapper.clearStockDB")!=0) {
			result = false;
		}
		return result;
	}
}
