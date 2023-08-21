package com.rm.roaming.dto;

public class SeasonPriceGroupDto {
	private int id;
	private int room_group_id;
	private int season_price_id;
	public SeasonPriceGroupDto() {
		super();
	}
	public SeasonPriceGroupDto(int id, int room_group_id, int season_price_id) {
		super();
		this.id = id;
		this.room_group_id = room_group_id;
		this.season_price_id = season_price_id;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getRoom_group_id() {
		return room_group_id;
	}
	public void setRoom_group_id(int room_group_id) {
		this.room_group_id = room_group_id;
	}
	public int getSeason_price_id() {
		return season_price_id;
	}
	public void setSeason_price_id(int season_price_id) {
		this.season_price_id = season_price_id;
	}
	
	
}
