package com.rm.roaming.dto;

public class RoomsDto {
	private String roomIndex;
	private int room_number;
	public RoomsDto() {
		super();
	}
	public RoomsDto(String roomIndex, int room_number) {
		super();
		this.roomIndex = roomIndex;
		this.room_number = room_number;
	}
	public String getRoomIndex() {
		return roomIndex;
	}
	public void setRoomIndex(String roomIndex) {
		this.roomIndex = roomIndex;
	}
	public int getRoom_number() {
		return room_number;
	}
	public void setRoom_number(int room_number) {
		this.room_number = room_number;
	}
	
	
}
