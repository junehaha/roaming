package com.rm.roaming.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class PostReviewDto {
	private int id;
	private int post_id;
	private int send_id;
	private int receive_id;
	private int rating;
	private String content;
	@DateTimeFormat(pattern = "yyyy.MM.dd HH:mm")
	private Date reg_date;
	
	public PostReviewDto() {
		// TODO Auto-generated constructor stub
	}

	public PostReviewDto(int id, int post_id, int send_id, int receive_id, int rating, String content, Date reg_date) {
		super();
		this.id = id;
		this.post_id = post_id;
		this.send_id = send_id;
		this.receive_id = receive_id;
		this.rating = rating;
		this.content = content;
		this.reg_date = reg_date;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getPost_id() {
		return post_id;
	}

	public void setPost_id(int post_id) {
		this.post_id = post_id;
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

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	@Override
	public String toString() {
		return "PostReviewDto [id=" + id + ", post_id=" + post_id + ", send_id=" + send_id + ", receive_id="
				+ receive_id + ", rating=" + rating + ", content=" + content + ", reg_date=" + reg_date + "]";
	}
	
}
