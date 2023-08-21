package com.rm.roaming.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class SeasonPriceDto {
	private int id;
	private String fluct_name;
	private int change_price;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date start_date;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date end_date;
	private Date reg_date;
	public SeasonPriceDto() {
		super();
	}
	public SeasonPriceDto(int id, String fluct_name, int change_price, Date start_date, Date end_date, Date reg_date) {
		super();
		this.id = id;
		this.fluct_name = fluct_name;
		this.change_price = change_price;
		this.start_date = start_date;
		this.end_date = end_date;
		this.reg_date = reg_date;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getFluct_name() {
		return fluct_name;
	}
	public void setFluct_name(String fluct_name) {
		this.fluct_name = fluct_name;
	}
	public int getChange_price() {
		return change_price;
	}
	public void setChange_price(int change_price) {
		this.change_price = change_price;
	}
	public Date getStart_date() {
		return start_date;
	}
	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}
	public Date getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	
}
