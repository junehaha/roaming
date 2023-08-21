package com.rm.roaming.userboard.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.rm.roaming.admincsboard.service.AdminCsServiceImpl;
import com.rm.roaming.dto.ItemBuyDto;
import com.rm.roaming.dto.ItemCategoryDto;
import com.rm.roaming.dto.ItemDto;
import com.rm.roaming.dto.ItemReviewDto;
import com.rm.roaming.dto.KakaoDto;
import com.rm.roaming.dto.PointDto;
import com.rm.roaming.dto.UserAddressDto;
import com.rm.roaming.dto.UserCouponDto;
import com.rm.roaming.dto.UserDto;
import com.rm.roaming.dto.ZimReviewDto;
import com.rm.roaming.dto.ZimSignUpDto;
import com.rm.roaming.facebook.service.FacebookServiceImpl;
import com.rm.roaming.post.service.PostService;
import com.rm.roaming.userboard.service.UserBoardServiceImpl;
import com.rm.roaming.userzim.service.UserZimService;


@Controller
@RequestMapping("/userboard/*")
public class UserBoardController {
	@Autowired
	private UserBoardServiceImpl userBoardService;
	@Autowired
	private PostService postService;
	@Autowired
	private FacebookServiceImpl facebookService;
	@Autowired
	private AdminCsServiceImpl adminCsService;
	@Autowired
	private UserZimService userZimService; 
	
	@RequestMapping("mainPage")
	public String mainPage(Model model) {
		int page = 1;
		String searchValue = null;
		String category = null;
		List<Map<String, Object>> list = postService.getPostList(page, searchValue, category);
	    Collections.shuffle(list);
	    // 동행
	    List<Map<String, Object>> randomList = list.subList(0, Math.min(list.size(), 4));
	    
		// 커뮤
	    List<Map<String, Object>> feedList = facebookService.selectFeedMain();
	    Collections.shuffle(feedList);
	    List<Map<String, Object>> feedRadomList = feedList.subList(0, Math.min(feedList.size(), 4));
	    
		// 호텔 - RESTController
	    // 쿠폰 - RESTController
	    // 공지사항
	    model.addAttribute("csNoticeList", adminCsService.getMainCsNotice());

		
		
	    
		model.addAttribute("postlist", randomList);
		model.addAttribute("feedlist", feedRadomList);
		
		
		
		
		return "userboard/mainPage";
	}
	

	// 마이 페이지
	@RequestMapping("myPage")
	public String myPage(HttpSession session, int id, Model model) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		
		if(sessionUser == null) return "user/loginPage";
		
		int userId = sessionUser.getId();
		
		Map<String, Object> myPage = userBoardService.getMyPage(userId);
		
		
		model.addAttribute("myPage",myPage);
		
		return "userboard/myPage";
	}
	
	
	// 쿠폰 리스트 페이지
		@RequestMapping("couponListPage")
		public String couponListPage(Model model, HttpSession session) {
			
			UserDto userDto = (UserDto) session.getAttribute("sessionUser");
			
			if(userDto == null) return "user/loginPage";
			
			int userId = userDto.getId();
			
			List<Map<String, Object>> couponList = userBoardService.getCouponList(userId);
			
			model.addAttribute("couponList", couponList);
			
		
			
			return "userboard/couponListPage";
		}
		
		// 쿠폰 리스트 프로세스
		@RequestMapping("couponListProcess")
		public String couponListProcess(HttpSession session, UserCouponDto userCouponDto) {
			session.getAttribute("sessionUser");
			userBoardService.userCouponAdd(userCouponDto);
			
			return "redirect:./couponListPage";
		}
		

		// 내 쿠폰함 페이지
		@RequestMapping("userCouponPage")
		public String userCouponPage(Model model, HttpSession session, @RequestParam(value = "page", defaultValue = "1") int page, @RequestParam(value = "pageNum", defaultValue = "1") int pageNum) {
			
			UserDto userDto = (UserDto)session.getAttribute("sessionUser");
			
			if(userDto == null) return "user/loginPage";
			
			int userId = userDto.getId();
			
			List<Map<String, Object>> userCouponList = userBoardService.getUserCouponList(userId,page);
			
			int userCouponCount = userBoardService.userCouponCount(userId);
			int totalPage = (int)Math.ceil(userCouponCount/3.0);
			
			int startPage = ((page - 1) / 3) * 3 + 1;
			int endPage = ((page - 1) / 3 + 1) * 3;
			
			if(endPage > totalPage) {
				endPage = totalPage;
			}
			
			model.addAttribute("userCouponList", userCouponList);
			model.addAttribute("totalPage", totalPage);
			model.addAttribute("currentPage", page);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			
			
			List<Map<String, Object>> notExistUserCouponList = userBoardService.getNotExistUserCouponList(userId,pageNum);
			
			int notExistUserCouponCount = userBoardService.notExistUserCouponCount(userId);
			int totalPages = (int)Math.ceil(notExistUserCouponCount/3.0);
			
			int startPages = ((pageNum - 1) / 3) * 3 + 1;
			int endPages = ((pageNum - 1)/ 3 + 1) * 3;
			
			if(endPages > totalPages) {
				endPages = totalPages;
			}
			
			model.addAttribute("notExistUserCouponList", notExistUserCouponList);
			model.addAttribute("totalPages", totalPages);
			model.addAttribute("currentPages", pageNum);
			model.addAttribute("startPages", startPages);
			model.addAttribute("endPages", endPages);
			
			Map<String, Object> myPage = userBoardService.getMyPage(userId);
			
			
			model.addAttribute("myPage",myPage);
			
			return "userboard/userCouponPage";
		}
		
		
		// 상품 리스트 페이지
		@RequestMapping("itemListPage")
		public String itemListPage(Model model) {
			
			
//					List<Map<String, Object>> itemList = userBoardService.getItemList();
			List<ItemCategoryDto> category = userBoardService.CategoryList();		
			
			
//					model.addAttribute("itemList",itemList);
			model.addAttribute("category",category);

			
			return "userboard/itemListPage";
		}
		
		// 상품 상세 페이지
		@RequestMapping("itemDetailPage")
		public String itemDetailPage(Model model, int id, HttpSession session) {
			
			UserDto userDto = (UserDto)session.getAttribute("sessionUser");
			
			int userId = userDto.getId();
			
	
			Map<String, Object> itemDetail = userBoardService.getItemDetail(id);
			Map<String, Object> itemBuy = userBoardService.getItemBuy(id);
			
			
			
			
			model.addAttribute("itemDetail", itemDetail);
			model.addAttribute("itemReview", userBoardService.getItemReviewList(id));
			model.addAttribute("itemBuy",itemBuy);
			model.addAttribute("couponList", userBoardService.getItemCouponList(userId));
			model.addAttribute("useAbleCouponCount", userBoardService.getuseAbleCouponCount(userId));
			
			return "userboard/itemDetailPage";
		}
		
		
	
		
		// 상품 구매 프로세스
		@RequestMapping("insertItemBuyProcess")
		public String insertItemBuyProcess(HttpSession session, UserAddressDto userAddressDto, int id, ItemBuyDto itemBuyDto, PointDto pointDto) {
			
			UserDto userDto = (UserDto)session.getAttribute("sessionUser");
			
			userAddressDto.setUser_id(userDto.getId());
			
			int addressPk = userBoardService.createAddressPk();
			userAddressDto.setId(addressPk);
			
			itemBuyDto.setItem_id(id);
			itemBuyDto.setAddress_id(addressPk);
			
			pointDto.setUser_id(userDto.getId());
		
			if(itemBuyDto.getUserCoupon_id() != 0) {
				userBoardService.useCouponByItem(itemBuyDto.getUserCoupon_id(),userDto.getId());
			}
			userBoardService.insertItemBuy(itemBuyDto);
			
			userBoardService.insertUserAddress(userAddressDto);
			userBoardService.insertPointStatus(pointDto);
			
			return "redirect:./itemBuyCompletePage?id=" + id;
			
		}
		
		
		// 상품 구매 완료 페이지
		@RequestMapping("itemBuyCompletePage")
		public String itemBuyCompletePage(Model model, int id) {
			
			Map<String, Object> itemBuyComplete = userBoardService.getItemBuyComplete(id);
			ItemBuyDto itemBuyDto= (ItemBuyDto) itemBuyComplete.get("itemBuyDto");
			ItemDto itemDto= (ItemDto) itemBuyComplete.get("itemDto");
			int count = itemBuyDto.getCount();
			System.out.println(count);
			int price = itemDto.getItem_price();
			System.out.println(price);
			if(itemBuyDto.getUserCoupon_id() != 0) {
				

				double couponPercent = userBoardService.getUseCouponPercentByItem(itemBuyDto.getUserCoupon_id()) / 100.0; // 나누기 100.0으로 소수점 이하 값 처리
				System.out.println(couponPercent);

				int finalPrice = (int) ((count * price) *  (couponPercent)); // 정수형으로 형변환하여 사용
				int realFinalPrice = (count * price) - finalPrice;
				System.out.println(finalPrice);
				model.addAttribute("finalPrice", realFinalPrice);
			}else {
				model.addAttribute("finalPrice", (count * price));
				
			}
			model.addAttribute("itemBuyComplete", itemBuyComplete);
			
			return "userboard/itemBuyCompletePage";
		}
		
		// 주문 내역 조회
		@RequestMapping("orderHistoryPage")
		public String orderHistoryPage(Model model, HttpSession session) {
			
			UserDto userDto = (UserDto)session.getAttribute("sessionUser");
			
			int userId = userDto.getId();
			
			List<Map<String, Object>> orderHistoryList = userBoardService.getOrderHistoryList(userId);
			Map<String, Object> myPage = userBoardService.getMyPage(userId);
			
			
			model.addAttribute("myPage",myPage);
			
			model.addAttribute("orderHistoryList",orderHistoryList);
			
			return "userboard/orderHistoryPage";
		}
		
		// 상품 리뷰 등록후 상품 구매 상태 업데이트
		@RequestMapping("insertItemReviewProcess")
		public String insertItemReviewProcess(ItemReviewDto itemReviewDto) {
		    userBoardService.insertItemReview(itemReviewDto);
		    
		    ItemBuyDto itemBuyDto = new ItemBuyDto();
		    itemBuyDto.setId(itemReviewDto.getItem_buy_id());
		    userBoardService.updateItemBuyProgress(itemBuyDto);
		    
		    return "redirect:./orderHistoryPage";
		}

		// 유저별 상품 좋아요 리스트
		@RequestMapping("userItemLikePage")
		public String userItemLikePage(Model model, HttpSession session) {
			
			UserDto userDto = (UserDto)session.getAttribute("sessionUser");
			
			int userId = userDto.getId();
			
			List<Map<String, Object>> userLikeItemList = userBoardService.getUserLikeItemList(userId);
			Map<String, Object> myPage = userBoardService.getMyPage(userId);
			
			
			model.addAttribute("myPage",myPage);
			
			model.addAttribute("userLikeItemList", userLikeItemList);
			
			return "userboard/userItemLikePage";
		}
		
		// 내 포인트 리스트 조회
		@RequestMapping("userPointPage")
		public String userPointPage(Model model, HttpSession session, @RequestParam(value = "page", defaultValue = "1") int page) {
			
			UserDto userDto = (UserDto)session.getAttribute("sessionUser");
			
			int userId = userDto.getId();
			
			List<Map<String, Object>> userPointList = userBoardService.getUserPointList(page);
			Map<String, Object> userPoint = userBoardService.getPoint(userId);
			Map<String, Object> myPage = userBoardService.getMyPage(userId);
			
			int userPointPaging = userBoardService.userPointPaging();
			int totalPage = (int)Math.ceil(userPointPaging/5.0);
			
			int startPage = ((page-1)/5)*3 + 1;
			int endPage = ((page-1)/5+1)*3;
			
			if(endPage > totalPage) {
				endPage = totalPage;
			}
			
			
			model.addAttribute("myPage",myPage);
			model.addAttribute("userPoint", userPoint);
			model.addAttribute("userPointList", userPointList);
			model.addAttribute("totalPage", totalPage);
			model.addAttribute("currentPage", page);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			
			return "userboard/userPointPage";
		}
		
		
	
	
	
	
	
	
	
	
	@RequestMapping("hotelPage")
	public String hotelPage() {
		return "userboard/hotelPage";
	}
	@RequestMapping("hotelInfoPage")
	public String hotelInfoPage(int id,String startDate,String endDate,int people,Model model) {
		
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("people", people);
		
		return "userboard/hotelInfoPage";
	}
	
	@RequestMapping("hotelReservePage")
	public String hotelReservePage(int groupId,String startDate,String endDate,Model model,HttpSession session) {
		UserDto userDto = (UserDto) session.getAttribute("sessionUser");
		int user_id = userDto.getId();
		System.out.println(user_id);
		model.addAttribute("info", userBoardService.getReserveInfo(groupId));
		model.addAttribute("startDate",startDate);
		model.addAttribute("endDate",endDate);
		model.addAttribute("couponList", userBoardService.getHotelCouponList(user_id));
		model.addAttribute("useAbleCouponCount", userBoardService.getUseAbleCouponCount(user_id));
		model.addAttribute("point", userBoardService.getMyPage(user_id));
		return "userboard/hotelReservePage";
	}
	
	
	@RequestMapping("reserveSuccessPage")
	public String reserveSuccessPage() {

		return "userboard/reserveSuccessPage";
	}
	
	@RequestMapping("reserveCancelPage")
	public String reserveCancelPage(int hotel_id,Model model) {
		model.addAttribute("id", hotel_id);
		return "userboard/reserveCancelPage";

	}
	@RequestMapping("reserveFailPage")
	public String reserveFailPage(int hotel_id,Model model) {
		model.addAttribute("id", hotel_id);
		return "userboard/reserveCancelPage";
	}
	
	@RequestMapping("userMyPage")
	public String userMyPage() {
		return "userboard/userMyPage";
	}
	
	@RequestMapping("successReserveInfoPage")
	public String successReserveInfoPage(HttpSession session,Model model) {
		KakaoDto kakaoDto =  (KakaoDto) session.getAttribute("kakaoDto");
		String tid = kakaoDto.getTid();
		model.addAttribute("info", userBoardService.getBeforeReserve(tid));
		model.addAttribute("startDate", kakaoDto.getStartDate());
		model.addAttribute("endDate", kakaoDto.getEndDate());
		session.removeAttribute("kakaoDto");
		return "userboard/successReserveInfoPage";
	}
	
	@RequestMapping("hotelCurrentReservePage")
	public String hotelCurrentReservePage(HttpSession session, Model model) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		int userId = sessionUser.getId();
		
		Map<String, Object> myPage = userBoardService.getMyPage(userId);
		
		
		model.addAttribute("myPage",myPage);
		return "userboard/hotelCurrentReservePage";
	}
	
	@RequestMapping("hotelBeforeReservePage")
	public String hotelBeforeReservePage(HttpSession session, Model model) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		int userId = sessionUser.getId();
		
		Map<String, Object> myPage = userBoardService.getMyPage(userId);
		
		
		model.addAttribute("myPage",myPage);
		return "userboard/hotelBeforeReservePage";
	}
	@RequestMapping("likeHotelListPage")
	public String likeHotelListPage(HttpSession session, Model model) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		int userId = sessionUser.getId();
		
		Map<String, Object> myPage = userBoardService.getMyPage(userId);
		
		
		model.addAttribute("myPage",myPage);
		return "userboard/likeHotelListPage";
	}
		
		
		
		
		
		
		
		
		
		
		
		
	//////////////////동행///////////////////////
	
	@RequestMapping("partyListPage")
	public String partyListPage(HttpSession session, Model model) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		if(sessionUser == null) return "user/loginPage";
		int userId = sessionUser.getId();
		Map<String, Object> myPage = userBoardService.getMyPage(userId); 
		model.addAttribute("myPage",myPage);
		
		
		
		model.addAttribute("list", postService.getIngPostList(userId));	
		return "userboard/partyListPage";
	}
	
	@RequestMapping("pastPartyListPage")
	public String pastPartyListPage(HttpSession session, Model model) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		if(sessionUser == null) return "user/loginPage";
		int userId = sessionUser.getId();
		Map<String, Object> myPage = userBoardService.getMyPage(userId); 
		model.addAttribute("myPage",myPage);
		
		model.addAttribute("sessionUser", sessionUser);
		model.addAttribute("list", postService.getPastPostList(userId));
		return "userboard/pastPartyListPage";
	}
	
	// 참가신청리스트
	@RequestMapping("joinConfirmPage")
	public String joinConfirmPage(HttpSession session, Model model) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		if(sessionUser == null) return "user/loginPage";
		int userId = sessionUser.getId();
		Map<String, Object> myPage = userBoardService.getMyPage(userId);
		// 참가신청 리스트
		
		model.addAttribute("myPage",myPage);
		model.addAttribute("list", postService.selectJoinConfirm(sessionUser.getId()));
		
		return "userboard/joinConfirmPage";
	}
	
	// 득균	
	// myPage의 배송상태 조회
	@RequestMapping("userZimInfoPage")
	public String userZimInfoPage(HttpSession session, Model model) {

	
			UserDto user = (UserDto) session.getAttribute("sessionUser");
			if(user!=null) {
			int userId = user.getId();
			
			List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
			List<ZimSignUpDto> signUpLists = userZimService.getZimSignUpByUserId(userId);
			for(ZimSignUpDto signUpDto : signUpLists) {
				Map<String,Object> map = new HashMap<>();
				
				int signUpId = signUpDto.getId();
				List<Map<String,Object>> signCateList = userZimService.getZimSignCateList(signUpId);
				String total = userZimService.totalSum(signUpId);
				
				int id = signUpDto.getUser_id();
				UserDto userDto = userZimService.getUserById(id);
				
				ZimReviewDto reviewDto = userZimService.getZimReview(signUpId);
				
				map.put("userDto", userDto);
				map.put("reviewDto", reviewDto);
				map.put("signUpDto", signUpDto);
				map.put("signCateList",signCateList);
				map.put("total", total);
				
				list.add(map);
			}
			
			
			
			model.addAttribute("list", list);
			
			return "userboard/userZimInfoPage";
			}else{
			return "userboard/myPage";}
	}	
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
}
