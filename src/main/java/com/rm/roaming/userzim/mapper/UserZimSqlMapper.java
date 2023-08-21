package com.rm.roaming.userzim.mapper;

import java.util.List;

import com.rm.roaming.dto.ReservedAddressDto;
import com.rm.roaming.dto.UserDto;
import com.rm.roaming.dto.ZimCategoryDto;
import com.rm.roaming.dto.ZimDeliveryManageDto;
import com.rm.roaming.dto.ZimReviewDto;
import com.rm.roaming.dto.ZimSignCateListDto;
import com.rm.roaming.dto.ZimSignUpDto;

public interface UserZimSqlMapper {
	// 짐 신청(날짜,장소)
	public void insertZimSignUp(ZimSignUpDto params);
	
	// 짐 신청2(짐 종류,수량)
	public List<ZimCategoryDto> selectZimCategory(); // 짐 카테고리 조회
	public void insertZimCategoryList(ZimSignCateListDto params); // 짐 종류, 수량 insert
	
	// 기본키 생성
	public int createPK();
	
	// 짐 신청 조회
	public ZimSignUpDto selectZimSignUpById(int signId); // 날짜,장소
	public ReservedAddressDto selectReservedAddresss(int userId); // 최근 예약한 숙소 주소 조회
	public List<ZimSignCateListDto> selectZimSignCateListById(int id); // 종류, 수량
	public ZimCategoryDto selectZimCategoryById(int zim_category_id); // 카테고리
	public String totalSum(int id); // 총 합계
	public List<ZimSignUpDto> selectAllSignUp(); // 모든 짐배송 조회
	public List<ZimSignUpDto> selectZimSignUpByUserId(int userId); //유저 id로 배송신청보기
	
	// 짐 신청 삭제
	public void cancelZimSignUp(int id);
	public void cancelZimSignAndCategory(int id);
	
	// 짐 신청 리뷰
	public ZimReviewDto selectZimReview(int signUpId);
	public List<ZimReviewDto> selectEightZimReview();
	public void insertZimReview(ZimReviewDto params);
	public double selectZimAverageStar();
	public int selectZimAmountById(int signId);
	public void deleteZimReview(int signId); //리뷰 삭제
	
	// 유저id로 정보가져오기
	public UserDto selectUserById(int id);

	// 짐 배송상태 변경
	public void updateZimProgress(ZimSignUpDto params); //업데이트
	public void insertZimDeliveryManage(ZimDeliveryManageDto zimDto); //기록
	
	// 변경이력 조회
	public List<ZimDeliveryManageDto> selectZimDeliveryManage(); 

}
