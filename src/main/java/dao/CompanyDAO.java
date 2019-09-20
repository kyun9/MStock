package dao;

import java.util.ArrayList;
import java.util.List;

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
}
