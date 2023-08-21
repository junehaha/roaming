package com.rm.roaming.dto;

import java.util.List;

public class RequestMapSeasonPriceDto {
	private List<RoomGroupNameDto> roomGroupNameList;
	private int id;
	private String fluctName;
	private int changePrice;
	private String startDate;
	private String endDate;
	

	public RequestMapSeasonPriceDto() {
		super();
	}


	public RequestMapSeasonPriceDto(List<RoomGroupNameDto> roomGroupNameList, int id, String fluctName, int changePrice,
			String startDate, String endDate) {
		super();
		this.roomGroupNameList = roomGroupNameList;
		this.id = id;
		this.fluctName = fluctName;
		this.changePrice = changePrice;
		this.startDate = startDate;
		this.endDate = endDate;
	}


	public List<RoomGroupNameDto> getRoomGroupNameList() {
		return roomGroupNameList;
	}


	public void setRoomGroupNameList(List<RoomGroupNameDto> roomGroupNameList) {
		this.roomGroupNameList = roomGroupNameList;
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getFluctName() {
		return fluctName;
	}


	public void setFluctName(String fluctName) {
		this.fluctName = fluctName;
	}


	public int getChangePrice() {
		return changePrice;
	}


	public void setChangePrice(int changePrice) {
		this.changePrice = changePrice;
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


	
}
