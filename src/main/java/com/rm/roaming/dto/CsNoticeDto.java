package com.rm.roaming.dto;

import java.util.Date;

public class CsNoticeDto {
	private int id;
	private int admin_id;
	private String notice_title;
	private String notice_content;
	private int notice_read_count;
	private Date reg_date;
	
	public CsNoticeDto() {
		super();
	}

	public CsNoticeDto(int id, int admin_id, String notice_title, String notice_content, int notice_read_count,
			Date reg_date) {
		super();
		this.id = id;
		this.admin_id = admin_id;
		this.notice_title = notice_title;
		this.notice_content = notice_content;
		this.notice_read_count = notice_read_count;
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

	public String getNotice_title() {
		return notice_title;
	}

	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}

	public String getNotice_content() {
		return notice_content;
	}

	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}

	public int getNotice_read_count() {
		return notice_read_count;
	}

	public void setNotice_read_count(int notice_read_count) {
		this.notice_read_count = notice_read_count;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	
}
