package com.rm.roaming.post.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.rm.roaming.dto.DayDto;
import com.rm.roaming.dto.JoinConfirmDto;
import com.rm.roaming.dto.JoinUserDto;
import com.rm.roaming.dto.PostChatDto;
import com.rm.roaming.dto.PostDto;
import com.rm.roaming.dto.PostImageDto;
import com.rm.roaming.dto.ReportDto;

import com.rm.roaming.dto.ScheduleRequestDto;
import com.rm.roaming.dto.UserDto;
import com.rm.roaming.post.service.PostService;


@RequestMapping("/post/*")
@Controller
public class PostController {

	@Autowired
	private PostService postService;
	
	@RequestMapping("registerPage")
	public String registerPage() {
		
		return "post/registerPage";
	}
	
	@RequestMapping("postListPage")
	public String postListPage(HttpSession session, Model model,
			@RequestParam(value = "page", defaultValue = "1") int page, String searchValue, String category) {
		System.out.println("searchValue : " + searchValue);
		System.out.println("category : " + category);
		UserDto userDto = (UserDto)session.getAttribute("sessionUser");
		
		List<Map<String, Object>> list = postService.getPostList(page, searchValue, category);

		int postCount = postService.getPostCount();
		int totalPage = (int)Math.ceil(postCount/10.0); 
		
		int startPage = ((page-1)/5)*5 + 1;
		int endPage = ((page-1)/5+1)*5;
		
		if(endPage > totalPage) {
			endPage = totalPage;
		}
		
		model.addAttribute("list", list);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("currentPage", page);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		
		
		return "post/postListPage";
	}
	
	@RequestMapping("postDetailPage")
	public String postDetailPage(HttpSession session, Model model, int id) {
		PostDto postDto = postService.getPostById(id);
		List<PostImageDto> postImageDto = postService.getPostImageByPostId(id);
		UserDto userDto = postService.getPostByCreateId(postDto.getCreate_id());
		
		// 나이계산
		 Date birthDateStr = userDto.getBirth();
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	        Calendar birthCal = Calendar.getInstance();
			birthCal.setTime(birthDateStr);

			Calendar now = Calendar.getInstance();

			int age = now.get(Calendar.YEAR) - birthCal.get(Calendar.YEAR);

			// 생년월일이 지나지 않았으면 한 살 빼줌
			if (now.get(Calendar.DAY_OF_YEAR) < birthCal.get(Calendar.DAY_OF_YEAR)) {
			    age--;
			}
			String birthday = null;
			System.out.println("만나이: " + age + "세");
			 if (age < 20) {
				 birthday = "10대";
		        } else if (age >= 20 && age < 30) {
		        	birthday = "20대";
		        } else if (age >= 30 && age < 40) {
		        	birthday = "30대";
		        } else if (age >= 40 && age < 50) {
		        	birthday = "40대";
		        } else {
		        	birthday = "50대";
		        }
		// 나이계산
		
		List<Map<String, Object>> list = postService.getJoinUserByPostId(id);
		
			
		model.addAttribute("list", list);
		model.addAttribute("count", postService.joinUserCount(id));
		// 동행 꽉차면 모달 띄워주기
		String oriNumber = userDto.getPhone_number();
		if(oriNumber.length() > 10 && !oriNumber.contains("-")) {
			System.out.println("변환 전 : " + oriNumber);
			String first = oriNumber.substring(0, 3);
			String second = oriNumber.substring(3, 7);
			String third = oriNumber.substring(7);
			String resultNumber = String.format("%s,-%s-%s", first, second, third);
			System.out.println("변환 후 : " + resultNumber);
			userDto.setPhone_number(resultNumber);
		}else {
			System.out.println("postController_Detail_fail");
			System.out.println("= " + oriNumber);
		}
		
		
		

		model.addAttribute("userDto", userDto);
		model.addAttribute("birthday", birthday);
		model.addAttribute("postImageDto", postImageDto);
		model.addAttribute("postDto", postDto);
		model.addAttribute("sessionUser", session.getAttribute("sessionUser"));
		postService.viewsUpdate(id);
		return "post/postDetailPage";
	}
	
	@RequestMapping("postPartyRoom")
	public String postPartyRoom(int id) {
		
		
		
		return "post/postPartyRoom";
	}
	
	@RequestMapping("postJoinPage")
	public String postJoinPage(HttpSession session, Model model, int id) {
		PostDto postDto = postService.getPostById(id);
		
		model.addAttribute("postDto", postDto);

		return "post/postJoinPage";
	}
	
	
	@RequestMapping("postAddSchedultPage")
	public String postAddSchedultPage(Model model, int id) {
		PostDto postDto = postService.getPostById(id);
		
//		날짜 변환
		Date start = postDto.getDay_start();
		Date end = postDto.getDay_end();
		long difference = Math.abs(end.getTime() - start.getTime());
		long days = TimeUnit.DAYS.convert(difference, TimeUnit.MILLISECONDS);
//		날짜변환
		
		model.addAttribute("postDto", postDto);
		model.addAttribute("days", days);
		return "post/postAddSchedultPage";
	}
	
	@RequestMapping("testPost")
	public String testPost(int id) {
		
	
		return "post/testPost";
	}
	
	
	// Process
	
	
	
	@RequestMapping("insertProcess")
	   public String insertProcess(HttpSession session, PostDto postDto, JoinUserDto joinUserDto,
	         @RequestParam("post_image") MultipartFile[] post_image 
	         ) {
	      System.out.println("씨");
	      
	      UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
	      
	      if(sessionUser != null) {
	         postDto.setCreate_id(sessionUser.getId());
	      }else {
	         return "redirect:../user/loginPage";
	      }
	      
	      if (post_image != null && post_image.length > 0) {
	           List<PostImageDto> postImageDtoList = new ArrayList<>();

	           for (MultipartFile multipartFile : post_image) {
	               if (multipartFile.isEmpty()) {
	                   continue;
	               }

	               System.out.println("파일명 : " + multipartFile.getOriginalFilename());
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

	               PostImageDto postImageDto = new PostImageDto();
	               postImageDto.setPost_image(saveFileName);
	               postImageDtoList.add(postImageDto);
	               
	           }
	          
	           
	        // 방장 파티 참가 쿼리
	         
	         joinUserDto.setUser_id(postDto.getCreate_id());
	         
	           // 게시글 작성
	           postService.insertPost(postDto, postImageDtoList, joinUserDto);
	      }
	      return "redirect:../post/postListPage";
	   }
	
	@RequestMapping("updateJoinConfirmProcess")
	public String updateJoinConfirmProcess(JoinConfirmDto joinConfirmDto) {
		postService.updatePostStatus(joinConfirmDto);
		// 중복 유저 인서트 금지 구현
		return "redirect:../userboard/joinConfirmPage";
	}
	
	
}
