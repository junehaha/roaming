package com.rm.roaming.dto;

public class TimeLineDto {
	private int id;
	private String title;
	private String start;
	private String end;
	private String status;
	public TimeLineDto() {
		super();
	}
	public TimeLineDto(int id, String title, String start, String end, String status) {
		super();
		this.id = id;
		this.title = title;
		this.start = start;
		this.end = end;
		this.status = status;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	
}
