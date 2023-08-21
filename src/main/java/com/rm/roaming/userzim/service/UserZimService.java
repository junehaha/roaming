package com.rm.roaming.userzim.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rm.roaming.admincsboard.mapper.AdminCsSqlMapper;
import com.rm.roaming.dto.AdminDto;
import com.rm.roaming.dto.ReservedAddressDto;
import com.rm.roaming.dto.UserDto;
import com.rm.roaming.dto.ZimCategoryDto;
import com.rm.roaming.dto.ZimDeliveryManageDto;
import com.rm.roaming.dto.ZimReviewDto;
import com.rm.roaming.dto.ZimSignCateListDto;
import com.rm.roaming.dto.ZimSignUpDto;
import com.rm.roaming.userzim.mapper.UserZimSqlMapper;

@Service
public class UserZimService {

	@Autowired
	private UserZimSqlMapper userZimSqlMapper;

	@Autowired
	private AdminCsSqlMapper adminCsSqlMapper;
	
	// 짐신청(장소 및 날짜)
	public void insertZimSignUp(ZimSignUpDto params) {
		if(params.getZim_image_link()==null) {
			params.setZim_image_link(null);
		}
		userZimSqlMapper.insertZimSignUp(params);
	}
	
	// 최근 호텔예약주소 가져오기
	public String getReservedAddresss(int userId) {
		
		ReservedAddressDto reservedAddressDto = userZimSqlMapper.selectReservedAddresss(userId);
		
		String totalAddress = "";
		
		if(reservedAddressDto != null) {
		totalAddress += reservedAddressDto.getHotel_name();
		totalAddress += " " + reservedAddressDto.getHotel_loc();
		totalAddress += " " +reservedAddressDto.getRoom_number();
		}
		return totalAddress;
	}

	// 짐 종류 및 수량 select
	public List<ZimCategoryDto> getZimCategory() {
		return userZimSqlMapper.selectZimCategory();
	}

	// 짐 신청(종류 및 수량)
	public void insertZimCategoryList(int id, ArrayList<ZimSignCateListDto> list) {

		int signId = id;
		ZimSignUpDto zimSignDto = userZimSqlMapper.selectZimSignUpById(signId);

		int pk = zimSignDto.getId();

		if (list != null) {
			for (ZimSignCateListDto params : list) {
				params.setId(pk);
				params.setZim_signup_id(id);
				userZimSqlMapper.insertZimCategoryList(params);
			}
		}
	}

	// 기본키 생성
	public int createPK() {
		return userZimSqlMapper.createPK();
	}

	// 짐 신청 조회
	public ZimSignUpDto getZimSignUp(int id) {
		int signId = id;
		return userZimSqlMapper.selectZimSignUpById(signId);
	}

	public List<ZimSignUpDto> getAllZimSignUp() {
		return userZimSqlMapper.selectAllSignUp();
	}

	public List<ZimSignUpDto> getZimSignUpByUserId(int userId) {
		return userZimSqlMapper.selectZimSignUpByUserId(userId);
	}

	public List<Map<String, Object>> getZimSignCateList(int id) {

		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

		List<ZimSignCateListDto> zimList = userZimSqlMapper.selectZimSignCateListById(id);

		for (ZimSignCateListDto zim : zimList) {
			Map<String, Object> map = new HashMap<>();

			int categoryId = zim.getZim_category_id();
			ZimCategoryDto zimCategory = userZimSqlMapper.selectZimCategoryById(categoryId);

			map.put("zim", zim);
			map.put("zimCategory", zimCategory);

			list.add(map);
		}

		return list;
	}

	// 짐 신청목록 조회(회원 id)

	public String totalSum(int id) {
		return userZimSqlMapper.totalSum(id);
	}

	public void cancelZimSignUp(int id) {
		userZimSqlMapper.cancelZimSignUp(id);
	}

	public void cancelZimSignAndCategory(int id) {
		userZimSqlMapper.cancelZimSignAndCategory(id);
	}

	// 짐 신청 리뷰
	public ZimReviewDto getZimReview(int signUpId) {
		return userZimSqlMapper.selectZimReview(signUpId);
	}

	public List<Map<String, Object>> getEightZimReview() {

		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

		List<ZimReviewDto> reviews = userZimSqlMapper.selectEightZimReview();

		for (ZimReviewDto review : reviews) {
			Map<String, Object> map = new HashMap<>();
			
			int signId = review.getZim_signup_id();
			ZimSignUpDto zimSignUpDto = userZimSqlMapper.selectZimSignUpById(signId);

			int zimAmount = userZimSqlMapper.selectZimAmountById(signId);

			int id = zimSignUpDto.getUser_id();
			UserDto userDto = userZimSqlMapper.selectUserById(id);

			map.put("userDto", userDto);
			map.put("review", review);
			map.put("zimSignUpDto", zimSignUpDto);
			map.put("zimAmount", zimAmount);

			list.add(map);
		}

		return list;
	}

	public void insertZimReview(ZimReviewDto params) {
		userZimSqlMapper.insertZimReview(params);
	}

	public double getZimAverageStar() {
		return userZimSqlMapper.selectZimAverageStar();
	}

	// 유저 정보 가져오기
	public UserDto getUserById(int id) {
		return userZimSqlMapper.selectUserById(id);
	}

	// 유저 짐 상태 변경
	public void updateZimProgress(ZimSignUpDto params) {
		userZimSqlMapper.updateZimProgress(params);
	}

	// 짐 상태 변경이력 기록
	public void insertZimDeliveryManage(ZimDeliveryManageDto zimDto) {
		userZimSqlMapper.insertZimDeliveryManage(zimDto);
	}

	// 짐 상태 변경이력 조회
	public List<Map<String, Object>> getZimProgressChange() {

		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

		List<ZimDeliveryManageDto> zimManageLists = userZimSqlMapper.selectZimDeliveryManage();

		for (ZimDeliveryManageDto zimManageList : zimManageLists) {
			Map<String, Object> map = new HashMap<>();

			int adminId = zimManageList.getAdmin_id();
			AdminDto adminDto = adminCsSqlMapper.selectAdminById(adminId);

			int signUpId = zimManageList.getZim_signup_id();
			ZimSignUpDto signUpDto = userZimSqlMapper.selectZimSignUpById(signUpId);
			
			int Id = signUpDto.getUser_id();
			
			UserDto userDto = userZimSqlMapper.selectUserById(Id);
			
			map.put("zimManageList", zimManageList);
			map.put("adminDto", adminDto);
			map.put("signUpDto", signUpDto);
			map.put("userDto", userDto);
			
			list.add(map);
		}

		return list;
	}
}
