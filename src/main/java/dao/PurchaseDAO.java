package dao;

import org.apache.ibatis.session.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

@Repository
public class PurchaseDAO {
	@Autowired
	SqlSession session = null;
	
	public int getStockValue(int account_id) {
		int stock_value;
		String statement = "resource.PurchaseMapper.getStockValue";
		stock_value = session.selectOne(statement, account_id);
		return stock_value;
	}
}
