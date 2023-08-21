package com.rm.roaming.seller.mapper;

import com.rm.roaming.dto.PointDto;
import com.rm.roaming.dto.SellerDto;
import com.rm.roaming.dto.UserDto;

public interface SellerSqlMapper {
	// seller 가입
	public void insertSeller(SellerDto sellerDto);
	// seller 로그인
	public SellerDto selectSellerByIdAndPw(SellerDto sellerDto);
	
	
	public SellerDto selectSellerIdById(String seller_id);
	public int selectSellerCountByUserId(String seller_id);
	
	public int selectExistSeller(SellerDto sellerDto);
}
