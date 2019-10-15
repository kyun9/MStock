package vo;

public class BoardVO {
	private int bid;
	private int writer;
	private String title;
	private String content;
	private String writedate;
	private int cnt;
	private int page;

	public int getBid() {
		return bid;
	}
	public void setBid(int bid) {
		this.bid = bid;
	}
	public int getWriter() {
		return writer;
	}
	public void setWriter(int writer) {
		this.writer = writer;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWritedate() {
		return writedate;
	}
	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	@Override
	public String toString() {
		return "BoardVO [bid=" + bid + ", writer=" + writer + ", title=" + title + ", content=" + content
				+ ", writedate=" + writedate + ", cnt=" + cnt + ", page=" + page + "]";
	}
    
}
