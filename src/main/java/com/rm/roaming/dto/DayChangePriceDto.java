package com.rm.roaming.dto;

public class DayChangePriceDto {
	private int day;
	private int change_price;
	public DayChangePriceDto() {
		super();
	}
	public DayChangePriceDto(int day, int change_price) {
		super();
		this.day = day;
		this.change_price = change_price;
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
