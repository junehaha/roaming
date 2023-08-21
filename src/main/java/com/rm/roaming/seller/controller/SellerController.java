package com.rm.roaming.seller.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rm.roaming.dto.SellerDto;
import com.rm.roaming.dto.UserDto;
import com.rm.roaming.seller.service.SellerServiceImpl;

@Controller
@RequestMapping("seller/*")
public class SellerController {
	@Autowired
	private SellerServiceImpl sellerServiceImpl;
	@RequestMapping("sellerLoginPage")
	public String SellerLoginPage() {
		return "seller/sellerLoginPage"; 
	}
	
	@RequestMapping("sellerRegisterPage")
	public String sellerRegisterPage() {
		return "seller/sellerRegisterPage"; 
	}
	@RequestMapping("sellerRegisterProcess")
	public String sellerRegisterProcess(SellerDto sellerDto) {
		sellerServiceImpl.registerSeller(sellerDto);
		return "seller/sellerRegiSuccessPage"; 
	}
	@RequestMapping("sellerLoginProcess")
	public String sellerLoginProcess(SellerDto sellerDto,HttpSession session) {
		SellerDto sessionSeller = sellerServiceImpl.sellerLogin(sellerDto);
		session.setAttribute("sessionSeller", sessionSeller);
		return "redirect:../sellerboard/sellerHotelListPage";
	}
	@RequestMapping("sellerLogoutProcess")
	public String sellerLogoutProcess(HttpSession session) {
		session.invalidate();
		return "redirect:./sellerLoginPage";
	}
	@RequestMapping("kakaoToken2")
	public String kakaoToken2(String code,Model model) {
		model.addAttribute("code", code);
		return "seller/kakaoToken2";
	}
	@RequestMapping("kakaoSellerRegisterProcess")
	public String kakaoSellerRegisterProcess(SellerDto sellerDto,HttpSession session) {
		String kid = (String) session.getAttribute("kid");
		String name = (String) session.getAttribute("name");
		sellerDto.setSeller_id(kid);
		sellerDto.setSeller_pw(kid);
		sellerDto.setSeller_name(name);
		sellerServiceImpl.KakaoSellerRegister(sellerDto);
		session.removeAttribute("kid");
		session.removeAttribute("name");
		session.setAttribute("sessionSeller", sellerServiceImpl.selectSellerIdById(kid));
		return  "redirect:../sellerboard/sellerHotelListPage";
		
	}
	
	
	@RequestMapping("kakaoRegister2")
	public String kakaoRegister2() {
		return "seller/kakaoRegister2";
	}
}
