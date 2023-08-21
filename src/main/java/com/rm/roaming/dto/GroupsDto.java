package com.rm.roaming.dto;

import java.util.List;

public class GroupsDto {
	private String index;
	private int view_id;
	private String room_group_name;
	private int price;
	private int fixed_number;
	private List<CustomCategorysDto> custom_categorys;
	private List<PlusOptionsDto> plus_options;
	private List<RoomsDto> rooms;
	public GroupsDto() {
		super();
	}
	public GroupsDto(String index, int view_id, String room_group_name, int price, int fixed_number,
			List<CustomCategorysDto> custom_categorys, List<PlusOptionsDto> plus_options, List<RoomsDto> rooms) {
		super();
		this.index = index;
		this.view_id = view_id;
		this.room_group_name = room_group_name;
		this.price = price;
		this.fixed_number = fixed_number;
		this.custom_categorys = custom_categorys;
		this.plus_options = plus_options;
		this.rooms = rooms;
	}
	public String getIndex() {
		return index;
	}
	public void setIndex(String index) {
		this.index = index;
	}
	public int getView_id() {
		return view_id;
	}
	public void setView_id(int view_id) {
		this.view_id = view_id;
	}
	public String getRoom_group_name() {
		return room_group_name;
	}
	public void setRoom_group_name(String room_group_name) {
		this.room_group_name = room_group_name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getFixed_number() {
		return fixed_number;
	}
	public void setFixed_number(int fixed_number) {
		this.fixed_number = fixed_number;
	}
	public List<CustomCategorysDto> getCustom_categorys() {
		return custom_categorys;
	}
	public void setCustom_categorys(List<CustomCategorysDto> custom_categorys) {
		this.custom_categorys = custom_categorys;
	}
	public List<PlusOptionsDto> getPlus_options() {
		return plus_options;
	}
	public void setPlus_options(List<PlusOptionsDto> plus_options) {
		this.plus_options = plus_options;
	}
	public List<RoomsDto> getRooms() {
		return rooms;
	}
	public void setRooms(List<RoomsDto> rooms) {
		this.rooms = rooms;
	}
	
	
	
	
}
