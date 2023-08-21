package com.rm.roaming.dto;

import java.util.Date;

public class MonthSaleDto {
	private Date thisMonthDate;
	private int totalDailySale;
	
	public MonthSaleDto() {
		super();
	}
	
	public MonthSaleDto(Date thisMonthDate, int totalDailySale) {
		super();
		this.thisMonthDate = thisMonthDate;
		this.totalDailySale = totalDailySale;
	}
	
	public Date getThisMonthDate() {
		return thisMonthDate;
	}
	public void setThisMonthDate(Date thisMonthDate) {
		this.thisMonthDate = thisMonthDate;
	}
	public int getTotalDailySale() {
		return totalDailySale;
	}
	public void setTotalDailySale(int totalDailySale) {
		this.totalDailySale = totalDailySale;
	}
	
	
	
}
