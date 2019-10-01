package dao;

import org.apache.ibatis.session.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import vo.*;

@Repository
public class LoginDAO {
	@Autowired
	SqlSession session = null;
	
	public boolean checkLogin(UserVO vo) {
		UserVO temp = null;
		boolean check = false;
		String statement = "resource.LoginMapper.checkLogin";
		temp = session.selectOne(statement, vo);
		if(temp != null) {
			check = true;
		}		
		return check;
	}

	public UserVO getUserInfo(String id) {
		UserVO vo = null;
		String statement = "resource.LoginMapper.getUserInfo";
		vo = session.selectOne(statement, id);
		return vo;
	}
	
	public boolean checkUser(String id) {
		String statement = "resource.LoginMapper.checkUser";
		int count = session.selectOne(statement, id);
		if(count != 1) {
			return false;
		}
		return true;
	}
	
	/*
	public boolean insertNaverUser(UserVO vo) {
		String statement = "resource.RegisterMapper.insertNaverUser";
		if (session.insert(statement, vo) != 1)
			return false;
		return true;
	}
	*/

}
