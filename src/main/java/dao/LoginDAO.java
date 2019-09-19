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
	
}
