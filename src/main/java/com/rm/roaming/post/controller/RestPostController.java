package com.rm.roaming.post.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.rm.roaming.dto.ChatDto;
import com.rm.roaming.dto.ChatGroupStatusDto;
import com.rm.roaming.dto.ChatOneStatusDto;
import com.rm.roaming.dto.ChatRoomDto;
import com.rm.roaming.dto.CommentDto;
import com.rm.roaming.dto.CommentLikeDto;
import com.rm.roaming.dto.JoinConfirmDto;
import com.rm.roaming.dto.PartyBoardDto;
import com.rm.roaming.dto.PostChatDto;
import com.rm.roaming.dto.PostDto;
import com.rm.roaming.dto.PostLikeDto;
import com.rm.roaming.dto.PostReviewDto;
import com.rm.roaming.dto.ReCommentDto;
import com.rm.roaming.dto.ReCommentLikeDto;
import com.rm.roaming.dto.ReportDto;
import com.rm.roaming.dto.RequestScheduleDto;
import com.rm.roaming.dto.UserDto;
import com.rm.roaming.post.service.PostService;

@RestController
@RequestMapping("/post/*")
public class RestPostController {

	@Autowired
	private PostService postService;
	
	
	
	
	@RequestMapping("getMyId")
	public Map<String, Object> getMyId(HttpSession session) {
		Map<String, Object> map = new HashMap<>();
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		if(sessionUser != null) {
			map.put("result", "success");
			map.put("id", sessionUser.getId());
		}else {
			map.put("result", "fail");
			map.put("reason", "로그인이 되어있지 않습니다.");
		}
		
		return map;
	}
	
	@RequestMapping("insertPostComment")
	public Map<String, Object> insertPostComment(HttpSession session, CommentDto commentDto) {
		// 게시글 댓글 구현
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		System.out.println(commentDto.getPost_id());
		commentDto.setUser_id(sessionUser.getId());
		System.out.println(commentDto.getUser_id());
		
		Map<String, Object> map = new HashMap<>();
		if(commentDto.getPost_comment() != null) {
			postService.insertPostComment(commentDto);
			map.put("result", "success");
			
		}else {
			map.put("result", "fail");
			map.put("reason", "댓글달기 실패");
		}
		
		return map;
	}
	
	// 대댓글 insert
		@RequestMapping("insertRePostComment")
		public Map<String, Object> insertRePostComment(HttpSession session, ReCommentDto reCommentDto) {
			System.out.println("댓글 인서트 확인");
			UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
			reCommentDto.setUser_id(sessionUser.getId());
			Map<String, Object> map = new HashMap<>();		
			
			map.put("result", "success");
			postService.insertPostReComment(reCommentDto);
			
			return map;
		}
	// 대대댓글 Insert
		@RequestMapping("insertReRePostComment")
		public Map<String, Object> insertReRePostComment(HttpSession session, ReCommentDto reCommentDto) {
			UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
			reCommentDto.setUser_id(sessionUser.getId());
			Map<String, Object> map = new HashMap<>();		
			
			map.put("result", "success");
			postService.insertPostReComment(reCommentDto);
			
			return map;
		}
	
	
	
//		동행 댓글 구현
	
	
	// 댓글 출력
	@RequestMapping("getPostCommentList")
	public Map<String, Object> getPostCommentList(int id) {
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		map.put("commentList", postService.getPostComment(id));
		 return map;
	}
	
	@RequestMapping("commentTotalCount")
	public Map<String, Object> commentTotalCount(int postId) {
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		map.put("comment_total", postService.getPostCommentTotalCount(postId));
		return map;
	}
	
	
	
	// 댓글 수정
	@RequestMapping("commentModify")
	public Map<String, Object> commentModify(CommentDto commentDto) {
		Map<String, Object> map = new HashMap<>();
		postService.commentModify(commentDto);
		map.put("result", "success");
		return map;
	}
	
	// 댓글 삭제
	@RequestMapping("commentDelete")
	public Map<String, Object> commentDelete(int commentId) {
		Map<String, Object> map = new HashMap<>();
		postService.commentDelete(commentId);
		map.put("result", "success");
		return map;
	}
	
	// 대댓글 수정
	@RequestMapping("reCommentModify")
	public Map<String, Object> reCommentModify(ReCommentDto reCommentDto) {
		Map<String, Object> map = new HashMap<>();
		postService.reCommentModify(reCommentDto);
		map.put("result", "success");
		return map;
	}

	// 대댓글 삭제
	@RequestMapping("reCommentDelete")
	public Map<String, Object> reCommentDelete(int reCommentId) {
		Map<String, Object> map = new HashMap<>();
		postService.reCommentDelete(reCommentId);
		map.put("result", "success");
		return map;
	}
		
		
		// 일정 구현, 추가버튼, 삭제버튼
	
		// 동행 꽉차면 모달
	
	
	
	
//	게시물 좋아요
	// 하트 클릭
	@RequestMapping("likeClick")
	public Map<String, Object> likeClick(HttpSession session, PostLikeDto postLikeDto) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		postLikeDto.setUser_id(sessionUser.getId());
		postService.insertLike(postLikeDto);
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		
		return map;
	}
	
	// 내 좋아요 가져오기
	@RequestMapping("myCheckLike")
	public Map<String, Object> myCheckLike(HttpSession session, PostLikeDto postLikeDto) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		if(sessionUser != null) {
			postLikeDto.setUser_id(sessionUser.getId());
			Map<String, Object> map = new HashMap<>();
			map.put("result", "success");
			map.put("liked", postService.getLikeCount(postLikeDto));
			return map;
		}else {
			Map<String, Object> map = new HashMap<>();
			map.put("result", "fail");
			return map;
		}
		
	}
	
	// 게시물 좋아요 총개수
	@RequestMapping("likedTotalCount")
	public Map<String, Object> likedTotalCount(int postId) {
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		map.put("totalCount", postService.getLikeTotalCount(postId));
		return map;
	}
	
	
		
	
	
	
//	댓글 좋아요
	// 하트 클릭
	@RequestMapping("commentLikeClick")
	public Map<String, Object> commentLikeClick(HttpSession session, CommentLikeDto commentLikeDto) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		commentLikeDto.setUser_id(sessionUser.getId());
		postService.insertCommentLike(commentLikeDto);
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		
		return map;
	}
	
	// 내 좋아요 가져오기
	@RequestMapping("commentMyCheckLike")
	public Map<String, Object> commentMyCheckLike(HttpSession session, CommentLikeDto commentLikeDto) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		commentLikeDto.setUser_id(sessionUser.getId());
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		map.put("liked", postService.getCommentLikeCount(commentLikeDto));
		return map;
	}
	
	// 게시물 댓글 좋아요 총개수
	@RequestMapping("commentLikedTotalCount")
	public Map<String, Object> commentLikedTotalCount(int commentId) {
		// 삭제
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		map.put("totalCount", postService.getCommentLikeTotalCount(commentId));
		return map;
	}
	
	
	
//	대댓글 좋아요
	// 하트 클릭
	@RequestMapping("reCommentLikeClick")
	public Map<String, Object> reCommentLikeClick(HttpSession session, ReCommentLikeDto reCommentLikeDto) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		if(sessionUser != null) {
			reCommentLikeDto.setUser_id(sessionUser.getId());
		}
		postService.insertReCommentLike(reCommentLikeDto);
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		
		return map;
	}
	
	// 내 좋아요 가져오기
	@RequestMapping("reCommentMyCheckLike")
	public Map<String, Object> reCommentMyCheckLike(HttpSession session, ReCommentLikeDto reCommentLikeDto) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		if(sessionUser != null) {
			reCommentLikeDto.setUser_id(sessionUser.getId());
		}
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		map.put("liked", postService.getReCommentLikeCount(reCommentLikeDto));
		return map;
	}
	
	// 게시물 댓글 좋아요 총개수
	@RequestMapping("reCommentLikedTotalCount")
	public Map<String, Object> reCommentLikedTotalCount(int recommentId) {
		// 삭제
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		map.put("totalCount", postService.getReCommentLikeTotalCount(recommentId));
		return map;
	}
	
	
	// 일차 리스트
	@RequestMapping("getDayList")
	public Map<String, Object> getDayList(int postId) {
		Map<String, Object> map = new HashMap<>();		
		
		map.put("result", "success");
		map.put("dayList", postService.selectNewDay(postId));
		map.put("postDto", postService.getPostById(postId));
		return map;
	}
	
	@RequestMapping("insertSchedule")
	public Map<String, Object> insertSchedule(@RequestBody RequestScheduleDto requestScheduleDto) {
		Map<String, Object> map = new HashMap<>();		
		System.out.println("인서트 스케줄 확인");
		map.put("result", "success");
		postService.insertSchedule(requestScheduleDto);
		return map;
	}
	
	@RequestMapping("getScheduleList")
	public Map<String, Object> getScheduleList(int post_id) {
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		map.put("data", postService.selectSchedulePostId(post_id));
		
		return map;
	}
	
	
	@RequestMapping("scheduleDelete")
	public Map<String, Object> scheduleDelete(int post_id) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		postService.deleteDaySchedule(post_id);
		return map;
	}
	
	

	
	// 동행참가 버튼 status
	@RequestMapping("getPostJoinStatus")
	public Map<String, Object> getPostJoinStatus(HttpSession session, JoinConfirmDto joinConfirmDto) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		if(sessionUser != null) {
		int user_id = sessionUser.getId();
		joinConfirmDto.setUser_id(user_id);
		int post_id = joinConfirmDto.getPost_id();
		System.out.println(post_id);
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		map.put("joinConfirmDto", postService.selectJoinStatus(joinConfirmDto));
		map.put("joinUserCount", postService.getJoinUserCount(joinConfirmDto));
		map.put("schCount", postService.getScheduleCount(post_id));
		map.put("postDto", postService.getPostById(post_id));
		map.put("statusCount", postService.getGroupPartyRoomCount(post_id));
		return map;
		}else {
			Map<String, Object> map = new HashMap<>();
			map.put("result", "faill");
			return map;
		}
	}

	@RequestMapping("joinProcess")
	public Map<String, Object> joinProcess(HttpSession session, JoinConfirmDto joinConfirmDto,
			HttpServletRequest request) {
		System.out.println("모달이미지실행");
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
	    MultipartFile confirm_image = multipartRequest.getFile("confirm_image1");

		Map<String, Object> map = new HashMap<>();
		
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		
		joinConfirmDto.setUser_id(sessionUser.getId());
		
		if (confirm_image != null && !confirm_image.isEmpty()) {
	        System.out.println("파일명 : " + confirm_image.getOriginalFilename());
	        String rootFolder = "/Users/su/Desktop/uploadFiles/";
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
	        String today = sdf.format(new Date());
	        File targetFolder = new File(rootFolder + today);

	        if (!targetFolder.exists()) {
	            targetFolder.mkdirs();
	        }

	        String fileName = UUID.randomUUID().toString();
	        fileName += "_" + System.currentTimeMillis();
	        String originalFileName = confirm_image.getOriginalFilename();
	        String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
	        String saveFileName = today + "/" + fileName + ext;

	        try {
	        	confirm_image.transferTo(new File(rootFolder + saveFileName));
	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        joinConfirmDto.setConfirm_image(saveFileName);
	    }
		
		postService.insertJoinConfirm(joinConfirmDto);
		map.put("result", "success");
		return map;
	}
	
	@RequestMapping("getTogetherMemberList")
	public Map<String, Object> getTogetherMemberList(int id) {
		Map<String, Object> map = new HashMap<>();
		PostDto postDto = postService.getPostById(id);
		List<Map<String, Object>> list = postService.getJoinUserByPostId(id);
		map.put("result", "success");
		map.put("list", list);
		map.put("joinCount", postService.joinUserCount(id));
		map.put("postDto", postDto);
		return map;
	}
	
	@RequestMapping("postReportProcess")
	public Map<String, Object> postReportProcess(ReportDto reportDto, @RequestParam("image1") MultipartFile image) {
		Map<String, Object> map = new HashMap<>();
		System.out.println("모달이미지실행");

		if (image != null && !image.isEmpty()) {
	        System.out.println("파일명 : " + image.getOriginalFilename());
	        String rootFolder = "/Users/su/Desktop/uploadFiles/";
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
	        String today = sdf.format(new Date());
	        File targetFolder = new File(rootFolder + today);

	        if (!targetFolder.exists()) {
	            targetFolder.mkdirs();
	        }

	        String fileName = UUID.randomUUID().toString();
	        fileName += "_" + System.currentTimeMillis();
	        String originalFileName = image.getOriginalFilename();
	        String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
	        String saveFileName = today + "/" + fileName + ext;

	        try {
	        	image.transferTo(new File(rootFolder + saveFileName));
	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        reportDto.setImage(saveFileName);
	    }
		
		postService.insertReport(reportDto);
		map.put("result", "success");
		return map;
	}
		
	
	@RequestMapping("partyCreateBoard")
	public Map<String, Object> partyCreateBoard(HttpSession session, PartyBoardDto partyBoardDto) {
		System.out.println("파티 게시물 실행확인");
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		partyBoardDto.setUser_id(sessionUser.getId());
		
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		postService.insertBoard(partyBoardDto);
		return map;
	}
	
	@RequestMapping("getPartyBoardList")
	public Map<String, Object> getPartyBoardList(int post_id) {
		System.out.println("실행");
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		map.put("list", postService.selectBoardList(post_id));
		
		return map;
	}
	
	@RequestMapping("getPartyBoardDetail")
	public Map<String, Object> getPartyBoardDetail(int board_id) {
		Map<String, Object> map = new HashMap<>();
		postService.boardViewsUpdate(board_id);
		map.put("result", "success");
		map.put("data", postService.selectBoardById(board_id));
		return map;
	}
	
	
	@RequestMapping("chatInformation")
	public Map<String, Object> chatInformation(HttpSession session, int id) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		if(sessionUser != null) {
			System.out.println("sessionUser1 : " + sessionUser.getId());
			Map<String, Object> map = new HashMap<>();
			map.put("result", "success");
			map.put("partyList", postService.getChatJoinUserPostId(id)); // 파티 참여 리스트
			return map;
		}else {
			Map<String, Object> map = new HashMap<>();
			map.put("result", "fail");
			return map;
		}
	}
	
	@RequestMapping("groupChatInfo")
	public Map<String, Object> groupChatInfo(HttpSession session, int id) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		if(sessionUser != null) {
			Map<String, Object> map = new HashMap<>();
			map.put("result", "success");
			map.put("list", postService.getPartyGroupList(sessionUser.getId()));
			return map;
		}else {
			Map<String, Object> map = new HashMap<>();
			map.put("result", "fail");
			return map;
		}
	}
	
	
	
	
	
	@RequestMapping("chatList")
	public Map<String, Object> chatList(HttpSession session, ChatGroupStatusDto chatGroupStatusDto, int post_id) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		chatGroupStatusDto.setUser_id(sessionUser.getId());
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		map.put("list", postService.getChatList(chatGroupStatusDto, post_id));
		map.put("personCount", postService.getGroupPartyRoomCount(post_id)); // 카운트 새로만들어야함
		
		return map;
	}
	
	@RequestMapping("insertChat")
	public Map<String, Object> insertChat(PostChatDto postChatDto) {
		Map<String, Object> map = new HashMap<>();
		postService.insertPartyChating(postChatDto);
		map.put("result", "success");
		
		
		return map;
	}
	
	@RequestMapping("insertOneChatRoom")
	public Map<String, Object> insertOneChatRoom(ChatRoomDto chatRoomDto) {
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		map.put("check", postService.insertOneChat(chatRoomDto));
		return map;
	}
	
	
	
	@RequestMapping("getOneChatRoom")
	public Map<String, Object> getOneChatRoom(int user_id) {
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		map.put("list", postService.getChatRoomList(user_id));
		return map;
	}
	
	
	@RequestMapping("oneChatList")
	public Map<String, Object> oneChatList(HttpSession session, ChatOneStatusDto chatOneStatusDto, int chat_id) {
		
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		chatOneStatusDto.setUser_id(sessionUser.getId());
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		map.put("list", postService.getOneChatList(chatOneStatusDto, chat_id));
		
		return map;
	}
	
	@RequestMapping("oneInsertChat")
	public Map<String, Object> oneInsertChat(ChatDto chatDto) {
		Map<String, Object> map = new HashMap<>();
		
		map.put("result", "success");
		postService.insertChating(chatDto);
		
		return map;
	}
	
	
	
	
	@RequestMapping("getDayListIndex")
	public Map<String, Object> getDayListIndex(int day_id) {
		Map<String, Object> map = new HashMap<>();
		
		map.put("result", "success");
		map.put("data", postService.getScheduleList(day_id));
		
//		getScheduleList
		
		return map;
	}
	
	@RequestMapping("getProfileModal")
	public Map<String, Object> getProfileModal(int userId) {
		Map<String, Object> map = new HashMap<>();
		Integer reviewCount = postService.getReviewCount(userId);
		if(reviewCount != null) {
			map.put("count", reviewCount);
		}else {
			map.put("count", 0);
		}
		map.put("result", "success");
		// 해당 유저
		UserDto userDto = postService.getUserById(userId);
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
				 birthday = "10대 이하";
		        } else if (age >= 20 && age < 30) {
		        	birthday = "20대";
		        } else if (age >= 30 && age < 40) {
		        	birthday = "30대";
		        } else if (age >= 40 && age < 50) {
		        	birthday = "40대";
		        } else {
		        	birthday = "50대";
		        }
			 System.out.println("유저 이름 : " + userDto.getUser_name());
			 System.out.println("연령대 : " + birthday);
		map.put("userDto", userDto);
		map.put("birthday", birthday);
		map.put("temperature", postService.getTemperature(userId));
		map.put("list", postService.getReviewList(userId));
		
		
		return map;
	}
	
	
	@RequestMapping("getStatusList")
	public Map<String, Object> getStatusList(int post_id) {
		Map<String, Object> map = new HashMap<>();
		
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yy.MM.dd");
		String nowDate = sdf.format(now);
		
		map.put("result", "success");
		map.put("comment_total", postService.getPostCommentTotalCount(post_id));
		map.put("like_total", postService.getLikeTotalCount(post_id));
		map.put("postDto", postService.getPostById(post_id));
		map.put("nowDate", nowDate);
		map.put("joinCount", postService.joinUserCount(post_id));
		
		return map;
	}
	
	@RequestMapping("getMyTemperature")
	public Map<String, Object> getMyTemperature(HttpSession session) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		if(sessionUser != null) {
			Map<String, Object> map = new HashMap<>();
			
			map.put("result", "success");
			map.put("temperature", postService.getTemperature(sessionUser.getId()));
			return map;
		}else { 
			Map<String, Object> map = new HashMap<>();
			map.put("result", "fail");
			return map;
		}
	}
	
	
	
	@RequestMapping("scheduleChange")
	public Map<String, Object> scheduleChange(HttpSession session, PostDto postDto) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		if(sessionUser != null) {
			Map<String, Object> map = new HashMap<>();
			
			map.put("result", "success");
			System.out.println("postDto : " + postDto.toString());
			postService.scheduleChange(postDto);
			return map;
		}else { 
			Map<String, Object> map = new HashMap<>();
			map.put("result", "fail");
			return map;
		}
	}
	
	
	@RequestMapping("postReviewInsert")
	public Map<String, Object> postReviewInsert(PostReviewDto postReviewDto) {
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		postService.insertPostReview(postReviewDto);
		
		return map; 
	}
	
	
	
	
	
	
	
	
}
