package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.BoardVO;

@Repository
public class BoardDAO {
	@Autowired
	SqlSession session = null;

	public boolean insert(BoardVO vo) {
		boolean result = true;
		if (session.insert("BoardMapper.insertBoard", vo) != 1)
			result = false;
		return result;
	}

	public boolean update(BoardVO vo) {
		boolean result = true;
		if (session.update("BoardMapper.updateBoard", vo) != 1)
			result = false;
		System.out.println("DAO result : "+ result);
		return result;
	}

	public boolean delete(int id) {
		boolean result = true;
		if (session.delete("BoardMapper.deleteBoard", id) != 1)
			result = false;
		return result;
	}

	public List<BoardVO> listAll(int page) {
		return session.selectList("BoardMapper.listAllBoard",page);
	}
	
	public int boardCnt() {
		String statement = "BoardMapper.boardCnt";
		return session.selectOne(statement);
	}
	public int listWriterCnt(String writer) {
		String statement = "BoardMapper.listWriterCnt";
		return session.selectOne(statement,writer);
	}

	public BoardVO listOne(int id) {
		session.update("BoardMapper.updateCount", id);
		return session.selectOne("BoardMapper.listOneBoard", id);
	}

	public List<BoardVO> listWriter(String writer,int page) {
		Map<String, String> parameters = new HashMap<String, String>();
		parameters.put("page",Integer.toString(page));
		parameters.put("writer",writer);
		return session.selectList("BoardMapper.listWriter", parameters);
	}

	public List<BoardVO> search(String key, String searchType,int page) {
		Map<String, String> parameters = new HashMap<String, String>();
		parameters.put("key", key);
		parameters.put("searchType", searchType);
		parameters.put("page",Integer.toString(page));
		return session.selectList("BoardMapper.searchInfo", parameters);
	}
	
	public int boardSearchCnt(String key, String searchType) {
		Map<String, String> parameters = new HashMap<String, String>();
		parameters.put("key", key);
		parameters.put("searchType", searchType);
		String statement = "BoardMapper.boardSearchCnt";
		return session.selectOne(statement,parameters);
	}
	
}
