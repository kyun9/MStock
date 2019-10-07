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
	
	public boolean insertAccount(AccountVO vo) {
		boolean result = false;
		String statement = "resource.AccountMapper.insertAccount";
		result = session.insert(statement, vo) == 0 ? false : true;
		return result;
	}
	
	public boolean updateCredit(int account_id, int credit) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();	
		map.put("account_id", account_id);
		map.put("credit", credit);
		boolean result = false;
		String statement = "resource.AccountMapper.updateCredit";
		result = session.insert(statement, map) == 0 ? false : true;
		return result;
	}
	
}
