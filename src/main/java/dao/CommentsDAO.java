package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.CommentsVO;

@Repository
public class CommentsDAO {
	@Autowired
	SqlSession session = null;
	
	public List<CommentsVO> boardcom(int bid){
		List<CommentsVO> list = null;
		String statement = "CommentsMapper.boardcom";
		list = session.selectList(statement, bid);
		return list;
	}
	
	public boolean insert(CommentsVO vo) {
		boolean result = true;
		String statement = "CommentsMapper.insert";
		if(session.insert(statement, vo) != 1) result = false;
		return result;
	}
	
	public boolean delete(int cid) {
		boolean result = true;
		String statement = "CommentsMapper.delete";
		if(session.delete(statement,cid) != 1) result = false;
		return result;
	}
	
	public boolean update(CommentsVO vo) {
		boolean result = true;
		String statement = "CommentsMapper.update";
		if(session.update(statement, vo) != 1) result = false;
		return result;
	}
}
