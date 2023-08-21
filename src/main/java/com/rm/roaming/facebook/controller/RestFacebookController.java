package com.rm.roaming.facebook.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.rm.roaming.dto.FeedCommentDto;
import com.rm.roaming.dto.FeedDto;
import com.rm.roaming.dto.FeedImageDto;
import com.rm.roaming.dto.FeedLikesDto;
import com.rm.roaming.dto.FollowDto;
import com.rm.roaming.dto.MessageDto;
import com.rm.roaming.dto.ReelsCommentDto;
import com.rm.roaming.dto.ReelsDto;
import com.rm.roaming.dto.ReelsLikesDto;
import com.rm.roaming.dto.UserDto;
import com.rm.roaming.facebook.service.FacebookServiceImpl;

@RestController
@RequestMapping("/facebook/*")
public class RestFacebookController {
	@Autowired
	private FacebookServiceImpl facebookService;
	
	@RequestMapping("toggleLike")
	public Map<String, Object> toggleLike(HttpSession session, FeedLikesDto feedLikesDto) {
		Map<String, Object> map = new HashMap<>();
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		feedLikesDto.setUser_id(sessionUser.getId());
		facebookService.toggleLike(feedLikesDto);
		map.put("result", sessionUser);
		return map;
	}
	@RequestMapping("toggleReelsLike")
	public Map<String, Object> toggleReelsLike(HttpSession session, ReelsLikesDto reelsLikesDto) {
		Map<String, Object> map = new HashMap<>();
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		reelsLikesDto.setUser_id(sessionUser.getId());
		System.out.println(reelsLikesDto.getReels_id());
		facebookService.toggleReelsLike(reelsLikesDto);
		map.put("result", sessionUser);
		return map;
	}
	@RequestMapping("toggleFeedLike")
	public Map<String, Object> toggleFeedLike(HttpSession session, FeedLikesDto feedLikesDto) {
		Map<String, Object> map = new HashMap<>();
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		feedLikesDto.setUser_id(sessionUser.getId());
		facebookService.toggleFeedLike(feedLikesDto);
		map.put("result", sessionUser);
		return map;
	}
	@RequestMapping("toggleHate")
	public Map<String, Object> toggleHate(HttpSession session, FeedLikesDto feedLikesDto) {
		Map<String, Object> map = new HashMap<>();
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		feedLikesDto.setUser_id(sessionUser.getId());
		facebookService.toggleHate(feedLikesDto);
		map.put("result", sessionUser);
		return map;
	}
	@RequestMapping("isLiked")
	public Map<String, Object> isLiked(HttpSession session, FeedLikesDto feedLikesDto) {
		Map<String, Object> map = new HashMap<>();
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		if(sessionUser == null) {
			map.put("result", "fail");
			map.put("reason", "로그인 되어 있지 않음..");
			return map;
		}
		feedLikesDto.setUser_id(sessionUser.getId());
		map.put("result", "success");
		map.put("isLike", facebookService.isLiked(feedLikesDto));
		map.put("isHate", facebookService.isHated(feedLikesDto));
		return map;
	}
	@RequestMapping("isReelsLike")
	public Map<String, Object> isReelsLike(HttpSession session, ReelsLikesDto reelsLikesDto) {
		Map<String, Object> map = new HashMap<>();
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		if(sessionUser == null) {
			map.put("result", "fail");
			map.put("reason", "로그인 해라!!");
		}
		reelsLikesDto.setUser_id(sessionUser.getId());
		map.put("result", "success");
		map.put("isReelsLike", facebookService.isReelsLike(reelsLikesDto));
		return map;
	}
	@RequestMapping("isFeedLike")
	public Map<String, Object> isFeedLike(HttpSession session, FeedLikesDto feedLikesDto) {
		Map<String, Object> map = new HashMap<>();
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		if(sessionUser == null) {
			map.put("result", "fail");
			map.put("reason", "로그인 해라!!");
		}
		feedLikesDto.setUser_id(sessionUser.getId());
		map.put("isFeedLike", facebookService.isFeedLike(feedLikesDto));
		map.put("result", "success");
		return map;
	}
	@RequestMapping("isHated")
	public Map<String, Object> isHated(HttpSession session, FeedLikesDto feedLikesDto) {
		Map<String, Object> map = new HashMap<>();
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		if(sessionUser == null) {
			map.put("result", "fail");
			map.put("reason", "로그인 되어 있지 않음..");
			return map;
		}
		feedLikesDto.setUser_id(sessionUser.getId());
		map.put("result", "success");
		map.put("isHate", facebookService.isHated(feedLikesDto));
		map.put("isLike", facebookService.isLiked(feedLikesDto));
		return map;
	}
	@RequestMapping("getTotalLikeCount")
	public Map<String, Object> getTotalLikeCount(int feedId) {
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		map.put("count", facebookService.getTotalLike(feedId));
		map.put("chatingCount", facebookService.getTotalHate(feedId));
		return map;
	}
	@RequestMapping("getTotalReelsCount")
	public Map<String, Object> getTotalReelsCount(int reels_id) {
		Map<String, Object> map = new HashMap<>();
		map.put("reelsCount", facebookService.countReelsTotal(reels_id));
		map.put("result", "success");
		return map;
	}
	@RequestMapping("getTotalFeedCount")
	public Map<String, Object> getTotalFeedCount(int feed_id) {
		Map<String, Object> map = new HashMap<>();
		map.put("feedCount", facebookService.countFeedTotal(feed_id));
		map.put("result", "success");
		return map;
	}
	@RequestMapping("registerComment")
	public Map<String, Object> registerComment(HttpSession session, FeedCommentDto feedCommentDto) {
		Map<String, Object> map = new HashMap<>();
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		feedCommentDto.setUser_comment_id(sessionUser.getId());
		feedCommentDto.setUser_id(sessionUser.getId());
		facebookService.registerComment(feedCommentDto);
		facebookService.insertFeedPoint(sessionUser.getId());
		map.put("result", "success");
		return map;
	}
	@RequestMapping("deleteComment")
	public Map<String, Object> deleteComment(int id) {
		Map<String, Object> map = new HashMap<>();
		facebookService.deleteComment(id);
		map.put("result", "success");
		return map;
	}
	@RequestMapping("updateComment")
	public Map<String, Object> updateComment(FeedCommentDto feedCommentDto) {
		Map<String, Object> map = new HashMap<>();
		facebookService.updateComment(feedCommentDto);
		map.put("result", "success");
		return map;
	}
	@RequestMapping("getCommentList")
	public Map<String, Object> getCommentList(int feedId) {
		Map<String, Object> map = new HashMap<>();
		map.put("feedCommentDto", facebookService.getCommentList(feedId));
		map.put("result", "success");
		return map;
	}
	@RequestMapping("getReelsList")
	public Map<String, Object> getReelsList(HttpSession session) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		
		if(sessionUser == null) {
			Map<String, Object> map = new HashMap<>();
			map.put("list", facebookService.getReelsList(0));
			return map;
		}
			
		int id = sessionUser.getId();

		Map<String, Object> map = new HashMap<>();
		map.put("list", facebookService.getReelsList(id));
		
		return map;
	}
	@RequestMapping("getMyPageInfo")
	public Map<String, Object> getMyPageInfo(HttpSession session) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		Map<String, Object> map = new HashMap<>();
		map.put("map", facebookService.selectUserImgDefault(sessionUser.getId()));
		map.put("list", facebookService.selectMyFeed(sessionUser.getId()));
		map.put("count", facebookService.selectMyFeedCount(sessionUser.getId()));
		map.put("follow", facebookService.selectFollow(sessionUser.getId()));
		map.put("follower", facebookService.selectFollower(sessionUser.getId()));
		
		return map;
	}
	@RequestMapping("getBoardList")
	public Map<String, Object> getBoardList(HttpSession session) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		Map<String, Object> map = new HashMap<>();
		map.put("list", facebookService.selectMyFeed(sessionUser.getId()));
		return map;
	}
	@RequestMapping("getMyBoardList")
	public Map<String, Object> getMyBoardList(HttpSession session, int userId) {
		Map<String, Object> map = new HashMap<>();
		map.put("list", facebookService.selectMyFeed(userId));
		return map;
	}
	@RequestMapping("followProcess")
	public Map<String, Object> followProcess(FollowDto followDto) {
		facebookService.insertFollow(followDto);
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		return map;
	}
	@RequestMapping("followDelete")
	public Map<String, Object> followDelete(FollowDto followDto) {
		facebookService.deleteFollow(followDto);
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		return map;
	}
	
	@RequestMapping("messageUserInfo")
	public Map<String, Object> messageUserInfo(HttpSession session) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		int receiveId = sessionUser.getId();
		Map<String, Object> map = new HashMap<>();
		map.put("list", facebookService.selectMessageUser(receiveId));
		return map;
	}
	@RequestMapping("randomUsers")
	public Map<String, Object> randomUsers(HttpSession session) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		
		if(sessionUser != null) {
			Map<String, Object> map = new HashMap<>();
			int id = sessionUser.getId();
			map.put("list", facebookService.randomUserList(id));
			return map;			
		} else {
			Map<String, Object> map = new HashMap<>();
			map.put("result", "fail");
			map.put("reason", "로그인 되어 있지 않음..");
			return map;
		}
	}
	@RequestMapping("chatUserInfo")
	public Map<String, Object> chatUserInfo(HttpSession session) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		int id = sessionUser.getId();
		Map<String, Object> map = new HashMap<>();
		
		return map;
	}
	@RequestMapping("registerChating")
	public Map<String, Object> chatRoomInfo(MessageDto messageDto, HttpSession session) {
		Map<String, Object> map = new HashMap<>();
		
		facebookService.insertMyChat(messageDto);
		map.put("result", "success");
		return map;
	}
	@RequestMapping("reloadChating")
	public Map<String, Object> reloadChating(HttpSession session, MessageDto messageDto, int receiveId) {
		Map<String, Object> map = new HashMap<>();
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		messageDto.setSend_id(sessionUser.getId());
		messageDto.setReceive_id(receiveId);
		map.put("list", facebookService.selectMyChat(messageDto));
		map.put("user", facebookService.selectChatUser(receiveId));
		return map;
	}
	@RequestMapping("getUserProfile")
	public Map<String, Object> getUserProfile(int userId, HttpSession session, FollowDto followDto) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		int id = sessionUser.getId();
		followDto.setSend_id(id);
		followDto.setReceive_id(userId);
		
		Map<String, Object> map = new HashMap<>();
		map.put("map", facebookService.selectUserImgDefault(userId));
		map.put("list", facebookService.selectMyFeed(userId));
		map.put("count", facebookService.selectMyFeedCount(userId));
		map.put("follow", facebookService.selectFollow(userId));
		map.put("follower", facebookService.selectFollower(userId));
		map.put("babo", facebookService.selectMyIdFollow(followDto));
		return map;
	}
	@RequestMapping("deleteFollowUser")
	public Map<String, Object> deleteFollowUser(FollowDto followDto) {
		facebookService.deleteFollow(followDto);
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		return map;
	}
	@RequestMapping("registerReelsComment")
	public Map<String, Object> registerReelsComment(HttpSession session, ReelsCommentDto reelsCommentDto) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		reelsCommentDto.setUser_comment_id(sessionUser.getId());
		facebookService.insertReelsComment(reelsCommentDto);
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		return map;
	}
	@RequestMapping("registerFeedComment")
	public Map<String, Object> registerFeedComment(HttpSession session, FeedCommentDto feedCommentDto) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		feedCommentDto.setUser_comment_id(sessionUser.getId());
		facebookService.insertFeedCommentMain(feedCommentDto);
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		return map;
	}
	@RequestMapping("registerReelsModalComment")
	public Map<String, Object> registerReelsModalComment(HttpSession session, ReelsCommentDto reelsCommentDto) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		reelsCommentDto.setUser_comment_id(sessionUser.getId());
		facebookService.insertReelsComment(reelsCommentDto);
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		return map;
	}
	@RequestMapping("registerFeedModalComment")
	public Map<String, Object> registerFeedModalComment(HttpSession session, FeedCommentDto feedCommentDto) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		feedCommentDto.setUser_comment_id(sessionUser.getId());
		facebookService.insertFeedCommentMain(feedCommentDto);
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		return map;
	}
	@RequestMapping("reeslsCommentModal")
	public Map<String, Object> reeslsCommentModal(int reels_id) {	
		Map<String, Object> map = new HashMap<>();
		map.put("list", facebookService.getReelsModalComment(reels_id));
		map.put("result", "success");
		return map;
	}
	@RequestMapping("feedCommentModal")
	public Map<String, Object> feedCommentModal(int feed_id) {	
		Map<String, Object> map = new HashMap<>();
		map.put("list", facebookService.getFeedModalComment(feed_id));
		map.put("map", facebookService.feedCommentModal(feed_id));
		map.put("result", "success");
		return map;
	}
	//릴스 피드 한번에 리스트에 담기..
	@RequestMapping("facebookMainUserList")
	public Map<String, Object> facebookMainUserList(HttpSession session) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		if(sessionUser == null) {
			Map<String, Object> map = new HashMap<>();
			map.put("list", facebookService.getReelsList(0));
			return map;
		}
		Map<String, Object> map = new HashMap<>();
		map.put("list", facebookService.facebookMainList(sessionUser.getId()));
		return map;
	}
	@RequestMapping("mainUnionList")
	public Map<String, Object> mainUnionList() {
		
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		map.put("list", facebookService.selectUnion());
		return map;
	}
	@RequestMapping("storyMain")
	public Map<String, Object> selectStoryUser(HttpSession session) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		if(sessionUser != null) {
			Map<String, Object> map = new HashMap<>();
			map.put("list", facebookService.selectStoryUser(sessionUser.getId()));
			return map;
		}else {
			Map<String, Object> map = new HashMap<>();
			map.put("result", "fail");
			return map;
		}
		
	}
	@RequestMapping("storyModal")
	public Map<String, Object> storyModal(int id) {
		Map<String, Object> map = new HashMap<>();
		map.put("map", facebookService.storyModal(id));
		return map;
	}
	//검색
	@RequestMapping("searchUser")
	public Map<String, Object> searchUser(String search) {
		Map<String, Object> map = new HashMap<>();
		map.put("list", facebookService.selectSearch(search));
		return map;
	}
	//알람
	@RequestMapping("alertFollow")
	public Map<String, Object> alertFollow(HttpSession session) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		int id = sessionUser.getId();
		Map<String, Object> map = new HashMap<>();
		map.put("list", facebookService.alertFollow(id));
		return map;
	}
	@RequestMapping("feedDetailList")
	public Map<String, Object> selectFeedDetailList() {
		Map<String, Object> map = new HashMap<>();
		map.put("list", facebookService.selectFeedDetailList());
		return map;
	}
	@RequestMapping("naviPhoto")
	public Map<String, Object> naviPhoto(HttpSession session) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		if(sessionUser != null) {
			int userId = sessionUser.getId();
			Map<String, Object> map = new HashMap<>();
			map.put("map", facebookService.naviPhoto(userId));
			return map;
		}else {
			Map<String, Object> map = new HashMap<>();
			map.put("result", "fail");
			return map;
			
		}
		
	}
	@RequestMapping("updateChatCount")
	public Map<String, Object> updateChatCount(HttpSession session, int receiveId, MessageDto messageDto) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		int sendId = sessionUser.getId();
		messageDto.setSend_id(sendId);
		messageDto.setReceive_id(receiveId);
		facebookService.updateChatCount(messageDto);
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		return map;
	}
	@RequestMapping("uploadFeed")
	public Map<String, Object> uploadFeed(HttpSession session, FeedDto feedDto,
			FeedImageDto feedImageDto, MultipartFile[] feedImageFiles) {
		System.out.println(feedImageFiles);
		Map<String, Object> map = new HashMap<>();
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		if(sessionUser == null) {
			map.put("result", "fail");
		}
		
		List<FeedImageDto> feedImageDtoList = new ArrayList<>();
		if(feedImageFiles != null) {
			for(MultipartFile multipartFile : feedImageFiles) {
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
				} catch(Exception e) {
					e.printStackTrace();
				}
				FeedImageDto feedImageDtoo = new FeedImageDto();
				feedImageDtoo.setFeed_image(saveFileName);
				feedImageDtoList.add(feedImageDtoo);
			}
			int userId = sessionUser.getId();
			feedDto.setUser_id(userId);
			facebookService.makeFeedRegistration(feedDto, feedImageDtoList);
			facebookService.insertFeedPoint(userId);
		}
		
		return map;
	}
	@RequestMapping("uploadReels")
	public Map<String, Object> uploadReels(HttpSession session, ReelsDto reelsDto, MultipartFile reelsFile) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		int sendId = sessionUser.getId();
		if(reelsFile != null) {
			String rootFolder = "/Users/su/Desktop/uploadFiles/";
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			String today = sdf.format(new Date());
			File targetFolder = new File(rootFolder + today);
			if(!targetFolder.exists()) {
				targetFolder.mkdirs();
			}
			String fileName = UUID.randomUUID().toString();
			fileName += "_" + System.currentTimeMillis();
			String originalFileName = reelsFile.getOriginalFilename();
			String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
			String saveFileName = today + "/" + fileName + ext;
			try {
				reelsFile.transferTo(new File(rootFolder + saveFileName));
			} catch(Exception e) {
				e.printStackTrace();
			}
			reelsDto.setReels_video(saveFileName);
		}
		int userId = sessionUser.getId();
		reelsDto.setUser_id(userId);
		facebookService.makeReelsRegistration(reelsDto);
		facebookService.insertFeedPoint(userId);
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		return map;
	}
	@RequestMapping("saveFiles")
	public Map<String, Object> saveFiles(HttpSession session) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		int sendId = sessionUser.getId();
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		return map;
	}
	@RequestMapping("getMyReels")
	public Map<String, Object> getMyReels(HttpSession session, int userId) {
		UserDto sessionUser = (UserDto)session.getAttribute("sessionUser");
		int sendId = sessionUser.getId();
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		map.put("list", facebookService.myPageUserReels(userId));
		return map;
	}
}
