package com.rm.roaming.dto;

public class DayPriceDto {
	private int id;
	private int room_group_id;
	private int day;
	private int change_price;
	public DayPriceDto() {
		super();
	}
	public DayPriceDto(int id, int room_group_id, int day, int change_price) {
		super();
		this.id = id;
		this.room_group_id = room_group_id;
		this.day = day;
		this.change_price = change_price;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getRoom_group_id() {
		return room_group_id;
	}
	public void setRoom_group_id(int room_group_id) {
		this.room_group_id = room_group_id;
	}
	public int getDay() {
		return day;
	}
	public void setDay(int day) {
		this.day = day;
	}
	public int getChange_price() {
		return change_price;
	}
	public void setChange_price(int change_price) {
		this.change_price = change_price;
	}
	
	
}
