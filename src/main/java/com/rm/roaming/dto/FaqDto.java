package com.rm.roaming.dto;

import java.util.Date;

public class FaqDto {
	private int id; 
	private int admin_id;
	private int faq_category_id;
	private String faq_title;
	private String faq_content;
	private Date reg_date;
	
	public FaqDto() {
		super();
	}

	public FaqDto(int id, int admin_id, int faq_category_id, String faq_title, String faq_content, Date reg_date) {
		super();
		this.id = id;
		this.admin_id = admin_id;
		this.faq_category_id = faq_category_id;
		this.faq_title = faq_title;
		this.faq_content = faq_content;
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

	public int getFaq_category_id() {
		return faq_category_id;
	}

	public void setFaq_category_id(int faq_category_id) {
		this.faq_category_id = faq_category_id;
	}

	public String getFaq_title() {
		return faq_title;
	}

	public void setFaq_title(String faq_title) {
		this.faq_title = faq_title;
	}

	public String getFaq_content() {
		return faq_content;
	}

	public void setFaq_content(String faq_content) {
		this.faq_content = faq_content;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	
}
