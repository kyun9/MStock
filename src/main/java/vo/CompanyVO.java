package vo;

public class CompanyVO {
	private String name;
	private String code;
	private String wcimg;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getWcimg() {
		return wcimg;
	}
	public void setWcimg(String wcimg) {
		this.wcimg = wcimg;
	}
	@Override
	public String toString() {
		return "CompanyVO [name=" + name + ", code=" + code + ", wcimg=" + wcimg + "]";
	}
	
}
