package com.project.mstock;

import java.util.List;

public class NewCapsule {
	
	private String code;
	private List<NewsRecode> newsRecode;
	
	public NewCapsule(String code,  List<NewsRecode> newsRecode){
		this.code = code;
		this.newsRecode = newsRecode;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public List<NewsRecode> getNewsRecode() {
		return newsRecode;
	}

	public void setNewsRecode(List<NewsRecode> newsRecode) {
		this.newsRecode = newsRecode;
	}

	@Override
	public String toString() {
		return "NewCapsule [code=" + code + ", newsRecode=" + newsRecode + "]";
	}
	
	
}