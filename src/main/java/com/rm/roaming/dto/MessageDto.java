package com.rm.roaming.dto;

import java.util.Date;

public class MessageDto {
	private int id;
	private int send_id;
	private int receive_id;
	private String content;
	private Date send_time;
	private Date read_time;
	private String read_status;
	public MessageDto() {
		super();
	}
	public MessageDto(int id, int send_id, int receive_id, String content, Date send_time, Date read_time,
			String read_status) {
		super();
		this.id = id;
		this.send_id = send_id;
		this.receive_id = receive_id;
		this.content = content;
		this.send_time = send_time;
		this.read_time = read_time;
		this.read_status = read_status;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getSend_id() {
		return send_id;
	}
	public void setSend_id(int send_id) {
		this.send_id = send_id;
	}
	public int getReceive_id() {
		return receive_id;
	}
	public void setReceive_id(int receive_id) {
		this.receive_id = receive_id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getSend_time() {
		return send_time;
	}
	public void setSend_time(Date send_time) {
		this.send_time = send_time;
	}
	public Date getRead_time() {
		return read_time;
	}
	public void setRead_time(Date read_time) {
		this.read_time = read_time;
	}
	public String getRead_status() {
		return read_status;
	}
	public void setRead_status(String read_status) {
		this.read_status = read_status;
	}
	
	
}
