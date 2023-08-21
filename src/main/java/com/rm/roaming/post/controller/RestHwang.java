package com.rm.roaming.post.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.rm.roaming.post.service.PostService;

@RestController
@RequestMapping("post/*")
public class RestHwang {
	@Autowired
	private PostService postService;
	@RequestMapping("savePostSchedule")
	public Map<String, Object> savePostSchedule(String[] placeName,String[] placeAddress, String[] estimated, String[] memo,int dayNumber){
		Map<String, Object> map = new HashMap<>();
		postService.registerPostSchedule(placeName, placeAddress, estimated, memo, dayNumber);
		map.put("result", "success");
		
		
		return map;
	}
}
