package com.rm.roaming.sellerboard.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.rm.roaming.dto.AssignRoomDto;
import com.rm.roaming.dto.CustomCategoryDto;
import com.rm.roaming.dto.DayChangePriceDto;
import com.rm.roaming.dto.DayPriceDto;
import com.rm.roaming.dto.DayPriceGroupsDto;
import com.rm.roaming.dto.DaysListDto;
import com.rm.roaming.dto.GroupPlusOptionDto;
import com.rm.roaming.dto.HotelCategoryDto;
import com.rm.roaming.dto.HotelDocuDto;
import com.rm.roaming.dto.HotelDto;
import com.rm.roaming.dto.HotelLinkSyscategoryDto;
import com.rm.roaming.dto.HotelListMapDto;
import com.rm.roaming.dto.HotelSyscategoryDto;
import com.rm.roaming.dto.RequestMapSeasonPriceDto;
import com.rm.roaming.dto.ReserveDto;
import com.rm.roaming.dto.ReserveInfoDto;
import com.rm.roaming.dto.RoomDto;
import com.rm.roaming.dto.RoomGroupDto;
import com.rm.roaming.dto.RoomGroupImgDto;
import com.rm.roaming.dto.RoomViewDto;
import com.rm.roaming.dto.SeasonPriceDto;
import com.rm.roaming.dto.SeasonPriceGroupDto;
import com.rm.roaming.dto.TimeLineDetailDto;
import com.rm.roaming.dto.TimeLineDto;
import com.rm.roaming.sellerboard.mapper.SellerBoardSqlMapper;
import com.rm.roaming.userboard.mapper.UserBoardSqlMapper;

@Service
public class SellerBoardServiceImpl {
	@Autowired
	private SellerBoardSqlMapper sellerBoardSqlMapper;
	@Autowired
	private UserBoardSqlMapper userBoardSqlMapper;
	
	public int getHotelPk() {
		return sellerBoardSqlMapper.createHotelPk();
	}
	public int getGroupPk() {
		return sellerBoardSqlMapper.createGroupPk();
	}
	
	public List<HotelCategoryDto> getHotelCategoriList(){ // 호텔카테고리
		return sellerBoardSqlMapper.selectHotelCategoryList();
	}
	public List<HotelSyscategoryDto> getHotelSysCateList(){
		return sellerBoardSqlMapper.selectHotelSyscategory();
	}
	public void registerHotel(HotelDto hotelDto) {
		sellerBoardSqlMapper.insertHotel(hotelDto);
	}
	public void registerHotelSysCategory(HotelLinkSyscategoryDto hotelLinkSyscategoryDto) {
		sellerBoardSqlMapper.insertHotelSyscategory(hotelLinkSyscategoryDto);
	}
	
	public void registerHotelImgAndDocu(int hotel_id,MultipartFile hotelImg,MultipartFile hotelDocu) {
		HotelDto hotelDto = new HotelDto();
		HotelDocuDto hotelDocuDto = new HotelDocuDto();
		hotelDto.setId(hotel_id);
		hotelDocuDto.setHotel_id(hotel_id);
		if (hotelImg != null) {
			
			String rootFolder =  "/Users/su/Desktop/uploadFiles/";
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			String today = sdf.format(new Date());

			File targetFolder = new File(rootFolder + today);
			if (!targetFolder.exists()) {
				targetFolder.mkdirs();
			}

			String fileName = UUID.randomUUID().toString();
			fileName += "_" + System.currentTimeMillis();

			String originalFileName = hotelImg.getOriginalFilename();
			String ext = originalFileName.substring(originalFileName.lastIndexOf("."));

			String savaFileName = today + "/" + fileName + ext;

			try {
				hotelImg.transferTo(new File(rootFolder + savaFileName));
			} catch (Exception e) {
				e.printStackTrace();
			}
			hotelDto.setHotel_img(savaFileName);
		}
		if (hotelDocu != null) {
			
			String rootFolder =  "/Users/su/Desktop/uploadFiles/";
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			String today = sdf.format(new Date());

			File targetFolder = new File(rootFolder + today);
			if (!targetFolder.exists()) {
				targetFolder.mkdirs();
			}

			String fileName = UUID.randomUUID().toString();
			fileName += "_" + System.currentTimeMillis();

			String originalFileName = hotelDocu.getOriginalFilename();
			String ext = originalFileName.substring(originalFileName.lastIndexOf("."));

			String savaFileName = today + "/" + fileName + ext;

			try {
				hotelDocu.transferTo(new File(rootFolder + savaFileName));
			} catch (Exception e) {
				e.printStackTrace();
			}
			hotelDocuDto.setDocu_link(savaFileName);
		}
		sellerBoardSqlMapper.insertHotelImg(hotelDto);
		sellerBoardSqlMapper.insertDocu(hotelDocuDto);
}
		

	public List<Map<String, Object>> getHotelListBySellerId(int seller_id){
		List<HotelDto> hotelList =  sellerBoardSqlMapper.selectMyHotelList(seller_id);
		List<Map<String, Object>> list = new ArrayList<>();
		for(HotelDto hotelDto : hotelList) {
			Map<String, Object> map = new HashMap<>();
			int categoryId = hotelDto.getHotel_category_id();
			map.put("hotelDto", hotelDto);
			map.put("category", userBoardSqlMapper.selectHotelCategoryByHotelCategoryId(categoryId));
			list.add(map);
		}
		return list;
	}
	
	public List<HotelListMapDto> getSellerHotelListAndStatus(int seller_id){
		return sellerBoardSqlMapper.selectHotelListAndDocuStatus(seller_id);
	}
	
	public Map<String, Object> getHotelInfo(int hotel_id){
		Map<String, Object> map = new HashMap<>();
		HotelDto hotelDto =sellerBoardSqlMapper.selectMyHotelById(hotel_id)	;
		map.put("hotelDto", hotelDto);
		map.put("category", userBoardSqlMapper.selectHotelCategoryByHotelCategoryId(hotelDto.getHotel_category_id()));
		return map;
	}

	public HotelDto getMyHotel(int id) { // 내 호텔정보 갖고오기
		return sellerBoardSqlMapper.selectMyHotelById(id);
	}
	
	public int getMyFirstHotel(int seller_id) {
		if(sellerBoardSqlMapper.selectMyFirstHotel(seller_id) != null) {
		HotelDto hotelDto = sellerBoardSqlMapper.selectMyFirstHotel(seller_id);		
		return hotelDto.getId();
		}else return 0;
	}
	public void registerGroup(RoomGroupDto roomGroupDto) {
		for(int i=0; i<7; i++) {
		DayPriceDto dayPriceDto = new DayPriceDto();
		dayPriceDto.setChange_price(0);
		dayPriceDto.setDay(i);
		dayPriceDto.setRoom_group_id(roomGroupDto.getId());
		sellerBoardSqlMapper.insertDayPrice(dayPriceDto);
		}
		sellerBoardSqlMapper.insertRoomGroup(roomGroupDto);
	}
public void registerGroupImg(int groupId,MultipartFile groupImg,MultipartFile[] groupDetailImg,int hotel_id) {
		RoomGroupDto roomGroupDto = new RoomGroupDto();
		roomGroupDto.setId(groupId);
		roomGroupDto.setHotel_id(hotel_id);
		System.out.println(hotel_id);
		if (groupDetailImg != null) {
			for (MultipartFile multipartFile : groupDetailImg) {
				if (multipartFile.isEmpty()) {
					continue;
				}
				String rootFolder = "/Users/su/Desktop/uploadFiles/";
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
				String today = sdf.format(new Date());

				File targetFolder = new File(rootFolder + today);
				if (!targetFolder.exists()) {
					targetFolder.mkdirs();
				}

				String fileName = UUID.randomUUID().toString();
				fileName += "_" + System.currentTimeMillis();

				String originalFileName = multipartFile.getOriginalFilename();
				String ext = originalFileName.substring(originalFileName.lastIndexOf("."));

				String savaFileName = today + "/" + fileName + ext;

				try {
					multipartFile.transferTo(new File(rootFolder + savaFileName));
				} catch (Exception e) {
					e.printStackTrace();
				}
				RoomGroupImgDto roomGroupImgDto = new RoomGroupImgDto();
				roomGroupImgDto.setRoom_group_id(groupId);
				roomGroupImgDto.setDetail_img(savaFileName);
				sellerBoardSqlMapper.insertRoomGroupImg(roomGroupImgDto);
			}
		}
		if (groupImg != null) {
			
			String rootFolder =  "/Users/su/Desktop/uploadFiles/";
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			String today = sdf.format(new Date());

			File targetFolder = new File(rootFolder + today);
			if (!targetFolder.exists()) {
				targetFolder.mkdirs();
			}

			String fileName = UUID.randomUUID().toString();
			fileName += "_" + System.currentTimeMillis();

			String originalFileName = groupImg.getOriginalFilename();
			String ext = originalFileName.substring(originalFileName.lastIndexOf("."));

			String savaFileName = today + "/" + fileName + ext;

			try {
				groupImg.transferTo(new File(rootFolder + savaFileName));
			} catch (Exception e) {
				e.printStackTrace();
			}
			roomGroupDto.setRoom_group_img(savaFileName);
		}
		sellerBoardSqlMapper.insertGroupImg(roomGroupDto);
}

	public void registerPlusOption(GroupPlusOptionDto groupPlusOptionDto) {
		sellerBoardSqlMapper.insertGroupPlusOption(groupPlusOptionDto);
	}
	public void registerCustomCategory(CustomCategoryDto customCategoryDto) {
		sellerBoardSqlMapper.insertCustomCategory(customCategoryDto);
	}
	
	public List<RoomGroupDto> getGroupListByHotelId(int hotel_id){ //그룹리스트 갖고오기
		return sellerBoardSqlMapper.selectGroupListByHotelId(hotel_id);
	}
	public RoomGroupDto getGroupInfo(int id) {//그룹정보갖고오기
		return sellerBoardSqlMapper.selectGroupById(id);
	}
	public List<RoomGroupImgDto> getGroupImg(int room_group_id){//그룹상세이미지
		return sellerBoardSqlMapper.selectGroupImgByRoomGroupId(room_group_id);
	}
	public RoomGroupDto getFirstGroup(int hotel_id) { // 첫번째그룹
		return sellerBoardSqlMapper.selectFirstGroup(hotel_id);
	}
	public List<RoomViewDto> getViewList(){ // 뷰 리스트셀렉트
		return sellerBoardSqlMapper.selectRoomViewList();
	}
	public void registerRoom(RoomDto roomDto) { // 룸등록
		sellerBoardSqlMapper.insertRoom(roomDto);
	}
	public Map<String, Object> getGroupDetailInfo(int room_group_id){ //그룹상세정보
		Map<String, Object> map = new HashMap<>();
		map.put("plusOption", sellerBoardSqlMapper.selectGroupPlusOptionByRoomGroupId(room_group_id));
		map.put("custom", sellerBoardSqlMapper.selectCustomCategoryByRoomGroupId(room_group_id));
		map.put("room", sellerBoardSqlMapper.selectRoomByRoomGroupId(room_group_id)); //호실
		RoomGroupDto roomGroupDto = sellerBoardSqlMapper.selectGroupById(room_group_id);
		map.put("view", sellerBoardSqlMapper.selectViewNameByRoomViewId(roomGroupDto.getView_id())); //뷰
		return map;
	}
	public List<RoomGroupDto> getCurrentWeekSellPrice(int hotel_id){
		return sellerBoardSqlMapper.selectCurrentWeekSellPrice(hotel_id);
	}
	public List<Map<String, Object>> getTodayRoomCount(int hotel_id){
		List<ReserveDto> getList = sellerBoardSqlMapper.selectCountTodayReserve(hotel_id);
		List<Map<String, Object>> list = new ArrayList<>();
		for(ReserveDto reserveDto :getList) {
			Map<String, Object> map = new HashMap<>();
			int reserve = reserveDto.getFinal_price();
			System.out.println(reserve);
			int room = sellerBoardSqlMapper.selectRoomCountByGroupId(reserveDto.getRoom_group_id());
			System.out.println(room);
			int per =  (int)((double)reserve/room * 100);
			System.out.println(per);
			map.put("roomGroupDto",sellerBoardSqlMapper.selectGroupById(reserveDto.getRoom_group_id()));
			map.put("per",per);
			list.add(map);
		}
		return list;
	}
	public Map<String, Object> getTodayCheckInOut(int hotel_id){
		Map<String, Object> map = new HashMap<>();
		
		map.put("checkIn",  sellerBoardSqlMapper.selectTodayCheckIn(hotel_id));
		map.put("checkOut",  sellerBoardSqlMapper.selectTodayCheckOut(hotel_id));
		return map;
	}
	
	public List<ReserveInfoDto> getReserveList(int hotel_id,String date){
		return sellerBoardSqlMapper.selectReserveListByDate(hotel_id, date);
	}
	
	public void updateStatus(int id,AssignRoomDto assignRoomDto) {
		String status = sellerBoardSqlMapper.selectReserveStatus(id).getStatus();
		System.out.println(status);
		if(status.equals("예약")){
			System.out.println(status);
			sellerBoardSqlMapper.updateReserveCheckIn(id);
			sellerBoardSqlMapper.insertAssignRoom(assignRoomDto);
		}else if(status.equals("입실")){
			System.out.println(status);
			sellerBoardSqlMapper.updateReserveCheckOut(id);
		}
	}
	
	public List<RoomDto> getEmptyRoomList(int id){
		return sellerBoardSqlMapper.selectEmptyRoom(id);
	}

	public List<TimeLineDto> getTimeLineList(int hotel_id){
		return sellerBoardSqlMapper.selectTimeLineInfo(hotel_id);
	}
	public TimeLineDetailDto getTimeLineDetailInfo(int reserve_id) {
		return sellerBoardSqlMapper.selectTimeLineDetailInfo(reserve_id);
	}
	
	//날짜별 가격변동찾기
	public List<DayPriceDto> getDayPriceList(int hotel_id){
		return sellerBoardSqlMapper.selectDayPriceByHotelId(hotel_id);
	}
	//날짜별 가격변동 등록
	public void registerDayPrice(DayPriceGroupsDto dayPriceGroupsDto) {
		List<DaysListDto> list = dayPriceGroupsDto.getGroups();
		for(int i=0; i<list.size(); i++) {
			List<DayChangePriceDto> dayChange = list.get(i).getDays();
			
			for(int j=0; j<dayChange.size(); j++) {
				DayPriceDto dayPriceDto = new DayPriceDto();
				dayPriceDto.setRoom_group_id(list.get(i).getGroup());
				dayPriceDto.setDay(dayChange.get(j).getDay());
				dayPriceDto.setChange_price(dayChange.get(j).getChange_price());
				sellerBoardSqlMapper.insertDayPrice(dayPriceDto);
			}
			
		}
	}
	
	public void deleteDayPrice(int hotel_id) {
		sellerBoardSqlMapper.deleteDayPrice(hotel_id);
	}
	
	public void insertSeasonPrice(SeasonPriceDto seasonPriceDto,int[] seasonTargetGroups,int hotelId) {
		List<RoomGroupDto> list  =  sellerBoardSqlMapper.selectGroupListByHotelId(hotelId);
		int seasonPk = sellerBoardSqlMapper.createSeasonPricePk();
		seasonPriceDto.setId(seasonPk);
		for(int roomGroupId : seasonTargetGroups) {
			if(roomGroupId == 0) {
				for(RoomGroupDto roomGroupDto : list) {
					SeasonPriceGroupDto seasonPriceGroupDto = new SeasonPriceGroupDto();
					seasonPriceGroupDto.setRoom_group_id(roomGroupDto.getId());
					seasonPriceGroupDto.setSeason_price_id(seasonPk);
					sellerBoardSqlMapper.insertSeasonPriceGroup(seasonPriceGroupDto);
				}
			}else {
				SeasonPriceGroupDto seasonPriceGroupDto = new SeasonPriceGroupDto();
				seasonPriceGroupDto.setRoom_group_id(roomGroupId);
				seasonPriceGroupDto.setSeason_price_id(seasonPk);
				sellerBoardSqlMapper.insertSeasonPriceGroup(seasonPriceGroupDto);
			}
		}
		sellerBoardSqlMapper.insertSeasonPrice(seasonPriceDto);
	}
	public List<RequestMapSeasonPriceDto> getSeasonPriceList(int hotel_id){
		return sellerBoardSqlMapper.selectSeasonPriceList(hotel_id);
	}
	
	public void deleteSeasonPrice(int id) {
		sellerBoardSqlMapper.deleteSeasonPrice(id);
		sellerBoardSqlMapper.deleteSeasonPriceGroup(id);
	}
	public void updateSeasonPriceAndGroup(SeasonPriceDto seasonPriceDto,int[] updateSeasonTargetGroups,int hotelId) {
		List<RoomGroupDto> list  =  sellerBoardSqlMapper.selectGroupListByHotelId(hotelId);
		sellerBoardSqlMapper.deleteSeasonPriceGroup(seasonPriceDto.getId());
		for(int roomGroupId : updateSeasonTargetGroups) {
			if(roomGroupId == 0) {
				for(RoomGroupDto roomGroupDto : list) {
					SeasonPriceGroupDto seasonPriceGroupDto = new SeasonPriceGroupDto();
					seasonPriceGroupDto.setRoom_group_id(roomGroupDto.getId());
					seasonPriceGroupDto.setSeason_price_id(seasonPriceDto.getId());
					sellerBoardSqlMapper.insertSeasonPriceGroup(seasonPriceGroupDto);
				}
			}else {
				SeasonPriceGroupDto seasonPriceGroupDto = new SeasonPriceGroupDto();
				seasonPriceGroupDto.setRoom_group_id(roomGroupId);
				seasonPriceGroupDto.setSeason_price_id(seasonPriceDto.getId());
				sellerBoardSqlMapper.insertSeasonPriceGroup(seasonPriceGroupDto);
			}
		}
		sellerBoardSqlMapper.updateSeasonPrice(seasonPriceDto);
	}
	public ReserveDto getReserveDashOfMonth(int hotel_id,int month) {
		return sellerBoardSqlMapper.selectReserveDashOfMonth(hotel_id, month);
	}
	public List<RoomGroupDto> getRoomReserveDashOfMonth(int hotel_id,int month) {
		return sellerBoardSqlMapper.selectRoomReserveDashOfMonth(hotel_id, month);
	}
	public List<ReserveDto> getReserveGraphOfMonth(int hotel_id,String[] dates) {
		List<ReserveDto> list = new ArrayList<>();
		for(String date : dates) {
			System.out.println(date);
			list.add(sellerBoardSqlMapper.selectReserveGraphOfMonth(hotel_id, date).get(0));
		}
		return list;
	}
	public List<ReserveDto> getBarGraph(int hotel_id){
		List<ReserveDto> list = new ArrayList<>();
		for(int i=1; i<=12; i++) {
			list.add(sellerBoardSqlMapper.selectBarGraphOfYear(hotel_id, i));
		}
		return list;
	}
	
	public void updateHotelStatus(int hotel_id) {
		sellerBoardSqlMapper.updateHotelStatus(hotel_id);
	}
	
	public HotelDocuDto getReturnText(int hotel_id) {
		return sellerBoardSqlMapper.selectReturnDocu(hotel_id);
	}
	public void updateHotelDocu(int hotel_id, MultipartFile file) {
		HotelDocuDto hotelDocuDto = new HotelDocuDto();
		if (file != null) {
			
			String rootFolder =  "/Users/su/Desktop/uploadFiles/";
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			String today = sdf.format(new Date());

			File targetFolder = new File(rootFolder + today);
			if (!targetFolder.exists()) {
				targetFolder.mkdirs();
			}

			String fileName = UUID.randomUUID().toString();
			fileName += "_" + System.currentTimeMillis();

			String originalFileName = file.getOriginalFilename();
			String ext = originalFileName.substring(originalFileName.lastIndexOf("."));

			String savaFileName = today + "/" + fileName + ext;

			try {
				file.transferTo(new File(rootFolder + savaFileName));
			} catch (Exception e) {
				e.printStackTrace();
			}
			hotelDocuDto.setHotel_id(hotel_id);
			hotelDocuDto.setDocu_link(savaFileName);
			sellerBoardSqlMapper.updateHotelDocu(hotelDocuDto);
		}
	}
	
	public ReserveDto getCancleReserveDashOfMonth(int hotel_id,int month) {
	      return sellerBoardSqlMapper.selectCancleReserveDashOfMonth(hotel_id, month);
	   }
}
