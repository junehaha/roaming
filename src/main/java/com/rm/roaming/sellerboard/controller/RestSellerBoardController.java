package com.rm.roaming.sellerboard.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.rm.roaming.dto.AssignRoomDto;
import com.rm.roaming.dto.CheckInOutDto;
import com.rm.roaming.dto.CustomCategoryDto;
import com.rm.roaming.dto.CustomCategorysDto;
import com.rm.roaming.dto.DayPriceGroupsDto;
import com.rm.roaming.dto.GroupPlusOptionDto;
import com.rm.roaming.dto.GroupsDto;
import com.rm.roaming.dto.HotelDto;
import com.rm.roaming.dto.HotelLinkSyscategoryDto;
import com.rm.roaming.dto.HotelObjDto;
import com.rm.roaming.dto.PlusOptionsDto;
import com.rm.roaming.dto.RoomDto;
import com.rm.roaming.dto.RoomGroupDto;
import com.rm.roaming.dto.RoomsDto;
import com.rm.roaming.dto.SeasonPriceDto;
import com.rm.roaming.dto.SellerDto;
import com.rm.roaming.sellerboard.service.SellerBoardServiceImpl;

@RestController
@RequestMapping("sellerboard/*")
public class RestSellerBoardController {
	@Autowired
	private SellerBoardServiceImpl sellerBoardServiceImpl;

	@RequestMapping("getMyID")
	public Map<String, Object> getMyID(HttpSession session) {
		Map<String, Object> map = new HashMap<>();
		if (session.getAttribute("sessionSeller") != null) {
			SellerDto SellerSession = (SellerDto) session.getAttribute("sessionSeller");
			map.put("result", "success");
			map.put("id", SellerSession.getId());
		} else
			map.put("result", "fail");
		return map;
	}

	@RequestMapping("getHotelCategory")
	public Map<String, Object> getHotelCategory() {
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		map.put("cateList", sellerBoardServiceImpl.getHotelCategoriList());
		map.put("syscateList", sellerBoardServiceImpl.getHotelSysCateList());
		return map;
	}


	@RequestMapping("getHotelList")
	public Map<String, Object> getHotelList(int seller_id) {
		Map<String, Object> map = new HashMap<>();
		if (!sellerBoardServiceImpl.getHotelListBySellerId(seller_id).isEmpty()
				&& sellerBoardServiceImpl.getHotelListBySellerId(seller_id) != null) {
			map.put("result", "success");
			map.put("hotelInfo", sellerBoardServiceImpl.getHotelListBySellerId(seller_id));
			return map;
		} else
			map.put("result", "fail");

		return map;

	}
	@RequestMapping("getSellerHotelListAndStatus")
	public Map<String, Object> getSellerHotelListAndStatus(int seller_id) {
		Map<String, Object> map = new HashMap<>();
		if (!sellerBoardServiceImpl.getSellerHotelListAndStatus(seller_id).isEmpty()
				&& sellerBoardServiceImpl.getSellerHotelListAndStatus(seller_id) != null) {
			map.put("result", "success");
			map.put("hotelInfo", sellerBoardServiceImpl.getSellerHotelListAndStatus(seller_id));
			return map;
		} else
			map.put("result", "fail");

		return map;

	}
	@RequestMapping("getMyHotel")
	public Map<String, Object> getMyHotel(int id) {
		System.out.println(id);
		Map<String, Object> map = new HashMap<>();
		if (sellerBoardServiceImpl.getMyHotel(id) != null) {
			map.put("result", "success");
			map.put("hotelInfo", sellerBoardServiceImpl.getMyHotel(id));
			map.put("groupList", sellerBoardServiceImpl.getGroupListByHotelId(id)); // getmyhotel 할때 아래 그룹리스트도 받아오기
			return map;
		} else {
			map.put("result", "fail");
			map.put("reason", "호텔을 등록하지 않았습니다.");
			return map;
		}

	}

	@RequestMapping("getMyFirstHotel")
	public Map<String, Object> getMyFirstHotel(int seller_id) {
		Map<String, Object> map = new HashMap<>();
		if (sellerBoardServiceImpl.getMyFirstHotel(seller_id) > 0) {
			map.put("result", "success");
			map.put("id", sellerBoardServiceImpl.getMyFirstHotel(seller_id));
			return map;
		} else
			map.put("result", "fail");
		return map;

	}



	@RequestMapping("getGroupInfo")
	public Map<String, Object> getGroupInfo(int id) {
		Map<String, Object> map = new HashMap<>();
		if (sellerBoardServiceImpl.getGroupInfo(id) != null) {
			map.put("result", "success");
			map.put("groupInfo", sellerBoardServiceImpl.getGroupInfo(id));
			return map;
		} else
			map.put("result", "fail");
		return map;
	}

	@RequestMapping("getFirstGroup")
	public Map<String, Object> getFirstGroup(int hotel_id) {
		Map<String, Object> map = new HashMap<>();
		if (sellerBoardServiceImpl.getFirstGroup(hotel_id) != null) {
			map.put("result", "success");
			RoomGroupDto roomGroupDto = sellerBoardServiceImpl.getFirstGroup(hotel_id);
			map.put("groupId", roomGroupDto.getId());
			return map;
		} else {
			map.put("result", "fail");
			return map;
		}

	}

	@RequestMapping("getGroupDetailImage")
	public Map<String, Object> getGroupDetailImage(int room_group_id) {
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		map.put("image", sellerBoardServiceImpl.getGroupImg(room_group_id));
		return map;
	}

	@RequestMapping("getViewList")
	public Map<String, Object> getViewList() {
		Map<String, Object> map = new HashMap<>();
		map.put("viewList", sellerBoardServiceImpl.getViewList());
		return map;
	}

	@RequestMapping("roomRegister")
	public Map<String, Object> roomRegister(RoomDto roomDto) {
		Map<String, Object> map = new HashMap<>();
		sellerBoardServiceImpl.registerRoom(roomDto);
		map.put("result", "success");
		return map;
	}

	@RequestMapping("getGroupDetailInfo")
	public Map<String, Object> getGroupDetailInfo(int room_group_id) {
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		map.put("info", sellerBoardServiceImpl.getGroupDetailInfo(room_group_id));
		return map;
	}

	 @RequestMapping("getCurrentWeekSellPrice")
	   public Map<String, Object> getCurrentWeekSellPrice(int hotel_id) {
	      int sumPrice = 0;
	      for(RoomGroupDto roomGroupDto : sellerBoardServiceImpl.getCurrentWeekSellPrice(hotel_id)) {
	         sumPrice += roomGroupDto.getPrice();
	      }
	      
	      Map<String, Object> map = new HashMap<>();
	      if (sumPrice != 0) {
	         map.put("result", "success");
	         map.put("info", sellerBoardServiceImpl.getCurrentWeekSellPrice(hotel_id));
	         return map;
	      } else
	         map.put("result", "fail");
	      return map;
	   }

	@RequestMapping("getRoomPercent")
	public Map<String, Object> getRoomPercent(int hotel_id) {
		Map<String, Object> map = new HashMap<>();
		map.put("info", sellerBoardServiceImpl.getTodayRoomCount(hotel_id));
		return map;
	}

	@RequestMapping("getTodayCheckInOut")
	   public Map<String, Object> getTodayCheckInOut(int hotel_id) {
	      Map<String, Object> map = new HashMap<>();
	      List<CheckInOutDto> inDto = (List<CheckInOutDto>) sellerBoardServiceImpl.getTodayCheckInOut(hotel_id).get("checkIn");
	      if(!inDto.isEmpty()) {
	         map.put("inresult", "insuccess");
	         map.put("info", sellerBoardServiceImpl.getTodayCheckInOut(hotel_id));
	         return map;

	      }
	      List<CheckInOutDto> outDto = (List<CheckInOutDto>) sellerBoardServiceImpl.getTodayCheckInOut(hotel_id).get("checkOut");
	      if(!outDto.isEmpty()) {
	         map.put("outresult", "outsuccess");
	         map.put("info", sellerBoardServiceImpl.getTodayCheckInOut(hotel_id));
	         return map;

	      }
	      
	      map.put("info", sellerBoardServiceImpl.getTodayCheckInOut(hotel_id));
	      return map;
	   }

	@RequestMapping("getReserveList")
	public Map<String, Object> getReserveList(int hotel_id, String date) {
		Map<String, Object> map = new HashMap<>();
		int LastIndex = date.lastIndexOf("/");
		String reserveDate = date.substring(0, LastIndex);
		System.out.println(date);
		System.out.println(reserveDate);
		if (!sellerBoardServiceImpl.getReserveList(hotel_id, reserveDate).isEmpty()
				&& sellerBoardServiceImpl.getReserveList(hotel_id, reserveDate) != null) {
			map.put("result", "success");
			map.put("info", sellerBoardServiceImpl.getReserveList(hotel_id, reserveDate));
			return map;
		} else {
			map.put("result", "fail");
			return map;
		}

	}

	@RequestMapping("checkInOutProcess")
	public Map<String, Object> checkInOutProcess(int id, AssignRoomDto assignRoomDto) {
		Map<String, Object> map = new HashMap<>();
		sellerBoardServiceImpl.updateStatus(id, assignRoomDto);
		map.put("result", "success");
		return map;
	}

	@RequestMapping("getEmptyRoom")
	public Map<String, Object> getEmptyRoom(int id) {
		Map<String, Object> map = new HashMap<>();
		if (!sellerBoardServiceImpl.getEmptyRoomList(id).isEmpty()
				&& sellerBoardServiceImpl.getEmptyRoomList(id) != null) {
			map.put("result", "success");
			map.put("list", sellerBoardServiceImpl.getEmptyRoomList(id));
			return map;
		}
		map.put("result", "fail");
		return map;
	}

	@RequestMapping("getTimeLine")
	public Map<String, Object> getTimeLine(int hotel_id) {
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		map.put("timeLine", sellerBoardServiceImpl.getTimeLineList(hotel_id));
		return map;
	}

	@RequestMapping("getTimeLineDetail")
	public Map<String, Object> getTimeLineDetail(int reserve_id) {
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		map.put("timeLineDetail", sellerBoardServiceImpl.getTimeLineDetailInfo(reserve_id));
		return map;
	}

	@RequestMapping("getGroupList")
	public Map<String, Object> getGroupList(int hotel_id) {
		Map<String, Object> map = new HashMap<>();
		map.put("groupList", sellerBoardServiceImpl.getGroupListByHotelId(hotel_id));
		return map;
	}

	@RequestMapping("getDayPriceList")
	public Map<String, Object> getDayPriceList(int hotel_id) {
		Map<String, Object> map = new HashMap<>();
		if (!sellerBoardServiceImpl.getDayPriceList(hotel_id).isEmpty()
				&& sellerBoardServiceImpl.getDayPriceList(hotel_id) != null) {
			map.put("result", "success");
			map.put("groupList", sellerBoardServiceImpl.getGroupListByHotelId(hotel_id));
			map.put("dayPriceList", sellerBoardServiceImpl.getDayPriceList(hotel_id));
			return map;
		} else {
			map.put("result", "fail");
			map.put("groupList", sellerBoardServiceImpl.getGroupListByHotelId(hotel_id));
			return map;
		}
	}

	@RequestMapping("saveDayPrice")
	public Map<String, Object> saveDayPrice(@RequestBody DayPriceGroupsDto dayPrice) {
		System.out.println("sadsadsadsa");
		Map<String, Object> map = new HashMap<>();
		int hotel_id = dayPrice.getHotel_id();

		if (sellerBoardServiceImpl.getDayPriceList(hotel_id).isEmpty()
				&& sellerBoardServiceImpl.getDayPriceList(hotel_id) == null) {
			sellerBoardServiceImpl.registerDayPrice(dayPrice);
			map.put("result", "success");
			return map;
		} else {
			map.put("result", "deleteAndSuccess");
			sellerBoardServiceImpl.deleteDayPrice(hotel_id);
			sellerBoardServiceImpl.registerDayPrice(dayPrice);
			return map;
		}
	}

	@RequestMapping("regiEventPrice")
	public Map<String, Object> regiEventPrice(SeasonPriceDto seasonPriceDto, int[] seasonTargetGroups, int hotelId) {
		Map<String, Object> map = new HashMap<>();
		sellerBoardServiceImpl.insertSeasonPrice(seasonPriceDto, seasonTargetGroups, hotelId);
		map.put("result", "success");
		return map;
	}

	@RequestMapping("getSeasonPriceList")
	public Map<String, Object> getSeasonPriceList(int hotel_id) {
		Map<String, Object> map = new HashMap<>();
		map.put("seasonPriceList", sellerBoardServiceImpl.getSeasonPriceList(hotel_id));
		return map;
	}

	@RequestMapping("deleteSeasonProcess")
	public Map<String, Object> deleteSeasonProcess(int id) {
		Map<String, Object> map = new HashMap<>();
		sellerBoardServiceImpl.deleteSeasonPrice(id);
		map.put("result", "success");
		return map;
	}

	@RequestMapping("updateEventPrice")
	public Map<String, Object> updateEventPrice(SeasonPriceDto seasonPriceDto, int[] updateSeasonTargetGroups,
			int hotelId) {
		Map<String, Object> map = new HashMap<>();
		sellerBoardServiceImpl.updateSeasonPriceAndGroup(seasonPriceDto, updateSeasonTargetGroups, hotelId);
		map.put("result", "success");
		return map;
	}

	@RequestMapping("getTotalReserve")
   public Map<String, Object> getTotalReserve(int hotel_id, int month) {
      Map<String, Object> map = new HashMap<>();
      map.put("result", "success");
      map.put("reserveInfo", sellerBoardServiceImpl.getReserveDashOfMonth(hotel_id, month));
      map.put("creserveInfo", sellerBoardServiceImpl.getCancleReserveDashOfMonth(hotel_id, month));
      return map;
   }

	@RequestMapping("getChartOfMonth")
	public Map<String, Object> getChartOfMonth(int hotel_id, int month) {
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		map.put("roomReserve", sellerBoardServiceImpl.getRoomReserveDashOfMonth(hotel_id, month));
		return map;
	}

	@RequestMapping("getGraphOfMonth")
	public Map<String, Object> getGraphOfMonth(int hotel_id, String[] dates) {
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		map.put("reserveGraph", sellerBoardServiceImpl.getReserveGraphOfMonth(hotel_id, dates));
		return map;
	}

	@RequestMapping("getBarGraph")
	public Map<String, Object> getBarGraph(int hotel_id) {
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		map.put("reserveBar", sellerBoardServiceImpl.getBarGraph(hotel_id));
		return map;
	}

	@RequestMapping("registHotel")
	public Map<String, Object> registHotel(@RequestBody HotelObjDto hotelObjj){
		Map<String, Object> map = new HashMap<>();
		System.out.println(hotelObjj.getHotel().getSeller_id());
		int hotelId = sellerBoardServiceImpl.getHotelPk();
		List<Integer> groupIdList = new ArrayList<>();
		HotelDto hotelDto = new HotelDto();
		hotelDto.setId(hotelId);
		hotelDto.setHotel_name(hotelObjj.getHotel().getHotel_name());
		hotelDto.setHotel_category_id(hotelObjj.getHotel().getHotel_category_id());
		hotelDto.setContent(hotelObjj.getHotel().getContent());
		hotelDto.setHotel_loc(hotelObjj.getHotel().getHotel_loc());
		hotelDto.setHotel_tel(hotelObjj.getHotel().getHotel_tel());
		hotelDto.setSeller_id(hotelObjj.getHotel().getSeller_id());
		sellerBoardServiceImpl.registerHotel(hotelDto);
		int[] syscate = hotelObjj.getHotel().getSystem_categorys();
		for(int s = 0; s<syscate.length; s++) {
			HotelLinkSyscategoryDto hotelLinkSyscategoryDto = new HotelLinkSyscategoryDto();
			hotelLinkSyscategoryDto.setHotel_id(hotelId);
			hotelLinkSyscategoryDto.setSyscategory_id(syscate[s]);
			sellerBoardServiceImpl.registerHotelSysCategory(hotelLinkSyscategoryDto);
		}
		for(GroupsDto groupsDto : hotelObjj.getGroups()) {
			RoomGroupDto roomGroupDto = new RoomGroupDto();
			int groupId= sellerBoardServiceImpl.getGroupPk();
			groupIdList.add(groupId);
			roomGroupDto.setId(groupId);
			roomGroupDto.setHotel_id(hotelId);
			roomGroupDto.setRoom_group_name(groupsDto.getRoom_group_name());
			roomGroupDto.setView_id(groupsDto.getView_id());
			roomGroupDto.setFixed_number(groupsDto.getFixed_number());
			roomGroupDto.setPrice(groupsDto.getPrice());
			sellerBoardServiceImpl.registerGroup(roomGroupDto);
			for(CustomCategorysDto customCategorysDto : groupsDto.getCustom_categorys()) {
				CustomCategoryDto customCategoryDto = new CustomCategoryDto();
				customCategoryDto.setRoom_group_id(groupId);
				customCategoryDto.setCategory_name(customCategorysDto.getCategory_name());
				sellerBoardServiceImpl.registerCustomCategory(customCategoryDto);
				
			}
			for(PlusOptionsDto plusOptionsDto :groupsDto.getPlus_options()) {
				GroupPlusOptionDto groupPlusOptionDto = new GroupPlusOptionDto();
				groupPlusOptionDto.setPlus_option(plusOptionsDto.getPlus_option());
				groupPlusOptionDto.setRoom_group_id(groupId);
				groupPlusOptionDto.setPrice(plusOptionsDto.getOption_price());
				sellerBoardServiceImpl.registerPlusOption(groupPlusOptionDto);		
			}
			for(RoomsDto roomsDto :groupsDto.getRooms()) {
				RoomDto roomDto = new RoomDto();
				roomDto.setRoom_group_id(groupId);
				roomDto.setRoom_number(roomsDto.getRoom_number());
				sellerBoardServiceImpl.registerRoom(roomDto);
			}
		}
		
		map.put("result", "success");
		map.put("hotelId", hotelId);
		map.put("groupIdList", groupIdList);
		return map;
	}
	
	@RequestMapping("registerImg")
	public Map<String, Object> registerImg(int groupId,MultipartFile groupImg,MultipartFile[] groupDetailImg,int hotelId) {
		Map<String, Object> map = new HashMap<>();
		System.out.println(hotelId);
		sellerBoardServiceImpl.registerGroupImg(groupId,groupImg,groupDetailImg,hotelId);
		map.put("result", "success");
		return map;
	}
	@RequestMapping("registerHotelImgAndDocu")
	public Map<String, Object> registerHotelImgAndDocu(int hotel_id,MultipartFile hotelImg,MultipartFile hotelDocu) {
		Map<String, Object> map = new HashMap<>();
		
		sellerBoardServiceImpl.registerHotelImgAndDocu(hotel_id,hotelImg,hotelDocu);
		map.put("result", "success");
		return map;
	}
	
	@RequestMapping("updateHotelStatus")
	public Map<String, Object> updateHotelStatus(int hotel_id) {
		Map<String, Object> map = new HashMap<>();
		sellerBoardServiceImpl.updateHotelStatus(hotel_id);
		map.put("result", "success");
		return map;
	}
	
	
	@RequestMapping("getReturnDocu")
	public Map<String, Object> getReturnDocu(int hotel_id) {
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		map.put("returnText", sellerBoardServiceImpl.getReturnText(hotel_id));
		return map;
	}
	
	@RequestMapping("updateHotelDocu")
	public Map<String, Object> updateHotelDocu(int hotel_id,MultipartFile file) {
		Map<String, Object> map = new HashMap<>();
		sellerBoardServiceImpl.updateHotelDocu(hotel_id, file);
		map.put("result", "success");
		return map;
	}
}