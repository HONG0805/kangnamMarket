package chat;

import java.sql.Timestamp;

public class ChatRoom {
	private int roomId; // 채팅방 ID
	private String postId; // 게시물 ID (게시물과 연결)
	private String user1Id; // 첫 번째 사용자 (채팅방 참여자)
	private String user2Id; // 두 번째 사용자 (채팅방 참여자)
	private Timestamp createdAt; // 채팅방 생성 시간

	// 기본 생성자
	public ChatRoom() {
	}

	// 파라미터를 받는 생성자
	public ChatRoom(int roomId, String postId, String user1Id, String user2Id, Timestamp createdAt) {
		this.roomId = roomId;
		this.postId = postId;
		this.user1Id = user1Id;
		this.user2Id = user2Id;
		this.createdAt = createdAt;
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

	public String getUser1Id() {
		return user1Id;
	}

	public void setUser1Id(String user1Id) {
		this.user1Id = user1Id;
	}

	public String getUser2Id() {
		return user2Id;
	}

	public void setUser2Id(String user2Id) {
		this.user2Id = user2Id;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	@Override
	public String toString() {
		return "ChatRoom [roomId=" + roomId + ", postId=" + postId + ", user1Id=" + user1Id + ", user2Id=" + user2Id
				+ ", createdAt=" + createdAt + "]";
	}
}
