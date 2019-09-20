package vo;

public class CompanyVO {
	private String company_id;
	private String name;
	private String wcimg;
	
	
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
	public String getWcimg() {
		return wcimg;
	}
	public void setWcimg(String wcimg) {
		this.wcimg = wcimg;
	}
	@Override
	public String toString() {
		return "CompanyVO [company_id=" + company_id + ", name=" + name + ", wcimg=" + wcimg + "]";
	}
	
}
