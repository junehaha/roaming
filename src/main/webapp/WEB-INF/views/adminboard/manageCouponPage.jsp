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
<title>adminCsNoticePage</title>

<style>
   .buttonColor {
    background-color: #46B8FF    !important;
    color : white;
     }
</style>
<script>


function parseCustomDate(dateString) {
	const dateParts = dateString.split(' ');
	  const monthNames = {
	    'Jan': '01', 'Feb': '02', 'Mar': '03', 'Apr': '04', 'May': '05', 'Jun': '06',
	    'Jul': '07', 'Aug': '08', 'Sep': '09', 'Oct': '10', 'Nov': '11', 'Dec': '12'
	  };

	  const year = dateParts[5];
	  const month = monthNames[dateParts[1]];
	  const day = dateParts[2];

	  return year +"-"+month+"-"+day;
}

function getCouponProduceModal() {
	const modal = bootstrap.Modal.getOrCreateInstance("#produceCouponModal")
	modal.show();
}

function getUpdateCouponModal(id,name,context,discount,quantity,cstart,cend,istart,iend) {
	const date1 = parseCustomDate(cstart);
	const date2 = parseCustomDate(cend);
	const date3 = parseCustomDate(istart);
	const date4 = parseCustomDate(iend);

	const modal = bootstrap.Modal.getOrCreateInstance("#updateCouponModal")
	const nameinput = document.getElementById("name");
	const disinput = document.getElementById("dis");
	const contextinput = document.getElementById("context");
	const quaninput = document.getElementById("quan");
	const cstartinput = document.getElementById("cstart");
	const cendinput = document.getElementById("cend");
	const istartinput = document.getElementById("istart");
	const iendinput = document.getElementById("iend");
	
	nameinput.value = "";
	contextinput.value = "";
	disinput.value = "";
	quaninput.value = "";
	cstartinput.value = "";
	cendinput.value = "";
	istartinput.value = "";
	iendinput.value = "";
	
	
	const hiddenId = document.getElementById("hiddenId");

	hiddenId.value = id;
	nameinput.value = name;
	contextinput.value = context
	disinput.value = discount;
	quaninput.value = quantity;
	
	cstartinput.value = date1;
	cendinput.value = date2;
	istartinput.value = date3;
	iendinput.value = date4;

	modal.show();
}
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
                  <a href="../adminboard/adminDashBoardPage" style="text-decoration: none; color: inherit;">
                     <i class="bi bi-graph-up-arrow fs-4 text-secondary pt-5"></i>
                     <span class="ps-3 text-gray-soft adminSideNavText pt-0">대시보드</span>
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
                  <span class="ps-3 text-gray-soft adminSideNavText pt-0 text-primary">쿠폰 관리</span>
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
            	<div class="col fw-semibold">
            		<span class=" fs-3"><i class="bi bi-ticket me-2"></i>쿠폰 관리	   </span>
				</div>
         </div>
         <div class="row mt-4">
         	<div class="col ms-4">
         		<span class="badge    text-bg-dark fs-4">배포중/대기</span>
         		<a href="./manageCouponPage2" style="text-decoration:none;"><span class="badge  text-bg-secondary fs-4 bg-opacity-50">만료된 쿠폰</span></a>
         	</div>	<div class="col text-end"><a class="btn btn-outline-dark me-4 fs-5 fw-semibold" onclick="getCouponProduceModal()">+ 쿠폰 생성</a>
            	</div>
         </div>
        <div class="row mt-4 px-4">
				<div class="col">
					<div class="card border-2">
						<div class="row fw-semibold text-center mx-0 mt-0 fs-5 bg-secondary bg-opacity-10">
							<div class="col border-end border-2 py-2">번호</div>
							<div class="col border-end border-2 py-2">이미지</div>
							<div class="col border-end border-2 py-2">쿠폰명</div>
							<div class="col border-end border-2 py-2">분류</div>
							<div class="col border-end border-2 py-2">할인율(%)</div>
							<div class="col border-end border-2 py-2">수량</div>
							<div class="col ps-3 border-end border-2 py-2">배포 기간</div>
							<div class="col border-end border-2 py-2">사용 기간</div>
							<div class="col  py-2">수정/삭제</div>
						</div>
						<c:forEach items="${couponList}" var="map">						
						<div class="row text-center mx-0 my-0 border-top border-2 py-2">
							<div class="col fw-semibold pt-4 fs-6">${map.couponDto.id}</div>
							<div class="col"><img src="/uploadFiles/${map.couponDto.coupon_image}" style="width:80px; height:80px;"></div>
							<div class="col  pt-4 fs-5">${map.couponDto.coupon_name}</div>
							<div class="col fw-semibold pt-4 fs-6">${map.couponDto.coupon_context}</div>
							<div class="col  fs-5  text-primary pt-4">${map.couponDto.coupon_discount}</div>
							<div class="col pt-4 fs-6">${map.quantity}</div>
							<div class="col pt-3">
							 <fmt:formatDate value="${map.couponDto.coupon_startdate}" pattern="yy.MM.dd"/> ~ <fmt:formatDate value="${map.couponDto.coupon_enddate }" pattern="yy.MM.dd"/>
							</div>
							<div class="col pt-3 "><fmt:formatDate value="${map.couponDto.coupon_issue_start}" pattern="yy.MM.dd"/> ~ <fmt:formatDate value="${map.couponDto.coupon_issue_end }" pattern="yy.MM.dd"/></div>
                            <div class="col mt-4">
								   <a class="btn btn-dark me-2 btn-sm" onclick="getUpdateCouponModal('${map.couponDto.id}', '${map.couponDto.coupon_name}', '${map.couponDto.coupon_context}', '${map.couponDto.coupon_discount}', '${map.quantity}', '${map.couponDto.coupon_startdate}', '${map.couponDto.coupon_enddate}', '${map.couponDto.coupon_issue_start}', '${map.couponDto.coupon_issue_end}')">수정</a>
                                                <a href="./deleteCouponProcess?id=${map.couponDto.id}" class="btn btn-danger me-2 btn-sm" role="button">삭제</a>
                             </div>						
                            </div>
						
						

						</c:forEach>
						
					</div>
				</div>
			</div>


         <div class="row mt-3 px-4">
            <div class="col-2"></div>
            <div class="col-8 text-center">
               <nav aria-label="Page navigation example">
                  <ul class="pagination pagination-sm justify-content-center">       
                     
                        <c:choose>
                             	<c:when test="${startPage <= 1}">
                             		<li class="page-item disabled">
                                		<a class="page-link border-white bg-white text-dark" href="./manageCouponPage?page=${startPage-1}"><i class="bi bi-chevron-left"></i></a>
                              		</li>
                             	</c:when>
                             	<c:otherwise>
                             		<li class="page-item">
                                		<a  class="page-link border-white bg-white text-dark" href="./manageCouponPage?page=${startPage-1}"><i class="bi bi-chevron-left"></i></a>
                              		</li>
                             	</c:otherwise>
                             </c:choose>
                             
                              <c:forEach begin="${startPage}" end="${endPage}" var="index">
                              		<c:choose>   
                              			<c:when test="${index == currentPage }">
                              				<li class="page-item active"><a class="page-link bg-white border-white text-dark fw-semibold" href="./manageCouponPage?page=${index}">${index}</a></li>
                              			</c:when>
                              			<c:otherwise>
                              				<li class="page-item"><a class="page-link bg-white border-white text-dark" href="./manageCouponPage?page=${index}">${index}</a></li>
                              			</c:otherwise>
                              		</c:choose>
                              </c:forEach>
                              <c:choose>
                              	<c:when test="${endPage >= totalPage}">                              	
                              		 <li class="page-item disabled">
		                                <a class="page-link border-white bg-white text-dark" href="./manageCouponPage?page=${endPage+1}"><i class="bi bi-chevron-right"></i></a>
		                             </li>
                              	</c:when>
                              	<c:otherwise>
                              		 <li class="page-item">
		                                <a class="page-link border-white bg-white text-dark" href="./manageCouponPage?page=${endPage+1}"><i class="bi bi-chevron-right"></i></a>
		                             </li>
                              	</c:otherwise>
                              </c:choose>
                     
                  </ul>
               </nav>
            </div>
            
         </div>
         



        </div>
    </div>
</div>

   
   <!-- 쿠폰생성 모달 -->
<form action="./produceCouponProcess" method="post" enctype="multipart/form-data">
<div class="modal fade" id="produceCouponModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-3" id="staticBackdropLabel">쿠폰생성</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
       	<div class="row ms-2">
       		<div class="col">
       			<div class="row">
       				<div class="col small fw-semibold">
						쿠폰명
       				</div>
       			</div>
       			<div class="row">
       				<div class="col">
						<input type="text" name="coupon_name">
       				</div>
       			</div>
       			<div class="row">
       				<div class="col small fw-semibold">
						쿠폰 이미지
       				</div>
       			</div>
       			<div class="row">
       				<div class="col">
  <input class="form-control form-control-sm" id="formFileSm" type="file" name="image">
       				</div>
       			</div>
       			<div class="row">
       				<div class="col small fw-semibold">
						분류
       				</div>
       			</div>
       			<div class="row">
       				<div class="col">
						<input type="text" name="coupon_context">
       				</div>
       			</div>
       			<div class="row">
       				<div class="col small fw-semibold">
						쿠폰 수량
       				</div>
       			</div>
       			<div class="row">
       				<div class="col">
						<input type="text" name="coupon_count">
       				</div>
       			</div>
       			<div class="row">
       				<div class="col small fw-semibold">
						할인율(%)
       				</div>
       			</div>
       		<div class="row">
       				<div class="col">
						<input type="text" name="coupon_discount">
       				</div>
       			</div>
       		</div>
       		<div class="col">
       			<div class="row">
       				<div class="col small fw-semibold">
						관리자 메모
       				</div>
       			</div>
       			<div class="row">
       				<div class="col">
						<input type="text">
       				</div>
       			</div>
       			<div class="row">
       				<div class="col small fw-semibold">
						배포 시작일
       				</div>
       			</div>
       			<div class="row">
       				<div class="col">
						<input type="date" name="coupon_startdate">
       				</div>
       			</div>
       			<div class="row mt-1">
       				<div class="col small fw-semibold">
						배포 종료일
       				</div>
       			</div>
       			<div class="row">
       				<div class="col">
						<input type="date" name="coupon_enddate">
       				</div>
       			</div>
       			<div class="row mt-1">
       				<div class="col small fw-semibold">
						사용 시작일
       				</div>
       			</div>
       			<div class="row">
       				<div class="col">
						<input type="date" name="coupon_issue_start">
       				</div>
       			</div>
       			<div class="row mt-1">
       				<div class="col small fw-semibold">
						사용 종료일
       				</div>
       			</div>
       			<div class="row">
       				<div class="col">
						<input type="date" name="coupon_issue_end">
       				</div>
       			</div>
       		</div>
       	</div>
      </div>
      <div class="modal-footer">
      	 <button class="btn btn-dark me-2 btn-sm">생성</button>
      </div>
    </div>
  </div>
</div>
</form>

<!-- 쿠폰수정 모달 -->
<form action="./updateCouponProcess" method="post" enctype="multipart/form-data">
<div class="modal fade" id="updateCouponModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
            <input type="hidden" name="id" id="hiddenId" >
      
        <h1 class="modal-title fs-3" id="staticBackdropLabel">쿠폰수정</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
       	<div class="row ms-2">
       		<div class="col">
       			<div class="row">
       				<div class="col small fw-semibold">
						쿠폰명
       				</div>
       			</div>
       			<div class="row">
       				<div class="col">
						<input type="text" name="coupon_name" id="name">
       				</div>
       			</div>
       			<div class="row">
       				<div class="col small fw-semibold">
						쿠폰 이미지
       				</div>
       			</div>
       			<div class="row">
       				<div class="col">
  <input class="form-control form-control-sm" id="formFileSm" type="file" name="image">
       				</div>
       			</div>
       			<div class="row">
       				<div class="col small fw-semibold">
						분류
       				</div>
       			</div>
       			<div class="row">
       				<div class="col">
						<input type="text" name="coupon_context" id="context">
       				</div>
       			</div>
       			<div class="row">
       				<div class="col small fw-semibold">
						쿠폰 수량
       				</div>
       			</div>
       			<div class="row">
       				<div class="col">
						<input type="text" name="coupon_count" id="quan">
       				</div>
       			</div>
       			<div class="row">
       				<div class="col small fw-semibold">
						할인율(%)
       				</div>
       			</div>
       		<div class="row">
       				<div class="col">
						<input type="text" name="coupon_discount" id="dis">
       				</div>
       			</div>
       		</div>
       		<div class="col">
       			<div class="row">
       				<div class="col small fw-semibold">
						관리자 메모
       				</div>
       			</div>
       			<div class="row">
       				<div class="col">
						<input type="text">
       				</div>
       			</div>
       			<div class="row">
       				<div class="col small fw-semibold">
						배포 시작일
       				</div>
       			</div>
       			<div class="row">
       				<div class="col">
						<input type="date" name="coupon_startdate"  id="cstart">
       				</div>
       			</div>
       			<div class="row mt-1">
       				<div class="col small fw-semibold">
						배포 종료일
       				</div>
       			</div>
       			<div class="row">
       				<div class="col">
						<input type="date" name="coupon_enddate" id="cend">
       				</div>
       			</div>
       			<div class="row mt-1">
       				<div class="col small fw-semibold">
						사용 시작일
       				</div>
       			</div>
       			<div class="row">
       				<div class="col">
						<input type="date" name="coupon_issue_start" id="istart">
       				</div>
       			</div>
       			<div class="row mt-1">
       				<div class="col small fw-semibold">
						사용 종료일
       				</div>
       			</div>
       			<div class="row">
       				<div class="col">
						<input type="date" name="coupon_issue_end" id="iend">
       				</div>
       			</div>
       		</div>
       	</div>
      </div>
      <div class="modal-footer">
      	 <button class="btn btn-dark me-2 btn-sm">수정</button>
      </div>
    </div>
  </div>
</div>
</form>
<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
		crossorigin="anonymous"></script>   

</body>
</html>