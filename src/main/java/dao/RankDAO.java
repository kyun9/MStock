package dao;

import java.util.*;

import org.apache.ibatis.session.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import vo.*;

@Repository
public class RankDAO {
	@Autowired
	SqlSession session = null;
	
	public String getGrade(int property) {
		String statement = "resource.RankMapper.getGrade";
		String grade = session.selectOne(statement, property);
		return grade;
	}
	
	public boolean updateGrade(int u_id, int account_id) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("u_id", u_id);
		map.put("account_id", account_id);
		String statement = "resource.RankMapper.updateGrade";
		if(session.update(statement, map) >= 1) {
			return true;
		}
		return false;
	}
	
	public void deleteRank() {
		String statement = "resource.RankMapper.deleteRank";
		session.delete(statement);
	}
	
	public void insertRnak() {
		String statement = "resource.RankMapper.insertRank";
		session.insert(statement);
	}
	
	public List<RankVO> getRankList() {
		List<RankVO> list = null;
		String statement = "resource.RankMapper.getRankList";
		list = session.selectList(statement);
		return list;
	}
}
