package com.rm.roaming.dto;

public class ReservedAddressDto {
	private String hotel_name;
	private String hotel_loc;
	private String room_number;
	
	public ReservedAddressDto() {
		super();
	}

	public ReservedAddressDto(String hotel_name, String hotel_loc, String room_number) {
		super();
		this.hotel_name = hotel_name;
		this.hotel_loc = hotel_loc;
		this.room_number = room_number;
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

	public String getRoom_number() {
		return room_number;
	}

	public void setRoom_number(String room_number) {
		this.room_number = room_number;
	}
	
}
