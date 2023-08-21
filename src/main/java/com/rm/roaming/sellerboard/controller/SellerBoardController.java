package com.rm.roaming.sellerboard.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rm.roaming.dto.SellerDto;
import com.rm.roaming.sellerboard.service.SellerBoardServiceImpl;

@Controller
@RequestMapping("sellerboard/*")
public class SellerBoardController {
	@Autowired
	private SellerBoardServiceImpl sellerBoardServiceImpl;
	
	@RequestMapping("sellerHotelListPage")
	public String sellerHotelListPage() {
		return "sellerboard/sellerHotelListPage";
	}
	@RequestMapping("sellerMainPage")
	public String sellerMainPage(int id,Model model) {
		model.addAttribute("hotelInfo", sellerBoardServiceImpl.getHotelInfo(id));
		return "sellerboard/sellerMainPage";
	}
	
	@RequestMapping("sellerReserveListPage")
	public String sellerReserveListPage(int id,Model model) {
		model.addAttribute("hotelInfo", sellerBoardServiceImpl.getHotelInfo(id));
		return "sellerboard/sellerReserveListPage";
	}
	@RequestMapping("sellerTimeLinePage")
	public String sellerTimeLinePage(int id,Model model) {
		model.addAttribute("hotelInfo", sellerBoardServiceImpl.getHotelInfo(id));

		return "sellerboard/sellerTimeLinePage";
	}
	@RequestMapping("sellerPriceSettingPage")
	public String sellerPriceSettingPage(int id,Model model) {
		model.addAttribute("hotelInfo", sellerBoardServiceImpl.getHotelInfo(id));

		return "sellerboard/sellerPriceSettingPage";
	}
	@RequestMapping("sellerHotelManagePage")
	public String sellerHotelManagePage(int id,Model model) {
		model.addAttribute("hotelInfo", sellerBoardServiceImpl.getHotelInfo(id));

		return "sellerboard/sellerHotelManagePage";
	}
	@RequestMapping("sellerDashBoardPage")
	public String sellerDashBoardPage(int id,Model model) {
		model.addAttribute("hotelInfo", sellerBoardServiceImpl.getHotelInfo(id));

		return "sellerboard/sellerDashBoardPage";
	}
	@RequestMapping("sellerHotelRegisterPage")
	public String sellerHotelRegisterPage(HttpSession session,Model model) {
		SellerDto sellerDto = (SellerDto) session.getAttribute("sessionSeller");
		sellerBoardServiceImpl.getHotelSysCateList();
		model.addAttribute("id", sellerDto.getId());
		model.addAttribute("syscate", sellerBoardServiceImpl.getHotelSysCateList());
		model.addAttribute("hotelcate", sellerBoardServiceImpl.getHotelCategoriList());
		model.addAttribute("viewList", sellerBoardServiceImpl.getViewList());
		

		return "sellerboard/sellerHotelRegisterPage";
	}
}
