package dao;

import java.util.*;

import org.apache.ibatis.session.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import vo.*;

@Repository
public class PurchaseDAO {
	@Autowired
	SqlSession session = null;
	
	//총 주식 보유액 get
	public int getStockValue(int account_id) {
		int stock_value;
		String statement = "resource.PurchaseMapper.getStockValue";
		stock_value = session.selectOne(statement, account_id);
		return stock_value;
	}
	
	//보유한 주식 List get
	public List<MyStockVO> getMyStock(int account_id) {
		List<MyStockVO> myStock = null;
		String statement = "resource.PurchaseMapper.getMyStock";
		myStock = session.selectList(statement, account_id);
		return myStock;
	}
	
	//보유한 주식 종목에 대한 데이터 get
	public List<PurchaseVO> getOneCompanyStock(String company_id, String account_id){
		List<PurchaseVO> purchaseVO = null;
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("company_id", company_id);
		map.put("account_id", account_id);
		String statement = "resource.PurchaseMapper.getOneCompanyStock";
		purchaseVO = session.selectList(statement, map);
		return purchaseVO;
	}
	
	//구매 종목 insert Purchase_List TABLE, Update Account TABLE
	public void purchaseStock(PurchaseVO vo) {
		if(session.insert("resource.PurchaseMapper.insertPurchasesStock", vo)!=0) {
			System.out.println("Purchase_List TABLE insert 성공");
		}else {
			System.out.println("insert 실패");
		}
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("price", vo.getPrice());
		map.put("account", vo.getAccount_id());
		if(session.update("resource.AccountMapper.updateCredit", map)!=0) {
			System.out.println("Account TABLE update 성공");
		}
		else {
			System.out.println("credit update 실패");
		}
	}
	
}
