package com.rm.roaming.admincsboard.controller;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.text.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.rm.roaming.admincsboard.service.AdminCsServiceImpl;
import com.rm.roaming.dto.AdminDto;
import com.rm.roaming.dto.CsNoticeDto;
import com.rm.roaming.dto.FaqCategoryDto;
import com.rm.roaming.dto.FaqDto;
import com.rm.roaming.dto.QaBoardDto;
import com.rm.roaming.usercsboard.service.UserCsServiceImpl;

@Controller
@RequestMapping("/admincsboard/*")
public class AdminCsController {
	
	@Autowired
	private AdminCsServiceImpl adminCsService;
	
	@Autowired
	private UserCsServiceImpl userCsService;
	
	//관리자 메인 페이지
	@RequestMapping("adminMainPage")
	public String adminMainPage() {
		
		return "admincsboard/adminMainPage";
	}
	
	//관리자 고객 공지사항 페이지
	@RequestMapping("adminCsNoticePage")
	public String adminCsNoticePage(Model model) {
		List<Map<String,Object>> noticeList = adminCsService.selectAllCsNotice();
		model.addAttribute("noticeList", noticeList);
		return "admincsboard/adminCsNoticePage";
	}
	
	//관리자 고객 공지사항 읽기 페이지
	@RequestMapping("adminReadCsNoticePage")
	public String adminReadCsNoticePage(int id, Model model) {
		Map<String,Object> nPageContent = adminCsService.getCsNoticePage(id);
		model.addAttribute("nPageContent", nPageContent);
		
		return "admincsboard/adminReadCsNoticePage";
	}
	
	//관리자 고객 공지사항 글쓰기 페이지
	@RequestMapping("adminWriteCsNoticePage")
	public String adminWriteCsNoticePage() {
		
		return "admincsboard/adminWriteCsNoticePage";
	}
	
	//관리자 고객 공지사항 글쓰기 프로세스
	@RequestMapping("adminWriteCsNoticeProcess")
	public String adminWriteCsNoticeProcess(CsNoticeDto params) {
		adminCsService.insertCsNotice(params);
		return "redirect:../admincsboard/adminCsNoticePage";
	}
	
	//관리자 고객 공지사항 수정 페이지
	@RequestMapping("adminUpdateCsNoticePage")
	public String adminUpdateCsNoticePage(int id, Model model) {
		Map<String,Object> nPageContent = adminCsService.getCsNoticePage(id);
		model.addAttribute("nPageContent", nPageContent);
		
		return "admincsboard/adminUpdateCsNoticePage";
	}
	
	//관리자 고객 공지사항 수정 프로세스
	@RequestMapping("adminUpdateCsNoticeProcess")
	public String adminUpdateCsNoticeProcess(CsNoticeDto params) {

		adminCsService.updateCsNotice(params);
		return "redirect:../admincsboard/adminCsNoticePage";
		
	}
	
	//관리자 고객 공지사항 삭제 프로세스
	@RequestMapping("deleteCsNoticeProcess")
	public String deleteCsNoticeProcess(int id) {
		adminCsService.deleteCsNoticeProcess(id);
		return "redirect:../admincsboard/adminCsNoticePage";
	}
	
	//관리자 자주묻는질문Faq 페이지
	@RequestMapping("adminFaqPage")
	public String adminFaqPage(Model model) {
		
		List<Map<String,Object>> lists = adminCsService.getAllFaq();
		
		model.addAttribute("lists", lists);
		
		return "admincsboard/adminFaqPage";
	}
	
	//관리자 자주묻는질문Faq 글쓰기
	@RequestMapping("adminWriteFaqPage")
	public String adminWriteFaqPage(HttpSession session, Model model) {
		
		AdminDto adminDto = (AdminDto)session.getAttribute("sessionAdmin");
		if(adminDto != null) {
		
		List<FaqCategoryDto> faqCategory = adminCsService.getFaqCategory();
		model.addAttribute("faqCategory", faqCategory);
		model.addAttribute("adminDto", adminDto);
		
		return "admincsboard/adminWriteFaqPage";
		}else {
		return "redirect:../admincsboard/adminFaqPage";}
	}
	
	
	
	//
	// 관리자 자주묻는 질문 Faq 글쓰기 프로세스
	@RequestMapping("adminWriteFaqProcess")
	public String adminWriteFaqProcess(FaqDto params) {
		adminCsService.insertFaq(params);
		return "redirect:../admincsboard/adminFaqPage";
	}
	
	// 관리자 자주묻는 질문 Faq 글읽기 page
	@RequestMapping("adminReadFaqPage")
	public String adminReadFaqPage(int id, Model model) {
		
		FaqDto faqDto = adminCsService.getFaqById(id);
		
		model.addAttribute("faqDto", faqDto);
		
		return "admincsboard/adminReadFaqPage";
	}
	
	// 관리자 자주묻는 질문 Faq 글삭제 프로세스
	@RequestMapping("adminDeleteFaqProcess")
	public String adminDeleteFaqProcess(int id) {
		
		adminCsService.deleteFaq(id);
		
		return "redirect:../admincsboard/adminFaqPage";
	}
	
	//관리자 처리중 QA게시글 목록
	@RequestMapping("adminQaBoardProgressPage")
	public String adminQaBoardProgressPage(Model model, @RequestParam(value="page", defaultValue = "1" )  int page) {
		
		//처리중 QA게시글 목록
		List<Map<String,Object>> qaProgressList= adminCsService.getAdminQaBoardProgress(page);
		
		//html escape & enter
		for(Map<String,Object> qaProgressBoards : qaProgressList) {
			QaBoardDto qaProgressBoard = (QaBoardDto) qaProgressBoards.get("qaProgress");
			String qa_title = qaProgressBoard.getQa_title();
			
			qa_title = StringEscapeUtils.escapeHtml4(qa_title);
			
			qaProgressBoard.setQa_title(qa_title);
		}
		
		//페이징
		int qaProgressCount = adminCsService.getProgressCount();
		int totalPage = (int) Math.ceil(qaProgressCount/5.0);
		
		int startPage = ((page-1)/5)*5 + 1;
		int endPage = ((page-1)/5)*5 + 5;
		
		if(endPage > totalPage) {
			endPage = totalPage;
		}
		
		model.addAttribute("qaProgressList", qaProgressList);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("currentPage", page);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		
		//처리완료 QA게시글 목록
		List<Map<String,Object>> qaCompleteList= adminCsService.getAdminQaBoardComplete(page);
		
		//html escape & enter
		for(Map<String,Object> qaCompleteBoards : qaCompleteList) {
			QaBoardDto qaCompleteBoard = (QaBoardDto) qaCompleteBoards.get("qaComplete");
			String qa_title = qaCompleteBoard.getQa_title();
			
			qa_title = StringEscapeUtils.escapeHtml4(qa_title);
			
			qaCompleteBoard.setQa_title(qa_title);
		}
		
		model.addAttribute("qaCompleteList", qaCompleteList);
		
		
		return "admincsboard/adminQaBoardProgressPage";
		}
	
	//관리자 처리완료 QA게시글 목록
	@RequestMapping("adminQaBoardCompletePage")
	public String adminQaBoardCompletePage(Model model, @RequestParam(value="page", defaultValue = "1" ) int page) {
		List<Map<String,Object>> qaCompleteList= adminCsService.getAdminQaBoardComplete(page);
		
		//html escape & enter
		for(Map<String,Object> qaCompleteBoards : qaCompleteList) {
			QaBoardDto qaCompleteBoard = (QaBoardDto) qaCompleteBoards.get("qaComplete");
			String qa_title = qaCompleteBoard.getQa_title();
			
			qa_title = StringEscapeUtils.escapeHtml4(qa_title);
			
			qaCompleteBoard.setQa_title(qa_title);
		}
		
		//페이징
		int qaCompleteCount = adminCsService.getCompleteCount();
		int totalPage = (int) Math.ceil(qaCompleteCount/5.0);
		
		int startPage = ((page-1)/5)*5 + 1;
		int endPage = ((page-1)/5)*5 + 5;
		
		if(endPage > totalPage) {
			endPage = totalPage;
		}
		
		model.addAttribute("qaCompleteList", qaCompleteList);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("currentPage", page);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		
	return "admincsboard/adminQaBoardCompletePage";
	}
	
	//관리자 QA게시글 답변 쓰기 Page.
	@RequestMapping("writeCommentPage")
	public String writeCommentPage(Model model, int id) {
		Map<String,Object> qaContent = userCsService.getQaBoard(id);
		
		model.addAttribute("qaContent", qaContent);
		
		return "admincsboard/writeCommentPage";
	}
	
	//관리자 QA게시글 답변 Process
	@RequestMapping("writeCommentProcess")
	public String writeCommentProcess(HttpSession session, QaBoardDto qaBoardDto) {
		AdminDto adminDto = (AdminDto) session.getAttribute("sessionAdmin");
		qaBoardDto.setAdmin_id(adminDto.getId());
		adminCsService.writeComment(qaBoardDto);
		return "redirect:../admincsboard/adminQaBoardProgressPage";
	}
	
}
