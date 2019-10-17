package dao;

import java.util.*;

import org.apache.ibatis.session.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import vo.*;

@Repository
public class AccountDAO {
	@Autowired
	SqlSession session = null;
	
	public AccountVO getAccount(int u_id) {
		AccountVO vo = null;
		String statement = "resource.AccountMapper.getAccount";
		vo = session.selectOne(statement, u_id);
		return vo;
	}
	
	public int getAccountCnt() {
		int cnt = 0;
		String statement = "resource.AccountMapper.getAccountCnt";
		cnt = session.selectOne(statement);
		return cnt;
	}
	
	public int getAccountPrice(int account_id) {
		int price = 0;
		String statement = "resource.AccountMapper.getAccountPrice";
		price = session.selectOne(statement, account_id);
		return price;
	}
	
	public List<AccountVO> getAccountList(){
		List<AccountVO> list = null;
		String statement = "resource.AccountMapper.getAccountList";
		list = session.selectList(statement);
		return list;
	}
	
	public int getU_id(int account_id) {
		int u_id = 0;
		String statement = "resource.AccountMapper.getU_id";
		u_id = session.selectOne(statement, account_id);
		return u_id;
	}
	
	public boolean insertAccount(AccountVO vo) {
		boolean result = false;
		String statement = "resource.AccountMapper.insertAccount";
		result = session.insert(statement, vo) == 0 ? false : true;
		return result;
	}
	
	public boolean updateSellCredit(int account_id, int credit) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();	
		map.put("account_id", account_id);
		map.put("credit", credit);
		boolean result = false;
		String statement = "resource.AccountMapper.updateSellCredit";
		result = session.insert(statement, map) == 0 ? false : true;
		return result;
	}
	
}
