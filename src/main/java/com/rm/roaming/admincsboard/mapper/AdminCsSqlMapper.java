package com.rm.roaming.admincsboard.mapper;

import java.util.List;

import com.rm.roaming.dto.AdminDto;
import com.rm.roaming.dto.CsNoticeDto;
import com.rm.roaming.dto.FaqCategoryDto;
import com.rm.roaming.dto.FaqDto;
import com.rm.roaming.dto.QaBoardDto;

public interface AdminCsSqlMapper {
	
	// 공지사항 목록 조회
	public List<CsNoticeDto> selectAllCsNotice();
	
	// 공지사항 글 조회
	public CsNoticeDto selectCsNoticeById(int id);
	
	// 공지사항 글쓰기
	public void insertCsNotice(CsNoticeDto params);

	// 공지사항 수정
	public void updateCsNotice(CsNoticeDto params);
	
	// 공지사항 삭제
	public void deleteCsNotice(int id);
	
	// 공지사항 조회수
	public void increaseNoticeReadCount(int id);
	
	// 메인용 공지사항 글 조회
	public List<CsNoticeDto> getMainCsNotice();

	
	// Faq 전체 조회
	public List<FaqDto> selectAllFaq();
	
	// Faq id로 조회
	public FaqDto selectFaqById(int id);
	
	// Faq 카테고리 모두 조회
	public List<FaqCategoryDto> selectFaqCategory();
	
	// Faq 카테고리 id로 카테고리 조회
	public FaqCategoryDto selectFaqCategoryById(int id);
	
	// Faq 카테고리로 조회
	public List<FaqDto>selectFaqByCategoryId(int faq_category_id);
	
	// Faq 글 등록 insert
	public void insertFaq(FaqDto params);
	
	// Faq 글 삭제
	public void deleteFaq(int id);
	
	// 관리자 정보 조회
	public AdminDto selectAdminById(int id);

	
	//QA 관리자 답변 업데이트. 
	public void updateQaBoardAdminById(QaBoardDto qaBoardDto);
	
	//QA 처리중 답변 목록
	public List<QaBoardDto> selectAdminQaBoardProgress(int page);
	public int getProgressCount();
	
	//QA 처리완료 답변 목록
	public List<QaBoardDto> selectAdminQaBoardComplete(int page);
	public int getCompleteCount();


	




}
