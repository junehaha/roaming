<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<head>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<meta charset="UTF-8">
<title>adminDashBoardPage</title>
<script>
// 차트 ajax
function getHotelChart(){
	const xhr = new XMLHttpRequest();
	
	xhr.onreadystatechange = function(){
		if(xhr.readyState ==4 && xhr.status==200){
			const response = JSON.parse(xhr.responseText);
			// label, data에 rest에서 뽑아온 날짜, 값 리스트 넣기.
			var labelList = [];
			var dataList = [];
			var labelListTwo = [];
			var dataListTwo = [];
			for(list of response.hotelDash){
				const date = new Date(list.thisMonthDate)
				const day = date.getDate().toString().padStart(2,'0'); // 1,2,3 한자리 숫자를 01,02,03으로 바꿔줌.
				labelList.push(day)
				dataList.push(list.totalDailySale)
			}
			for(list of response.zimDash){
				const date = new Date(list.thisMonthDate)
				const day = date.getDate().toString().padStart(2,'0');
				labelListTwo.push(day)
				dataListTwo.push(list.totalDailySale)
			}
			
			const ctx = document.getElementById('myHotelChart');
			const ctxTwo = document.getElementById('myZimChart')
			
			new Chart(ctx, {
			  type: 'bar',
			  data: {
			    labels: labelList,
			    datasets: [{
			      label: '매출액',
			      data: dataList,
			      borderWidth: 1
			    }]
			  },
			  options: {
			    scales: {
			      y: {
			        beginAtZero: true
			      }
			    }
			  }
			});
			
			new Chart(ctxTwo, {
			  type: 'bar',
			  data: {
			    labels: labelListTwo,
			    datasets: [{
			      label: '매출액',
			      data: dataListTwo,
			      borderWidth: 1,
			      borderColor: '#FF6384',
			      backgroundColor: '#FFB1C1',
			    }]
			  },
			  options: {
			    scales: {
			      y: {
			        beginAtZero: true
			      }
			    }
			  }
			});
		}
	}
	xhr.open("get","./getHotelDash");
	xhr.send();
}
window.addEventListener("DOMContentLoaded",function(){
	getHotelChart();
})
</script>

</head>
<body>
   <div class="container-fluid">
      <div class="row">
         <div class="col-2 scroll-container bg-secondary bg-opacity-10 fw-semibold" style="background-color: #dfe5ed;">

            <div class="row mt-5">
               <div class="col-1"></div>
               <div class="col text-secondary fw-bold fs-5">관리자 </div>
            </div>
            <div class="row mt-4">
                <div class="col-2"></div>
                <div class="col  pb-0">
                <c:choose>
                    <c:when test="${!empty sessionAdmin}">
                        <a href="../admin/adminLogoutProcess" style="text-decoration: none; color: inherit;">
                            <i class="bi bi-power fs-4" style="color: gray;"></i>
                            <span class="ps-3 text-gray-soft adminSideNavText pt-0" >로그아웃</span>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="../admin/adminLoginPage" style="text-decoration: none; color: inherit;">
                            <i class="bi bi-power fs-4" style="color: black;"></i>
                            <span class="ps-3 text-gray-soft adminSideNavText pt-0"  >로그인</span>
                        </a>
                    </c:otherwise>
                </c:choose>
                </div>
            </div>
            <div class="row mt-4">
               <div class="col-2"></div>
               <div class="col  pb-0">
                  <a href="./adminDashBoardPage" style="text-decoration: none; color: inherit;">
                     <i class="bi bi-graph-up-arrow fs-4 text-secondary pt-5"></i>
                     <span class="ps-3 text-primary adminSideNavText pt-0">대시보드</span>
                  </a>
               </div>
            </div>

            <div class="row mt-5">
               <div class="col-1"></div>
               <div class="col text-secondary fw-bold fs-5">판매자 관리</div>
            </div>
            <div class="row mt-4">
               <div class="col-2"></div>
               <div class="col  pb-0">
                <a href="./sellerNoticePage" style="text-decoration: none; color: inherit;">
                  <i class="bi bi-clipboard fs-4 text-secondary pt-5"></i>
                  <span class="ps-3 text-gray-soft adminSideNavText pt-0">공지사항</span>
                </a>
               </div>
            </div>
             <div class="row mt-4">
               <div class="col-2"></div>
               <div class="col  pb-0">
               <a href="./hotelDocuPage" style="text-decoration: none; color: inherit;">
                  <i class="bi bi-check-circle fs-4 text-secondary pt-5"></i>
                  <span class="ps-3 text-gray-soft adminSideNavText pt-0">신청 관리</span>
               </a>
               </div>
            </div>
            
            <div class="row mt-5">
               <div class="col-1"></div>
               <div class="col text-secondary fw-bold fs-5">쿠폰 및 상품 관리</div>
            </div>
            <div class="row mt-4">
               <div class="col-2"></div>
               <div class="col  pb-0">
               <a href="./manageCouponPage" style="text-decoration: none; color: inherit;">
                  <i class="bi bi-ticket fs-4 text-secondary pt-5"></i>
                  <span class="ps-3 text-gray-soft adminSideNavText pt-0">쿠폰 관리</span>
               </a>
               </div>
            </div>
            <div class="row mt-4">
               <div class="col-2"></div>
               <div class="col  pb-0">
               <a href="./manageItemPage" style="text-decoration: none; color: inherit;">
                  <i class="bi bi-bag fs-4 text-secondary pt-5"></i>
                  <span class="ps-3 text-gray-soft adminSideNavText pt-0">상품 관리</span>
               </a>
               </div>
            </div> 
            <div class="row mt-5">
               <div class="col-1"></div>
               <div class="col text-secondary fw-bold fs-5">짐 관리</div>
            </div>
            
            <div class="row mt-4">
               <div class="col-2"></div>
               <div class="col  pb-0">
                  <a href="../adminboard/adminZimPage" style="text-decoration: none; color: inherit;">
                     <i class="bi bi-truck fs-4 text-secondary pt-5"></i>
                     <span class="ps-3 text-gray-soft adminSideNavText pt-0">짐 배송 관리</span>
                  </a>
               </div>
            </div>
            
            <div class="row mt-5">
               <div class="col-1"></div>
               <div class="col text-secondary fw-bold fs-5">고객게시판 관리</div>
            </div>
            <div class="row mt-4">
               <div class="col-2"></div>
               <div class="col  pb-0">
                 <a href="../admincsboard/adminCsNoticePage" style="text-decoration: none; color: inherit;">
                    <i class="bi bi-clipboard fs-4 text-secondary pt-5"></i>
                    <span class="ps-3 text-gray-soft adminSideNavText pt-0">공지사항</span>
                 </a>
               </div>
            </div>
            <div class="row mt-4">
               <div class="col-2"></div>
               <div class="col  pb-0">
                  <a href="../admincsboard/adminFaqPage" style="text-decoration: none; color: inherit;">
                     <i class="bi bi-question-circle fs-4 text-secondary pt-5"></i>
                     <span class="ps-3 text-gray-soft adminSideNavText pt-0">자주묻는 질문</span>
                    </a>
               </div>
            </div>
            <div class="row mt-4">
               <div class="col-2"></div>
               <div class="col  pb-0">
                  <a href="../admincsboard/adminQaBoardProgressPage" style="text-decoration: none; color: inherit;">
                     <i class="bi bi-question-circle fs-4 text-secondary pt-5"></i>
                     <span class="ps-3 text-gray-soft adminSideNavText pt-0">문의게시판</span>
                  </a>
               </div>
            </div>

            <div class="row mt-5">
                <div class="col-1"></div>
                <div class="col text-secondary fw-bold fs-5">신고 관리</div>
             </div>

             <div class="row mt-4">
                <div class="col-2"></div>
                <div class="col  pb-0">
                   <a href="../adminboard/adminReportPage" style="text-decoration: none; color: inherit;">
                      <i class="bi bi-truck fs-4 text-secondary pt-5"></i>
                      <span class="ps-3 text-gray-soft adminSideNavText pt-0">신고관리</span>
                   </a>
                </div>
             </div>
         </div>
             

         <div class="col px-5">
            <div class="row mt-5 px-4">
                <div class="col">
                <h3><i class="bi bi-graph-up-arrow me-2"></i> 관리자 대시보드</h3>      
                </div>
            </div>

			<div class="row mt-4 px-4">
				<div class="col-6 pe-2">
					<div class="card shadow-sm p-3">
						<div class="row">
							<div class="col">
								<strong>숙소</strong>&nbsp;&nbsp;<span class="text-body-tertiary"><fmt:formatDate value="${today}" pattern="MM월 dd일"></fmt:formatDate></span> 
							</div>
						</div>
						<div class="row mt-3">
							<div class="col-6">
								오늘 숙소 예약수 : ${TodayReserveCount}개
							</div>
							<div class="col-6">
								오늘 숙소 매출 : <fmt:formatNumber value="${TodayReserveSale}" pattern="###,###,###"></fmt:formatNumber>원
							</div>
						</div>				
					</div>
				</div>
				
				<div class="col-6 ps-2">
					<div class="card shadow-sm p-3">
						<div class="row">
							<div class="col">
								<strong>짐 서비스</strong>&nbsp;&nbsp;<span class="text-body-tertiary"><fmt:formatDate value="${today}" pattern="MM월 dd일"></fmt:formatDate></span> 
							</div>
						</div>
						<div class="row mt-3">
							<div class="col-6">
								오늘 짐서비스 예약수 : ${TodayZimCount}개
							</div>							
							<div class="col-6">
								오늘 짐서비스 매출 : <fmt:formatNumber value="${TodayZimSale}" pattern="###,###,###"></fmt:formatNumber>원
							</div>							
						</div>
					</div>
				</div>
			</div>

			<div class="row mt-3 px-4">
				<div class="col-6 pe-2">
				   <div class="card shadow-sm p-3">
				   	  <div class="row">
						  <div class="col">
							  <strong>이번달 숙소 매출</strong>&nbsp;&nbsp;<span class="text-body-tertiary"><fmt:formatDate value="${today}" pattern="yyyy.MM"></fmt:formatDate></span> 
						  </div>
				      </div>
				   	  
				      <div class="row mt-3">
				         <div class="col">

				        </div>
				     </div>
				     <div class="row">
				        <div class="col">
				           <canvas id="myHotelChart" width="400" height="200"></canvas>
				         </div>						
				      </div>
				   </div>
				</div>
				
				<div class="col-6 ps-2">
				   <div class="card shadow-sm p-3">
				   	  <div class="row">
						  <div class="col">
							  <strong>이번달 짐 서비스 매출</strong>&nbsp;&nbsp;<span class="text-body-tertiary"><fmt:formatDate value="${today}" pattern="yyyy.MM"></fmt:formatDate></span> 
						  </div>
				      </div>
				   	  
				      <div class="row mt-3">
				     </div>
				     <div class="row">
				        <div class="col">
				           <canvas id="myZimChart"></canvas>
				         </div>						
				      </div>
				   </div>
				</div>
			</div>

			<div class="row mt-3 px-4">
				<div class="col-12 ">
				   <div class="card shadow-sm p-3">
				   	  <div class="row">
						  <div class="col">
							  <strong>포인트샵</strong>&nbsp;&nbsp;<span class="text-body-tertiary"><fmt:formatDate value="${today}" pattern="MM월dd일"></fmt:formatDate></span> 
						  </div>
				      </div>
			   	  	
					 <div class="row mt-3">
						<div class="col-6">
							오늘 구매된 포인트샵 상품수 : ${TodayItemCount}개
						</div>
						<div class="col-6">
							오늘 사용된 포인트 : ${TodayPointUsed}p
						</div>					
					 </div>
				   </div>
				</div>
			</div>

            <div class="row mt-3 px-4">
			    <div class="col">
				    <i class="bi bi-question-circle"></i> <strong>처리중인 문의글 </strong> :  ${QaNotAnswered}개
			    </div>
	        </div>
            
            <div class="row mt-2 mb-4 px-4">
				<div class="col">
					<div class="card shadow-sm">
						<div class="card-header text-center">
							<div class="row fw-semibold">
								<div class="col-2">구분</div>
								<div class="col-6">제목</div>
								<div class="col-2">작성자</div>
								<div class="col-2">작성일</div>
							</div>
						</div>
							<ul class="list-group list-group-flush">
								<c:forEach items="${qaProgressList}" var="qaProgressList">
								<c:if test="${qaProgressList.qaProgress.qa_comment_content == null}">
								<li class="list-group-item">
									<div class="row text-center">
										<div class="col-2">${qaProgressList.category.qa_category_name}</div>
										<div class="col-6">
											<div class="row">
					                            <a class="link-dark link-offset-2 link-underline link-underline-opacity-0 link-opacity-25-hover text-truncate" href="../usercsboard/readQaBoardPage?id=${qaProgressList.qaProgress.id}">
					                               ${qaProgressList.qaProgress.qa_title}
					                               <c:if test="${qaProgressList.isRecent < 2}"><span style="font-size : 11px; color:red;">N</span></c:if>
					                               <c:if test="${qaProgressList.qaProgress.qa_comment_content != null}"><span style="font-size : 11px">[답변완료]</span></c:if>
					                            </a>												
											</div>
										</div>
										<div class="col-2">
											<div class="row">
												<div class="col">${qaProgressList.user.user_name}</div>
											</div>
										</div>
										<div class="col-2">
											<div class="row">
												<div class="col"><fmt:formatDate value="${qaProgressList.qaProgress.qa_reg_date}" pattern="yyyy-MM-dd"/></div>
											</div>
										</div>
									</div>
								</li>
							</c:if>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>       


        </div>
    </div>
</div>

</body>
</html>