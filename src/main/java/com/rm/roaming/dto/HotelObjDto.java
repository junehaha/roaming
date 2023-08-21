package com.rm.roaming.dto;

import java.util.List;

public class HotelObjDto {
	private HotelInfoDto hotel;
	private List<GroupsDto> groups;
	public HotelObjDto() {
		super();
	}
	public HotelObjDto(HotelInfoDto hotel, List<GroupsDto> groups) {
		super();
		this.hotel = hotel;
		this.groups = groups;
	}
	public HotelInfoDto getHotel() {
		return hotel;
	}
	public void setHotel(HotelInfoDto hotel) {
		this.hotel = hotel;
	}
	public List<GroupsDto> getGroups() {
		return groups;
	}
	public void setGroups(List<GroupsDto> groups) {
		this.groups = groups;
	}
	
	
}
