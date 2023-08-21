package com.rm.roaming.adminboard.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.rm.roaming.dto.CouponDto;
import com.rm.roaming.dto.ItemCategoryDto;
import com.rm.roaming.dto.ItemDto;
import com.rm.roaming.dto.ItemImageDto;
import com.rm.roaming.dto.MonthSaleDto;
import com.rm.roaming.dto.ReportDto;
import com.rm.roaming.dto.SellerAuthorityDto;
import com.rm.roaming.dto.SellerNoticeBoardDto;

public interface AdminBoardSqlMapper {

	
	public int createPk();
	// 쿠폰 생성
	public void insertCoupon(CouponDto couponDto);
	// 사용가능한 쿠폰 조회
	public List<CouponDto> selectCouponAll(int page);
	// 사용가능한 쿠폰 조회 페이징
	public int manageCouponCount();
	// 만료된 쿠폰 조회
	public List<CouponDto> selectNotExistCouponAll(int pageNum);
	// 만료된 쿠폰 조회 페이징
	public int notExistManageCouponCount();
	// 특정 쿠폰 조회
	public CouponDto selectByCouponId(int id);
	// 쿠폰 수량 차감 
	public int decreaseCouponCount(int id);
	// 중복 쿠폰 발급 금지
	public int selectNotDuplicate(@Param("coupon_id") int coupon_id,@Param("user_id") int user_id);
	// 쿠폰 삭제
	public void deleteCoupon(CouponDto couponDto);
	// 쿠폰 수정
	public void updateCoupon(CouponDto couponDto);
	// 상품 등록
	public void insertItem(ItemDto itemDto);
	// 상품 상세이미지 등록
	public void insertItemImage(ItemImageDto itemImageDto);
	// 상품 상세이미지 조회
	public List<ItemImageDto> selectItemImageByItemId(int item_id);
	// 상품 카테고리
	public List<ItemCategoryDto> selectByCategoryId();
	// 상품관리 조회
	public List<ItemDto> selectItemAll();
	// 카테고리 ID
	public ItemCategoryDto selectByItemCategoryId(int id);
	// 상품 삭제
	public void deleteItem(int id);
	// 상품 수정
	public void updateItem(ItemDto itemDto);
	// 상품 이미지 수정
	public void updateItemImage(ItemImageDto itemImageDto);
	// 특정 상품 조회
	public ItemDto selectByItemId(int id);
	// 상품 수량 차감
	public int decreaseItemCount(int id);
	
	// 판매자 공지사항 게시판 등록
	public void insertNotice(SellerNoticeBoardDto sellerNoticeBoardDto);
	// 판매자 공지사항 게시판 리스트
	public List<SellerNoticeBoardDto> selectNoticeAll();
	// 판매자 공지사항 게시판 글 조회
	public SellerNoticeBoardDto selectNoticeId(int id);
	// 판매자 공지사항 게시판 조회수 증가
	public void increaseReadCount(int id);
	// 판매자 공지사항 게시판 게시글 수정
	public void updateSellerNotice(SellerNoticeBoardDto sellerNoticeBoardDto);
	// 판매자 공지사항 게시판 게시글 삭제
	public void deleteSellerNotice(int id);
	// 판매자 신청관리 게시판 조회
	public List<SellerAuthorityDto> selectByHotelDocuList();
	// 판매자 신청관리 게시판 수락 업데이트
	public void updateSellerAuthorityAccept(SellerAuthorityDto sellerAuthorityDto);
	// 판매자 신청관리 게시판 거절 업데이트
	public void updateSellerAuthorityRefuse(SellerAuthorityDto sellerAuthorityDto);
	
	
	
	
	
	
	///////////////////득균
	// 신고 조회
	public List<ReportDto> selectAllReport();
	// 신고받은 게시물 삭제
	public void deleteReportedPost(int id);
	
	
	// 관리자 대쉬보드
	// 오늘 날짜
	public Date getToday();
	
	// 일일 숙소 예약수
	public int getTodayReserveCount();
	// 일일 숙소 매출
	public int getTodayReserveSale();
	// 월간 숙소 매출
	public List<MonthSaleDto> getMonthReserveSale();
	
	// 일일 짐서비스 예약수
	public int getTodayZimCount();
	// 일일 짐서비스 매출
	public int getTodayZimSale();
	// 월간 짐서비스 매출
	public List<MonthSaleDto> getMonthZimSale();
	
	// 구매된 포인트샵 상품수
	public int getTodayItemCount();
	// 일일 포인트 사용
	public int getTodayPointUsed();
	
	// 처리중 문의게시글
	public int getQaNotAnswered();
}
