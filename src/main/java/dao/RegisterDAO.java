package dao;

import org.apache.ibatis.session.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import vo.*;

@Repository
public class RegisterDAO {
	@Autowired
	SqlSession session = null;
	
	public boolean insert(UserVO vo) {
		String statement = "resource.RegisterMapper.insert";
		if (session.insert(statement, vo) != 1)
			return false;
		return true;
	}
	
	public boolean checkId(String id) {
		UserVO vo = null;
		boolean check = false;
		String statement = "resource.RegisterMapper.checkId";
		vo = session.selectOne(statement, id);
		if(vo == null) {
			check = true;
		}
		
		return check;
	}

	public boolean checkNickname(String nickname) {
		UserVO vo = null;
		boolean check = false;
		String statement = "resource.RegisterMapper.checkNickname";
		vo = session.selectOne(statement, nickname);
		if(vo == null) {
			check = true;
		}
		
		return check;
	}
	
	public boolean checkEmail(String email) {
		UserVO vo = null;
		boolean check = false;
		String statement = "resource.RegisterMapper.checkEmail";
		vo = session.selectOne(statement, email);
		if(vo == null) {
			check = true;
		}
		
		return check;
	}
	
}
