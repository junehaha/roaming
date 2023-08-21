package com.rm.roaming.dto;

import java.util.List;

public class DayPriceGroupsDto {
	private List<DaysListDto> groups;
	private int hotel_id;
	
	public DayPriceGroupsDto() {
		super();
	}

	public DayPriceGroupsDto(List<DaysListDto> groups, int hotel_id) {
		super();
		this.groups = groups;
		this.hotel_id = hotel_id;
	}

	public List<DaysListDto> getGroups() {
		return groups;
	}

	public void setGroups(List<DaysListDto> groups) {
		this.groups = groups;
	}

	public int getHotel_id() {
		return hotel_id;
	}

	public void setHotel_id(int hotel_id) {
		this.hotel_id = hotel_id;
	}

	
	
}
