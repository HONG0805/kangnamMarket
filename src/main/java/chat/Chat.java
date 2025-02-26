package chat;

public class Chat {
	private int roomId; // 채팅방 ID
	private String postId; // 게시물 ID
	private String userID; // 메시지를 보낸 사용자 ID
	private String message; // 채팅 메시지 내용

	// 기본 생성자
	public Chat() {
	}

	// 파라미터를 받는 생성자
	public Chat(int roomId, String postId, String userID, String message) {
		this.roomId = roomId;
		this.postId = postId;
		this.userID = userID;
		this.message = message;
	}

	// Getters and Setters
	public int getRoomId() {
		return roomId;
	}

	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}

	public String getPostId() {
		return postId;
	}

	public void setPostId(String postId) {
		this.postId = postId;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
}
