package vo;

public class MyStockVO {
	String company_id;
	String name;
	int price;
	int curjuka;
	String dongrak;
	String debi;
	int quantity;
	int profit;
	double profit_rate;
	
	public int getProfit() {
		return profit;
	}
	public void setProfit(int profit) {
		this.profit = profit;
	}
	public String getCompany_id() {
		return company_id;
	}
	public void setCompany_id(String company_id) {
		this.company_id = company_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getCurjuka() {
		return curjuka;
	}
	public void setCurjuka(int curjuka) {
		this.curjuka = curjuka;
	}
	public String getDongrak() {
		return dongrak;
	}
	public void setDongrak(String dongrak) {
		this.dongrak = dongrak;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public double getProfit_rate() {
		return profit_rate;
	}
	public void setProfit_rate(double profit_rate) {
		this.profit_rate = profit_rate;
	}
	public String getDebi() {
		return debi;
	}
	public void setDebi(String debi) {
		this.debi = debi;
	}
	
}
