package com.project.mstock;

import java.util.List;

public class NewsRecode {
	
	private String title;
	private String press;
	private String time;
	private String content;
	
	public NewsRecode(String title, String press, String time, String content){
		this.title=title;
		this.press=press;
		this.time=time;
		this.content=content;
	}
	
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getPress() {
		return press;
	}
	public void setPress(String press) {
		this.press = press;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@Override
	public String toString() {
		return "NewsRecode [title=" + title + ", press=" + press + ", time=" + time + ", content=" + content + "]";
	}
	
	
	
	
}