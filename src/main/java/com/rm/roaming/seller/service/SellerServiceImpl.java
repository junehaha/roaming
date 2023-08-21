package com.rm.roaming.seller.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rm.roaming.dto.PointDto;
import com.rm.roaming.dto.SellerDto;
import com.rm.roaming.dto.UserDto;
import com.rm.roaming.seller.mapper.SellerSqlMapper;

@Service
public class SellerServiceImpl {
	@Autowired
	private SellerSqlMapper sellerSqlMapper;
	
	// seller 가입
	public void registerSeller(SellerDto sellerDto) {
		sellerSqlMapper.insertSeller(sellerDto);
	}
	
	//seller 로그인
	public SellerDto sellerLogin(SellerDto sellerDto) {
		return sellerSqlMapper.selectSellerByIdAndPw(sellerDto);
	}
	
	
	public int getSellerCountByUserId(String seller_id) {
		return sellerSqlMapper.selectSellerCountByUserId(seller_id);
	}
	public SellerDto selectSellerIdById(String seller_id) {
		SellerDto sellerDto = sellerSqlMapper.selectSellerIdById(seller_id);
		return sellerDto;
	}
	
	public void KakaoSellerRegister(SellerDto sellerDto) {
		sellerSqlMapper.insertSeller(sellerDto);
	}
	
	public int getSellerExist(SellerDto sellerDto) {
		return sellerSqlMapper.selectExistSeller(sellerDto);
	}
}
