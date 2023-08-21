package com.rm.roaming.dto;

public class PostChatGroupDto {
	private int join_id;
	private int post_id;
	private int create_id;
	private String title;
	private String profile_img;
	
	public PostChatGroupDto() {
		// TODO Auto-generated constructor stub
	}

	public PostChatGroupDto(int join_id, int post_id, int create_id, String title, String profile_img) {
		super();
		this.join_id = join_id;
		this.post_id = post_id;
		this.create_id = create_id;
		this.title = title;
		this.profile_img = profile_img;
	}

	public int getJoin_id() {
		return join_id;
	}

	public void setJoin_id(int join_id) {
		this.join_id = join_id;
	}

	public int getPost_id() {
		return post_id;
	}

	public void setPost_id(int post_id) {
		this.post_id = post_id;
	}

	public int getCreate_id() {
		return create_id;
	}

	public void setCreate_id(int create_id) {
		this.create_id = create_id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getProfile_img() {
		return profile_img;
	}

	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}

	@Override
	public String toString() {
		return "PostChatGroupDto [join_id=" + join_id + ", post_id=" + post_id + ", create_id=" + create_id + ", title="
				+ title + ", profile_img=" + profile_img + "]";
	}

	
	
}
