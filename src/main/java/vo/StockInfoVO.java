package vo;

//주식 정보 담는 vo객체
public class StockInfoVO {
	private String JongCd;
	private String gettime;
	private String janggubun;
	private String DungRakrate_str;
	private int dailystock_length;
	private String[] Stockinfo = new String[17];
	private String[][] Dailystock = new String[10][9];
	
	public String getJongCd() {
		return JongCd;
	}
	public void setJongCd(String jongCd) {
		JongCd = jongCd;
	}
	public String getGettime() {
		return gettime;
	}
	public void setGettime(String gettime) {
		this.gettime = gettime;
	}
	public String getJanggubun() {
		return janggubun;
	}
	public void setJanggubun(String janggubun) {
		this.janggubun = janggubun;
	}
	public String getDungRakrate_str() {
		return DungRakrate_str;
	}
	public void setDungRakrate_str(String dungRakrate_str) {
		DungRakrate_str = dungRakrate_str;
	}
	public int getDailystock_length() {
		return dailystock_length;
	}
	public void setDailystock_length(int dailystock_length) {
		this.dailystock_length = dailystock_length;
	}
	public String[] getStockinfo() {
		return Stockinfo;
	}
	public void setStockinfo(String[] stockinfo) {
		Stockinfo = stockinfo;
	}
	public String[][] getDailystock() {
		return Dailystock;
	}
	public void setDailystock(String[][] dailystock) {
		Dailystock = dailystock;
	}
	
	
}
