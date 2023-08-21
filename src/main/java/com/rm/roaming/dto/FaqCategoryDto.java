package com.rm.roaming.dto;

public class FaqCategoryDto {
	private int id;
	private String faq_name;
	
	public FaqCategoryDto() {
		super();
	}

	public FaqCategoryDto(int id, String faq_name) {
		super();
		this.id = id;
		this.faq_name = faq_name;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFaq_name() {
		return faq_name;
	}

	public void setFaq_name(String faq_name) {
		this.faq_name = faq_name;
	}
	
}
