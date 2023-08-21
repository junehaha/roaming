package com.rm.roaming.userzim.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.rm.roaming.dto.UserDto;
import com.rm.roaming.dto.ZimCategoryDto;
import com.rm.roaming.dto.ZimReviewDto;
import com.rm.roaming.dto.ZimSignCateListDto;
import com.rm.roaming.dto.ZimSignUpDto;
import com.rm.roaming.userzim.service.UserZimService;

@RequestMapping("/userzim/*")
@Controller
public class UserZimController {
	
	@Autowired
	private UserZimService userZimService;
	
	// 짐 메인 페이지
	@RequestMapping("zimMainPage")
	public String zimMainPage(Model model) {
		
		List<Map<String, Object>> EightReview = userZimService.getEightZimReview();
		
		double avgStar = userZimService.getZimAverageStar();
		
		model.addAttribute("avgStar", avgStar);
		model.addAttribute("EightReview", EightReview);
		return "userzim/zimMainPage";
	}
	
	// 짐 신청(날짜, 장소) 입력 페이지
	@RequestMapping("zimSignFirstPage")
	public String zimSignFirstPage(HttpSession session, Model model) {
		
		UserDto userDto = (UserDto) session.getAttribute("sessionUser");
		if(userDto != null) {
		int userId = userDto.getId();
		
		String totalAddress = userZimService.getReservedAddresss(userId);
		model.addAttribute("totalAddress", totalAddress);
		
		return "userzim/zimSignFirstPage";
		}else {
		return "user/loginPage";
		}
	}

	// 짐 신청(날짜, 장소) DB 입력 프로세스
	@RequestMapping("zimSignFirstProcess")
	public String zimSignFirstProcess(HttpSession session, ZimSignUpDto params, MultipartFile zimImage) {

		// 메인 파일 저장 로직
		if(!zimImage.isEmpty()) {
			
			System.out.println("파일명 : " + zimImage.getOriginalFilename());
			
			String rootFolder = "/Users/su/Desktop/uploadFiles/";
			
			// 메인 날짜별 폴더 생성 로직
			
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
				String today= sdf.format(new Date());
				
				File targetFolder = new File(rootFolder+today); // C:/uploadMainFiles/2023/06/02
				
				if(!targetFolder.exists()) {
					targetFolder.mkdirs(); //mkdir말고 mkdirs해야 다만들어줌.
				}
				
				// 메인 파일 저장 파일명 만들기. 
				
				String fileName = UUID.randomUUID().toString();
				fileName += "_" + System.currentTimeMillis();
				
				// 확장자 추출
				String originalFileName = zimImage.getOriginalFilename();
				
				String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
				
				String saveFileName = today + "/" + fileName + ext;
				
						
			// 메인 파일 저장 파일명 만들기.
			try {
				zimImage.transferTo(new File(rootFolder + saveFileName)); //transfer to 어디파일로 저장하겠다.
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			params.setZim_image_link(saveFileName);
		}		
		

		UserDto sessionUser = (UserDto) session.getAttribute("sessionUser");
		
		if(sessionUser != null) {
		params.setUser_id(sessionUser.getId());
		
		int id = userZimService.createPK();
		params.setId(id);
		
		userZimService.insertZimSignUp(params);
		
		return "redirect:../userzim/zimSignSecondPage?id="+id;
		}else {
		return "userzim/zimMainPage";
		}
		
	}
	
	// 짐 신청(종류 및 수량) 입력 페이지
	@RequestMapping("zimSignSecondPage")
	public String zimSignSecondPage(Model model,int id) {
		List<ZimCategoryDto> zimCategory = userZimService.getZimCategory();
		
		model.addAttribute("zimCategory", zimCategory);
		model.addAttribute("id",id);
		
		return "userzim/zimSignSecondPage";
	}
	
	// 짐 신청(종류 및 수량) DB입력 프로세스
	@RequestMapping("zimSignSecondProcess")
	public String zimSignSecondProcess(int id, @RequestParam("zim_category_id") int[] zimCategoryIds,
									  @RequestParam("zim_amount") int[] zimAmounts) {
		
		ArrayList<ZimSignCateListDto> list = new ArrayList<>();
		
		if(zimCategoryIds == null) {
			return "redirect:../userzim/zimSignSecondPage";
		}
		
		for(int i=0; i<zimCategoryIds.length; i++) {
			if(zimCategoryIds[i]!=0) {
			ZimSignCateListDto dto = new ZimSignCateListDto();
			dto.setZim_category_id(zimCategoryIds[i]);
			dto.setZim_amount(zimAmounts[i]);
			list.add(dto);
			}
		}
		
		userZimService.insertZimCategoryList(id,list);
		
		return "redirect:../userzim/zimSignFinalPage?id="+id;
	}
	
	// 신청 확인 페이지
	@RequestMapping("zimSignFinalPage")
	public String zimSignFinalPage(Model model, int id) {
		
		ZimSignUpDto signUpDto = userZimService.getZimSignUp(id);
		int userId = signUpDto.getUser_id();
		UserDto userDto = userZimService.getUserById(userId);
		
		List<Map<String,Object>> signCateList = userZimService.getZimSignCateList(id);
		String total = userZimService.totalSum(id);
		
		
		
		model.addAttribute("userDto", userDto);
		
		model.addAttribute("signUpDto", signUpDto);
		model.addAttribute("signCateList", signCateList);
		model.addAttribute("total", total);
		
		return "userzim/zimSignFinalPage";
	}
	
	// 신청 취소
	@RequestMapping("cancelZimSignUpProcess")
	public String cancelZimSignUpProcess(int id) {
		userZimService.cancelZimSignUp(id);
		userZimService.cancelZimSignAndCategory(id);
		return "redirect:../userboard/userZimInfoPage";
	}
	
	// 접수 취소
	@RequestMapping("cancelMyZimSignUp")
	public String cancelMyZimSignUp(int id) {
		userZimService.cancelZimSignUp(id);
		userZimService.cancelZimSignAndCategory(id);
		return "redirect:../userboard/userZimInfoPage";
	}
	
	// 결제, 신청 완료
	@RequestMapping("completeZimSignUpPage")
	public String completeZimSignUpPage(int id, Model model) {
		
		int signUpId = id;
		
		
		model.addAttribute("signUpDto", userZimService.getZimSignUp(signUpId));
		
		return "userzim/completeZimSignUpPage";
	}
	
	// 짐 세부 배송정보 페이지
	@RequestMapping("zimDetailInfoPage")
	public String zimDetailInfoPage(Model model, int signUpId) {
		
		ZimSignUpDto signUpDto = userZimService.getZimSignUp(signUpId);
		int userId = signUpDto.getUser_id();
		UserDto userDto = userZimService.getUserById(userId);
		
		List<Map<String,Object>> signCateList = userZimService.getZimSignCateList(signUpId);
		String total = userZimService.totalSum(signUpId);
		
		model.addAttribute("userDto", userDto);
		model.addAttribute("signUpDto", signUpDto);
		model.addAttribute("signCateList", signCateList);
		model.addAttribute("total", total);
		
		return "userzim/zimDetailInfoPage";
	}
	
	// 짐 서비스 리뷰작성 페이지
	@RequestMapping("zimWriteReviewPage")
	public String zimWriteReviewPage(Model model, int signUpId) {
		
		ZimSignUpDto signUp = userZimService.getZimSignUp(signUpId);
		List<Map<String,Object>> signCateList = userZimService.getZimSignCateList(signUpId);
		
		model.addAttribute("signUp", signUp);
		model.addAttribute("signCateList", signCateList);
		
		return "userzim/zimWriteReviewPage";
	}
	
	// 리뷰 작성 프로세스 
	@RequestMapping("zimReviewProcess")
	public String zimReviewProcess(ZimReviewDto params) {
		
		userZimService.insertZimReview(params);
		return "redirect:../userboard/userZimInfoPage";
	}
	
}
