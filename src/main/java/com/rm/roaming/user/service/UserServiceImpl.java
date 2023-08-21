package com.rm.roaming.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rm.roaming.dto.PointDto;
import com.rm.roaming.dto.UserDto;
import com.rm.roaming.user.mapper.UserSqlMapper;
import com.rm.roaming.userboard.mapper.UserBoardSqlMapper;

@Service
public class UserServiceImpl {
	@Autowired
	private UserSqlMapper userSqlMapper;
	@Autowired
	private UserBoardSqlMapper userBoardSqlMapper;

	// userRegister 수정 - 매너온도
	public void userRegister(UserDto userDto) {
		int userPk = userSqlMapper.createUserPk();
		userDto.setId(userPk);
		userSqlMapper.insertUser(userDto);
		userSqlMapper.insertTemp(userPk);
	}
	
	
	
	//로그인
	public UserDto getUserInfo(UserDto userDto) {
		UserDto user = userSqlMapper.selectByUserIdAndPw(userDto);
		
		PointDto pointDto = new PointDto();
		pointDto.setUser_id(user.getId());
		
		
		if(userSqlMapper.getLoginCount(user.getId()) == 0) {
			System.out.println("count : " + userSqlMapper.getLoginCount(user.getId()));
			userSqlMapper.insertLoginPoint(pointDto);
		}
		
		
		return user; 
	}
	
	//유저 정보 수정
	public void updateUserInfo(UserDto userDto) {
		
		userSqlMapper.updateUserInfo(userDto);
		
	}
	
	public UserDto getUserId(int id) {
		
		UserDto userDto = userSqlMapper.selectByUserId(id);
		
		return userDto;
	}
	public UserDto selectUserIdById(String user_id) {
		UserDto userDto = userSqlMapper.selectUserIdById(user_id);
		PointDto pointDto = new PointDto();
		pointDto.setUser_id(userDto.getId());
		if(userSqlMapper.getLoginCount(userDto.getId()) == 0) {
			System.out.println("count : " + userSqlMapper.getLoginCount(userDto.getId()));
			userSqlMapper.insertLoginPoint(pointDto);
		}
		return userDto;
	}
	public int getUserCountByUserId(String user_id) {
		return userSqlMapper.selectUserCountByUserId(user_id);
	}
	public void KakaoUserRegister(UserDto userDto) {
		userSqlMapper.insertUser(userDto);
	}
	public int getUserExist(UserDto userDto) {
		return userSqlMapper.selectExistUser(userDto);
	}
	
	
	
	// 득균
	public boolean existsUserId(String userId) {
		int count = userSqlMapper.countByUserId(userId);

		if(count>0) { 
			return true;
		}else{
			return false;
		}
	}
}
