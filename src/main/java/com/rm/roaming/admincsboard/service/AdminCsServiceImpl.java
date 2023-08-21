package com.rm.roaming.admincsboard.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rm.roaming.admin.mapper.AdminSqlMapper;
import com.rm.roaming.admincsboard.mapper.AdminCsSqlMapper;
import com.rm.roaming.dto.AdminDto;
import com.rm.roaming.dto.CsNoticeDto;
import com.rm.roaming.dto.FaqCategoryDto;
import com.rm.roaming.dto.FaqDto;
import com.rm.roaming.dto.QaBoardDto;
import com.rm.roaming.dto.QaCategoryDto;
import com.rm.roaming.dto.UserDto;
import com.rm.roaming.user.mapper.UserSqlMapper;
import com.rm.roaming.usercsboard.mapper.UserCsSqlMapper;

@Service
public class AdminCsServiceImpl {
	
	@Autowired
	private AdminCsSqlMapper adminCsSqlMapper;
	
	@Autowired
	private UserCsSqlMapper userCsSqlMapper;
	
	@Autowired
	private UserSqlMapper userSqlMapper;
	
	@Autowired
	private AdminSqlMapper adminSqlMapper;
	
	//고객게시판 공지사항 목록 조회
	public List<Map<String, Object>> selectAllCsNotice() {
		
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

		// page 범위 QA게시글 조회해서 List에 담기
		List<CsNoticeDto> csNoticeDtoList = adminCsSqlMapper.selectAllCsNotice();
		
		for (CsNoticeDto csNoticeDto : csNoticeDtoList) {
			Map<String, Object> map = new HashMap<>();

			int admin_id = csNoticeDto.getAdmin_id();
			AdminDto adminDto = adminSqlMapper.selectByAdminId(admin_id);

			map.put("csNoticeDto", csNoticeDto);
			map.put("adminDto", adminDto);
			list.add(map);
		}
		return list;
	}
	// 메인페이지용 공지사항 목록 조회
	public List<CsNoticeDto> getMainCsNotice(){
		return adminCsSqlMapper.getMainCsNotice();
	}
	
	//  공지사항 게시글 내용 조회
	public Map<String,Object> getCsNoticePage(int id) {
		Map<String, Object> map = new HashMap<>();

		CsNoticeDto csNoticeById = adminCsSqlMapper.selectCsNoticeById(id);
		
		int admin_id = csNoticeById.getAdmin_id();
		AdminDto adminDto = adminSqlMapper.selectByAdminId(admin_id);
		
		map.put("CsNoticeDto", csNoticeById);
		map.put("adminDto", adminDto);
		
		
		return map;
	}
	
	// 공지사항 글쓰기
	public void insertCsNotice(CsNoticeDto params) {
		adminCsSqlMapper.insertCsNotice(params);
	}
	
	// 공지사항 조회수 증가
	public void increaseNoticeReadCount(int id) {
		adminCsSqlMapper.increaseNoticeReadCount(id);
	}
	
	// 공지사항 수정
	public void updateCsNotice(CsNoticeDto params) {
		
		adminCsSqlMapper.updateCsNotice(params);
	}
	
	// 공지사항 삭제
	public void deleteCsNoticeProcess(int id) {
		adminCsSqlMapper.deleteCsNotice(id);
	}
	
	//Faq 카테고리 조회
	public List<FaqCategoryDto> getFaqCategory(){
		return adminCsSqlMapper.selectFaqCategory();
	}
	
	//Faq 카테고리별로 조회
	public List<FaqDto> getFaqByCategoryId(int faq_category_id){
		return adminCsSqlMapper.selectFaqByCategoryId(faq_category_id);
	}
	
	//Faq 전체 조회
	public List<Map<String,Object>> getAllFaq(){
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		List<FaqDto> faqDtos = adminCsSqlMapper.selectAllFaq();
		
		for(FaqDto faqDto : faqDtos) {
			Map<String,Object> map = new HashMap<>();
			
			int adminId = faqDto.getAdmin_id();
			AdminDto adminDto = adminCsSqlMapper.selectAdminById(adminId);
			
			int faqCategoryId = faqDto.getFaq_category_id();
			FaqCategoryDto faqCategoryDto = adminCsSqlMapper.selectFaqCategoryById(faqCategoryId);
			
			map.put("faqDto", faqDto);
			map.put("adminDto", adminDto);
			map.put("faqCategoryDto", faqCategoryDto);
			
			list.add(map);
		}
		
		return list;
	}
	
	//Faq id로 조회
	public FaqDto getFaqById(int id) {
		
		return adminCsSqlMapper.selectFaqById(id);
	}
	
	//Faq 글 등록
	public void insertFaq(FaqDto params) {
		adminCsSqlMapper.insertFaq(params);
	}
	
	//QA 게시판 답변 쓰기.
	public void writeComment(QaBoardDto qaBoardDto) {
		adminCsSqlMapper.updateQaBoardAdminById(qaBoardDto);
	}
	
	//QA 처리중 답변 목록
	public List<Map<String, Object>> getAdminQaBoardProgress(int page) {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		//page 범위 QA 처리중 게시글 조회해서 List에 담기
		List<QaBoardDto> AdminQaBoardProgressList = adminCsSqlMapper.selectAdminQaBoardProgress(page);
		
		for(QaBoardDto qaProgress : AdminQaBoardProgressList) {
			Map<String, Object> map = new HashMap<>();
			
			int category_id = qaProgress.getQa_category_id();
			QaCategoryDto category = userCsSqlMapper.selectCategoryById(category_id);
			
			int user_id = qaProgress.getUser_id();
			UserDto user = userSqlMapper.selectByUserId(user_id);
			
			//최신(날짜차이 계산)
			int id = qaProgress.getId();
			int isRecent = userCsSqlMapper.recentQaBoardById(id);
			
			map.put("qaProgress", qaProgress);
			map.put("category", category);
			map.put("user", user);
			map.put("isRecent", isRecent);
			list.add(map);
		}
		
		return list;
	}
	
	// QA 처리중 게시글 페이징 갯수 조회
	public int getProgressCount() {
		return adminCsSqlMapper.getProgressCount();
	}
	
	
	//QA 처리완료 답변 목록
	public List<Map<String, Object>> getAdminQaBoardComplete(int page) {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		//page 범위 QA 처리중 게시글 조회해서 List에 담기
		List<QaBoardDto> AdminQaBoardCompleteList = adminCsSqlMapper.selectAdminQaBoardComplete(page);
		
		for(QaBoardDto qaComplete : AdminQaBoardCompleteList) {
			Map<String, Object> map = new HashMap<>();
			
			int category_id = qaComplete.getQa_category_id();
			QaCategoryDto category = userCsSqlMapper.selectCategoryById(category_id);
			
			int user_id = qaComplete.getUser_id();
			UserDto user = userSqlMapper.selectByUserId(user_id);
			
			//최신(날짜차이 계산)
			int id = qaComplete.getId();
			int isRecent = userCsSqlMapper.recentQaBoardById(id);
			
			map.put("qaComplete", qaComplete);
			map.put("category", category);
			map.put("user", user);
			map.put("isRecent", isRecent);
			list.add(map);
		}
		
		return list;
	}
	
	// QA 처리완료 게시글 페이징 갯수 조회
	public int getCompleteCount() {
		return adminCsSqlMapper.getCompleteCount();
	}

	public void deleteFaq(int id) {
		adminCsSqlMapper.deleteFaq(id);
	}
	
	
}
