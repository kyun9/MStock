package vo;

public class CommentsVO {
	private int cid;
	private int bid;
	private int writer;
	private String content;
	private String writedate;
	public int getCid() {
		return cid;
	}
	public void setCid(int cid) {
		this.cid = cid;
	}
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
	@Override
	public String toString() {
		return "CommentVO [cid=" + cid + ", bid=" + bid + ", writer=" + writer + ", content=" + content + ", writedate="
				+ writedate + "]";
	}

}
