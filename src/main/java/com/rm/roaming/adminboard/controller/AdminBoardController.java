package com.rm.roaming.adminboard.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.commons.text.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.rm.roaming.adminboard.service.AdminBoardServiceImpl;
import com.rm.roaming.admincsboard.service.AdminCsServiceImpl;
import com.rm.roaming.dto.AdminDto;
import com.rm.roaming.dto.CouponDto;
import com.rm.roaming.dto.ItemCategoryDto;
import com.rm.roaming.dto.ItemDto;
import com.rm.roaming.dto.ItemImageDto;
import com.rm.roaming.dto.QaBoardDto;
import com.rm.roaming.dto.SellerAuthorityDto;
import com.rm.roaming.dto.SellerNoticeBoardDto;
import com.rm.roaming.dto.UserDto;
import com.rm.roaming.dto.ZimDeliveryManageDto;
import com.rm.roaming.dto.ZimSignUpDto;
import com.rm.roaming.userzim.service.UserZimService;

@Controller
@RequestMapping("/adminboard/*")
public class AdminBoardController {

	@Autowired
	private AdminBoardServiceImpl adminBoardService;
	@Autowired
	private AdminCsServiceImpl adminCsService;
	@Autowired
	private UserZimService userZimService;

	
	
	// 관리자 메인페이지
	@RequestMapping("adminMainPage")
	public String adminMainPage() {
		
		return "adminboard/adminMainPage";
	}
	// 관리자 쿠폰관리 페이지
	@RequestMapping("manageCouponPage")
	public String manageCouponPage(Model model, @RequestParam(value = "page", defaultValue = "1") int page,  @RequestParam(value = "pageNum", defaultValue = "1") int pageNum) {
		
		List<Map<String, Object>> couponList = adminBoardService.getCouponList(page);
		int manageCouponCount = adminBoardService.manageCouponCount();
		int totalPage = (int)Math.ceil(manageCouponCount/3.0);
		
		int startPage = ((page-1)/3)*3 + 1;
		int endPage = ((page-1)/3+1)*3;
		
		if(endPage > totalPage) {
			endPage = totalPage;
		}
		
		model.addAttribute("couponList", couponList);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("currentPage", page);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		
		
		List<Map<String, Object>> notExistcouponList = adminBoardService.getNotExistCouponList(pageNum);
		int notExistManageCouponCount = adminBoardService.notExistManageCouponCount();
		int totalPage2 = (int)Math.ceil(notExistManageCouponCount/3.0);
		
		int startPage2 = ((pageNum-1)/3)*3 + 1;
		int endPage2 = ((pageNum-1)/3+1)*3;
		
		if(endPage2 > totalPage2) {
			endPage2 = totalPage2;
		}
		
		model.addAttribute("notExistcouponList", notExistcouponList);
		model.addAttribute("totalPage2", totalPage2);
		model.addAttribute("currentPage2", pageNum);
		model.addAttribute("startPage2", startPage2);
		model.addAttribute("endPage2", endPage2);
		
		return "adminboard/manageCouponPage";
		
		
	}
	
	// 관리자 쿠폰관리 페이지
    @RequestMapping("manageCouponPage2")
    public String manageCouponPage2(Model model, @RequestParam(value = "page", defaultValue = "1") int page,  @RequestParam(value = "pageNum", defaultValue = "1") int pageNum) {
       
       List<Map<String, Object>> couponList = adminBoardService.getCouponList(page);
       int manageCouponCount = adminBoardService.manageCouponCount();
       int totalPage = (int)Math.ceil(manageCouponCount/3.0);
       
       int startPage = ((page-1)/3)*3 + 1;
       int endPage = ((page-1)/3+1)*3;
       
       if(endPage > totalPage) {
          endPage = totalPage;
       }
       
       model.addAttribute("couponList", couponList);
       model.addAttribute("totalPage", totalPage);
       model.addAttribute("currentPage", page);
       model.addAttribute("startPage", startPage);
       model.addAttribute("endPage", endPage);
       
       
       List<Map<String, Object>> notExistcouponList = adminBoardService.getNotExistCouponList(pageNum);
       int notExistManageCouponCount = adminBoardService.notExistManageCouponCount();
       int totalPage2 = (int)Math.ceil(notExistManageCouponCount/3.0);
       
       int startPage2 = ((pageNum-1)/3)*3 + 1;
       int endPage2 = ((pageNum-1)/3+1)*3;
       
       if(endPage2 > totalPage2) {
          endPage2 = totalPage2;
       }
       
       model.addAttribute("notExistcouponList", notExistcouponList);
       model.addAttribute("totalPage2", totalPage2);
       model.addAttribute("currentPage2", pageNum);
       model.addAttribute("startPage2", startPage2);
       model.addAttribute("endPage2", endPage2);
       
       return "adminboard/manageCouponPage2";
       
       
    }
	
	
	// 쿠폰생성 프로세스
	@RequestMapping("produceCouponProcess")
	public String produceCouponProcess(HttpSession session, CouponDto couponDto, MultipartFile[] image) {
		
		if(image != null) {
			
			for(MultipartFile multipartFile : image) {
				
				if(multipartFile.isEmpty()) {
					continue;
				}
				
				String rootFolder = "/Users/su/Desktop/uploadFiles/";
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
				String today = sdf.format(new Date());
				
				File targetFolder = new File(rootFolder + today);
				
				if(!targetFolder.exists()) {
					targetFolder.mkdirs();
				}
				
				String fileName = UUID.randomUUID().toString();
				fileName += "_" + System.currentTimeMillis();
				
				String originalFileName = multipartFile.getOriginalFilename();
				
				String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
				
				String saveFileName = today + "/" + fileName + ext;
				
				try {
					multipartFile.transferTo(new File(rootFolder + saveFileName));
					
				}catch(Exception e) {
					e.printStackTrace();
				}
				
				couponDto.setCoupon_image(saveFileName);
			}
		}
		
		
		AdminDto sessionAdmin = (AdminDto)session.getAttribute("sessionAdmin");
		
		int adminId = sessionAdmin.getId();
		couponDto.setAdmin_id(adminId);
		
		adminBoardService.produceCoupon(couponDto);
		
		return "redirect:./manageCouponPage";	
	}
	
	// 쿠폰 삭제 프로세스
	@RequestMapping("deleteCouponProcess")
	public String deleteCouponProcess(CouponDto couponDto) {
		
		adminBoardService.deleteCoupon(couponDto);
		
		return "redirect:./manageCouponPage";
	}
	

	
	// 쿠폰 수정 프로세스
	@RequestMapping("updateCouponProcess")
	public String updateCouponProcess(CouponDto couponDto, MultipartFile[] image) {
		
		if(image != null) {
			
			for(MultipartFile multipartFile : image) {
				
				if(multipartFile.isEmpty()) {
					continue;
				}
				
				String rootFolder = "/Users/su/Desktop/uploadFiles/";
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
				String today = sdf.format(new Date());
				
				File targetFolder = new File(rootFolder + today);
				
				if(!targetFolder.exists()) {
					targetFolder.mkdirs();
				}
				
				String fileName = UUID.randomUUID().toString();
				fileName += "_" + System.currentTimeMillis();
				
				String originalFileName = multipartFile.getOriginalFilename();
				
				String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
				
				String saveFileName = today + "/" + fileName + ext;
				
				try {
					multipartFile.transferTo(new File(rootFolder + saveFileName));
					
				}catch(Exception e) {
					e.printStackTrace();
				}
				
				couponDto.setCoupon_image(saveFileName);
			}
		}
		
		
		
		adminBoardService.updateCoupon(couponDto);
		
		return "redirect:./manageCouponPage";
	}
	
	
	
	// 상품등록 프로세스
	@RequestMapping("itemRegisterProcess")
	public String itemRegisterProcess(HttpSession session, ItemDto itemDto, @RequestParam("images") MultipartFile[] image, @RequestParam("item_thumbnails") MultipartFile[] item_thumbnail) {
		
		List<ItemImageDto> itemImageDtoList = new ArrayList<>();
		
		if(image != null) {
			
			for(MultipartFile multipartFile : image) {
				
				if(multipartFile.isEmpty()) {
					continue;
				}
				
				String rootFolder = "/Users/su/Desktop/uploadFiles/";
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
				String today = sdf.format(new Date());
				
				File targetFolder = new File(rootFolder + today);
				
				if(!targetFolder.exists()) {
					targetFolder.mkdirs();
				}
				
				String fileName = UUID.randomUUID().toString();
				fileName += "_" + System.currentTimeMillis();
				
				String originalFileName = multipartFile.getOriginalFilename();
				
				String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
				
				String saveFileName = today + "/" + fileName + ext;
				
				try {
					multipartFile.transferTo(new File(rootFolder + saveFileName));
					
				}catch(Exception e) {
					e.printStackTrace();
				}
				
				ItemImageDto itemImageDto = new ItemImageDto();
				itemImageDto.setImage(saveFileName);
				
				itemImageDtoList.add(itemImageDto);
			}
		}
		
		
		if(item_thumbnail != null) {
			
			for(MultipartFile multipartFile : item_thumbnail) {
				
				if(multipartFile.isEmpty()) {
					continue;
				}
				
				String rootFolder = "/Users/su/Desktop/uploadFiles/";
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
				String today = sdf.format(new Date());
				
				File targetFolder = new File(rootFolder + today);
				
				if(!targetFolder.exists()) {
					targetFolder.mkdirs();
				}
				
				String fileName = UUID.randomUUID().toString();
				fileName += "_" + System.currentTimeMillis();
				
				String originalFileName = multipartFile.getOriginalFilename();
				
				String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
				
				String saveFileName = today + "/" + fileName + ext;
				
				try {
					multipartFile.transferTo(new File(rootFolder + saveFileName));
					
				}catch(Exception e) {
					e.printStackTrace();
				}
		
				
				itemDto.setItem_thumbnail(saveFileName);
				
			}
		

		}
			
			AdminDto sessionAdmin = (AdminDto)session.getAttribute("sessionAdmin");
			
			int adminId = sessionAdmin.getId();
			itemDto.setAdmin_id(adminId);
			
			adminBoardService.itemRegister(itemDto, itemImageDtoList);
			
			
			return "redirect:./manageItemPage";
	}
	
	// 상품관리 조회
		@RequestMapping("manageItemPage")
		public String manageItemPage(Model model) {
			
			List<Map<String, Object>> itemList = adminBoardService.getItemList();
			List<ItemCategoryDto> category = adminBoardService.getCategory();
			
			model.addAttribute("itemList", itemList);
			model.addAttribute("category", category);
			
			
			return "adminboard/manageItemPage";
		}
	
	// 상품삭제
		@RequestMapping("deleteItemProcess")
		public String deleteItemProcess(int id) {
			
			adminBoardService.deleteItem(id);
			
			return "redirect:./manageItemPage";
		}
		
		
	// 상품수정 프로세스
		@RequestMapping("updateItemProcess")
		public String updateItemProcess(ItemDto itemDto, ItemImageDto itemImageDto, @RequestParam("images") MultipartFile[] image, @RequestParam("item_thumbnails") MultipartFile[] item_thumbnail ) {
			
			if(image != null) {
				
				for(MultipartFile multipartFile : image) {
					
					if(multipartFile.isEmpty()) {
						continue;
					}
					
					String rootFolder = "/Users/su/Desktop/uploadFiles/";
					
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
					String today = sdf.format(new Date());
					
					File targetFolder = new File(rootFolder + today);
					
					if(!targetFolder.exists()) {
						targetFolder.mkdirs();
					}
					
					String fileName = UUID.randomUUID().toString();
					fileName += "_" + System.currentTimeMillis();
					
					String originalFileName = multipartFile.getOriginalFilename();
					
					String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
					
					String saveFileName = today + "/" + fileName + ext;
					
					try {
						multipartFile.transferTo(new File(rootFolder + saveFileName));
						
					}catch(Exception e) {
						e.printStackTrace();
					}
					
					
					itemImageDto.setImage(saveFileName);
					
				}
			}
			
			
			if(item_thumbnail != null) {
				
				for(MultipartFile multipartFile : item_thumbnail) {
					
					if(multipartFile.isEmpty()) {
						continue;
					}
					
					String rootFolder = "/Users/su/Desktop/uploadFiles/";
					
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
					String today = sdf.format(new Date());
					
					File targetFolder = new File(rootFolder + today);
					
					if(!targetFolder.exists()) {
						targetFolder.mkdirs();
					}
					
					String fileName = UUID.randomUUID().toString();
					fileName += "_" + System.currentTimeMillis();
					
					String originalFileName = multipartFile.getOriginalFilename();
					
					String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
					
					String saveFileName = today + "/" + fileName + ext;
					
					try {
						multipartFile.transferTo(new File(rootFolder + saveFileName));
						
					}catch(Exception e) {
						e.printStackTrace();
					}
			
					
					itemDto.setItem_thumbnail(saveFileName);
					
				}
			}
			
			adminBoardService.updateItem(itemDto);
			adminBoardService.updateItemImage(itemImageDto);
			
			return "redirect:./manageItemPage";
		}
	
		// 판매자 공지사항 게시판 등록
		@RequestMapping("writeSellerNoticePage")
		public String writeSellerNoticePage() {
			
			return "adminboard/writeSellerNoticePage";
			
		}
		
		// 판매자 공지사항 게시판 등록 프로세스
		@RequestMapping("writeSellerNoticeProcess")
		public String writeSellerNoticeProcess(HttpSession session, SellerNoticeBoardDto sellerNoticeBoardDto) {
			
			AdminDto sessionAdmin = (AdminDto)session.getAttribute("sessionAdmin");
			
			int adminId = sessionAdmin.getId();
			sellerNoticeBoardDto.setAdmin_id(adminId);
			
			adminBoardService.writeSellerNotice(sellerNoticeBoardDto);
			
			return "redirect:./sellerNoticePage";
		}
		
		// 판매자 공지사항 게시판 리스트
		@RequestMapping("sellerNoticePage")
		public String sellerNoticePage(Model model) {
			
			List<Map<String, Object>> list = adminBoardService.getSellerNoticeList();
			
			model.addAttribute("list", list);
			
			return "adminboard/sellerNoticePage";
		}
		
		// 판매자 공지사항 게시판 글 조회
		@RequestMapping("readSellerNoticePage")
		public String readSellerNoticePage(Model model, int id) {
			
			adminBoardService.increaseReadCount(id);
			
			Map<String, Object> map = adminBoardService.getSellerNotice(id);
			
			model.addAttribute("data", map);
			
			return "adminboard/readSellerNoticePage";
		}
		
		// 판매자 공지사항 게시판 게시글 삭제
		@RequestMapping("deleteSellerNoticeProcess")
		public String deleteSellerNoticeProcess(int id) {
			
			adminBoardService.deleteSellerNotice(id);
			
			return "redirect:./sellerNoticePage";
		}
		
		// 판매자 공지사항 게시판 게시글 수정 프로세스
		@RequestMapping("updateSellerNoticeProcess")
		public String updateSellerNoticeProcess(SellerNoticeBoardDto sellerNoticeBoardDto) {
			
			adminBoardService.updateSellerNotice(sellerNoticeBoardDto);
			
			return "redirect:./sellerNoticePage";
		}
		
		// 판매자 공지사항 게시판 게시글 수정 페이지
		@RequestMapping("updateSellerNoticePage")
		public String updateSellerNoticePage(Model model, int id) {
			
			Map<String, Object> map = adminBoardService.getSellerNotice(id);
			model.addAttribute("data", map);
			
			return "adminboard/updateSellerNoticePage";
		}
		
		// 판매자 권한관리 게시판 리스트 
		@RequestMapping("hotelDocuPage")
		public String hotelDocuPage(Model model) {
			
			
			model.addAttribute("list", adminBoardService.getHotelDocuList());
			
			
			return "adminboard/hotelDocuPage";
		}
		
		// 판매자 신청관리 게시판 수락 업데이트
		@RequestMapping("updateSellerAuthorityAcceptProcess")
		public String updateSellerAuthorityAcceptProcess(SellerAuthorityDto sellerAuthorityDto) {
			
			adminBoardService.updateSellerAuthorityAccept(sellerAuthorityDto);
			
			return "redirect:./hotelDocuPage";
		}
		
		// 판매자 신청관리 게시판 거절 업데이트
		@RequestMapping("updateSellerAuthorityRefuseProcess")
		public String updateSellerAuthorityRefuseProcess(SellerAuthorityDto sellerAuthorityDto) {
			
			adminBoardService.updateSellerAuthorityRefuse(sellerAuthorityDto);
			
			return "redirect:./hotelDocuPage";
		}
		
		// 관리자 대쉬보드 페이지
		   @RequestMapping("adminDashBoardPage")
		   public String adminDashBoardPage(Model model, @RequestParam(value="page", defaultValue = "1" )  int page) {
		      
		      //처리중 QA게시글 목록
		      List<Map<String,Object>> qaProgressList= adminCsService.getAdminQaBoardProgress(page);
		      
		      //html escape & enter
		      for(Map<String,Object> qaProgressBoards : qaProgressList) {
		         QaBoardDto qaProgressBoard = (QaBoardDto) qaProgressBoards.get("qaProgress");
		         String qa_title = qaProgressBoard.getQa_title();
		         
		         qa_title = StringEscapeUtils.escapeHtml4(qa_title);
		         
		         qaProgressBoard.setQa_title(qa_title);
		      }
		      
		      model.addAttribute("qaProgressList", qaProgressList);
		      
		      
		      
		      
		      // 날짜 가져오기
		      Date today = adminBoardService.getToday();
		      
		      // 일일 숙소 예약수
		      int TodayReserveCount = adminBoardService.getTodayReserveCount();
		      // 일일 숙소 매출
		      int TodayReserveSale = adminBoardService.getTodayReserveSale();
		      

		      // 일일 짐서비스 예약수
		      int TodayZimCount = adminBoardService.getTodayZimCount();
		      // 일일 짐서비스 매출
		      int TodayZimSale = adminBoardService.getTodayZimSale();

		      
		      // 구매된 포인트샵 상품수
		      int TodayItemCount = adminBoardService.getTodayItemCount();
		      // 오늘 포인트 사용
		      int TodayPointUsed = adminBoardService.getTodayPointUsed();
		      
		      // 처리중 문의게시글
		      int QaNotAnswered = adminBoardService.getQaNotAnswered();

		      model.addAttribute("today", today);
		      model.addAttribute("TodayReserveCount", TodayReserveCount);
		      model.addAttribute("TodayReserveSale", TodayReserveSale);
		      model.addAttribute("TodayZimCount", TodayZimCount);
		      model.addAttribute("TodayZimSale", TodayZimSale);
		      model.addAttribute("TodayItemCount", TodayItemCount);
		      model.addAttribute("TodayPointUsed", TodayPointUsed);
		      model.addAttribute("QaNotAnswered", QaNotAnswered);
		      
		      return "adminboard/adminDashBoardPage";
		   }
		
		
		
		//짐 관리 페이지
		@RequestMapping("adminZimPage")
		public String adminZimPage(Model model) {
			
			 // 짐 배송 관리 이력 출력
			 List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
			 
			 List<ZimSignUpDto> signUpLists = userZimService.getAllZimSignUp();
			 
			 for(ZimSignUpDto signUpDto : signUpLists) {
				 Map<String,Object> map = new HashMap<>();
				 int userId = signUpDto.getUser_id();
				 UserDto userDto = userZimService.getUserById(userId);
				 map.put("signUpDto", signUpDto);
				 map.put("userDto", userDto);
				 
				 list.add(map);
			 }
			 
			 // 변경 이력 출력
			 List<Map<String, Object>> changeList = userZimService.getZimProgressChange();
			 
			 model.addAttribute("changeList", changeList);
			 model.addAttribute("list", list);
			
			return "adminboard/adminZimPage";
		}
		
		// 짐 배송상태 업데이트
		@RequestMapping("updateZimProgress")
		public String updateZimProgress(HttpSession session, ZimSignUpDto params) {
			
			AdminDto adminDto = (AdminDto) session.getAttribute("sessionAdmin");
			ZimDeliveryManageDto zimDto = new ZimDeliveryManageDto();
			ZimSignUpDto zimSignUpDto = userZimService.getZimSignUp(params.getId());
			
			
			if (adminDto == null) {
				return "redirect:../adminboard/adminZimPage";
			}
			
			userZimService.updateZimProgress(params);
			
			
			int admin_id = adminDto.getId();
			int zim_signup_id = params.getId();
			String zim_prog_before = zimSignUpDto.getZim_progress();
			String zim_prog_after = params.getZim_progress();
			
			zimDto.setAdmin_id(admin_id);
			zimDto.setZim_signup_id(zim_signup_id);
			zimDto.setZim_prog_before(zim_prog_before);
			zimDto.setZim_prog_after(zim_prog_after);
			
			userZimService.insertZimDeliveryManage(zimDto);
			
			return "redirect:../adminboard/adminZimPage";
		}
		
		
		// 신고 관리 페이지
		@RequestMapping("adminReportPage")
		public String adminReportPage(Model model) {
			
			List<Map<String,Object>> reportList = adminBoardService.getAllReport();
			model.addAttribute("reportList", reportList);
			
			return "adminboard/adminReportPage";
		}
		
		// 신고된 게시물 삭제 프로세스
		@RequestMapping("adminDeleteReportProcess")
		public String adminDeleteReportProcess(int id) {
			adminBoardService.deleteReportedPost(id);
			
			return "redirect:../adminboard/adminReportPage";
		}
		
		
		
		
		
		
		
		
}
