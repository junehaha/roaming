package com.rm.roaming.userboard.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rm.roaming.dto.CouponDto;
import com.rm.roaming.dto.CustomCategoryDto;
import com.rm.roaming.dto.DayPriceDto;
import com.rm.roaming.dto.GroupPlusOptionDto;
import com.rm.roaming.dto.HotelCategoryDto;
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
import com.rm.roaming.dto.RoomViewDto;
import com.rm.roaming.dto.UserAddressDto;
import com.rm.roaming.dto.UserCouponDto;
import com.rm.roaming.dto.UserDto;


public interface UserBoardSqlMapper {
	// 내 포인트 조회
		public int selectMyPoint(int user_id);
		// 내 쿠폰 수량 조회
		public int selectMyCouponCount(int user_id);

		
		// 쿠폰리스트 조회
		public List<CouponDto> selectCouponList();
		// 내 쿠폰함 등록
		public void insertUserCoupon(UserCouponDto userCouponDto);
		// 내 쿠폰함 사용가능 쿠폰 조회
		public List<UserCouponDto> selectUserCouponAll(@Param("userId") int id, @Param("page") int page); 
		// 내 쿠폰함 사용가능 쿠폰 조회 페이징
		public int UserCouponCount(@Param("userId") int id);
		// 내 쿠폰함 사용완료 쿠폰 조회
		public List<UserCouponDto> selectNotExistUserCouponAll(@Param("userId") int id, @Param("pageNum") int page);
		// 내 쿠폰함 사용완료 쿠폰 조회 페이징
		public int notExistUserCouponCount(@Param("userId") int id);	
		

		
		// 상품리스트 조회
		public List<ItemDto> selectItemList(@Param("categoryId") int categoryId);
		// 상품리스트 카테고리조회
		public List<ItemCategoryDto> selectItemCategoryList();
		// 특정 상품 리뷰수 조회
		public int selectReviewBuyCount(int itemBuyId);
		// 특정 상품 구매수 조회
		public int selectBuyCount(int itemId);
		// 특정 상품 좋아요 조회
		public int selectItemLikeCount(int itemId);
		// 특정 상품 조회
		public ItemDto selectByItemId(int id);
		// 연관 상품
		public List<ItemDto> selectRelationItem(int id);
		// 특정 상품 이미지 조회
		public List<ItemImageDto> selectItemImageById(int id);
		// 배송지 등록
		public void insertUserAddress(UserAddressDto userAddressDto);
		// 배송지 조회
		public UserAddressDto selectUserAddressId(int id);
		// 상품 구매 등록
		public void insertItemBuy(ItemBuyDto itemBuyDto);
		// 쿠폰 사용
		public void updateUserCouponUseByItem(@Param("coupon_id") int coupon_id,@Param("user_id") int user_id);
		public int selectUseCouponPercent(int id);
		// 포인트 사용내역 등록
		public void insertPointStatus(PointDto pointDto);
		// 배송지, 상품구매 배송지 동시 Insert
		public int createAddressPk();
		// 상품리뷰 등록
		public void insertItemReview(ItemReviewDto itemReviewDto);
		// 상품구매 상태 업데이트
		public void updateItemBuyProgress(ItemBuyDto itemBuyDto);
		// 주문내역 리스트 조회
		public List<ItemBuyDto> selectByItemBuyList(int id);
		// 상품리뷰 조회
		public List<ReviewJoinDto> selectByItemReviewList(int id);
		// 상품구매 ID
		public ItemBuyDto selectByItemBuyId(int id);
		// 상품구매 완료
		public ItemBuyDto selectByItemBuyComplete(int id);
		// 상품에 적용할 쿠폰
		public List<CouponDto> selectByBuyCouponList(int id);

	    
	    public void useCouponByItem(UserCouponDto userCouponDto);
	    
		
		
		
		// 상품 좋아요
		public void insertLike(ItemLikeDto itemLikeDto);
		public void deleteLike(ItemLikeDto itemLikeDto);
		public int countMyLike(ItemLikeDto itemLikeDto);
		public int countLikeByItemId(int itemId);
		
		// 유저별 상품 좋아요 조회
		public List<ItemLikeDto> selectByItemLikeList(int id);
		
		// 내 포인트 리스트 조회
		public List<PointDto> selectByPointList(int page);
		// 내 포인트 리스트 조회 페이징
		public int pointPaging();
		// 내 적립 포인트 조회
		public int selectSaveMyPoint(int user_id);
		// 내 사용 포인트 조회
		public int selectUseMyPoint(int user_id);
		
		
		
	
	
	
	// 카테고리 이름갖고오기
		public HotelCategoryDto selectHotelCategoryByHotelCategoryId(int id);
		// 호텔에서 가장 싼 그룹 가격
		public RoomGroupDto selectMinPriceByHotelId(int hotel_id);
		// 호텔리스트
		public List<HotelDto> selectHotelListByStar(@Param("star") int star, @Param("category") String category,@Param("checkBoxValues") int[] checkBoxValues,@Param("orderByNumber") int orderByNumber,
				@Param("startDate") String startDate,@Param("endDate") String endDate, @Param("fixed_number")int fixed_number,@Param("loc") String loc);
		// 호텔정보 (hotel, hotelsyscategory,customcategory,view,roomgroup,roomgroupimg)
		public HotelDto selectHotelInfoById(int id);
		public List<HotelLinkSyscategoryDto> selectHotelLinkSysCategoryByHotelId(int hotel_id);
		public List<CustomCategoryDto> selectCustomCategoryByHotelId(int hotel_id);
		public List<CustomCategoryDto> selectCustomCategoryByGroupId(int room_group_id);
		public List<RoomViewDto> selectViewList();
		public RoomViewDto selectViewByviewID(int id);
		public List<RoomGroupImgDto> selectRoomGroupImgByHotelId(int hotel_id);
		// 그룹갖고오기
		public List<RoomGroupDto> selectRoomGroupByHotelId(int hotel_id);
		public List<RoomGroupDto> selectRoomGroupBySearch(@Param("startDate") String startDate,@Param("endDate") String endDate,@Param("hotel_id")int hotel_id,@Param("fixed_number")int fixed_number,@Param("view_id")Integer view_id);
		public HotelSyscategoryDto selectHotelSysCategoryById(int id);
		public Double selectStarAvgByHotelId(int hotel_id); // 별점
		public int selectStarCountByHotelId(int hotel_id); //리뷰수
		
		
		//그룹상세이미지
		public List<RoomGroupImgDto> selectRoomGroupImgByRoomGroupId(int room_group_id);
		
		//예약페이지 그룹정보,추가옵션
		public RoomGroupDto selectRoomGroupById(int id);
		public List<GroupPlusOptionDto> selectGroupPlusOptionByGroupId(int room_group_id);
		
		//숙소예약 옵션예약
		public int createReservePk(); // pk생성
		public void insertReserve(ReserveDto reserveDto);
		public void insertOptionReserve(OptionReserveDto optionReserveDto);
		
		// 방금 한 예약정보 갖고오기
		public ReserveDto selectReserveByTid(String tid);
		
		//마이페이지 예약리스트 1이면 예정 2면 이전
		public List<ReserveDto> selectReserveListByUserId(@Param("user_id") int user_id , @Param("filter") int filter);
		// 예약에 대한 옵션
		public List<OptionReserveDto> selectOptionReserveList(int reserve_id);
		public GroupPlusOptionDto selectGroupPlusOptionInfo(int id);
		
		//리부
		public int selectCountReviewByReserveId(int reserve_id);
		public void insertReview(HotelReviewDto hotelReviewDto);
		//리뷰갖고오기
		public List<HotelReviewDto> selectReviewListByHotelId(int hotel_id);
		// 예약 정보 하나
		public ReserveDto selectReserveById(int id);
		//user id로 유저 찾기
		public UserDto selectUserById(int id);
		public int selectUseAbleCouponCount(int id);

		
		//찜
		public int selectMyHotelLikeCount(HotelLikeDto hotelLikeDto);
		public int selectTotalHotelLikeCount(int hotel_id);
		public void insertHotelLike(HotelLikeDto hotelLikeDto);
		public void deleteHotelLike(HotelLikeDto hotelLikeDto);
		public List<HotelDto> selectLikeHotelList(int user_id);

		public DayPriceDto selectDayPrice(@Param("hotel_id") int hotel_id,@Param("day") int day);
		public int selectSeasonPrice(@Param("date") String date,@Param("hotel_id") int hotel_id);
	
		
		public DayPriceDto selectGroupDayPrice(@Param("id") int id,@Param("day") int day);
		public int selectGroupSeasonPrice(@Param("date") String date,@Param("id") int id);
		
		public int selectStarCountByHotel(@Param("hotel_id") int hotel_id,@Param("star") int star);
		
		public List<CouponDto> selectByBuyHotelCouponList(int id);
		public int selectCouponPercent(int id);
		public void useCouponByHotel(UserCouponDto userCouponDto);
		public int selectUseAbleCouponCount1(int id);
		public void insertHotelPointStatus(PointDto pointDto);
      public int selectReservePointAddCount(@Param("user_id") int user_id,@Param("id") int id);
      public void insertHotelReservePointStatus(@Param("user_id") int user_id,@Param("point") int point,@Param("hotel_name") String hotel_name);
      public HotelDto selectHotelName(int id);
      
      public void updateReserveCancle(String tid);
      public void insertHotelReserveCanclePointStatus(PointDto pointDto);
}