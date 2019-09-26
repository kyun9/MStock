package dao;

import org.apache.ibatis.session.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

@Repository
public class CompanyDAO {
	@Autowired
	SqlSession session = null;
	
	public int getCurJuka(String company_id) {
		int curJuka = 0;		
		String statement = "resource.CompanyMapper.getCurJuka";
		curJuka = session.selectOne(statement, company_id);
		return curJuka;
	}
}
