package dao;

import org.apache.ibatis.session.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

@Repository
public class UserDAO {
	
	@Autowired
	SqlSession session = null;
	
	public String getNickname(int u_id) {
		String nickname = null;
		String statement = "resource.UserMapper.getNickname";
		nickname = session.selectOne(statement, u_id);
		return nickname;
	}
}
