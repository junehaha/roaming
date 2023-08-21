package com.rm.roaming.dto;


public class HotelInfoDto {
	private int seller_id;
	private String hotel_name;
	private int hotel_category_id;
	private String hotel_loc;
	private String hotel_tel;
	private String content;
	private int[] system_categorys;
	public HotelInfoDto() {
		super();
	}
	public HotelInfoDto(int seller_id, String hotel_name, int hotel_category_id, String hotel_loc, String hotel_tel,
			String content, int[] system_categorys) {
		super();
		this.seller_id = seller_id;
		this.hotel_name = hotel_name;
		this.hotel_category_id = hotel_category_id;
		this.hotel_loc = hotel_loc;
		this.hotel_tel = hotel_tel;
		this.content = content;
		this.system_categorys = system_categorys;
	}
	public int getSeller_id() {
		return seller_id;
	}
	public void setSeller_id(int seller_id) {
		this.seller_id = seller_id;
	}
	public String getHotel_name() {
		return hotel_name;
	}
	public void setHotel_name(String hotel_name) {
		this.hotel_name = hotel_name;
	}
	public int getHotel_category_id() {
		return hotel_category_id;
	}
	public void setHotel_category_id(int hotel_category_id) {
		this.hotel_category_id = hotel_category_id;
	}
	public String getHotel_loc() {
		return hotel_loc;
	}
	public void setHotel_loc(String hotel_loc) {
		this.hotel_loc = hotel_loc;
	}
	public String getHotel_tel() {
		return hotel_tel;
	}
	public void setHotel_tel(String hotel_tel) {
		this.hotel_tel = hotel_tel;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int[] getSystem_categorys() {
		return system_categorys;
	}
	public void setSystem_categorys(int[] system_categorys) {
		this.system_categorys = system_categorys;
	}
	
	
	
}
