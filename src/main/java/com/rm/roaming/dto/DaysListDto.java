package com.rm.roaming.dto;

import java.util.List;

public class DaysListDto {

	private List<DayChangePriceDto> days;
	private int group;
	
	public DaysListDto() {
		super();
	}

	public DaysListDto(int group, List<DayChangePriceDto> days) {
		super();
		this.group = group;
		this.days = days;
	}

	public int getGroup() {
		return group;
	}

	public void setGroup(int group) {
		this.group = group;
	}

	public List<DayChangePriceDto> getDays() {
		return days;
	}

	public void setDays(List<DayChangePriceDto> days) {
		this.days = days;
	}

	
}
