package com.rm.roaming.post.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

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

public interface PostMapper {

	// pk id 생성
	public int createPk();
	// 여행 게시글 등록
	public void insertPost(PostDto postDto);
	// 여행 게시글 수정
	public void updatePost(PostDto postDto);
	// 여행 게시글 일차 수정
	public void updatePostDays(PostDto postDto);
	// 여행 게시글 리스트 가져오기
	public List<PostDto> getPostList(@Param("page")int page, @Param("searchValue")String searchValue, @Param("category") String category);
	// 여행 게시글 전체 카운트
	public int getPostCount();
	// 여행 게시글 Id로 가져오기
	public PostDto getPostById(int id);
	// 여행 게시글 작성자 정보 가져오기
	public UserDto getPostByCreateId(int create_id);
	// 파티참가
	public void insertPartyJoin(JoinUserDto joinUserDto);
	// 조회수 증가
	public void viewsUpdate(int id);
	// 참가신청
	public void insertJoinConfirm(JoinConfirmDto joinConfirmDto);
	// 참가신청 리스트
	public List<JoinConfirmDto> selectJoinConfirm(int create_id);
	// 참가신청 status 업데이트
	public void updatePostStatus(JoinConfirmDto joinConfirmDto);
	// 게시물 신고하기
	public void insertReport(ReportDto reportDto);
	// 게시물 스케줄 작성 유무 카운트
	public int getScheduleCount(int post_id);
	// 유저 정보 가져오기
	public UserDto getUserById(int userId);
	// 파티참가 유저 리스트
	public List<JoinUserDto> getJoinUserByPostId(int id);
	// 파티참가 인원 수
	public int joinUserCount(int id);
	
	// 동행참가 status 
	public JoinConfirmDto selectJoinStatus(JoinConfirmDto joinConfirmDto);
	// 해당 파티원 카운터 가져오기
	public int getJoinUserCount(JoinConfirmDto joinConfirmDto);

	// 여행 게시글 이미지 등록
	public void insertPostImage(PostImageDto postImageDto);
	// 여행 게시글 이미지 리스트 가져오기
	public List<PostImageDto> getPostImageByPostId(int postId);
	
	// 게시물 댓글 등록
	public void insertPostComment(CommentDto commentDto);
	// 게시물 대댓글 등록
	public void insertPostReComment(ReCommentDto reCommentDto);
	// 게시물 댓글 수정
	public void commentModify(CommentDto commentDto);
	// 게시물 댓글 삭제
	public void commentDelete(int commentId);
	// 게시물 대댓글 수정
	public void reCommentModify(ReCommentDto reCommentDto);
	// 게시물 대댓글 삭제
	public void reCommentDelete(int reCommentId);
	// 게시물 댓글 가져오기
	public List<CommentDto> getPostComment(int postId);
	// 게시물 리댓글 가져오기
	public List<ReCommentDto> getPostReComment(int commentId);
	// 게시물 댓글 총합
	public int getPostCommentTotalCount(int postId);
	
	// 게시물 좋아요 추가
	public void insertLike(PostLikeDto postLikeDto);
	// 게시물 좋아요 삭제
	public void deleteLike(PostLikeDto postLikeDto);
	// 게시물 좋아요 개수 가져오기
	public int getLikeCount(PostLikeDto postLikeDto);
	// 게시물 좋아요 총개수 가져오기
	public int getLikeTotalCount(int postId);
	// 댓글 좋아요 추가
	public void insertCommentLike(CommentLikeDto commentLikeDto);
	// 댓글 좋아요 삭제
	public void deleteCommentLike(CommentLikeDto commentLikeDto);
	// 댓글 좋아요 개수 가져오기
	public int getCommentLikeCount(CommentLikeDto commentLikeDto);
	// 댓글 좋아요 총개수 가져오기
	public int getCommentLikeTotalCount(int commentId);
	// 대댓글 좋아요
	public void insertReCommentLike(ReCommentLikeDto reCommentLikeDto);
	public void deleteReCommentLike(ReCommentLikeDto reCommentLikeDto);
	public int getReCommentLikeCount(ReCommentLikeDto reCommentLikeDto);
	public int getReCommentLikeTotalCount(int recommentId);
	
	// 파티방 게시물
	public void insertBoard(PartyBoardDto partyBoardDto);
	public List<PartyBoardDto> selectBoardList(int post_id);
	public PartyBoardDto selectBoardById(int board_id);
	public void deleteBoardById(int id);
	public void updateBoardById(PartyBoardDto partyBoardDto);
	public void boardViewsUpdate(int board_id);
	
	
	// 일차 추가
	public void insertNewDay(DayDto dayDto);
	// 일차 가져오기
	public List<DayDto> selectNewDay(int postId);
	// 일차 삭제
	public void deleteNewDays(int id);
//	public void deleteDayId(int id);
	// 게시물 스케줄 인서트
	public void insertSchedule(RequestScheduleDto.ScheduleDto scheduleDto);
	// 게시물 스케줄 가져오기
	public List<SchedulerDto> getScheduleList(int day_id);
	public void deleteSchedules(int day_id);
	
	// 채팅방 구현
	// 채팅 PK
	public int getGroupChatPk();
	public List<UserDto> getChatJoinUserPostId(int id);
	// 채팅 status 인서트
	public void insertGroupStatus(ChatGroupStatusDto chatGroupStatusDto);
	// 그룹 인원 리스트 가져오기
	public List<JoinUserDto> getGroupUserIdList(int post_id);
	// 채팅 안읽음 카운트
	public int getGroupChatCount(int chating_id);
	// 그룹 유저별 안읽은 카운트
	public int getGroupNotReadCount(@Param("post_id")int post_id, @Param("user_id")int user_id);
	// 채팅방 인서트
	public void insertPartyChating(PostChatDto postChatDto);
	// 채팅방 status 읽음 업데이트
	public void updateGroupStatus(ChatGroupStatusDto chatGroupStatusDto);
	// 채팅방 그룹 리스트
	public List<PostChatGroupDto> getPartyGroupList(int user_id);
	
	public PostChatDto getRecentChatingByPostId(int post_id);
	// 채팅방 인원 카운트
	public int getGroupPartyRoomCount(int post_id);
	// 해당 채팅방 채팅 리스트
	public List<PostChatDto> getChatList(int post_id);

	// 1:1 채팅방 인서트
	public void insertOneChat(ChatRoomDto chatRoomDto);
	// 1:1 채팅방 가져오기
	public List<ChatRoomDto> getChatRoomList(int user_id);
	// 1:1 채팅방 최신 채팅 가져오기
	public ChatDto getRecentChatingBy(int chat_id);
	// 1:1 채팅방 pk로 가져오기
	public ChatRoomDto chatOneRoomPK(int id);
	// 1:1 채팅 리스트 가져오기
	public List<ChatDto> getOneChatList(int chat_id);
	// 1:1 채팅 PK
	public int chatingPk();
	// 1:1 채팅 인서트
	public void insertChating(ChatDto chatDto);
	// 1:1 읽음 안읽음 인서트
	public void insertOneStatus(ChatOneStatusDto chatOneStatusDto);
	// 1:1 읽음 업데이트
	public void updateOneStatus(ChatOneStatusDto chatOneStatusDto);
	// 1:1 같은 채팅방이 있는지 확인
	public ChatRoomDto chatRoomCheck(ChatRoomDto chatRoomDto);
	// 1:1 채팅방 안읽음 개수 체크
	public int getOneChatingNotReadCount(@Param("chat_id") int chat_id, @Param("user_id") int user_id);
	// 1:1 update readCount
	public void updateOneReadCount(int chat_id);
	// 1:1 status count
	public int getOneStatusCount(int id);
	
	// 프로필
	// 프로필 온도 테이블 조회
	public TemperatureDto getTemperature(int userId);
	// 리뷰 리스트
	public List<PostReviewDto> getReviewList(int userId);
	// 내 리뷰 카운트
	public Integer getReviewCount(int userId);
	
	// myPage
	// 진행 여행 리스트
	public List<PostDto> getIngPostList(int userId);
	// 지난 여행 리스트
	public List<PostDto> getPastPostList(int userId);
	// post 리뷰 리스트
	public List<PostReviewDto> getReviewPostUserList(@Param("postId")int postId, @Param("userId")int userId);
	// post 리뷰 등록
	public void insertPostReview(PostReviewDto postReviewDto);
	// post 리뷰 작성 카운트
	public int getPostMyReviewCount(@Param("postId")int postId, @Param("userId")int userId);
	// 회원 매너온도 업데이트
	public void updatePostReviewUserInfo(@Param("rating")int rating, @Param("receive_id")int receive_id);
	
	
	
	
	
	
	
	//황준 테스트
	public void insertPostSchedule(HwangDto hwangDto);
}
