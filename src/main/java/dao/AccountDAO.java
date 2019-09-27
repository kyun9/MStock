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
	
	public void updateCredit(int price,int account) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		System.out.println(price);
		System.out.println(account);
		map.put("price", price);
		map.put("account", account);
		System.out.println(map);
		System.out.println("여기");
		session.update("resource.AccountMapper.updateCredit", map);
		System.out.println("here");
//		if(session.update("resource.AccountMapper.updateCredit", map)==1) {
//			System.out.println("credit updtate");
//		}
	}
	
}
