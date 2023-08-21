<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

<title>zimDetailInfoPage</title>
</head>
<body>

	<jsp:include page="../common/topNavi.jsp" />
	
	<div class="container-fluid">
		<div class="row mt-4">
			<div class="col-3"></div>
			<div class="col-6">
			
			   <div class="row mb-4">
			      <div class="col fs-4">배송 상세 내역 </div>
			   </div>
			   
			   <div class="row">
			      <div class="col">
			         <div class="card shadow-sm mb-4">
			            <div class="card-body p-0">
			               <div class="row px-3 py-3 text-start">
			                  <div class="col">
			                     <strong>
			                        ${signUpDto.start_date.year}.
			                        ${signUpDto.start_date.monthValue}.
			                        ${signUpDto.start_date.dayOfMonth}
	                                 <c:choose>
	                                 	<c:when test="${signUpDto.start_date.hour <=9}">0${signUpDto.start_date.hour}</c:when>
	                                 	<c:otherwise>${signUpDto.start_date.hour}</c:otherwise>
	                                 </c:choose>
	                                 :
                               	     <c:choose>
		                                 <c:when test="${signUpDto.start_date.minute <= 9}">0${signUpDto.start_date.minute}</c:when>
		                                 <c:otherwise>${signUpDto.start_date.minute}</c:otherwise>
                                	 </c:choose>
			                        픽업
			                     </strong>
			                  </div>
			               </div>
			               <div class="row mx-3 mb-3 border rounded text-start">
			                  <div class="col">
			                     <div class="row p-3">
			                        <div class="col">
			                           <strong>${signUpDto.zim_progress}</strong>
			                           <span class="text-success" style="margin-left: 15px;">
			                              <strong>
			                                 ${signUpDto.arrive_date.year}.
			                                 ${signUpDto.arrive_date.monthValue}.
			                                 ${signUpDto.arrive_date.dayOfMonth}&nbsp
			                                 <c:choose>
			                                 	<c:when test="${signUpDto.arrive_date.hour <=9}">0${signUpDto.arrive_date.hour}</c:when>
			                                 	<c:otherwise>${signUpDto.arrive_date.hour}</c:otherwise>
			                                 </c:choose>
			                                 :
			                                 <c:choose>
				                                 <c:when test="${signUpDto.arrive_date.minute <= 9}">0${signUpDto.arrive_date.minute}</c:when>
				                                 <c:otherwise>${signUpDto.arrive_date.minute}</c:otherwise>
			                                 </c:choose>
			                                 <c:choose>
			                                    <c:when test="${signUpDto.zim_progress eq '배송완료'}">
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
			                           <img src="/uploadFiles/${signUpDto.zim_image_link }" alt="이미지가 없습니다." class="img-fluid" style="max-height : 100%;" onerror="this.src='../resources/img/noimg.png'">
			                        </div>
			                        <div class="col-10">
		                        	<c:forEach items="${signCateList}" var="cateList">
		                            	<div class="row mb-2 p-0 text-body-secondary" style="font-size:14px">
		                                	<div class="col">
			                                    <span>- ${cateList.zimCategory.name}</span>
			                                    <span style="margin-left: 15px;">${cateList.zimCategory.zim_fee}원</span>
			                                    <span style="margin-left: 15px;">${cateList.zim.zim_amount}개</span>
		                                	</div>
		                            	</div>
		                        	</c:forEach>
			                            <div class="row mt-3 p-0">
			                            	<div class="col text-start text-primary" style="font-size:16px"><strong>총액 : ${total}원</strong></div>
			                            </div>
			                        </div>
			                     </div>
			                     <div class="row p-3">
			                        <div class="col"></div>
			                     </div>
			                  </div>
			               </div>
			            </div>
			         </div>
			      </div>
			   </div>
			   
	           <div class="row">
	               <div class="col">
	                  <div class="card shadow-sm mb-4">
	                     <div class="card-body p-0">
	                        <div class="row px-3 py-3 text-start">
	                           <div class="col">
	                              <strong>
	                                 배송지정보
	                              </strong>
	                           </div>
	                        </div>
							<div class="row px-3 pb-3">
	                           <div class="col-2">
	                              <div class="row mb-2 p-0 text-body-secondary" style="font-size:14px">
	                                 <div class="col">신청인</div>
	                              </div>
	                              <div class="row mb-2 p-0 text-body-secondary" style="font-size:14px">
	                                 <div class="col">연락처</div>
	                              </div>
	                              <div class="row mb-2 p-0 text-body-secondary" style="font-size:14px">
	                                 <div class="col">출발주소</div>
	                              </div>
	                              <div class="row mb-2 p-0 text-body-secondary" style="font-size:14px">
	                                 <div class="col">도착주소</div>
	                              </div>
	                           </div>
	     
	                           <div class="col-10">
	                              <div class="row mb-2 p-0" style="font-size:14px">
	                                 <div class="col">${userDto.user_name}</div>
	                              </div>
	                              <div class="row mb-2 p-0" style="font-size:14px">
	                                 <div class="col">
										<span>${userDto.phone_number}</span>	                                 	
	                                 </div>
	                              </div>
	                              <div class="row mb-2 p-0" style="font-size:14px">
	                                 <div class="col">${signUpDto.start_address}</div>
	                              </div>
	                              <div class="row mb-2 p-0" style="font-size:14px">
	                                 <div class="col">${signUpDto.arrive_address}</div>
	                              </div>
	                           </div>
	                        </div>
	                        
	                     </div>
	                  </div>
	               </div>
	           </div>
            
			   <div class="row mb-3">
					<div class="col-5 "></div>
					<c:if test="${!empty sessionUser}">
						<div class="col-2 d-flex justify-content-center">
							<a href="../userboard/userZimInfoPage" role="button" id="check" class="btn" style="background-color: #46B8FF !important; color : white;">돌아가기 </a>
						</div>
					</c:if>
					<c:if test="${!empty sessionAdmin && empty sessionUser}">
						<div class="col-2 d-flex justify-content-center">
							<a href="../adminboard/adminZimPage" role="button" id="check" class="btn" style="background-color: #46B8FF !important; color : white;">돌아가기</a>
						</div>
					</c:if>
					<div class="col-5"></div>
			   </div>	
			   
			</div>
			<div class="col-3"></div>
		</div>
	</div>
	
<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>