package com.rm.roaming.seller.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.rm.roaming.dto.SellerDto;
import com.rm.roaming.dto.UserDto;
import com.rm.roaming.seller.service.SellerServiceImpl;

@RestController
@RequestMapping("seller/*")
public class RestSellerController {
	@Autowired
	private SellerServiceImpl sellerServiceImpl;

	
	@RequestMapping("loginOrSign2")
	public Map<String, Object> loginOrSign2(String kid,String name,HttpSession session) {
		Map<String, Object> map = new HashMap<>();
		if(sellerServiceImpl.getSellerCountByUserId(kid) == 0) {
			map.put("result", "regi");
			session.setAttribute("kid", kid);
			session.setAttribute("name", name);
			return map;
		}else {
			map.put("result", "login");
			session.setAttribute("sessionSeller", sellerServiceImpl.selectSellerIdById(kid));
			return map;
		}
		
	}
	
	@RequestMapping("useAbleId")
	public Map<String, Object> useAbleId(String id){
		Map<String, Object> map = new HashMap<>();
		if(sellerServiceImpl.getSellerCountByUserId(id) == 0) {
			map.put("result", "success");
			return map;
		}else {
			map.put("result", "fail");
			return map;
		}
	}
	@RequestMapping("sellerLoginFilter")
	public Map<String, Object> sellerLoginFilter(SellerDto sellerDto) {
		Map<String, Object> map = new HashMap<>();
		if(sellerServiceImpl.getSellerExist(sellerDto) != 0) {
			map.put("result", "success");
			return map;
		}
		map.put("result", "fail");
		return map;
	}
}
