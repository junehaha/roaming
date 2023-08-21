package com.rm.roaming.userboard.service;

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

import com.rm.roaming.admin.mapper.AdminSqlMapper;
import com.rm.roaming.adminboard.mapper.AdminBoardSqlMapper;
import com.rm.roaming.dto.AdminDto;
import com.rm.roaming.dto.CouponDto;
import com.rm.roaming.dto.DayPriceDto;
import com.rm.roaming.dto.GroupPlusOptionDto;
import com.rm.roaming.dto.HotelDto;
import com.rm.roaming.dto.HotelLikeDto;
import com.rm.roaming.dto.HotelLinkSyscategoryDto;
import com.rm.roaming.dto.HotelReviewDto;
import com.rm.roaming.dto.HotelSyscategoryDto;
import com.rm.roaming.dto.ItemBuyDto;
import com.rm.roaming.dto.ItemCategoryDto;
import com.rm.roaming.dto.ItemDto;
import com.rm.roaming.dto.ItemImageDto;
import com.rm.roaming.dto.ItemLikeDto;
import com.rm.roaming.dto.ItemReviewDto;
import com.rm.roaming.dto.OptionReserveDto;
import com.rm.roaming.dto.PointDto;
import com.rm.roaming.dto.ReserveDto;
import com.rm.roaming.dto.ReviewJoinDto;
import com.rm.roaming.dto.RoomGroupDto;
import com.rm.roaming.dto.RoomGroupImgDto;
import com.rm.roaming.dto.UserAddressDto;
import com.rm.roaming.dto.UserCouponDto;
import com.rm.roaming.dto.UserDto;
import com.rm.roaming.sellerboard.mapper.SellerBoardSqlMapper;
import com.rm.roaming.user.mapper.UserSqlMapper;
import com.rm.roaming.userboard.mapper.UserBoardSqlMapper;

@Service
public class UserBoardServiceImpl { 
	
	@Autowired
	private UserBoardSqlMapper userBoardSqlMapper;
	
	@Autowired
	private UserSqlMapper userSqlMapper;
	
	@Autowired
	private AdminBoardSqlMapper adminBoardSqlMapper;
	
	@Autowired
	private SellerBoardSqlMapper sellerBoardSqlMapper;
	
	@Autowired
	private AdminSqlMapper adminSqlMapper;
	
	// 마이 페이지 메인
	public Map<String, Object> getMyPage(int id) {
		Map<String, Object> map = new HashMap<>();
		System.out.println("id : " + id);
		UserDto userDto = userSqlMapper.selectByUserId(id);
		System.out.println("userDto : " + userDto.toString());
		int myPoint = userBoardSqlMapper.selectMyPoint(userDto.getId());
		System.out.println("myPoint : " + myPoint);
		int myCouponCount = userBoardSqlMapper.selectMyCouponCount(userDto.getId());
		
		map.put("userDto", userDto);
		map.put("myPoint", myPoint);
		map.put("myCouponCount", myCouponCount);
		
		
		return map;
	}
	
	
	
	
	// 모든 쿠폰 리스트 조회
	public List<Map<String,Object>> getCouponList(int userId) {
		
		List<Map<String, Object>> couponList = new ArrayList<>();
		
		List<CouponDto> couponDtoList = userBoardSqlMapper.selectCouponList();
		
		for(CouponDto couponDto : couponDtoList) {
			
			Map<String, Object> map = new HashMap<>();
				
			int duplicate = adminBoardSqlMapper.selectNotDuplicate(couponDto.getId(), userId);
			int useCouponCount = adminBoardSqlMapper.decreaseCouponCount(couponDto.getId());
			int quantity = couponDto.getCoupon_count() - useCouponCount;
			
			map.put("duplicate", duplicate);
			map.put("couponDto", couponDto);
			map.put("quantity", quantity);
			
			couponList.add(map);
		}
		
		return couponList;
	}
	
	
	
	// 내 쿠폰함에 쿠폰 추가 
	public void userCouponAdd(UserCouponDto userCouponDto) {
		
		userBoardSqlMapper.insertUserCoupon(userCouponDto);
		
	}
	
	public int userCouponCount(int id) {
		return userBoardSqlMapper.UserCouponCount(id);
	}
	
	// 내 쿠폰함 사용가능쿠폰 리스트 조회
	public List<Map<String,Object>> getUserCouponList(int id, int page) {
		
		List<Map<String, Object>> userCouponList = new ArrayList<>();
		
		List<UserCouponDto> userCouponDtoList = userBoardSqlMapper.selectUserCouponAll(id, page);
		
		for(UserCouponDto userCouponDto : userCouponDtoList) {
			
			Map<String, Object> map = new HashMap<>();
			
			int userId = userCouponDto.getUser_id();
			int couponId = userCouponDto.getCoupon_id();
			
			UserDto userDto = userSqlMapper.selectByUserId(userId);
			CouponDto couponDto = adminBoardSqlMapper.selectByCouponId(couponId);
			
			map.put("userDto", userDto);
			map.put("couponDto", couponDto);
			
			userCouponList.add(map);
			
		}
		
		return userCouponList;
	}
	
	public int notExistUserCouponCount(int id) {
		return userBoardSqlMapper.notExistUserCouponCount(id);
	}
	
		
	// 내 쿠폰함 사용완료쿠폰 리스트 조회
	public List<Map<String,Object>> getNotExistUserCouponList(int id, int pageNum) {
		
		List<Map<String, Object>> notExistUserCouponList = new ArrayList<>();
		
		List<UserCouponDto> notExistUserCouponDtoList = userBoardSqlMapper.selectNotExistUserCouponAll(id, pageNum);
		
		for(UserCouponDto userCouponDto : notExistUserCouponDtoList) {
			
			Map<String, Object> map = new HashMap<>();
			
			int userId = userCouponDto.getUser_id();
			int couponId = userCouponDto.getCoupon_id();
			
			UserDto userDto = userSqlMapper.selectByUserId(userId);
			CouponDto couponDto = adminBoardSqlMapper.selectByCouponId(couponId);
			
			map.put("userDto", userDto);
			map.put("couponDto", couponDto);
			
			notExistUserCouponList.add(map);
			
		}
		
		return notExistUserCouponList;
	}
		

			
	// 상품 카테고리 조회
		public List<ItemCategoryDto> CategoryList() {
			
			return userBoardSqlMapper.selectItemCategoryList();
		}

	// 모든 상품 리스트 조회
		public List<Map<String, Object>> getItemList(int categoryId) {
		    List<Map<String, Object>> itemList = new ArrayList<>();
		    
		    List<ItemDto> itemDtoList = userBoardSqlMapper.selectItemList(categoryId);
		    
		    for (ItemDto itemDto : itemDtoList) {
		        Map<String, Object> map = new HashMap<>();
		        
		        int adminId = itemDto.getAdmin_id();
		        int itemCategoryId = itemDto.getCategory_id();
		        
		        
		        AdminDto adminDto = adminSqlMapper.selectByAdminId(adminId);
		        ItemCategoryDto itemCategoryDto = adminBoardSqlMapper.selectByItemCategoryId(itemCategoryId);
		        int itemBuyCount = userBoardSqlMapper.selectBuyCount(itemDto.getId());
		        int itemReviewCount = userBoardSqlMapper.selectReviewBuyCount(itemDto.getId());
		        int itemLikeCount = userBoardSqlMapper.selectItemLikeCount(itemDto.getId());
		        
		        map.put("itemLikeCount", itemLikeCount);
		        map.put("itemBuyCount", itemBuyCount);
		        map.put("itemReviewCount", itemReviewCount);
		        map.put("adminDto", adminDto);
		        map.put("itemDto", itemDto);
		        map.put("itemCategoryDto", itemCategoryDto);
		        
		        itemList.add(map);
		    }
		    
		    return itemList;
		}

			
		
	// 특정 상품 조회
		public Map<String, Object> getItemDetail(int id) {
			
			Map<String, Object> map = new HashMap<>();
			
			
			ItemDto itemDto = userBoardSqlMapper.selectByItemId(id);
			ItemCategoryDto itemCategoryDto = adminBoardSqlMapper.selectByItemCategoryId(itemDto.getCategory_id());
			List<ItemImageDto> itemImageDto = userBoardSqlMapper.selectItemImageById(id);
			List<ItemDto> itemRelation = userBoardSqlMapper.selectRelationItem(itemCategoryDto.getId());
			
			int itemBuyCount = userBoardSqlMapper.selectBuyCount(itemDto.getId());
	        int itemReviewCount = userBoardSqlMapper.selectReviewBuyCount(itemDto.getId());
	        int itemLikeCount = userBoardSqlMapper.selectItemLikeCount(itemDto.getId());
	        int buyItemCount = adminBoardSqlMapper.decreaseItemCount(itemDto.getId());
	        int quantity = itemDto.getItem_count() - buyItemCount;
	        
	        map.put("itemLikeCount", itemLikeCount);
	        map.put("itemBuyCount", itemBuyCount);
	        map.put("itemReviewCount", itemReviewCount);	
			map.put("itemRelation", itemRelation);
			map.put("itemDto", itemDto);
			map.put("itemCategoryDto", itemCategoryDto);
			map.put("itemImageDto", itemImageDto);
			map.put("quantity", quantity);
			
			return map;
		}

		
		
	// 특정 상품 구매 정보 조회
		public Map<String, Object> getItemBuy(int id) {
			
			Map<String, Object> map = new HashMap<>();
			
			ItemDto itemDto = userBoardSqlMapper.selectByItemId(id);
			ItemCategoryDto itemCategoryDto = adminBoardSqlMapper.selectByItemCategoryId(itemDto.getCategory_id());
			List<ItemImageDto> itemImageDto = userBoardSqlMapper.selectItemImageById(id);
			
			
			map.put("itemDto", itemDto);
			map.put("itemCategoryDto", itemCategoryDto);
			map.put("itemImageDto", itemImageDto);
			
			
			return map;
		}
		
		
		public int createAddressPk() {
			return userBoardSqlMapper.createAddressPk();
		}
	
	// 특정 상품 구매 등록
		public void insertItemBuy (ItemBuyDto itemBuyDto) {
			
			userBoardSqlMapper.insertItemBuy(itemBuyDto);
			
			
		}
		
	// 쿠폰 사용
		public void useCouponByItem(int id,int user_id) {
			userBoardSqlMapper.updateUserCouponUseByItem(id,user_id);
		}

	// 특정 상품 구매 내역 포인트 등록
		public void insertPointStatus (PointDto pointDto) {
			
			userBoardSqlMapper.insertPointStatus(pointDto);
			
		}
		
	// 배송지 등록
		public void insertUserAddress (UserAddressDto userAddressDto) {
				
			userBoardSqlMapper.insertUserAddress(userAddressDto);
			
		}
	
	// 주문내역 조회
	public List<Map<String, Object>> getOrderHistoryList(int id) {
		
		List<Map<String, Object>> orderHistoryList = new ArrayList<>();
		
		List<ItemBuyDto> orderHistoryDtoList = userBoardSqlMapper.selectByItemBuyList(id);
		
		for(ItemBuyDto itemBuyDto : orderHistoryDtoList) {
			
			Map<String, Object> map = new HashMap<>();
			
			
			int itemId = itemBuyDto.getItem_id();
			int addressId = itemBuyDto.getAddress_id();
			
			
			ItemDto itemDto = userBoardSqlMapper.selectByItemId(itemId);
			UserAddressDto userAddressDto = userBoardSqlMapper.selectUserAddressId(addressId);
			
			
			map.put("itemDto", itemDto);
			map.put("itemBuyDto", itemBuyDto);
			map.put("userAddressDto", userAddressDto);
			

			orderHistoryList.add(map);
		}
		
		return orderHistoryList;
	}
	
		
		
	// 상품리뷰 등록
	public void insertItemReview (ItemReviewDto itemReviewDto) {
		
		userBoardSqlMapper.insertItemReview(itemReviewDto);
	}
		
	// 상품구매 상태 업데이트
	public void updateItemBuyProgress(ItemBuyDto itemBuyDto) {
		
		userBoardSqlMapper.updateItemBuyProgress(itemBuyDto);
	}
	
		
	// 상품리뷰 조회
	public List<ReviewJoinDto> getItemReviewList(int id) {
		
		List<ReviewJoinDto> reviewJoinDtoList  = userBoardSqlMapper.selectByItemReviewList(id);
		
		return reviewJoinDtoList;
	}
		
	// 상품구매 완료
	public Map<String, Object> getItemBuyComplete(int id) {
		
		Map<String, Object> map = new HashMap<>();
		
		ItemBuyDto itemBuyDto = userBoardSqlMapper.selectByItemBuyComplete(id);
		ItemDto itemDto = userBoardSqlMapper.selectByItemId(itemBuyDto.getItem_id());
		ItemCategoryDto itemCategoryDto = adminBoardSqlMapper.selectByItemCategoryId(itemDto.getCategory_id());
		UserAddressDto userAddressDto = userBoardSqlMapper.selectUserAddressId(itemBuyDto.getAddress_id());
		UserDto userDto = userSqlMapper.selectByUserId(userAddressDto.getUser_id());
		
		map.put("itemBuyDto", itemBuyDto);
		map.put("itemDto", itemDto);
		map.put("itemCategoryDto", itemCategoryDto);
		map.put("userAddressDto", userAddressDto);
		map.put("userDto", userDto);
		
		
		return map;
	}
	public int getUseCouponPercentByItem(int id) {
		return userBoardSqlMapper.selectUseCouponPercent(id);
	}
	
	// 상품에 적용할 쿠폰
	 public List<CouponDto> getItemCouponList(int id){
         return userBoardSqlMapper.selectByBuyCouponList(id);
      }

	public int getuseAbleCouponCount (int user_id) {
		return userBoardSqlMapper.selectUseAbleCouponCount(user_id);
	}
	
	// 상품 좋아요
	public void itemToggleLike(ItemLikeDto itemLikeDto) {
		
		if(userBoardSqlMapper.countMyLike(itemLikeDto) > 0) {
			userBoardSqlMapper.deleteLike(itemLikeDto);
		}else {
			userBoardSqlMapper.insertLike(itemLikeDto);
		}
	}
	
	public boolean isLiked(ItemLikeDto itemLikeDto) {
		return userBoardSqlMapper.countMyLike(itemLikeDto) > 0;
	}
	
	public int getTotalLike(int itemId) {
		return userBoardSqlMapper.countLikeByItemId(itemId);
	}
	
	// 유저별 상품 좋아요 조회
	public List<Map<String, Object>> getUserLikeItemList(int id) {
		
		List<Map<String, Object>> userLikeItemList = new ArrayList<>();
		
		List<ItemLikeDto> userLikeItemDtoList = userBoardSqlMapper.selectByItemLikeList(id);
		
		for(ItemLikeDto itemLikeDto : userLikeItemDtoList) {
			
			Map<String, Object> map = new HashMap<>();
			
			int itemId = itemLikeDto.getItem_id();
			int userId = itemLikeDto.getUser_id();
			
			ItemDto itemDto = userBoardSqlMapper.selectByItemId(itemId);
			UserDto userDto = userBoardSqlMapper.selectUserById(userId);
			
			map.put("itemDto", itemDto);
			map.put("userDto", userDto);
			
			userLikeItemList.add(map);
		}
		
		return userLikeItemList;
	}
	
	// 내 포인트 리스트 조회 
	public List<Map<String, Object>> getUserPointList(int page) {
		
		List<Map<String, Object>> userPointList = new ArrayList<>();
		
		List<PointDto> userPointDtoList = userBoardSqlMapper.selectByPointList(page);
		
		for(PointDto pointDto : userPointDtoList) {
			
			Map<String, Object> map = new HashMap<>();
			
			int userId = pointDto.getUser_id();
			
			UserDto userDto = userBoardSqlMapper.selectUserById(userId);
			
			map.put("userDto", userDto);
			map.put("pointDto", pointDto);
			
			userPointList.add(map);
		}
		
		return userPointList;
	}
		
	// 내 포인트 리스트 페이징
	public int userPointPaging() {
		return userBoardSqlMapper.pointPaging();
	}
	
	// 내 적립,사용 포인트 조회
	public Map<String, Object> getPoint(int id) {
		Map<String, Object> map = new HashMap<>();
		
		UserDto userDto = userSqlMapper.selectByUserId(id);
		int saveMyPoint = userBoardSqlMapper.selectSaveMyPoint(userDto.getId());
		int useMyPoint = userBoardSqlMapper.selectUseMyPoint(userDto.getId());
		
		map.put("userDto", userDto);
		map.put("saveMyPoint", saveMyPoint);
		map.put("useMyPoint", useMyPoint);
		
		
		return map;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	public List<Map<String, Object>> getHotelListByStar(int star,String category,int[] checkBoxValues,int orderByNumber,
			 String startDate,String endDate,int fixed_number, String loc,int[] days
			){ // 호텔리스트
		List<Map<String, Object>> list = new ArrayList<>();
		List<HotelDto> getList = userBoardSqlMapper.selectHotelListByStar(star,category,checkBoxValues,orderByNumber,startDate,endDate,fixed_number,loc);
		for(HotelDto hotelDto : getList) {
			Map<String, Object> map = new HashMap<>();
			map.put("category", userBoardSqlMapper.selectHotelCategoryByHotelCategoryId(hotelDto.getHotel_category_id()));
			map.put("hotelDto", hotelDto);
			/*
			 * map.put("price",
			 * userBoardSqlMapper.selectMinPriceByHotelId(hotelDto.getId()));
			 */	
			map.put("star", userBoardSqlMapper.selectStarAvgByHotelId(hotelDto.getId()));
			map.put("review", userBoardSqlMapper.selectStarCountByHotelId(hotelDto.getId()));
			
			int seasonPrice = userBoardSqlMapper.selectSeasonPrice(startDate,hotelDto.getId());
			int oriPrice = 0;
			int changePrice= 0;
			for(int day : days) {
				DayPriceDto dayPriceDto = userBoardSqlMapper.selectDayPrice(hotelDto.getId(), day);
				RoomGroupDto roomGroupDto = userBoardSqlMapper.selectRoomGroupById(dayPriceDto.getRoom_group_id());
				oriPrice += roomGroupDto.getPrice();
				changePrice += roomGroupDto.getPrice()*(1 + ((double) dayPriceDto.getChange_price()) / 100);
			}
			if(seasonPrice != 0) {
				changePrice = (int) (changePrice *(1+((double)seasonPrice/100)));
			}
			map.put("oriPrice", oriPrice/days.length);
			map.put("changePrice", changePrice/days.length);
			map.put("seasonPrice", seasonPrice/days.length);	
			list.add(map);
		}
		return list;
	}
	
	public List<HotelSyscategoryDto> getCategoryList(){
		return sellerBoardSqlMapper.selectHotelSyscategory();
	}
	
	
	public Map<String, Object> getHotelInfo(int id){
		Map<String, Object> map = new HashMap<>();
		map.put("hotelDto", userBoardSqlMapper.selectHotelInfoById(id));
		HotelDto hotelDto = userBoardSqlMapper.selectHotelInfoById(id);
		map.put("category", userBoardSqlMapper.selectHotelCategoryByHotelCategoryId(hotelDto.getHotel_category_id()));
		map.put("custom", userBoardSqlMapper.selectCustomCategoryByHotelId(id));	// 나중에 필터에 넣자
		map.put("view", userBoardSqlMapper.selectViewList());
		List<HotelLinkSyscategoryDto> getList = userBoardSqlMapper.selectHotelLinkSysCategoryByHotelId(id);
		List<HotelSyscategoryDto> list = new ArrayList<>();
		for(HotelLinkSyscategoryDto hotelLinkSyscategoryDto : getList) {
			list.add(userBoardSqlMapper.selectHotelSysCategoryById(hotelLinkSyscategoryDto.getSyscategory_id()));
		}

		map.put("system", list);
		map.put("star", userBoardSqlMapper.selectStarAvgByHotelId(hotelDto.getId()));
		map.put("review", userBoardSqlMapper.selectStarCountByHotelId(hotelDto.getId()));
		//아래는 그룹의 모든 이미지(대표,상세)
		map.put("roomGroupDto", userBoardSqlMapper.selectRoomGroupByHotelId(id));
		map.put("roomGroupImgDto", userBoardSqlMapper.selectRoomGroupImgByHotelId(id));
		map.put("like", userBoardSqlMapper.selectTotalHotelLikeCount(id));
		return map;
	}
	
	public List<Map<String, Object>> getGroupList(String startDate,String endDate,int hotel_id,int fixed_number,Integer view_id,int[] days){ // 그룹리스트(호텔상세페이지)
		List<Map<String, Object>> list = new ArrayList<>();
		List<RoomGroupDto> getList= userBoardSqlMapper.selectRoomGroupBySearch(startDate,endDate,hotel_id,fixed_number,view_id);
		for(RoomGroupDto roomGroupDto : getList) {
			Map<String, Object> map = new HashMap<>();
			map.put("roomGroupDto", roomGroupDto);
			map.put("customCategory", userBoardSqlMapper.selectCustomCategoryByGroupId(roomGroupDto.getId()));
			map.put("view", userBoardSqlMapper.selectViewByviewID(roomGroupDto.getView_id()));
			
			
			
			int seasonPrice = userBoardSqlMapper.selectGroupSeasonPrice(startDate,roomGroupDto.getId());
			int oriPrice = 0;
			int changePrice= 0;
			for(int day : days) {
				DayPriceDto dayPriceDto = userBoardSqlMapper.selectGroupDayPrice(roomGroupDto.getId(), day);
				oriPrice += roomGroupDto.getPrice();
				changePrice += roomGroupDto.getPrice()*(1 + ((double) dayPriceDto.getChange_price()) / 100);
			}
			if(seasonPrice != 0) {
				changePrice = (int) (changePrice *(1+((double)seasonPrice/100)));
			}
			map.put("oriPrice", oriPrice/days.length);
			map.put("changePrice", changePrice/days.length);
			map.put("seasonPrice", seasonPrice/days.length);	
			map.put("finalPrice", changePrice);
			list.add(map);
		}
	
		return list;
		
	}
	
	public List<RoomGroupImgDto> getGroupImages(int room_group_id){ // 그룹 상세이미지
		return userBoardSqlMapper.selectRoomGroupImgByRoomGroupId(room_group_id);
	}
	public Map<String, Object> getReserveInfo(int room_group_id){
		Map<String, Object> map = new HashMap<>();
		map.put("roomGroupDto", userBoardSqlMapper.selectRoomGroupById(room_group_id));
		map.put("plusOption", userBoardSqlMapper.selectGroupPlusOptionByGroupId(room_group_id));
		return map;
	}
	
	public void reserveHotel(ReserveDto reserveDto, int[] option_id) {  // 호텔예약
        int reserve_id = userBoardSqlMapper.createReservePk();
        if(option_id != null) { // 옵션예약 인서트 (값이 있으면 처리)
           OptionReserveDto optionReserveDto = new OptionReserveDto();
           optionReserveDto.setReserve_id(reserve_id);
           for(int optionId : option_id) {
              optionReserveDto.setOption_id(optionId);
              userBoardSqlMapper.insertOptionReserve(optionReserveDto);
           }
        }
        
        reserveDto.setId(reserve_id);
        userBoardSqlMapper.insertReserve(reserveDto);
        
        if(userBoardSqlMapper.selectReservePointAddCount(reserveDto.getUser_id(), reserveDto.getRoom_group_id()) == 0) {
           
           userBoardSqlMapper.insertHotelReservePointStatus(reserveDto.getUser_id(),reserveDto.getFinal_price()/10,userBoardSqlMapper.selectHotelName(reserveDto.getRoom_group_id()).getHotel_name());
        }
     }
	
	public List<Map<String, Object>> getReserveListByUserId(int user_id,int filter){ //예약리스트
		List<Map<String, Object>> list = new ArrayList<>();
		List<ReserveDto> getList = userBoardSqlMapper.selectReserveListByUserId(user_id, filter);
		System.out.println(filter);
		for(ReserveDto reserveDto : getList) {
			Map<String, Object> map = new HashMap<>();
			RoomGroupDto roomgroupDto = userBoardSqlMapper.selectRoomGroupById(reserveDto.getRoom_group_id());
			map.put("hotelDto", userBoardSqlMapper.selectHotelInfoById(roomgroupDto.getHotel_id()));
			map.put("roomGroupDto", roomgroupDto);
			map.put("reserveDto", reserveDto);
			List<OptionReserveDto> optionList= userBoardSqlMapper.selectOptionReserveList(reserveDto.getId());
			List<GroupPlusOptionDto> plusList = new ArrayList<>();
			for(OptionReserveDto optionReserveDto : optionList) {
				GroupPlusOptionDto groupPlusOptionDto = userBoardSqlMapper.selectGroupPlusOptionInfo(optionReserveDto.getOption_id());
				plusList.add(groupPlusOptionDto);
			}
			
			map.put("plusList", plusList);
			map.put("reviewCount", userBoardSqlMapper.selectCountReviewByReserveId(reserveDto.getId()));
			list.add(map);
		}
		return list;
	}
	
	public void writeReview(HotelReviewDto hotelReviewDto,MultipartFile file) {
		if (file != null) {
			String rootFolder = "/uploadFiles/";
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
			hotelReviewDto.setReview_img_link(savaFileName);
		}
		userBoardSqlMapper.insertReview(hotelReviewDto);
	}
	
	public List<Map<String, Object>> getReviewList(int hotel_id){
		List<Map<String, Object>> list = new ArrayList<>();
		List<HotelReviewDto> getList = userBoardSqlMapper.selectReviewListByHotelId(hotel_id);
		for(HotelReviewDto hotelReviewDto : getList) {
			Map<String, Object> map = new HashMap<>();
			int reserveId = hotelReviewDto.getReserve_id();
			ReserveDto reserveDto = userBoardSqlMapper.selectReserveById(reserveId);
			int userID = reserveDto.getUser_id();
			int room_group_id = reserveDto.getRoom_group_id();
			map.put("reviewDto", hotelReviewDto);
			map.put("userDto", userBoardSqlMapper.selectUserById(userID));
			map.put("roomGroupDto", userBoardSqlMapper.selectRoomGroupById(room_group_id));
			
			list.add(map);
		}
		
		
		return list;
	}
	public Map<String, Object> getBeforeReserve(String tid){
		Map<String, Object> map =new HashMap<>();
		ReserveDto reserveDto = userBoardSqlMapper.selectReserveByTid(tid);
		int room_group_id = reserveDto.getRoom_group_id();
		map.put("roomGroupDto",  userBoardSqlMapper.selectRoomGroupById(room_group_id));
		map.put("reserveDto", reserveDto);
		List<OptionReserveDto> list =  userBoardSqlMapper.selectOptionReserveList(reserveDto.getId());
		List<GroupPlusOptionDto> optionList = new ArrayList<>();
		for(OptionReserveDto optionReserveDto : list) {
			int option_id = optionReserveDto.getOption_id();
			optionList.add(userBoardSqlMapper.selectGroupPlusOptionInfo(option_id));
		}
		map.put("option", optionList);
		return map;
	}
	
	//찜
	public int useLike(HotelLikeDto hotelLikeDto) {
		return userBoardSqlMapper.selectMyHotelLikeCount(hotelLikeDto);
	}
	
	public void toggleLike(HotelLikeDto hotelLikeDto) {
		if(userBoardSqlMapper.selectMyHotelLikeCount(hotelLikeDto) == 0) {
			userBoardSqlMapper.insertHotelLike(hotelLikeDto);
		}else if(userBoardSqlMapper.selectMyHotelLikeCount(hotelLikeDto) !=0) {
			userBoardSqlMapper.deleteHotelLike(hotelLikeDto);
		}
	}
	public List<Map<String, Object>> getLikeHotelList(int user_id,int[] days,String startDate){
		List<HotelDto> getList = userBoardSqlMapper.selectLikeHotelList(user_id);
		List<Map<String, Object>> list= new ArrayList<>();
		for(HotelDto hotelDto : getList) {
			Map<String, Object> map = new HashMap<>();
			map.put("category", userBoardSqlMapper.selectHotelCategoryByHotelCategoryId(hotelDto.getHotel_category_id()));
			map.put("hotelDto", hotelDto);
			/*
			 * map.put("price",
			 * userBoardSqlMapper.selectMinPriceByHotelId(hotelDto.getId()));
			 */	
			map.put("star", userBoardSqlMapper.selectStarAvgByHotelId(hotelDto.getId()));
			map.put("review", userBoardSqlMapper.selectStarCountByHotelId(hotelDto.getId()));
			
			int seasonPrice = userBoardSqlMapper.selectSeasonPrice(startDate,hotelDto.getId());
			int oriPrice = 0;
			int changePrice= 0;
			for(int day : days) {
				DayPriceDto dayPriceDto = userBoardSqlMapper.selectDayPrice(hotelDto.getId(), day);
				RoomGroupDto roomGroupDto = userBoardSqlMapper.selectRoomGroupById(dayPriceDto.getRoom_group_id());
				oriPrice += roomGroupDto.getPrice();
				changePrice += roomGroupDto.getPrice()*(1 + ((double) dayPriceDto.getChange_price()) / 100);
			}
			if(seasonPrice != 0) {
				changePrice = (int) (changePrice *(1+((double)seasonPrice/100)));
			}
			map.put("oriPrice", oriPrice/days.length);
			map.put("changePrice", changePrice/days.length);
			map.put("seasonPrice", seasonPrice/days.length);	
			list.add(map);
		}
		return list;
	}
	public int[] getReviewCountStar(int hotel_id) {
		int[] list = new int[5];
		for(int i=1; i<=5; i++) {
			list[i-1] = userBoardSqlMapper.selectStarCountByHotel(hotel_id, i);
		}
		return list;
	}

	public List<CouponDto> getHotelCouponList(int id){
		return userBoardSqlMapper.selectByBuyHotelCouponList(id);
	}
	public int getCouponDisCount(int id) {
		return userBoardSqlMapper.selectCouponPercent(id);
	}
	public void useCouponProcessByHotel(int coupon_id,int user_id) {
		UserCouponDto userCouponDto = new UserCouponDto();
		userCouponDto.setUser_id(user_id);
		userCouponDto.setCoupon_id(coupon_id);
		userBoardSqlMapper.useCouponByHotel(userCouponDto);
	}
	
	public int getUseAbleCouponCount(int user_id) {
		return userBoardSqlMapper.selectUseAbleCouponCount1(user_id);
	}
	
	   public void usePointByHotel(PointDto pointDto) {
	         userBoardSqlMapper.insertHotelPointStatus(pointDto);
	      }
	      public void reserveCancle(String tid,int price,int user_id) {
	         userBoardSqlMapper.updateReserveCancle(tid);
	         
	         PointDto pointDto  = new PointDto();
	         pointDto.setUser_id(user_id);
	         pointDto.setPoint(price/10);
	         userBoardSqlMapper.insertHotelReserveCanclePointStatus(pointDto);
	      }
}