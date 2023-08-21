package com.rm.roaming.sellerboard.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rm.roaming.dto.AssignRoomDto;
import com.rm.roaming.dto.CheckInOutDto;
import com.rm.roaming.dto.CustomCategoryDto;
import com.rm.roaming.dto.DayPriceDto;
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

public interface SellerBoardSqlMapper {
	//카테고리불러오기
	public List<HotelCategoryDto> selectHotelCategoryList();
	// 호텔 pk생성
	public int createHotelPk();
	// 호텔 시스카테 리스트
	public List<HotelSyscategoryDto> selectHotelSyscategory();
	// 호텔 시스카테 등록
	public void insertHotelSyscategory(HotelLinkSyscategoryDto hotelLinkSyscategory);
	// 호텔등록
	public void insertHotel(HotelDto hotelDto);
	//호텔 사진등록
	public void insertHotelImg(HotelDto hotelDto);
	// 호텔등록시 서류등록
	public void insertDocu(HotelDocuDto hotelDocuDto);
	// 호텔리스트 갖고오기
	public List<HotelDto> selectMyHotelList(int seller_id);
	//셀러 호텔리스트페이지
	public List<HotelListMapDto> selectHotelListAndDocuStatus(int seller_id);
	// 호텔 갖고오기
	public HotelDto selectMyHotelById(int id);
	// 첫번쨰(디폴트) 호텔
	public HotelDto selectMyFirstHotel(int seller_id);
	//그룹pk생성
	public int createGroupPk();
	// 그룹등록
	public void insertRoomGroup(RoomGroupDto roomGroupDto);
	public void insertGroupImg(RoomGroupDto roomGroupDto);

	//그룹상세이미지
	public void insertRoomGroupImg(RoomGroupImgDto roomGroupImgDto);
	//그룹 추가옵션
	public void insertGroupPlusOption(GroupPlusOptionDto groupPlusOptionDto);
	//그룹 커스텀옵션
	public void insertCustomCategory(CustomCategoryDto customCategoryDto);
	// 그룹 리스트 가져오기
	public List<RoomGroupDto> selectGroupListByHotelId(int hotel_id);
	// 그룹 정보 갖고오기
	public RoomGroupDto selectGroupById(int id);
	// 그룹 상세이미지
	public List<RoomGroupImgDto> selectGroupImgByRoomGroupId(int room_group_id);
	// 첫번째 그룹
	public RoomGroupDto selectFirstGroup(int hotel_id);
	// 뷰 리스트 셀렉트
	public List<RoomViewDto> selectRoomViewList();
	// 룸등록
	public void insertRoom(RoomDto roomDto);
	// 그룹정보 추가옵션 커스텀 방번호 뷰
	public List<GroupPlusOptionDto> selectGroupPlusOptionByRoomGroupId(int room_group_id);
	public List<CustomCategoryDto> selectCustomCategoryByRoomGroupId(int room_group_id);
	public List<RoomDto> selectRoomByRoomGroupId(int room_group_id);
	public RoomViewDto selectViewNameByRoomViewId(int id);

	//이번주 판매액 그룹별
	public List<RoomGroupDto> selectCurrentWeekSellPrice(int hotel_id);
	// 방점유율
	public List<ReserveDto> selectCountTodayReserve(int hotel_id);
	public int selectRoomCountByGroupId(int room_group_id);
	
	//오늘 체크인 체크아웃
	public List<CheckInOutDto> selectTodayCheckIn(int hotel_id);
	public List<CheckInOutDto> selectTodayCheckOut(int hotel_id);
	
	
	//지정 날짜 예약찾기
	public List<ReserveInfoDto> selectReserveListByDate(@Param("hotel_id") int hotel_id,@Param("date") String date);
	
	
	//입실퇴실 업데이트
	public ReserveDto selectReserveStatus(int id);
	public void updateReserveCheckIn(int id);
	public void updateReserveCheckOut(int id);
	//방배정
	public List<RoomDto> selectEmptyRoom(int id);
	public void insertAssignRoom(AssignRoomDto assignRoomDto);
	
	//타임라인
	public List<TimeLineDto> selectTimeLineInfo(int hotel_id);
	public TimeLineDetailDto selectTimeLineDetailInfo(int reserve_id);
	
	//날짜별 가격변동 찾기
	public List<DayPriceDto> selectDayPriceByHotelId(int hotel_id);
	//날짜별 가격변동 등록
	public void insertDayPrice(DayPriceDto dayPriceDto);
	//날짜별 가격변동 삭제
	public void deleteDayPrice(int hotel_id);
	//시즌별 가격변동
	public int createSeasonPricePk();
	public void insertSeasonPrice(SeasonPriceDto seasonPriceDto);
	public void insertSeasonPriceGroup(SeasonPriceGroupDto seasonPriceGroupDto);
	
	//시즌별 가격변동 리스트
	public List<RequestMapSeasonPriceDto> selectSeasonPriceList(int hotel_id);
	//삭제
	public void deleteSeasonPrice(int id);
	public void deleteSeasonPriceGroup(int id);
	
	//수정
	public void updateSeasonPrice(SeasonPriceDto seasonPriceDto);
	//대시보드
	public ReserveDto selectReserveDashOfMonth(@Param("hotel_id") int hotel_id,@Param("month") int month);
	public List<RoomGroupDto> selectRoomReserveDashOfMonth(@Param("hotel_id") int hotel_id,@Param("month") int month);
	public List<ReserveDto> selectReserveGraphOfMonth(@Param("hotel_id") int hotel_id,@Param("date") String date);
	public ReserveDto selectBarGraphOfYear(@Param("hotel_id") int hotel_id,@Param("month") int month);
	
	public void updateHotelStatus(int hotel_id);
	
	public HotelDocuDto selectReturnDocu(int id);
	public void updateHotelDocu(HotelDocuDto hotelDocuDto);
   public ReserveDto selectCancleReserveDashOfMonth(@Param("hotel_id") int hotel_id,@Param("month") int month);
}
