package vo;

public class PropertyVO {
	int credit;
	int price_value;
	int stock_value;
	double profit_rate;
	String grade;
	
	
	public int getPrice_value() {
		return price_value;
	}
	public void setPrice_value(int price_value) {
		this.price_value = price_value;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public int getCredit() {
		return credit;
	}
	public void setCredit(int credit) {
		this.credit = credit;
	}
	public int getStock_value() {
		return stock_value;
	}
	public void setStock_value(int stock_value) {
		this.stock_value = stock_value;
	}
	public double getProfit_rate() {
		return profit_rate;
	}
	public void setProfit_rate(double profit_rate) {
		this.profit_rate = profit_rate;
	}
	
}
