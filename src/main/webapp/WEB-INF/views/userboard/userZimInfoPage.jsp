<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

<title>userZimInfoPage</title>
<style>
	    .card-image {
            width: 80px;
            height: 80px;
            overflow: hidden;
            border-radius: 50%;
            border: 1px solid rgba(0, 0, 0, 0.125);
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 20px; 
            margin-left: 70px;
        }
        .card-image img {
        max-width: 100%;
        max-height: 100%;
    	}
        
        .card-body {
            text-align: center;
        }

</style>
</head>
<body>

	<jsp:include page="../common/topNavi.jsp" />

<div class="container-fluid">
    <div class="row">
        <div class="col-2"></div>
        <div class="col-8">
            <div class="row">
                <div class="col-12">
                    <h4 class="mt-5">프로필 관리</h4>
                </div>
                <div class="col">
                    <div class="row mt-4">
                    
                        <div class="col-3">
                            <div class="card" style="width: 14rem;">
                                <div class="card-image">
                                    <img src="/uploadFiles/${myPage.userDto.profile_img}" class="card-img-top">
                                </div>
                                <div class="card-body">
                                    <p class="card-text">${myPage.userDto.user_name}</p>
                                    <a href="./myPage?id=${sessionUser.id}" style="text-decoration: none;">
                                        <span class="card-text"><i class="bi bi-house"></i></span>
                                    </a>
                                </div>
                            </div>
                            <div class="card" style="width: 14rem; margin-top: 20px;">
                                <div class="card-point">
                                    <p class="card-text" style="font-size: 14px; margin-top: 10px; margin-left: 10px;">내 포인트 :
                                        <span style="float: right; color: #0078ff; margin-right: 10px;">${myPage.myPoint}</span>
                                    </p>
                                    <p class="card-text" style="font-size: 14px; margin-top: -10px; margin-bottom: 10px; margin-left: 10px;">
                                        내 쿠폰 : <span style="float: right; color: #0078ff; margin-right: 10px;">${myPage.myCouponCount}</span>
                                    </p>
                                </div>
                            </div>
                            <div class="row mt-4">
                                <h5>포인트샵</h5>
                                <a href="./orderHistoryPage" style="text-decoration: none;">
                                    <span style="font-size: 15px; color: gray;">주문 내역 조회</span>
                                </a>
                            </div>
                            <div class="row mt-4">
                                <h5>쿠폰</h5>
                                <a href="./userCouponPage" style="text-decoration: none;">
                                    <span style="font-size: 15px; color: gray;">내 쿠폰함</span>
                                </a>
                            </div>
                            <div class="row mt-4">
                                <h5>동행</h5>
                                <p style="font-size: 15px; color: gray;">파티 현황</p>
                                <p style="font-size: 15px; color: gray;">파티 신청 목록</p>
                            </div>
                            <div class="row mt-4">
                                <h5>숙소</h5>
                                <p style="font-size: 15px; color: gray;">현재 예약 내역</p>
                                <p style="font-size: 15px; color: gray;">지난 예역 내역</p>
                                <p style="font-size: 15px; color: gray;">내가 찜한 숙소</p>
                            </div>

                            <div class="row mt-4">
                                <h5>짐 서비스</h5>
                                <a href="../userboard/userZimInfoPage" style="text-decoration: none;">
                                    <span style="font-size: 15px; color: #0078ff;">배송 신청 내역</span>
                                </a>
                            </div>
                            <div class="row mt-4">
                                <h5>고객센터</h5>
                                <a href="../usercsboard/oneOnOneQaPage" style="text-decoration: none;">
                                    <span style="font-size: 15px; color: gray;">나의 문의 내역</span>
                                </a>
                            </div>
                        </div>

						<!-- 배송 신청 내역 -->
                        <div class="col-9">
                  	        <div class="row mb-4">
                            	<div class="col fs-4">배송 신청 내역 </div>
                            </div>
                            
							<c:forEach items="${list}" var="li">
                            <div class="row">
								<div class="col">
									<div class="card shadow-sm mb-4">
										<div class="card-body p-0">
											
											<div class="row px-3 py-3 text-start">
												<div class="col-3">
													<strong>
													${li.signUpDto.start_date.year}.
													${li.signUpDto.start_date.monthValue}.
													${li.signUpDto.start_date.dayOfMonth}
													픽업
													</strong>
												</div>
												<div class="col-6"></div>
												<div class="col-3 text-end">
													<a href="../userzim/zimDetailInfoPage?signUpId=${li.signUpDto.id}" class="link-primary link-offset-2 link-underline link-underline-opacity-0" style="text-decoration:none; font-size:16px;">
														배송 상세보기<i class="bi bi-chevron-right"></i>
													</a>
												</div>
											</div>
											
											<div class="row mx-3 mb-3 border rounded text-start">
												<div class="col">
													<div class="row p-3">
														<div class="col">
															<strong>${li.signUpDto.zim_progress}</strong>
															<span class="text-success" style="margin-left: 15px;">
																<strong>
																${li.signUpDto.arrive_date.year}.
																${li.signUpDto.arrive_date.monthValue}.
																${li.signUpDto.arrive_date.dayOfMonth}
																<c:choose>
																	<c:when test="${li.signUpDto.zim_progress eq '배송완료'}">
																	도착
																	</c:when>
																	<c:otherwise>도착예정</c:otherwise>
																</c:choose>
																</strong>
															</span>
														</div>
													</div>
													<div class="row px-3 pt-2">
														<div class="col-2">
															<img src="/uploadFiles/${li.signUpDto.zim_image_link }" alt="이미지가 없습니다." class="img-fluid" style="max-height : 100%;" onerror="this.src='../resources/img/noimg.png'">
														</div>
														<div class="col-10">
															<c:forEach items="${li.signCateList}" var="cateList" >
																<div class="row mb-2 p-0 text-body-secondary" style="font-size:14px">
																	<div class="col">
																		<span>- ${cateList.zimCategory.name}</span>
																		<span style="margin-left: 15px;">${cateList.zimCategory.zim_fee}원</span>
																		<span style="margin-left: 15px;">${cateList.zim.zim_amount}개</span>
																	</div>
																</div>
															</c:forEach>
														</div>
													</div>
													<div class="row p-3">
														<div class="col-6">
															<c:choose>
																<c:when test="${li.signUpDto.zim_progress eq '배송준비중'}">
																	<a href="../userzim/cancelZimSignUpProcess?id=${li.signUpDto.id}" class="btn btn-outline-danger btn-sm form-control">취소하기</a>
																</c:when>
																<c:otherwise>
																	<button type="button" class="btn btn-outline-danger btn-sm form-control" disabled>취소하기</button>
																</c:otherwise>
															</c:choose>
														</div>
														<div class="col-6">
															<c:choose>
															<c:when test="${li.signUpDto.zim_progress eq '배송완료'}">
																<c:choose>
																	<c:when test="${!empty li.reviewDto.zim_review_content}">
																		<!-- 모달 버튼 -->
																		<button type="button" class="btn btn-outline-primary btn-sm form-control" data-bs-toggle="modal" data-bs-target="#myReview">
																		    내가 쓴 리뷰보기
																		</button>
																		
																		<!-- 내가 쓴 리뷰보기 모달 -->
																		<div class="modal fade" id="myReview" tabindex="-1" aria-labelledby="myReviewLabel" aria-hidden="true">
																		    <div class="modal-dialog">
																		        <div class="modal-content">
																		            <div class="modal-body">
																		                <div class="row">
																		                    <div class="col">
																		                    	<div class="row fs-5 p-3 ">
																		                    		내 리뷰 보기
																		                    	</div>
																		                        <div class="row p-3 border-secondary-subtle border-top border-bottom ">
																		                        	<div class="col">
																		                        		<div class="row">
																				                            <div class="col-3"><img src="/uploadFiles/${li.userDto.profile_img}" alt="이미지가 없습니다." class="img-fluid" style="border-radius : 50%;" onerror="this.src='../resources/img/noimg.png'"></div>
																				                            <div class="col-9">
																				                                <div class="row">
																				                                    <div class="col">${li.userDto.user_name}</div>
																				                                </div>
																				                                <div class="row">
																				                                    <div class="col">
																				                                        <c:if test="${li.reviewDto.zim_star >= 0 && li.reviewDto.zim_star < 1}"><small><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i></small></c:if>
																				                                        <c:if test="${li.reviewDto.zim_star  >= 1 && li.reviewDto.zim_star < 1.5}"><small><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i></small></c:if>
																				                                        <c:if test="${li.reviewDto.zim_star  >= 1.5 && li.reviewDto.zim_star < 2}"><small><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-half text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i></small></c:if>
																				                                        <c:if test="${li.reviewDto.zim_star >= 2 && li.reviewDto.zim_star < 2.5}"><small><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i></small></c:if>
																				                                        <c:if test="${li.reviewDto.zim_star  >= 2.5 && li.reviewDto.zim_star < 3}"><small><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-half text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i></small></c:if>
																				                                        <c:if test="${li.reviewDto.zim_star >= 3 && li.reviewDto.zim_star < 3.5}"><small><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star text-warning"></i><i class="bi bi-star text-warning"></i></small></c:if>
																				                                        <c:if test="${li.reviewDto.zim_star >=3.5 && li.reviewDto.zim_star < 4}"><small><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-half text-warning"></i><i class="bi bi-star text-warning"></i></small></c:if>
																				                                        <c:if test="${li.reviewDto.zim_star >= 4 && li.reviewDto.zim_star < 4.5}"><small><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star text-warning"></i></small></c:if>
																				                                        <c:if test="${li.reviewDto.zim_star >= 4.5 && li.reviewDto.zim_star < 5}"><small><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-half text-warning"></i></small></c:if>
																				                                        <c:if test="${li.reviewDto.zim_star >= 5}"><small><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i><i class="bi bi-star-fill text-warning"></i></small></c:if>
																				                                    	<span class="text-body-secondary" style="font-size:14px">
		                                                                                                                	<fmt:formatDate value="${li.reviewDto.review_reg_date}" pattern="yyyy.MM.dd" /> 작성
																				                                    	</span>
																				                                    </div>
																				                                </div>
																							                    <div class="row mt-2 fw-semibold" style="font-size:14px">
				                                                                                                    <div class="col">${li.reviewDto.zim_review_title }</div>
				                                                                                                </div>
				                                                                                                <div class="row" style="font-size:14px">
				                                                                                                    <div class="col fw-light">${li.reviewDto.zim_review_content }</div>
				                                                                                                </div>																				                                
																				                            </div>
																			                            </div>
																		                            </div>
																		                        </div>
                                                                                                <div class="row mt-3">
                                                                                                	<div class="col-2"></div>
                                                                                                	<div class="col-8"></div>
                                                                                                	<div class="col-2">
                                                                                                		<button type="button" class="btn btn-outline-primary btn-sm" data-bs-dismiss="modal">닫기</button>
                                                                                                	</div>
                                                                                                </div>
																		                    </div>
																		                </div>
																		            </div>
																		        </div>
																		    </div>
																		</div>
																	</c:when>
																	<c:otherwise>
																		<a href="../userzim/zimWriteReviewPage?signUpId=${li.signUpDto.id}" class="btn btn-outline-primary btn-sm form-control">리뷰작성</a>
																	</c:otherwise>
																</c:choose>
															</c:when>
															<c:otherwise>
																<button type="button" class="btn btn-outline-primary btn-sm form-control" disabled>리뷰작성</button>
															</c:otherwise>
															</c:choose>
														</div>
													</div>
													
												</div>
											</div>
											
										</div>
									</div>
								</div>
                            </div>
							</c:forEach>
                        </div>
                        
                    </div>
                </div>	
            </div>
        </div>

        <div class="col-2"></div>
    </div>
</div>
<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>


