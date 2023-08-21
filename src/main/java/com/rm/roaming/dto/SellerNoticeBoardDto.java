package com.rm.roaming.dto;

import java.util.Date;

public class SellerNoticeBoardDto {

	private int id;
	private int admin_id;
	private String title;
	private String content;
	private int readCount;
	private Date reg_date;
	
	public SellerNoticeBoardDto() {
		super();
	}

	public SellerNoticeBoardDto(int id, int admin_id, String title, String content, int readCount, Date reg_date) {
		super();
		this.id = id;
		this.admin_id = admin_id;
		this.title = title;
		this.content = content;
		this.readCount = readCount;
		this.reg_date = reg_date;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getAdmin_id() {
		return admin_id;
	}

	public void setAdmin_id(int admin_id) {
		this.admin_id = admin_id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getReadCount() {
		return readCount;
	}

	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	
	
	
}
