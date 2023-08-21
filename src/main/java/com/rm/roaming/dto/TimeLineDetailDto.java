package com.rm.roaming.dto;

import java.util.List;

public class TimeLineDetailDto {
	private String roomGroupName;
	private String userName;
	private String phoneNumber;
	private int fixedNumber;
	private List<OptionsDto> optionList;
	private int finalPrice;
	private String startDate;
	private String endDate;
	private String status;
	private String tid;
	private String reserveDate;
	private int roomNumber;
	public TimeLineDetailDto() {
		super();
	}
	public TimeLineDetailDto(String roomGroupName, String userName, String phoneNumber, int fixedNumber,
			List<OptionsDto> optionList, int finalPrice, String startDate, String endDate, String status, String tid,
			String reserveDate, int roomNumber) {
		super();
		this.roomGroupName = roomGroupName;
		this.userName = userName;
		this.phoneNumber = phoneNumber;
		this.fixedNumber = fixedNumber;
		this.optionList = optionList;
		this.finalPrice = finalPrice;
		this.startDate = startDate;
		this.endDate = endDate;
		this.status = status;
		this.tid = tid;
		this.reserveDate = reserveDate;
		this.roomNumber = roomNumber;
	}
	public String getRoomGroupName() {
		return roomGroupName;
	}
	public void setRoomGroupName(String roomGroupName) {
		this.roomGroupName = roomGroupName;
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
	public int getFixedNumber() {
		return fixedNumber;
	}
	public void setFixedNumber(int fixedNumber) {
		this.fixedNumber = fixedNumber;
	}
	public List<OptionsDto> getOptionList() {
		return optionList;
	}
	public void setOptionList(List<OptionsDto> optionList) {
		this.optionList = optionList;
	}
	public int getFinalPrice() {
		return finalPrice;
	}
	public void setFinalPrice(int finalPrice) {
		this.finalPrice = finalPrice;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getTid() {
		return tid;
	}
	public void setTid(String tid) {
		this.tid = tid;
	}
	public String getReserveDate() {
		return reserveDate;
	}
	public void setReserveDate(String reserveDate) {
		this.reserveDate = reserveDate;
	}
	public int getRoomNumber() {
		return roomNumber;
	}
	public void setRoomNumber(int roomNumber) {
		this.roomNumber = roomNumber;
	}
	
	
	
}
