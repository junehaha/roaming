package com.rm.roaming.user.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.rm.roaming.dto.UserDto;
import com.rm.roaming.user.service.UserServiceImpl;
import com.rm.roaming.userboard.service.UserBoardServiceImpl;

@RestController
@RequestMapping("user/*")
public class RestUserController {
	@Autowired
	private UserServiceImpl userService;
	@Autowired
	private UserBoardServiceImpl userBoardServiceImpl;
	
	@RequestMapping("getMyId")
	public Map<String, Object> getMyId(HttpSession session) {
		Map<String, Object> map = new HashMap<>();
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		if(sessionUser == null) {
			map.put("result", "fail");
			map.put("reason", "로그인 안되있음..");
		} else {
			map.put("result", "success");
			map.put("id", sessionUser.getId());
		}
		return map;
	}
	
	@RequestMapping("loginOrSign")
	 public Map<String, Object> loginOrSign(String kid,String name,String gender,String pimg,HttpSession session) {
	      Map<String, Object> map = new HashMap<>();
	      if(userService.getUserCountByUserId(kid) == 0) {
	         map.put("result", "regi");
	         session.setAttribute("kid", kid);
	         session.setAttribute("name", name);
	         session.setAttribute("gender", gender);
	         session.setAttribute("pimg", pimg);
	         return map;
	      }else {
	         map.put("result", "login");
	         session.setAttribute("sessionUser", userService.selectUserIdById(kid));
	         
	         UserDto userDto2 = userService.selectUserIdById(kid);
	         Map<String, Object> myPage = userBoardServiceImpl.getMyPage(userDto2.getId());
	         session.setAttribute("myPage",myPage);
	         return map;
	      }
	}

	
	@RequestMapping("loginFilter")
	public Map<String, Object> loginFilter(UserDto userDto) {
		Map<String, Object> map = new HashMap<>();
		if(userService.getUserExist(userDto) != 0) {
			map.put("result", "success");
			return map;
		}
		map.put("result", "fail");
		return map;
	}
	
	
	
	// 득균
	@RequestMapping("existsUserId")
	public Map<String, Object> existsUserId(String id) {
		
		String userId = id;
		
		boolean exists = userService.existsUserId(userId);		
		
		Map<String,Object> map = new HashMap<>();
		map.put("result", "success");	 
		map.put("data", exists);        
		
		return map;
	}
}
