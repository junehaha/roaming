package com.rm.roaming.user.mapper;


import com.rm.roaming.dto.PointDto;
import com.rm.roaming.dto.UserDto;

public interface UserSqlMapper {
	
	// 영수
	// pk 추가
	public int createUserPk();
	// 온도 인서트
	public void insertTemp(int user_id);
	// 영수
	
	
	
	// 회원가입
	public void insertUser(UserDto userDto);
	// 로그인
	public UserDto selectByUserIdAndPw(UserDto userDto);
	// 유저 고유ID 
	public UserDto selectByUserId(int id);
	// 유저 user_name
	public UserDto selectByUserName(String user_name);
	// 로그인 하면 포인트 획득
	public void insertLoginPoint(PointDto pointDto);
	// 유저 정보 수정
	public void updateUserInfo(UserDto userDto);
	
	public UserDto selectUserIdById(String user_id);
	public int selectUserCountByUserId(String user_id);
	public int getLoginCount(int user_id);
	
	public int selectExistUser(UserDto userDto);
	
	// 득균
	// 닉네임 중복 체크
	public int countByUserId(String userId);
	
	
}
