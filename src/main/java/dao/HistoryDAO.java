package dao;

import org.apache.ibatis.session.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

@Repository
public class HistoryDAO {
	@Autowired
	SqlSession session = null;
}
