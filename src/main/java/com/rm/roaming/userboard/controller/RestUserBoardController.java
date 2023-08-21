package com.rm.roaming.userboard.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.rm.roaming.dto.CouponDto;
import com.rm.roaming.dto.HotelLikeDto;
import com.rm.roaming.dto.HotelReviewDto;
import com.rm.roaming.dto.ItemDto;
import com.rm.roaming.dto.ItemLikeDto;
import com.rm.roaming.dto.KakaoDto;
import com.rm.roaming.dto.PointDto;
import com.rm.roaming.dto.ReserveDto;
import com.rm.roaming.dto.UserCouponDto;
import com.rm.roaming.dto.UserDto;
import com.rm.roaming.post.service.PostService;
import com.rm.roaming.userboard.service.UserBoardServiceImpl;

@RestController
@RequestMapping("/userboard/*")
public class RestUserBoardController {
	@Autowired
	private UserBoardServiceImpl userBoardServiceImpl;
	@Autowired
	private PostService postService;
	
	
	
	@RequestMapping("getUserId")
	public Map<String,Object> getUserId(HttpSession session){
		Map<String, Object> map = new HashMap<>();
		UserDto userDto = (UserDto) session.getAttribute("sessionUser");
		if(userDto != null) {
			
			map.put("result", "success");
			map.put("userId", userDto.getId());
			return map;
		}
		return map;
	}
	
	
	@RequestMapping("getCouponList") // 쿠폰 리스트
	public Map<String, Object> getCouponList(HttpSession session, CouponDto couponDto) {
		Map<String, Object> map = new HashMap<>();
		
		UserDto userDto = (UserDto) session.getAttribute("sessionUser");
		
		int userId = userDto.getId();
		
		map.put("couponList", userBoardServiceImpl.getCouponList(userId));
		map.put("resutlt", "success");
		return map;
	}
	
	@RequestMapping("insertUserCouponList") // 내 쿠폰함에 등록
	public Map<String, Object> insertUserCouponList(int couponId, HttpSession session, UserCouponDto userCouponDto) {
		
		UserDto userDto = (UserDto) session.getAttribute("sessionUser");
		
		int userId = userDto.getId();
		
		userCouponDto.setUser_id(userId);
		userCouponDto.setCoupon_id(couponId);
		
		Map<String, Object> map = new HashMap<>();
		
		userBoardServiceImpl.userCouponAdd(userCouponDto);
		
		map.put("result", "success");
		return map;
	}
	
	@RequestMapping("getItemList") // 상품 리스트
	public Map<String, Object> getItemList(int categoryId) {
		Map<String, Object> map = new HashMap<>();
		
		map.put("itemList", userBoardServiceImpl.getItemList(categoryId));
		map.put("result", "success");
		return map;
		
	}
	
	

	
	
	
	@RequestMapping("itemToggleLike")
	public Map<String, Object> itemToggleLike(HttpSession session, ItemLikeDto itemLikeDto) {
		
		Map<String, Object> map = new HashMap<>();
		
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		itemLikeDto.setUser_id(sessionUser.getId());
		
		userBoardServiceImpl.itemToggleLike(itemLikeDto);
		
		map.put("result", "success");
		
		return map;
	}
	
	@RequestMapping("isLiked")
	public Map<String, Object> isLiked(HttpSession session, ItemLikeDto itemLikeDto) {
		Map<String, Object> map = new HashMap<>();
		
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		
		if(sessionUser == null) {
			map.put("result", "fail");
			map.put("reason", "로그인되어있지않습니다.");
			return map;
		}else {

			itemLikeDto.setUser_id(sessionUser.getId());
			
			map.put("result", "success");
			map.put("data", userBoardServiceImpl.isLiked(itemLikeDto));
			
			return map;
		}
		
	}
	
	@RequestMapping("getTotalLikeCount")
	public Map<String, Object> getTotalLikeCount(int itemId) {
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("result", "success");
		map.put("count", userBoardServiceImpl.getTotalLike(itemId));
		
		return map;
	}
	
	
	
	
	
	

	   @RequestMapping("getCategoryList")
	   public Map<String,Object> getCategoryList(){
	      Map<String, Object> map = new HashMap<>();
	      map.put("result", "success");
	      map.put("cateList", userBoardServiceImpl.getCategoryList());
	      return map;
	   }
	   
	   @RequestMapping("getHotelListByStar")
	   public Map<String, Object> getHotelListByStar(int star,String category,int[] checkBoxValues,int orderByNumber,
	         String startDay,String endDay,int fixed_number, String loc,int[] weekDays){ //호텔리스트 출력
	      Map<String, Object> map = new HashMap<>();
	      for(int i=0; i<weekDays.length; i++) {
	         System.out.println(weekDays[i]);
	      }
	      int startLastIndex = startDay.lastIndexOf("/");
	      int endLastIndex = endDay.lastIndexOf("/");
	      
	      String startDate = startDay.substring(0, startLastIndex);
	      String endDate = endDay.substring(0, endLastIndex);
	      if(userBoardServiceImpl.getHotelListByStar(star, category,checkBoxValues,orderByNumber,startDate,endDate,fixed_number,loc,weekDays)!=null 
	            && !userBoardServiceImpl.getHotelListByStar(star, category,checkBoxValues,orderByNumber,startDate,endDate,fixed_number,loc,weekDays).isEmpty()) {
	      map.put("result", "success");
	      map.put("list",userBoardServiceImpl.getHotelListByStar(star, category,checkBoxValues,orderByNumber,startDate,endDate,fixed_number,loc,weekDays));
	      return map;
	      }else {
	         map.put("result", "fail");
	         return map;
	      }
	      
	   }
	   @RequestMapping("getHotelInfo")
	   public Map<String, Object> getHotelInfo(int id){ // 호텔 상세페이지
	      Map<String, Object> map = new HashMap<>();
	      map.put("result", "success");
	      map.put("info", userBoardServiceImpl.getHotelInfo(id));
	      return map;
	   }
	   
	   @RequestMapping("getGroupList")
	   public Map<String, Object> getGroupList(String startDay,String endDay,int hotel_id,int fixed_number,Integer view_id,int[] days){
	      Map<String, Object> map = new HashMap<>();
	      
	      int startLastIndex = startDay.lastIndexOf("/");
	      int endLastIndex = endDay.lastIndexOf("/");
	      
	      String startDate = startDay.substring(0, startLastIndex);
	      String endDate = endDay.substring(0, endLastIndex);
	      
	      System.out.println(startDate);
	      
	      if(!userBoardServiceImpl.getGroupList(startDate,endDate,hotel_id,fixed_number,view_id,days).isEmpty()) {
	         map.put("group", userBoardServiceImpl.getGroupList(startDate,endDate,hotel_id,fixed_number,view_id,days));
	         map.put("result", "success");
	         return map;
	      }else {
	         map.put("result", "fail");
	      }   
	      return map;
	   }
	   @RequestMapping("getGroupImage")
	   public Map<String, Object> getGroupImage(int room_group_id){
	      Map<String, Object> map = new HashMap<>();
	      map.put("images", userBoardServiceImpl.getGroupImages(room_group_id));
	      return map;
	   }
	   @RequestMapping("goToServer")
	   public Map<String, Object> goToServer(KakaoDto kakaoDto,HttpSession session){
	      Map<String, Object> map = new HashMap<>();
	      session.setAttribute("kakaoDto",kakaoDto);
	      map.put("result", "success");
	      return map;
	   }
	   
	   
	   
	   @RequestMapping("insertReserve")
	   public Map<String, Object> insertReserve(ReserveDto reserveDto,int[] option_id,String startDate,String endDate){
	      System.out.println(reserveDto.getUser_id());
	      Map<String, Object> map = new HashMap<>();
	      //날짜변환
	      SimpleDateFormat sdf = new SimpleDateFormat("yy/MM/dd");
	      
	      try {
	         Date start_date = sdf.parse(startDate);
	         Date end_date = sdf.parse(endDate);
	         
	         reserveDto.setStart_date(start_date);
	         reserveDto.setEnd_date(end_date);
	         
	         userBoardServiceImpl.reserveHotel(reserveDto, option_id);
	      } catch (ParseException e) {
	         e.printStackTrace();
	      }
	      
	      map.put("result", "success");
	      return map;
	   }
	   
	   
	   @RequestMapping("getGroupInfo")
	   public Map<String, Object> getGroupInfo(int id){
	      Map<String, Object> map = new HashMap<>();
	      map.put("groupInfo", userBoardServiceImpl.getReserveInfo(id));
	      
	      return map;
	   }
	   
	   @RequestMapping("getReserveList")
	   public Map<String, Object> getReserveList(int filter,HttpSession session){
	      Map<String, Object> map = new HashMap<>();
	      UserDto userDto = (UserDto) session.getAttribute("sessionUser");
	      if(!userBoardServiceImpl.getReserveListByUserId(userDto.getId(),filter).isEmpty()) {
	         map.put("result", "success");
	         map.put("list", userBoardServiceImpl.getReserveListByUserId(userDto.getId(),filter));
	         return map;
	      }else {
	         map.put("result", "fail");
	         return map;
	      }
	      
	   
	   }
	   
	   @RequestMapping("writeReviewProcess")
	   public Map<String, Object>  writeReviewProcess(HotelReviewDto hotelReviewDto,MultipartFile file){
	      Map<String, Object> map = new HashMap<>();
	      userBoardServiceImpl.writeReview(hotelReviewDto,file);
	      map.put("result", "success");
	      return map;
	   }
	   @RequestMapping("getReviewList")
	   public Map<String, Object> getReviewList(int hotel_id){
	      Map<String, Object> map = new HashMap<>();
	      if(!userBoardServiceImpl.getReviewList(hotel_id).isEmpty()) {
	      map.put("result", "success");
	      map.put("review", userBoardServiceImpl.getReviewList(hotel_id));
	         map.put("starCount", userBoardServiceImpl.getReviewCountStar(hotel_id));
	      return map;
	      }else {
	         map.put("result", "fail");
	         map.put("starCount", userBoardServiceImpl.getReviewCountStar(hotel_id));

	         return map;
	      }
	   }
	   @RequestMapping("getMyUseLike")
	   public Map<String, Object> getMyUseLike(HotelLikeDto hotelLikeDto){
	      Map<String, Object> map = new HashMap<>();
	      map.put("result", "success");
	      map.put("useCount", userBoardServiceImpl.useLike(hotelLikeDto));
	      return map;
	   }
	   
	   @RequestMapping("toggleLike")
	   public Map<String, Object> toggleLike(HotelLikeDto hotelLikeDto){
	      Map<String, Object> map = new HashMap<>();
	      userBoardServiceImpl.toggleLike(hotelLikeDto);
	      map.put("result", "success");
	      return map;
	   }
	   
	   @RequestMapping("getFavoriteHotelList")
	   public Map<String, Object> getFavoriteHotelList(int user_id,int [] weekDays,String startDate){
	      Map<String, Object> map = new HashMap<>();
	      int startLastIndex = startDate.lastIndexOf("/");
	      
	      String startDay = startDate.substring(0, startLastIndex);
	      if(!userBoardServiceImpl.getLikeHotelList(user_id,weekDays,startDay).isEmpty() && userBoardServiceImpl.getLikeHotelList(user_id,weekDays,startDay)!=null) {
	      map.put("result", "success");
	      map.put("list", userBoardServiceImpl.getLikeHotelList(user_id,weekDays,startDay));
	      return map;
	      }else {
	         map.put("result", "fail");
	         return map;
	      }
	   }
	   
	   @RequestMapping("getCouptonInfo")
	   public Map<String, Object> getCouptonInfo(int id){
	      Map<String, Object> map = new HashMap<>();

	      map.put("result", "success");
	      map.put("disCount",userBoardServiceImpl.getCouponDisCount(id));
	      return map;
	   }
	   @RequestMapping("useCouponProcess")
	   public Map<String, Object> useCouponProcess(int id,HttpSession httpSession){
	      Map<String, Object> map = new HashMap<>();
	      UserDto userDto = (UserDto)httpSession.getAttribute("sessionUser");
	      userBoardServiceImpl.useCouponProcessByHotel(id, userDto.getId());
	      map.put("result", "success");
	      return map;
	   }
	   @RequestMapping("usePointProcess")
	   public Map<String, Object> usePointProcess(int usePoint,HttpSession httpSession){
	      Map<String, Object> map = new HashMap<>();
	      UserDto userDto = (UserDto)httpSession.getAttribute("sessionUser");
	      PointDto pointDto = new PointDto();
	      pointDto.setPoint(usePoint);
	      pointDto.setUser_id(userDto.getId());
	      userBoardServiceImpl.usePointByHotel(pointDto);
	      
	      map.put("result", "success");
	      return map;
	   }
	   @RequestMapping("updateReserveCancle")
	   public Map<String, Object> updateReserveCancle(int price,String tid,HttpSession httpSession){
	      Map<String, Object> map = new HashMap<>();
	      UserDto userDto = (UserDto)httpSession.getAttribute("sessionUser");
	      userBoardServiceImpl.reserveCancle(tid, price, userDto.getId());;
	      map.put("result", "success");
	      return map;
	   }
	
	
	
	
	
	
	
	
	
	
	////////////////////////// 메인 페이지 ////////////////////////////
	
	@RequestMapping("getItemRandomList") // 상품 리스트
	public Map<String, Object> getItemRandomList(int categoryId) {
		Map<String, Object> map = new HashMap<>();
		List<Map<String, Object>> itemList = userBoardServiceImpl.getItemList(categoryId);
		
		Collections.shuffle(itemList);
	    List<Map<String, Object>> randomList = itemList.subList(0, Math.min(itemList.size(), 4));
		
		
		map.put("result", "success");
		map.put("itemList", randomList);
//		map.put("itemList", itemList);
		return map;
		
	}
	
	@RequestMapping("getHotelRandomListByStar")
	public Map<String, Object> getHotelRandomListByStar(int star,String category,int[] checkBoxValues,int orderByNumber,
			String startDay,String endDay,int fixed_number, String loc,int[] weekDays){ //호텔리스트 출력
		Map<String, Object> map = new HashMap<>();
		for(int i=0; i<weekDays.length; i++) {
			System.out.println(weekDays[i]);
		}
		int startLastIndex = startDay.lastIndexOf("/");
		int endLastIndex = endDay.lastIndexOf("/");
		
		String startDate = startDay.substring(0, startLastIndex);
		String endDate = endDay.substring(0, endLastIndex);
		if(userBoardServiceImpl.getHotelListByStar(star, category,checkBoxValues,orderByNumber,startDate,endDate,fixed_number,loc,weekDays)!=null 
				&& !userBoardServiceImpl.getHotelListByStar(star, category,checkBoxValues,orderByNumber,startDate,endDate,fixed_number,loc,weekDays).isEmpty()) {
		map.put("result", "success");
		
		
		
		List<Map<String, Object>> list = userBoardServiceImpl.getHotelListByStar(star, category,checkBoxValues,orderByNumber,startDate,endDate,fixed_number,loc,weekDays);
		Collections.shuffle(list);
	    List<Map<String, Object>> randomList = list.subList(0, Math.min(list.size(), 4));
		
		map.put("list", randomList);
		return map;
		}else {
			map.put("result", "fail");
			return map;
		}
		
	}
	
}
