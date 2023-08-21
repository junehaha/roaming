package com.rm.roaming.adminboard.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rm.roaming.admin.mapper.AdminSqlMapper;
import com.rm.roaming.adminboard.mapper.AdminBoardSqlMapper;
import com.rm.roaming.dto.AdminDto;
import com.rm.roaming.dto.CouponDto;
import com.rm.roaming.dto.ItemCategoryDto;
import com.rm.roaming.dto.ItemDto;
import com.rm.roaming.dto.ItemImageDto;
import com.rm.roaming.dto.MonthSaleDto;
import com.rm.roaming.dto.ReportDto;
import com.rm.roaming.dto.SellerAuthorityDto;
import com.rm.roaming.dto.SellerNoticeBoardDto;
import com.rm.roaming.dto.UserDto;
import com.rm.roaming.user.mapper.UserSqlMapper;

@Service
public class AdminBoardServiceImpl {

	@Autowired
	private AdminBoardSqlMapper adminBoardSqlMapper;
	@Autowired
	private AdminSqlMapper adminSqlMapper;
	@Autowired
	private UserSqlMapper userSqlMapper;
	
	// 쿠폰 생성 insert
	public void produceCoupon(CouponDto couponDto) {
		
		adminBoardSqlMapper.insertCoupon(couponDto);
	}
	
	// 쿠폰관리 쿠폰현황 페이징
	public int manageCouponCount() {
		return adminBoardSqlMapper.manageCouponCount();
	}
	
	// 쿠폰관리 쿠폰현황 리스트
	public List<Map<String,Object>> getCouponList(int page) {
		
		List<Map<String, Object>> couponList = new ArrayList<>();
		
		List<CouponDto> couponDtoList = adminBoardSqlMapper.selectCouponAll(page);
		
		
		for(CouponDto couponDto : couponDtoList) {
			
			Map<String, Object> map = new HashMap<>();
			
			int adminId = couponDto.getAdmin_id();
			int useCouponCount = adminBoardSqlMapper.decreaseCouponCount(couponDto.getId());
			int quantity = couponDto.getCoupon_count() - useCouponCount;
			
			AdminDto adminDto = adminSqlMapper.selectByAdminId(adminId);
			
			map.put("adminDto", adminDto);
			map.put("couponDto", couponDto);
			map.put("quantity", quantity);
			
			couponList.add(map);
		}
		
		return couponList;
	}
	
	// 쿠폰관리 만료된 쿠폰 페이징
	public int notExistManageCouponCount() {
		return adminBoardSqlMapper.notExistManageCouponCount();
	}
	
	// 쿠폰관리 만료된 쿠폰 리스트
	public List<Map<String,Object>> getNotExistCouponList(int pageNum) {
		
		List<Map<String, Object>> notExistcouponList = new ArrayList<>();
		
		List<CouponDto> couponDtoList = adminBoardSqlMapper.selectNotExistCouponAll(pageNum);
		
		for(CouponDto couponDto : couponDtoList) {
			
			Map<String, Object> map = new HashMap<>();
			
			int adminId = couponDto.getAdmin_id();
			int useCouponCount = adminBoardSqlMapper.decreaseCouponCount(couponDto.getId());
			int quantity = couponDto.getCoupon_count() - useCouponCount;
			
			AdminDto adminDto = adminSqlMapper.selectByAdminId(adminId);
			
			map.put("adminDto", adminDto);
			map.put("couponDto", couponDto);
			map.put("quantity", quantity);
			
			notExistcouponList.add(map);
		}
		
		return notExistcouponList;
	}
	
	
	
	// 쿠폰 삭제
	public void deleteCoupon(CouponDto couponDto) {
		adminBoardSqlMapper.deleteCoupon(couponDto);
	}
	
	// 쿠폰수정
	public void updateCoupon(CouponDto couponDto) {
		adminBoardSqlMapper.updateCoupon(couponDto);
	}
	
	// 쿠폰 테이블 및 관리자ID
	public Map<String, Object> getCoupon(int id) {
		
		Map<String, Object> map = new HashMap<>();
		
		CouponDto couponDto = adminBoardSqlMapper.selectByCouponId(id);
		AdminDto adminDto = adminSqlMapper.selectByAdminId(couponDto.getAdmin_id());
		
		map.put("adminDto", adminDto);
		map.put("couponDto", couponDto);
		
		return map;
	}
	
	// 상품 등록 insert
		public void itemRegister(ItemDto itemDto, List<ItemImageDto> itemImageDtoList ) {
			
			int itemId = adminBoardSqlMapper.createPk();
			
			itemDto.setId(itemId);
			adminBoardSqlMapper.insertItem(itemDto);
			
			for(ItemImageDto itemImageDto : itemImageDtoList) {
				itemImageDto.setItem_id(itemId);
				adminBoardSqlMapper.insertItemImage(itemImageDto);
			}
		}
		
	// 상품 카테고리
		public List<ItemCategoryDto> getCategory() {
			
			return adminBoardSqlMapper.selectByCategoryId();
		}
		
	// 상품관리 조회
		public List<Map<String, Object>> getItemList() {
			
			List<Map<String, Object>> itemList = new ArrayList<>();
			
			List<ItemDto> itemDtoList = adminBoardSqlMapper.selectItemAll();
			
			for(ItemDto itemDto : itemDtoList) {
				
				Map<String, Object> map = new HashMap<>();
				
				int adminId = itemDto.getAdmin_id();
				int itemCategoryId = itemDto.getCategory_id();
				int buyItemCount = adminBoardSqlMapper.decreaseItemCount(itemDto.getId());
				int quantity = itemDto.getItem_count() - buyItemCount;
				
				AdminDto adminDto = adminSqlMapper.selectByAdminId(adminId);
				ItemCategoryDto itemCategoryDto = adminBoardSqlMapper.selectByItemCategoryId(itemCategoryId);
				
				map.put("adminDto", adminDto);
				map.put("itemDto", itemDto);
				map.put("itemCategoryDto", itemCategoryDto);
				map.put("quantity", quantity);
				
				itemList.add(map);
			}
			
			return itemList;
		}
		
	// 상품삭제
		public void deleteItem(int id) {
			adminBoardSqlMapper.deleteItem(id);
		}
		
	// 상품수정
		public void updateItem(ItemDto itemDto) {
			adminBoardSqlMapper.updateItem(itemDto);
		}
		
	// 상품 이미지 수정
		public void updateItemImage(ItemImageDto itemImageDto) {
			adminBoardSqlMapper.updateItemImage(itemImageDto);
		}
		
		public Map<String, Object> getItem(int id) {
			
			Map<String, Object> map = new HashMap<>();
			
			ItemDto itemDto = adminBoardSqlMapper.selectByItemId(id);
			AdminDto adminDto = adminSqlMapper.selectByAdminId(itemDto.getAdmin_id());
			
			map.put("adminDto", adminDto);
			map.put("itemDto", itemDto);
			
			return map;
		}
		
	// 판매자 공지사항 게시판 등록
		public void writeSellerNotice(SellerNoticeBoardDto sellerNoticeBoardDto) {
			
			adminBoardSqlMapper.insertNotice(sellerNoticeBoardDto);
			
		}
	// 판매자 공지사항 게시판 리스트
		public List<Map<String, Object>> getSellerNoticeList() {
			
			List<Map<String, Object>> list = new ArrayList<>();
			
			List<SellerNoticeBoardDto> sellerNoticeBoardDtoList = adminBoardSqlMapper.selectNoticeAll();
			
			for(SellerNoticeBoardDto sellerNoticeBoardDto : sellerNoticeBoardDtoList) {
				
				Map<String, Object> map = new HashMap<>();
				
				int adminId = sellerNoticeBoardDto.getAdmin_id();
				
				AdminDto adminDto = adminSqlMapper.selectByAdminId(adminId);
				
				map.put("adminDto", adminDto);
				map.put("sellerNoticeBoardDto", sellerNoticeBoardDto);
				
				list.add(map);
			}
			
			return list;
		}
		
	// 판매자 공지사항 게시판 글 조회
		public Map<String, Object> getSellerNotice(int id) {
			
			Map<String, Object> map = new HashMap<>();
			
			SellerNoticeBoardDto sellerNoticeBoardDto = adminBoardSqlMapper.selectNoticeId(id);
			AdminDto adminDto = adminSqlMapper.selectByAdminId(sellerNoticeBoardDto.getAdmin_id());
			
			map.put("adminDto", adminDto);
			map.put("sellerNoticeBoardDto", sellerNoticeBoardDto);
			
			return map;
			
		}
	// 판매자 공지사항 게시판 게시글 조회수 증가
		public void increaseReadCount(int id) {
			
			adminBoardSqlMapper.increaseReadCount(id);
			
		}
	
	// 판매자 공지사항 게시판 게시글 수정
		public void updateSellerNotice(SellerNoticeBoardDto sellerNoticeBoardDto) {
			
			adminBoardSqlMapper.updateSellerNotice(sellerNoticeBoardDto);
			
		}
		
	// 판매자 공지사항 게시판 게시글 삭제
		public void deleteSellerNotice(int id) {
			
			adminBoardSqlMapper.deleteSellerNotice(id);
			
		}
	
	// 판매자 권한관리 게시판 리스트 
		public List<SellerAuthorityDto> getHotelDocuList() {
			
			List<SellerAuthorityDto> sellerAuthorityDtoList = adminBoardSqlMapper.selectByHotelDocuList();
			
			return sellerAuthorityDtoList;
		}
			
	// 판매자 신청관리 게시판 수락 업데이트
		public void updateSellerAuthorityAccept(SellerAuthorityDto sellerAuthorityDto) {
			
			adminBoardSqlMapper.updateSellerAuthorityAccept(sellerAuthorityDto);
			
		}
		
	// 판매자 신청관리 게시판 거절 업데이트
		public void updateSellerAuthorityRefuse(SellerAuthorityDto sellerAuthorityDto) {
			
			adminBoardSqlMapper.updateSellerAuthorityRefuse(sellerAuthorityDto);
			
		}
		
		
		
		
		
		
		
		
		//////////////////// 득균 ///////////////////
		
	// 신고 조회
	public List<Map<String,Object>> getAllReport(){
		
		List<Map<String,Object>> reportList = new ArrayList<>();
		
		List<ReportDto> reportDtoList = adminBoardSqlMapper.selectAllReport();
		
		for(ReportDto reportDto : reportDtoList) {
			
			Map<String,Object> map = new HashMap<>();
			
			int userId = reportDto.getUser_id();
			UserDto userDto = userSqlMapper.selectByUserId(userId);
			
			map.put("userDto", userDto);
			map.put("reportDto", reportDto);
			
			reportList.add(map);			
		}
		
		return reportList;
	}
	
	// 신고된 게시물 삭제
	public void deleteReportedPost(int id) {
		adminBoardSqlMapper.deleteReportedPost(id);
	}
	
	// 관리자 대쉬보드
	// 날짜 가져오기
	public Date getToday() {
		return adminBoardSqlMapper.getToday();
	}
	
	// 일일 숙소 예약수
	public int getTodayReserveCount() {
		return adminBoardSqlMapper.getTodayReserveCount();
	}
	// 일일 숙소 매출
	public int getTodayReserveSale() {
		return adminBoardSqlMapper.getTodayReserveSale();
	}
	// 월간 숙소 매출
	public List<MonthSaleDto> getMonthReserveSale(){

		return adminBoardSqlMapper.getMonthReserveSale();
	}
	
	// 일일 짐서비스 예약수
	public int getTodayZimCount() {
		return adminBoardSqlMapper.getTodayZimCount();
	}
	// 일일 짐서비스 매출
	public int getTodayZimSale() {
		return adminBoardSqlMapper.getTodayZimSale();
	}
	// 월간 짐 서비스 매출
	public List<MonthSaleDto> getMonthZimSale(){
		return adminBoardSqlMapper.getMonthZimSale();
	}
	
	// 구매된 포인트샵 상품수
	public int getTodayItemCount() {
		return adminBoardSqlMapper.getTodayItemCount();
	}
	// 일일 포인트 사용
	public int getTodayPointUsed() {
		return adminBoardSqlMapper.getTodayPointUsed();
	}
	
	// 처리중 문의게시글
	public int getQaNotAnswered() {
		return adminBoardSqlMapper.getQaNotAnswered();
	}
		
}
