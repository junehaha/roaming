package com.rm.roaming.dto;

public class CustomCategorysDto {
	private String categoryIndex;
	private String category_name;
	public CustomCategorysDto() {
		super();
	}
	public CustomCategorysDto(String categoryIndex, String category_name) {
		super();
		this.categoryIndex = categoryIndex;
		this.category_name = category_name;
	}
	public String getCategoryIndex() {
		return categoryIndex;
	}
	public void setCategoryIndex(String categoryIndex) {
		this.categoryIndex = categoryIndex;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	
	
}
