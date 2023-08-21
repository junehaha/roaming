package com.rm.roaming.dto;

import java.util.Date;

public class ZimDeliveryManageDto {
	private int id;
	private int admin_id;
	private int zim_signup_id;
	private String zim_prog_before;
	private String zim_prog_after;
	Date delivery_reg_date;
	
	public ZimDeliveryManageDto() {
		super();
	}

	public ZimDeliveryManageDto(int id, int admin_id, int zim_signup_id, String zim_prog_before, String zim_prog_after,
			Date delivery_reg_date) {
		super();
		this.id = id;
		this.admin_id = admin_id;
		this.zim_signup_id = zim_signup_id;
		this.zim_prog_before = zim_prog_before;
		this.zim_prog_after = zim_prog_after;
		this.delivery_reg_date = delivery_reg_date;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getAdmin_id() {
		return admin_id;
	}

	public void setAdmin_id(int admin_id) {
		this.admin_id = admin_id;
	}

	public int getZim_signup_id() {
		return zim_signup_id;
	}

	public void setZim_signup_id(int zim_signup_id) {
		this.zim_signup_id = zim_signup_id;
	}

	public String getZim_prog_before() {
		return zim_prog_before;
	}

	public void setZim_prog_before(String zim_prog_before) {
		this.zim_prog_before = zim_prog_before;
	}

	public String getZim_prog_after() {
		return zim_prog_after;
	}

	public void setZim_prog_after(String zim_prog_after) {
		this.zim_prog_after = zim_prog_after;
	}

	public Date getDelivery_reg_date() {
		return delivery_reg_date;
	}

	public void setDelivery_reg_date(Date delivery_reg_date) {
		this.delivery_reg_date = delivery_reg_date;
	}

}
