package com.rm.roaming.dto;

public class CheckInOutDto {
	private String userName;
	private String phoneNumber;
	private String roomGroupName;
	private int fixedNumber;
	private String status;
	private int id;
	public CheckInOutDto() {
		super();
	}
	public CheckInOutDto(String userName, String phoneNumber, String roomGroupName, int fixedNumber, String status,
			int id) {
		super();
		this.userName = userName;
		this.phoneNumber = phoneNumber;
		this.roomGroupName = roomGroupName;
		this.fixedNumber = fixedNumber;
		this.status = status;
		this.id = id;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getRoomGroupName() {
		return roomGroupName;
	}
	public void setRoomGroupName(String roomGroupName) {
		this.roomGroupName = roomGroupName;
	}
	public int getFixedNumber() {
		return fixedNumber;
	}
	public void setFixedNumber(int fixedNumber) {
		this.fixedNumber = fixedNumber;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
}
