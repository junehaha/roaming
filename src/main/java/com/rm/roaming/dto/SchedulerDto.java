package com.rm.roaming.dto;

import java.util.Date;

public class SchedulerDto {
	private int id;
	private int day_id;
	private int order_no;
	private String name;
	private String address;
	private String trip_time;
	private String trip_memo;
	private Date reg_date;
	
	public SchedulerDto() {
		// TODO Auto-generated constructor stub
	}

	public SchedulerDto(int id, int day_id, int order_no, String name, String address, String trip_time,
			String trip_memo, Date reg_date) {
		super();
		this.id = id;
		this.day_id = day_id;
		this.order_no = order_no;
		this.name = name;
		this.address = address;
		this.trip_time = trip_time;
		this.trip_memo = trip_memo;
		this.reg_date = reg_date;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getDay_id() {
		return day_id;
	}

	public void setDay_id(int day_id) {
		this.day_id = day_id;
	}

	public int getOrder_no() {
		return order_no;
	}

	public void setOrder_no(int order_no) {
		this.order_no = order_no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String gettrip_time() {
		return trip_time;
	}

	public void settrip_time(String trip_time) {
		this.trip_time = trip_time;
	}

	public String gettrip_memo() {
		return trip_memo;
	}

	public void settrip_memo(String trip_memo) {
		this.trip_memo = trip_memo;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	@Override
	public String toString() {
		return "SchedulerDto [id=" + id + ", day_id=" + day_id + ", order_no=" + order_no + ", name=" + name
				+ ", address=" + address + ", trip_time=" + trip_time + ", trip_memo=" + trip_memo + ", reg_date="
				+ reg_date + "]";
	}

}
