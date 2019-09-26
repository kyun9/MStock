package service;

import org.springframework.stereotype.*;

import vo.*;

@Service
public class HistoryService {
	public HistoryVO getHistory(PurchaseVO purchaseVO, int curJuka, String status) {
		HistoryVO historyVO = new HistoryVO();
		historyVO.setAccount_id(purchaseVO.getAccount_id());
		historyVO.setStatus(status);
		historyVO.setCompany_id(purchaseVO.getCompany_id());
		historyVO.setPrice(curJuka);
		historyVO.setQuantity(purchaseVO.getQuantity());
		return historyVO;
	}
}
