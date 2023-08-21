package com.rm.roaming.dto;

import java.util.Date;
import java.util.List;

public class ReserveInfoDto {
	private String roomGroupName;
	private String userName;
	private String phoneNumber;
	private int fixedNumber;
	private List<OptionsDto> optionList;
	private int finalPrice;
	private Date startDate;
	private Date endDate;
	private String status;
	private int id;
	public ReserveInfoDto() {
		super();
	}
	public ReserveInfoDto(String roomGroupName, String userName, String phoneNumber, int fixedNumber,
			List<OptionsDto> optionList, int finalPrice, Date startDate, Date endDate, String status, int id) {
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
		this.id = id;
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
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
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
