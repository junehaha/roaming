package com.rm.roaming.adminboard.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.rm.roaming.adminboard.service.AdminBoardServiceImpl;
import com.rm.roaming.dto.MonthSaleDto;

@RestController
@RequestMapping("/adminboard/")
public class RestAdminBoardController {
   @Autowired
   private AdminBoardServiceImpl adminBoardService;
   
   @RequestMapping("getHotelDash")
   public Map<String, Object> getHotelDash(){
      Map<String, Object> map = new HashMap<>();
      // 월간 숙소 매출
      List<MonthSaleDto> MonthReserveSale = adminBoardService.getMonthReserveSale();
      // 월간 짐 서비스 매출
      List<MonthSaleDto> MonthZimSale = adminBoardService.getMonthZimSale();
      map.put("hotelDash", MonthReserveSale);
      map.put("zimDash", MonthZimSale);
      return map;
   }
}