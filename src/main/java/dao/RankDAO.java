package dao;

import org.apache.ibatis.session.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

@Repository
public class RankDAO {
	@Autowired
	SqlSession session = null;
	
	public String getGrade(int property) {
		String statement = "resource.RankMapper.getGrade";
		String grade = session.selectOne(statement, property);
		return grade;
	}
}
