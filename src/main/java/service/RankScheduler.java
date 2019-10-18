package service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.scheduling.annotation.*;
import org.springframework.stereotype.*;

import dao.*;
import vo.*;

@Service
public class RankScheduler {

	@Autowired
	AccountDAO accountDAO;
	@Autowired
	RankDAO rankDAO;
	
	//@Scheduled(cron="0 0 16 ? * 1-5")
	public void updateRank() {
		//모든 Account의 Rank Update
		List<AccountVO> list = accountDAO.getAccountList();
		if(!list.isEmpty()) {
			for(int i=0; i<list.size(); i++) {
				int account_id = list.get(i).getAccount_id();
				int u_id = accountDAO.getU_id(account_id);
				rankDAO.updateGrade(u_id, account_id);
			}
			System.out.println("Success Update Grade");
		}
		
		//Rank Table 초기화(전체 삭제)
		rankDAO.deleteRank();
		System.out.println("Success Delete Ranking Info");
		
		//Rank Table 갱신(모든 계좌에 대한 랭킹 정보 삽입) 
		rankDAO.insertRnak();
		System.out.println("Success Insert Ranking Info");
	}
}
