package com.rm.roaming.dto;

import java.util.Date;

public class SellerAuthorityDto {

	private int id;
	private String docu_link;
	private String category;
	private String hotel_name;
	private String hotel_loc;
	private String hotel_img;
	private String hotel_tel;
	private String status;
	private String content;
	private Date reg_date;
	private String docu_return;
	private String docu_status;
	
	public SellerAuthorityDto() {
		super();
	}

	public SellerAuthorityDto(int id, String docu_link, String category, String hotel_name, String hotel_loc,
			String hotel_img, String hotel_tel, String status, String content, Date reg_date, String docu_return,
			String docu_status) {
		super();
		this.id = id;
		this.docu_link = docu_link;
		this.category = category;
		this.hotel_name = hotel_name;
		this.hotel_loc = hotel_loc;
		this.hotel_img = hotel_img;
		this.hotel_tel = hotel_tel;
		this.status = status;
		this.content = content;
		this.reg_date = reg_date;
		this.docu_return = docu_return;
		this.docu_status = docu_status;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDocu_link() {
		return docu_link;
	}

	public void setDocu_link(String docu_link) {
		this.docu_link = docu_link;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getHotel_name() {
		return hotel_name;
	}

	public void setHotel_name(String hotel_name) {
		this.hotel_name = hotel_name;
	}

	public String getHotel_loc() {
		return hotel_loc;
	}

	public void setHotel_loc(String hotel_loc) {
		this.hotel_loc = hotel_loc;
	}

	public String getHotel_img() {
		return hotel_img;
	}

	public void setHotel_img(String hotel_img) {
		this.hotel_img = hotel_img;
	}

	public String getHotel_tel() {
		return hotel_tel;
	}

	public void setHotel_tel(String hotel_tel) {
		this.hotel_tel = hotel_tel;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
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

	
}
