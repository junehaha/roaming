package com.rm.roaming.dto;

public class PlusOptionsDto {
	private String plus_option;
	private int option_price;
	public PlusOptionsDto() {
		super();
	}
	public PlusOptionsDto(String plus_option, int option_price) {
		super();
		this.plus_option = plus_option;
		this.option_price = option_price;
	}
	public String getPlus_option() {
		return plus_option;
	}
	public void setPlus_option(String plus_option) {
		this.plus_option = plus_option;
	}
	public int getOption_price() {
		return option_price;
	}
	public void setOption_price(int option_price) {
		this.option_price = option_price;
	}
	
	
}
