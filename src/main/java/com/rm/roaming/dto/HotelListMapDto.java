package com.rm.roaming.dto;


public class HotelListMapDto {
	private int id;
	private String hotelName;
	private String hotelImg;
	private String hotelCategory;
	private String docuStatus;
	private String hotelStatus;
	public HotelListMapDto() {
		super();
	}
	public HotelListMapDto(int id, String hotelName, String hotelImg, String hotelCategory, String docuStatus,
			String hotelStatus) {
		super();
		this.id = id;
		this.hotelName = hotelName;
		this.hotelImg = hotelImg;
		this.hotelCategory = hotelCategory;
		this.docuStatus = docuStatus;
		this.hotelStatus = hotelStatus;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getHotelName() {
		return hotelName;
	}
	public void setHotelName(String hotelName) {
		this.hotelName = hotelName;
	}
	public String getHotelImg() {
		return hotelImg;
	}
	public void setHotelImg(String hotelImg) {
		this.hotelImg = hotelImg;
	}
	public String getHotelCategory() {
		return hotelCategory;
	}
	public void setHotelCategory(String hotelCategory) {
		this.hotelCategory = hotelCategory;
	}
	public String getDocuStatus() {
		return docuStatus;
	}
	public void setDocuStatus(String docuStatus) {
		this.docuStatus = docuStatus;
	}
	public String getHotelStatus() {
		return hotelStatus;
	}
	public void setHotelStatus(String hotelStatus) {
		this.hotelStatus = hotelStatus;
	}

	
}
