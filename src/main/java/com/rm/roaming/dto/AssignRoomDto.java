package com.rm.roaming.dto;

public class AssignRoomDto {
	private int id;
	private int room_id;
	private int reserve_id;
	public AssignRoomDto() {
		super();
	}
	public AssignRoomDto(int id, int room_id, int reserve_id) {
		super();
		this.id = id;
		this.room_id = room_id;
		this.reserve_id = reserve_id;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getRoom_id() {
		return room_id;
	}
	public void setRoom_id(int room_id) {
		this.room_id = room_id;
	}
	public int getReserve_id() {
		return reserve_id;
	}
	public void setReserve_id(int reserve_id) {
		this.reserve_id = reserve_id;
	}
	
}
