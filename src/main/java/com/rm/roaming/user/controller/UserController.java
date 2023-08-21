package com.rm.roaming.user.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import com.rm.roaming.user.service.UserServiceImpl;
import com.rm.roaming.userboard.service.UserBoardServiceImpl;

@Controller
@RequestMapping("/user/*")
public class UserController {
	@Autowired
	private UserServiceImpl userServiceImpl;
	@Autowired
	private UserBoardServiceImpl userBoardService;
	
	// 유저 회원가입 페이지
		@RequestMapping("userRegisterPage")
		public String userRegisterPage() {
			return "user/userRegisterPage";
		}
		@RequestMapping("kakaoRegister")
		public String kakaoRegister() {
			return "user/kakaoRegister";
		}
		// 유저 회원가입 프로세스
		@RequestMapping("userRegisterProcess")
		public String userRegisterProcess(UserDto userDto, @RequestParam("image") MultipartFile[] image) {

			if (image != null) {

				for (MultipartFile multipartFile : image) {

					if (multipartFile.isEmpty()) {
						continue;
					}

					String rootFolder = "/Users/su/Desktop/uploadFiles/";

					SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
					String today = sdf.format(new Date());

					File targetFolder = new File(rootFolder + today);

					if (!targetFolder.exists()) {
						targetFolder.mkdirs();
					}

					String fileName = UUID.randomUUID().toString();
					fileName += "_" + System.currentTimeMillis();

					String originalFileName = multipartFile.getOriginalFilename();

					String ext = originalFileName.substring(originalFileName.lastIndexOf("."));

					String saveFileName = today + "/" + fileName + ext;

					try {
						multipartFile.transferTo(new File(rootFolder + saveFileName));

					} catch (Exception e) {
						e.printStackTrace();
					}

					userDto.setProfile_img(saveFileName);
				}
			}

			userServiceImpl.userRegister(userDto);
			return "redirect:../userboard/mainPage";
		}
		@RequestMapping("kakaoUserRegisterProcess")
		public String kakaoUserRegisterProcess(UserDto userDto,HttpSession session) {
		      String kid = (String) session.getAttribute("kid");
		      String name = (String) session.getAttribute("name");
		      String gender = (String) session.getAttribute("gender");
		      String pimg  = (String) session.getAttribute("pimg");
		      userDto.setUser_id(kid);
		      userDto.setUser_pw(kid);
		      if(gender == "male") {
		         userDto.setGender("M");
		      }else {
		         userDto.setGender("F");
		      }
		      userDto.setProfile_img(pimg);
		      userDto.setUser_name(name);
		      System.out.println(userDto.toString());
		      userServiceImpl.KakaoUserRegister(userDto);
		      session.removeAttribute("kid");
		      session.removeAttribute("name");
		      session.removeAttribute("gender");
		      session.removeAttribute("pimg");
		      session.setAttribute("sessionUser", userServiceImpl.selectUserIdById(kid));
		      UserDto userDto2 = userServiceImpl.selectUserIdById(kid);
		      int userId = userDto2.getId();
		      Map<String, Object> myPage = userBoardService.getMyPage(userId);
		      session.setAttribute("myPage",myPage);
		      
		      return  "redirect:../userboard/mainPage";
		      
		   }

		
		
		// 유저 로그인 페이지
		@RequestMapping("loginPage")
		public String loginPage() {
			return "user/loginPage";
		}
		@RequestMapping("kakaoToken")
		public String kakaoToken(String code,Model model) {
			model.addAttribute("code", code);
			return "user/kakaoToken";
		}
		// 유저 로그인 프로세스
		@RequestMapping("loginProcess")
		   public String loginProcess(UserDto userDto, HttpSession session) {
		      UserDto userDto2 = userServiceImpl.getUserInfo(userDto);
		      session.setAttribute("sessionUser", userServiceImpl.getUserInfo(userDto));
		      
		      int userId = userDto2.getId();
		      
		      Map<String, Object> myPage = userBoardService.getMyPage(userId);   
		      session.setAttribute("myPage",myPage);
		      return "redirect:../userboard/mainPage";
		   }

		// 유저 로그아웃 프로세스
		@RequestMapping("logoutProcess")
		public String logoutProcess(HttpSession session) {
			session.invalidate();
			return "redirect:../userboard/mainPage";
		}

		// 유저 정보 수정 페이지
		@RequestMapping("updateUserInfoPage")
		public String updateUserInfoPage(HttpSession session, Model model, int id) {

			UserDto sessionUser = (UserDto) session.getAttribute("sessionUser");

			if (sessionUser == null)
				return "user/loginPage";

			int userId = sessionUser.getId();

			Map<String, Object> myPage = userBoardService.getMyPage(userId);

			model.addAttribute("myPage", myPage);

			return "user/updateUserInfoPage";
		}

		// 유저 정보 수정 프로세스
		@RequestMapping("updateUserInfoProcess")
		public String updateUserInfoProcess(UserDto userDto, @RequestParam("profile_image") MultipartFile[] image) {

			if (image != null) {

				for (MultipartFile multipartFile : image) {

					if (multipartFile.isEmpty()) {
						continue;
					}

					String rootFolder = "/Users/su/Desktop/uploadFiles/";

					SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
					String today = sdf.format(new Date());

					File targetFolder = new File(rootFolder + today);

					if (!targetFolder.exists()) {
						targetFolder.mkdirs();
					}

					String fileName = UUID.randomUUID().toString();
					fileName += "_" + System.currentTimeMillis();

					String originalFileName = multipartFile.getOriginalFilename();

					String ext = originalFileName.substring(originalFileName.lastIndexOf("."));

					String saveFileName = today + "/" + fileName + ext;

					try {
						multipartFile.transferTo(new File(rootFolder + saveFileName));

					} catch (Exception e) {
						e.printStackTrace();
					}

					userDto.setProfile_img(saveFileName);
				}
			}

			userServiceImpl.updateUserInfo(userDto);

			return "redirect:../userboard/myPage?id=" + userDto.getId();

		}
	
}
