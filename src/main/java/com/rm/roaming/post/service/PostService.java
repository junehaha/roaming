package com.rm.roaming.post.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rm.roaming.dto.ChatDto;
import com.rm.roaming.dto.ChatGroupStatusDto;
import com.rm.roaming.dto.ChatOneStatusDto;
import com.rm.roaming.dto.ChatRoomDto;
import com.rm.roaming.dto.CommentDto;
import com.rm.roaming.dto.CommentLikeDto;
import com.rm.roaming.dto.DayDto;
import com.rm.roaming.dto.HwangDto;
import com.rm.roaming.dto.JoinConfirmDto;
import com.rm.roaming.dto.JoinUserDto;
import com.rm.roaming.dto.PartyBoardDto;
import com.rm.roaming.dto.PostChatDto;
import com.rm.roaming.dto.PostChatGroupDto;
import com.rm.roaming.dto.PostDto;
import com.rm.roaming.dto.PostImageDto;
import com.rm.roaming.dto.PostLikeDto;
import com.rm.roaming.dto.PostReviewDto;
import com.rm.roaming.dto.ReCommentDto;
import com.rm.roaming.dto.ReCommentLikeDto;
import com.rm.roaming.dto.ReportDto;
import com.rm.roaming.dto.RequestScheduleDto;
import com.rm.roaming.dto.SchedulerDto;
import com.rm.roaming.dto.TemperatureDto;
import com.rm.roaming.dto.UserDto;
import com.rm.roaming.post.mapper.PostMapper;
import com.rm.roaming.user.mapper.UserSqlMapper;

@Service
public class PostService {

	@Autowired
	private PostMapper postMapper;
	@Autowired
	private UserSqlMapper UserSqlMapper;
	
	public UserDto getUserById(int userId) {
		return postMapper.getUserById(userId);
	}
	
	
	
	public void insertPost(PostDto postDto, List<PostImageDto> postImageDtoList, JoinUserDto joinUserDto
			) {
		
		System.out.println("실행확인");
		int pkId = postMapper.createPk();
		postDto.setId(pkId);
		System.out.println(postDto.toString());
		postMapper.insertPost(postDto);
		
		// 파팉참여
		joinUserDto.setPost_id(pkId);
		postMapper.insertPartyJoin(joinUserDto);
		
		// 일차 인서트
		Date start = postDto.getDay_start();
		Date end = postDto.getDay_end();
		long difference = Math.abs(end.getTime() - start.getTime());
		long days = TimeUnit.DAYS.convert(difference, TimeUnit.MILLISECONDS);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(start);
		
		
		for(int i = 0; i < days + 1; i++) {
			Date todayDate = calendar.getTime();
			DayDto dayDto = new DayDto();
			dayDto.setPost_id(pkId);
			dayDto.setTodayDate(todayDate);
			postMapper.insertNewDay(dayDto);

			calendar.add(Calendar.DAY_OF_MONTH, 1);
		}
		
		
		if(postImageDtoList != null && !postImageDtoList.isEmpty()) {
			for(PostImageDto postImageDto : postImageDtoList) {
				postImageDto.setPost_id(pkId); 
				
				postMapper.insertPostImage(postImageDto);
				System.out.println(postImageDto.toString());
			}
		}
	}
	
	public void updatePost(PostDto postDto) {
		postMapper.updatePost(postDto);
		
	}
	
	
	public void insertJoinConfirm(JoinConfirmDto joinConfirmDto) {
		postMapper.insertJoinConfirm(joinConfirmDto);
	}
	
	public List<Map<String, Object>> selectJoinConfirm(int create_id) {
		List<Map<String, Object>> list = new ArrayList<>();
		List<JoinConfirmDto> joinConfirmDtoList = postMapper.selectJoinConfirm(create_id);
		for(JoinConfirmDto joinConfirmDto : joinConfirmDtoList) {
			Map<String, Object> map = new HashMap<>();
			UserDto userDto = postMapper.getUserById(joinConfirmDto.getUser_id());
			map.put("joinConfirmDto", joinConfirmDto);
			map.put("userDto", userDto);
			list.add(map);
		}
		return list; 
	}
	
	
	public JoinConfirmDto selectJoinStatus(JoinConfirmDto joinConfirmDto) {
		return postMapper.selectJoinStatus(joinConfirmDto);
	}
	
	public int getJoinUserCount(JoinConfirmDto joinConfirmDto) {
		return postMapper.getJoinUserCount(joinConfirmDto);
	}
	
	public void updatePostStatus(JoinConfirmDto joinConfirmDto) {
		int post_id = joinConfirmDto.getPost_id();
		int user_id = joinConfirmDto.getUser_id();
		
		JoinUserDto joinUserDto = new JoinUserDto();
		joinUserDto.setPost_id(post_id);
		joinUserDto.setUser_id(user_id);
		
		
		if(joinConfirmDto.getStatus().equals("y")) {
			postMapper.updatePostStatus(joinConfirmDto);
			postMapper.insertPartyJoin(joinUserDto);
			
			System.out.println("Y실행");
			
		}else if(joinConfirmDto.getStatus().equals("n")) {
			postMapper.updatePostStatus(joinConfirmDto);
			// 거절 사유 구현
			System.out.println("N실행");
			
		}
	}
	
	
	
	
	public List<Map<String, Object>> getPostList(int page, String searchValue, String category) {
		List<Map<String, Object>> list = new ArrayList<>();
		List<PostDto> postDtoList = postMapper.getPostList(page, searchValue, category);
		
		for(PostDto postDto : postDtoList) {
			Map<String, Object> map = new HashMap<>();
			int postId = postDto.getId();
			
			List<PostImageDto> postImageDtoList = postMapper.getPostImageByPostId(postId);
			
			UserDto userDto = postMapper.getUserById(postDto.getCreate_id());
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
			
			String title = postDto.getTitle();
			if(title.length() > 21) {
				title = title.substring(0, 18) + "···";
				postDto.setTitle(title);
			}else {
				postDto.setTitle(title);
			}
			
			String content = postDto.getContent();
			if(content.length() > 42) {
				content = content.substring(0, 39) + "···";
				postDto.setContent(content);
			}else {
				postDto.setContent(content);
			}
			
			Date start = postDto.getDay_start();
			Date end = postDto.getDay_end();
			long difference = Math.abs(end.getTime() - start.getTime());
			long days = TimeUnit.DAYS.convert(difference, TimeUnit.MILLISECONDS);
			
			map.put("days", days);
			map.put("userDto", userDto);
			map.put("birthday", birthday);
			map.put("postDto", postDto);
			map.put("postImageDto", postImageDtoList);
			map.put("count", postMapper.joinUserCount(postId));
			list.add(map);
		}
		
		return list;
	}
	
	public int getPostCount() {
		return postMapper.getPostCount();
				
	}
	
	
	public int getScheduleCount(int post_id) {
		return postMapper.getScheduleCount(post_id);
	}
	
	
	public void viewsUpdate(int id) {
		
		System.out.println("qwrt)");
		
		postMapper.viewsUpdate(id);	
	}
	
	public PostDto getPostById(int id) {
		
		return postMapper.getPostById(id);
	}
	
	public UserDto getPostByCreateId(int create_id) {
		return postMapper.getPostByCreateId(create_id);
	}
	
	public List<PostImageDto> getPostImageByPostId(int postId) {
		return postMapper.getPostImageByPostId(postId);
	}
	
	public void insertReport(ReportDto reportDto) {
		postMapper.insertReport(reportDto);
	}
	
	public List<Map<String, Object>> getJoinUserByPostId(int id) {
		List<Map<String, Object>> list = new ArrayList<>();
		List<JoinUserDto> joinUserDtolist = postMapper.getJoinUserByPostId(id);
		
		for(JoinUserDto joinUserDto : joinUserDtolist) {
			Map<String, Object> map = new HashMap<>();
			UserDto userDto = postMapper.getUserById(joinUserDto.getUser_id());
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
			// 나이계산
			map.put("joinUserDto", joinUserDto);
			map.put("userDto", userDto);
			map.put("birthday", birthday);
			list.add(map);
			
		}
		return list;
	}
	
	public int joinUserCount(int id) {
		return postMapper.joinUserCount(id);
	}
	
	
	public void insertPostComment(CommentDto commentDto) {
		postMapper.insertPostComment(commentDto);
	}

	public void insertPostReComment(ReCommentDto reCommentDto) {
		postMapper.insertPostReComment(reCommentDto);
	}
	
	// 게시물 댓글 수정
	public void commentModify(CommentDto commentDto) {
		postMapper.commentModify(commentDto);
	}
	// 게시물 댓글 삭제
	public void commentDelete(int commentId) {
		postMapper.commentDelete(commentId);
	}
	// 게시물 대댓글 수정
	public void reCommentModify(ReCommentDto reCommentDto) {
		postMapper.reCommentModify(reCommentDto);
	}
	// 게시물 대댓글 삭제
	public void reCommentDelete(int reCommentId) {
		postMapper.reCommentDelete(reCommentId);
	}
	
	public List<Map<String, Object>> getPostComment(int postId) {
		List<Map<String, Object>> resultList = new ArrayList<>();
		List<CommentDto> commentDtoList = postMapper.getPostComment(postId);
		for(CommentDto commentDto : commentDtoList) {
			Map<String, Object> map1 = new HashMap<>();
			UserDto commentUserDto = postMapper.getUserById(commentDto.getUser_id());
			int comment_total = postMapper.getCommentLikeTotalCount(commentDto.getId());
			if(commentUserDto.getProfile_img() == null) {
				commentUserDto.setProfile_img("f3c96c43766c04eaa1b773eb38ef531e.jpg");
			}
			
			map1.put("comment_total", comment_total);
			map1.put("commentDto", commentDto);
			map1.put("commentUserDto", commentUserDto);
			List<ReCommentDto> reCommentDtoList = postMapper.getPostReComment(commentDto.getId());	
		
			List<Map<String, Object>> reCommentResultList = new ArrayList<>();
			for(ReCommentDto reCommentDto : reCommentDtoList) {
				Map<String, Object> map2 = new HashMap<>();
				UserDto reCommentUserDto = postMapper.getUserById(reCommentDto.getUser_id()); // 대댓작성자
				UserDto reCommentReUserDto = postMapper.getUserById(reCommentDto.getRe_user_id()); // 어떤 사람의 댓그
				if(reCommentUserDto.getProfile_img() == null) {
					reCommentUserDto.setProfile_img("f3c96c43766c04eaa1b773eb38ef531e.jpg");
				}
				UserDto frontUserDto = postMapper.getUserById(reCommentDto.getRe_user_id());
				
				map2.put("frontUserDto", frontUserDto);
				map2.put("reCommentReUserDto", reCommentReUserDto);
				map2.put("reCommentDto", reCommentDto);
				map2.put("reCommentUserDto", reCommentUserDto);
				reCommentResultList.add(map2);			
			}
				map1.put("reCommentList", reCommentResultList);
				resultList.add(map1);
		}		
			
		return resultList;
	}
	
	
	public int getPostCommentTotalCount(int postId) {
		return postMapper.getPostCommentTotalCount(postId);
	}
	
	// 게시물 좋아요 추가
	public void insertLike(PostLikeDto postLikeDto) {
		
		if(postMapper.getLikeCount(postLikeDto) > 0) {
			postMapper.deleteLike(postLikeDto);
		}else {
			postMapper.insertLike(postLikeDto);
		}
	}
	
	// 게시물 좋아요 삭제
	public void deleteLike(PostLikeDto postLikeDto) {
		postMapper.deleteLike(postLikeDto);
	}
	
	// 게시물 좋아요 개수 가져오기
	public int getLikeCount(PostLikeDto postLikeDto) {
		return postMapper.getLikeCount(postLikeDto);
		
	}
	
	// 게시물 좋아요 총개수 가져오기
	public int getLikeTotalCount(int postId) {
		return postMapper.getLikeTotalCount(postId);
	}
	
	
	// 댓글 좋아요 추가
	public void insertCommentLike(CommentLikeDto commentLikeDto) {
		
		if(postMapper.getCommentLikeCount(commentLikeDto) > 0) {
			postMapper.deleteCommentLike(commentLikeDto);
		}else {
			postMapper.insertCommentLike(commentLikeDto);
		}
	}
	
	public void deleteCommentLike(CommentLikeDto commentLikeDto) {
		postMapper.deleteCommentLike(commentLikeDto);
	}
	
	public int getCommentLikeCount(CommentLikeDto commentLikeDto) {
		return postMapper.getCommentLikeCount(commentLikeDto);
		
	}
	
	public int getCommentLikeTotalCount(int commentId) {
		return postMapper.getCommentLikeTotalCount(commentId);
	}
	
	// 대댓글 좋아요
	public void insertReCommentLike(ReCommentLikeDto reCommentLikeDto) {
		
		if(postMapper.getReCommentLikeCount(reCommentLikeDto) > 0) {
			postMapper.deleteReCommentLike(reCommentLikeDto);
		}else {
			postMapper.insertReCommentLike(reCommentLikeDto);
		}
	}
	
	public void deleteReCommentLike(ReCommentLikeDto reCommentLikeDto) {
		postMapper.deleteReCommentLike(reCommentLikeDto);
	}
	
	public int getReCommentLikeCount(ReCommentLikeDto reCommentLikeDto) {
		return postMapper.getReCommentLikeCount(reCommentLikeDto);
		
	}
	
	public int getReCommentLikeTotalCount(int recommentId) {
		return postMapper.getReCommentLikeTotalCount(recommentId);
	}
	
	// 파티 게시물
	public void insertBoard(PartyBoardDto partyBoardDto) {
		postMapper.insertBoard(partyBoardDto);
	}
	
	public List<Map<String, Object>> selectBoardList(int post_id) {
		List<Map<String, Object>> list = new ArrayList<>();
		List<PartyBoardDto> partyBoardDtoList = postMapper.selectBoardList(post_id);
		for(PartyBoardDto partyBoardDto : partyBoardDtoList) {
			Map<String, Object> map = new HashMap<>();
			UserDto userDto = postMapper.getUserById(partyBoardDto.getUser_id());
			map.put("partyBoardDto", partyBoardDto);
			map.put("userDto", userDto);
			list.add(map);
		}
		return list;
	 
	}
	public Map<String, Object> selectBoardById(int board_id) {
		Map<String, Object> map = new HashMap<>();
		PartyBoardDto partyBoardDto = postMapper.selectBoardById(board_id);
		UserDto userDto = postMapper.getUserById(partyBoardDto.getUser_id());
		
		map.put("partyBoardDto", partyBoardDto);
		map.put("userDto", userDto);
		return map;
	}
	
	public void deleteBoardById(int id) {
		postMapper.deleteBoardById(id);
	}
	public void updateBoardById(PartyBoardDto partyBoardDto) {
		postMapper.updateBoardById(partyBoardDto);
	}
	public void boardViewsUpdate(int id) {
		postMapper.boardViewsUpdate(id);
	}
	

	public List<DayDto> selectNewDay(int postId) {
		return postMapper.selectNewDay(postId);
	}
	
//	public void deleteDayId(int id) {
//		postMapper.deleteDayId(id);
//	}
	public void deleteDaySchedule(int post_id) {
		List<DayDto> dayDtoList = postMapper.selectNewDay(post_id);
		for(DayDto dayDto : dayDtoList) {
			System.out.println("4번실행");
			int day_id = dayDto.getId();
//			postMapper.deleteNewDays(day_id); // 일차 삭제
			postMapper.deleteSchedules(day_id);
		}
	}
	
	public void insertSchedule(RequestScheduleDto requestScheduleDto) {
		
		List<RequestScheduleDto.DayScheduleDto> dayScheduleList = requestScheduleDto.getDays();
	    for (RequestScheduleDto.DayScheduleDto daySchedule : dayScheduleList) {
	        int day_id = daySchedule.getDay(); 
	        List<RequestScheduleDto.ScheduleDto> scheduleList = daySchedule.getSchedule();
	        for (RequestScheduleDto.ScheduleDto scheduleDto : scheduleList) {
	            
	        	scheduleDto.setDay_id(day_id);
	        	System.out.println("day_id : " + day_id);
	        	System.out.println("scheduleDto : " + scheduleDto.toString());
	            postMapper.insertSchedule(scheduleDto);
	        }
	    }
	}
	
	public void scheduleChange(PostDto postDto) {
		List<DayDto> dayDtoList = postMapper.selectNewDay(postDto.getId());
		// 일차, 스케줄 삭제
		for(DayDto dayDto : dayDtoList) {
			System.out.println("4번실행");
			int day_id = dayDto.getId();
			postMapper.deleteNewDays(day_id);
			postMapper.deleteSchedules(day_id);
		}
		// 게시물 일정 업데이트
		postMapper.updatePostDays(postDto);
		// 일차 인서트
		Date start = postDto.getDay_start();
		Date end = postDto.getDay_end();
		long difference = Math.abs(end.getTime() - start.getTime());
		long days = TimeUnit.DAYS.convert(difference, TimeUnit.MILLISECONDS);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(start);
		
		
		for(int i = 0; i < days + 1; i++) {
			System.out.println("4번 인서트");
			Date todayDate = calendar.getTime();
			DayDto dayDto = new DayDto();
			dayDto.setPost_id(postDto.getId());
			dayDto.setTodayDate(todayDate);
			postMapper.insertNewDay(dayDto);

			calendar.add(Calendar.DAY_OF_MONTH, 1);
		}
	}
	
	
	
	// postPartyRoom 
	public List<Map<String, Object>> selectSchedulePostId(int post_id) {
		List<Map<String, Object>> list = new ArrayList<>();

		PostDto postDto = postMapper.getPostById(post_id); // get post pk
		UserDto userDto = UserSqlMapper.selectByUserId(postDto.getCreate_id()); 
		List<DayDto> dayDtoList = postMapper.selectNewDay(post_id);
		for(DayDto dayDto : dayDtoList) {
			Map<String, Object> map = new HashMap<>();
			int day_id = dayDto.getId();
			List<SchedulerDto> schedulerDtoList = postMapper.getScheduleList(day_id);
			map.put("dayDto", dayDto);
			map.put("schedulerDtoList", schedulerDtoList);
			map.put("postDto", postDto);
			map.put("userDto", userDto);
			list.add(map);
		}
		return list;
		
	}

	public List<SchedulerDto> getScheduleList(int day_id) {
		return postMapper.getScheduleList(day_id);
		
	}
	
	// 채팅방 구현
	// 동행 참가 프로필 리스트
	public List<UserDto> getChatJoinUserPostId(int id) {
		return postMapper.getChatJoinUserPostId(id);
	}
	// 채팅인서트
	public void insertPartyChating(PostChatDto postChatDto) {
		int groupPk = postMapper.getGroupChatPk();
		// 
		
		List<JoinUserDto> joinUserDtoList = postMapper.getGroupUserIdList(postChatDto.getPost_id());
		for(JoinUserDto joinUserDto : joinUserDtoList) {
			ChatGroupStatusDto chatGroupStatusDto = new ChatGroupStatusDto();
			int user_id = joinUserDto.getUser_id();
			if(postChatDto.getUser_id() == user_id) {
				chatGroupStatusDto.setChating_id(groupPk);
				chatGroupStatusDto.setUser_id(postChatDto.getUser_id());
				chatGroupStatusDto.setStatus("읽음");
				postMapper.insertGroupStatus(chatGroupStatusDto);
			}else {
				chatGroupStatusDto.setChating_id(groupPk);
				chatGroupStatusDto.setUser_id(user_id);
				chatGroupStatusDto.setStatus("안읽음");
				postMapper.insertGroupStatus(chatGroupStatusDto);
			}
		}
		postChatDto.setId(groupPk);
		postMapper.insertPartyChating(postChatDto);
	}
	// 최신 채팅 가져오기
	public PostChatDto getRecentChatingByPostId(int post_id) {
		return postMapper.getRecentChatingByPostId(post_id);
	}
	
	public List<Map<String, Object>> getPartyGroupList(int user_id) {
		List<Map<String, Object>> list = new ArrayList<>();
		List<PostChatGroupDto> postChatGroupDtoList = postMapper.getPartyGroupList(user_id);
		for(PostChatGroupDto postChatGroupDto : postChatGroupDtoList) {
			Map<String, Object> map = new HashMap<>();
			int post_id = postChatGroupDto.getPost_id();
			PostChatDto postChatDto = postMapper.getRecentChatingByPostId(postChatGroupDto.getPost_id());
			int count = postMapper.getGroupNotReadCount(post_id, user_id);
			map.put("postChatGroupDto", postChatGroupDto);
			map.put("postChatDto", postChatDto);
			map.put("count", count);
			list.add(map);
		}
		return list;
	}
	
	// 채팅방 인원 카운트
	public int getGroupPartyRoomCount(int post_id) {
		return postMapper.getGroupPartyRoomCount(post_id);
	}
	// 해당 채팅방 채팅 리스트
	public List<Map<String, Object>> getChatList(ChatGroupStatusDto chatGroupStatusDto, int post_id) {
		List<Map<String, Object>> list = new ArrayList<>();
		List<PostChatDto> postChatDtoList = postMapper.getChatList(post_id);
		for(PostChatDto postChatDto : postChatDtoList) {
			Map<String, Object> map = new HashMap<>();
			int count = postMapper.getGroupChatCount(postChatDto.getId());
			UserDto userDto = postMapper.getUserById(postChatDto.getUser_id());
			postMapper.updateGroupStatus(chatGroupStatusDto);
			
			map.put("postChatDto", postChatDto);
			map.put("userDto", userDto);
			map.put("count", count);
			list.add(map);
		}
		return list;
	}
	
	// 1:1 채팅방 인서트
	public Map<String, Object> insertOneChat(ChatRoomDto chatRoomDto) {
		
		// 1:1 채팅방이 있는지 확인
		if(postMapper.chatRoomCheck(chatRoomDto) == null) {
			postMapper.insertOneChat(chatRoomDto);
			System.out.println("null실행");
			ChatRoomDto chatRoom = postMapper.chatRoomCheck(chatRoomDto);
			Map<String, Object> map = new HashMap<>();
			UserDto receiveDto = postMapper.getUserById(chatRoom.getReceive_id());
			UserDto sendDto = postMapper.getUserById(chatRoom.getSend_id());
			map.put("chatRoom", chatRoom);
			map.put("receiveDto", receiveDto);
			map.put("sendDto", sendDto);
			return map;
		}else {
			Map<String, Object> map = new HashMap<>();
			ChatRoomDto chatRoom = postMapper.chatRoomCheck(chatRoomDto);
			UserDto receiveDto = postMapper.getUserById(chatRoom.getReceive_id());
			UserDto sendDto = postMapper.getUserById(chatRoom.getSend_id());
			map.put("chatRoom", chatRoom);
			map.put("receiveDto", receiveDto);
			map.put("sendDto", sendDto);
			return map;
		}
	}
	
	public ChatRoomDto chatRoomCheck(ChatRoomDto chatRoomDto) {
		return postMapper.chatRoomCheck(chatRoomDto);
	}
	
	// 1:1 채팅방 리스트 가져오기
	public List<Map<String, Object>> getChatRoomList(int user_id) {
		
		List<Map<String, Object>> list = new ArrayList<>();
		List<ChatRoomDto> chatRoomDtoList = postMapper.getChatRoomList(user_id);
		for(ChatRoomDto chatRoomDto : chatRoomDtoList) {
			Map<String, Object> map = new HashMap<>();
			int receive_id = chatRoomDto.getReceive_id();
			int send_id = chatRoomDto.getSend_id();
			// 안읽음 count //
			int chat_id = chatRoomDto.getId();
			
			// 안읽음 count //
			UserDto receiveDto = postMapper.getUserById(receive_id);
			UserDto sendDto = postMapper.getUserById(send_id);
			
			map.put("chatRoomDto", chatRoomDto);
			map.put("receiveDto", receiveDto);
			map.put("sendDto", sendDto);
			map.put("newChat", postMapper.getRecentChatingBy(chatRoomDto.getId())); // 최신 채팅
			map.put("count", postMapper.getOneChatingNotReadCount(chat_id, user_id)); // 안읽은 채팅 수
			
			list.add(map);
		}
		return list;
	}
	
	public ChatDto getRecentChatingBy(int chat_id) {
		return postMapper.getRecentChatingBy(chat_id);
	}
	
	// 1:1 채팅 리스트 가오기 
	public List<Map<String, Object>> getOneChatList(ChatOneStatusDto chatOneStatusDto, int chat_id) {
		List<Map<String, Object>> list = new ArrayList<>();
		// 읽음 업데이트
		chatOneStatusDto.setStatus("읽음");
		postMapper.updateOneStatus(chatOneStatusDto);
		
		// 읽음 업데이트
		List<ChatDto> chatDtoList = postMapper.getOneChatList(chat_id);
		for(ChatDto chatDto : chatDtoList) {
			Map<String, Object> map = new HashMap<>();
			UserDto userDto = postMapper.getUserById(chatDto.getUser_id());
			// status 안읽음 카운트
			
//			
			int count = postMapper.getOneStatusCount(chatDto.getId());
			map.put("chatDto", chatDto);
			map.put("userDto", userDto);
			map.put("count", count);
			
			list.add(map);
		}
		return list;
	}
	
	public int chatingPk() {
		return postMapper.chatingPk();
	}
	public void insertChating(ChatDto chatDto) {
		int chatPK = postMapper.chatingPk();
		
		// 채팅 인서트 //
		chatDto.setId(chatPK);
		postMapper.insertChating(chatDto);
		
		// 채팅 STATUS 인서트 //
		ChatOneStatusDto chatOneStatusDto = new ChatOneStatusDto();
		ChatOneStatusDto chatOneStatusDto2 = new ChatOneStatusDto();
		ChatRoomDto chatRoomDto = postMapper.chatOneRoomPK(chatDto.getChat_id());
		int sendId = chatRoomDto.getSend_id();
		int receiveId = chatRoomDto.getReceive_id();
		int chatingId = chatDto.getUser_id();
		if(chatingId == sendId) {
			chatOneStatusDto.setChating_id(chatPK);
			chatOneStatusDto.setUser_id(chatingId);
			chatOneStatusDto.setStatus("읽음");
			postMapper.insertOneStatus(chatOneStatusDto);
			chatOneStatusDto2.setChating_id(chatPK);
			chatOneStatusDto2.setUser_id(receiveId);
			chatOneStatusDto2.setStatus("안읽음");
			postMapper.insertOneStatus(chatOneStatusDto2);
		}else if(chatingId == receiveId) {
			chatOneStatusDto.setChating_id(chatPK);
			chatOneStatusDto.setUser_id(chatingId);
			chatOneStatusDto.setStatus("읽음");
			postMapper.insertOneStatus(chatOneStatusDto);
			chatOneStatusDto2.setChating_id(chatPK);
			chatOneStatusDto2.setUser_id(sendId);
			chatOneStatusDto2.setStatus("안읽음");
			postMapper.insertOneStatus(chatOneStatusDto2);
		}else {
			System.out.println("1:1 채팅 읽음, 안읽음 실패");
		}
	}
	
	public void insertOneStatus(ChatOneStatusDto chatOneStatusDto) {
		postMapper.insertOneStatus(chatOneStatusDto);
	}
	
	public int getOneChatingNotReadCount(int chat_id, int user_id) {
		return postMapper.getOneChatingNotReadCount(chat_id, user_id);
	}
	
	
	
	// 프로필
	// 프로필 온도 테이블 조회
	public TemperatureDto getTemperature(int userId) {
		return postMapper.getTemperature(userId);
	}
	// 리뷰 리스트
	public List<Map<String, Object>> getReviewList(int userId) {
		List<Map<String, Object>> list = new ArrayList<>();
		List<PostReviewDto> PostReviewDtoList = postMapper.getReviewList(userId);
		for(PostReviewDto postReviewDto : PostReviewDtoList) {
			Map<String, Object> map = new HashMap<>();
			UserDto sendDto = postMapper.getUserById(postReviewDto.getSend_id());
			map.put("postReviewDto", postReviewDto);
			map.put("sendDto", sendDto);
			list.add(map);
		}
		return list;
		
	}
	// 내 리뷰 카운트
	public Integer getReviewCount(int userId) {
		return postMapper.getReviewCount(userId);
	}
	
	
	
	// myPage
	// 진행 여행 리스트
	public List<Map<String, Object>> getIngPostList(int userId) {
		List<Map<String, Object>> list = new ArrayList<>();
		List<PostDto> postDtoList = postMapper.getIngPostList(userId);
		for(PostDto postDto : postDtoList) {
			Map<String, Object> map1 = new HashMap<>();
			int postId = postDto.getId();
			List<PostImageDto> postImg = postMapper.getPostImageByPostId(postId);
			int joinUserCount = postMapper.joinUserCount(postId);
			Date now = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yy.MM.dd");
			String nowDate = sdf.format(now);
			System.out.println("현재 날짜 : " + nowDate);
			
			map1.put("postDto", postDto);
			map1.put("postImg", postImg);
			map1.put("nowDate", nowDate);
			map1.put("joinUserCount", joinUserCount);
			list.add(map1);
		}
		return list;
	}
	
	// 지난 여행 리스트
	public List<Map<String, Object>> getPastPostList(int userId) {
		List<Map<String, Object>> list = new ArrayList<>();
		List<PostDto> postDtoList = postMapper.getPastPostList(userId);
		for(PostDto postDto : postDtoList) {
			Map<String, Object> map1 = new HashMap<>();
			int postId = postDto.getId();
			List<PostImageDto> postImg = postMapper.getPostImageByPostId(postId);
			
			Integer reviewCount = postMapper.getPostMyReviewCount(postId, userId); // 리뷰 카운트
			int partyCount = postMapper.joinUserCount(postId); // 해당 동행 파티원 카운트
			System.out.println("리뷰 카운트 : " + reviewCount);
			System.out.println("파티 카운트 : " + partyCount);
			
			map1.put("postDto", postDto);
			map1.put("postImg", postImg);
			map1.put("reviewCount", reviewCount);
			map1.put("partyCount", partyCount);
			
			
			List<PostReviewDto> reviewDtoList = postMapper.getReviewPostUserList(postId, userId);
			List<Map<String, Object>> partyUserList = new ArrayList<>();
			List<JoinUserDto> joinUserDtoList = postMapper.getJoinUserByPostId(postId);
			for(JoinUserDto joinUserDto : joinUserDtoList) { // 파티인원리스트 // id로 불러와서
				int joinUserId = joinUserDto.getUser_id();
				if(joinUserId == userId) {
					continue;
				}
				UserDto joinDto = postMapper.getUserById(joinUserId);
				boolean foundInReview = false;
					
					for(PostReviewDto reviewDto : reviewDtoList) {
						if(joinUserId == reviewDto.getReceive_id()) {
							foundInReview = true;
							System.out.println("foundInReview : " + foundInReview);
							break;
						}
					}
				
				if(!foundInReview) {
					System.out.println("false 실행 횟수");
					Map<String, Object> map2 = new HashMap<>();
					System.out.println("joinUserDto : " + joinUserDto);
					System.out.println("joinDto : " + joinDto.getUser_id() + joinDto.getUser_name());
					map2.put("joinUserDto", joinUserDto);
					map2.put("joinDto", joinDto);
					
					partyUserList.add(map2);
				}
			}
			map1.put("partyUserList", partyUserList);
			list.add(map1);
		}
		return list;
	}
	
	public List<PostReviewDto> getReviewPostUserList(int post_id, int user_id) {
		return postMapper.getReviewPostUserList(post_id, user_id);
	}
	
	
	public void insertPostReview(PostReviewDto postReviewDto) {
		postMapper.insertPostReview(postReviewDto);
		postMapper.updatePostReviewUserInfo(postReviewDto.getRating(), postReviewDto.getReceive_id());
	}
	
	public void updatePostReviewUserInfo(int rating, int receive_id) {
		postMapper.updatePostReviewUserInfo(rating, receive_id);
	}
	
	
	
	
	

	
	//황준 테스트
	public void registerPostSchedule(String[] placeName,String[] placeAddress, String[] estimated, String[] memo,int dayNumber) {
		for(int i=0; i<placeName.length; i++) {
			HwangDto hwangDto = new HwangDto();
			hwangDto.setDay_id(dayNumber);
			hwangDto.setEstimated_time(estimated[i]);
			hwangDto.setOrder_no(i+1);
			hwangDto.setPlace_location(placeAddress[i]);
			hwangDto.setPlace_title(placeName[i]);
			hwangDto.setTrip_memo(memo[i]);
			postMapper.insertPostSchedule(hwangDto);
		}
	}
}
