package com.rm.roaming.dto;

import java.util.Date;

public class HotelDocuDto {
	 private int id;
	 private int hotel_id;
	 private String docu_link;
	 private String docu_return;
	 private String docu_status;
	 private Date reg_date;
	public HotelDocuDto() {
		super();
	}
	public HotelDocuDto(int id, int hotel_id, String docu_link, String docu_return, String docu_status, Date reg_date) {
		super();
		this.id = id;
		this.hotel_id = hotel_id;
		this.docu_link = docu_link;
		this.docu_return = docu_return;
		this.docu_status = docu_status;
		this.reg_date = reg_date;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getHotel_id() {
		return hotel_id;
	}
	public void setHotel_id(int hotel_id) {
		this.hotel_id = hotel_id;
	}
	public String getDocu_link() {
		return docu_link;
	}
	public void setDocu_link(String docu_link) {
		this.docu_link = docu_link;
	}
	public String getDocu_return() {
		return docu_return;
	}
	public void setDocu_return(String docu_return) {
		this.docu_return = docu_return;
	}
	public String getDocu_status() {
		return docu_status;
	}
	public void setDocu_status(String docu_status) {
		this.docu_status = docu_status;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	
	 
	 
}
