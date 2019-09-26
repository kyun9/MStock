package dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.CompanyVO;

@Repository
public class CompanyDAO {
	@Autowired
	SqlSession session = null;
	
	public List<CompanyVO> listAll() {
		List<CompanyVO> list = new ArrayList<CompanyVO>();
		list = session.selectList("CompanyMapper.listall");
		System.out.println(list);
		return list;
	}
	
	public boolean updateCurjuka(String curjuka,String company_id) {
		boolean result = true;
		Map<String, String> parameters = new HashMap<String, String>();
		parameters.put("company_id", company_id);
		parameters.put("curjuka", curjuka);
		if (session.update("CompanyMapper.updateCurjuka", parameters) != 1) {
			result = false;
		}
		return result;
	}
	
}
