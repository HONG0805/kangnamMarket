package reply;

public class Reply {

	private int bbsID;
	private int replyID;
	private String replyContent;
	private String userID;
	private int replyAvailable;
	private java.sql.Timestamp replyDate;

	public int getBbsID() {
		return bbsID;
	}

	public void setBbsID(int bbsID) {
		this.bbsID = bbsID;
	}

	public int getReplyID() {
		return replyID;
	}

	public void setReplyID(int replyID) {
		this.replyID = replyID;
	}

	public String getReplyContent() {
		return replyContent;
	}

	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public int getReplyAvailable() {
		return replyAvailable;
	}

	public void setReplyAvailable(int replyAvailable) {
		this.replyAvailable = replyAvailable;
	}

	public java.sql.Timestamp getReplyDate() {
		return replyDate;
	}

	public void setReplyDate(java.sql.Timestamp replyDate) {
		this.replyDate = replyDate;
	}

}