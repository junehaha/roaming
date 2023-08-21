<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<head>
<style>
        .pagination {
            justify-content: center;
        }
 </style>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
   rel="stylesheet"
   integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
   crossorigin="anonymous">
<meta charset="UTF-8">
<title>상품관리</title>
<script>
function getRegisterItemModal(id) {
	const modal = bootstrap.Modal.getOrCreateInstance("#registerItemModal")
	
	/* const hiddenCategoryId = document.getElementById("hiddenCategoryId")
	
	hiddenCategoryId.value = id; */
	
	modal.show();
}

function getUpdateItemModal(id,name,quan,price,con) {
	const modal = bootstrap.Modal.getOrCreateInstance("#updateItemModal")
	
	
	const hiddenId = document.getElementById("hiddenId")
	/* const hiddenCategoryId = document.getElementById("hiddenCategoryId") */
	const nameinput = document.getElementById("name");
	const quaninput = document.getElementById("quan");
	const priceinput = document.getElementById("price");
	const contextinput = document.getElementById("context");
	nameinput.value = "";
	quaninput.value =  "";
	priceinput.value =  "";
	contextinput.value =  "";
	
	
	hiddenId.value = id;
	nameinput.value = name;
	quaninput.value = quan;
	priceinput.value = price;
	contextinput.value = con;
	/* hiddenCategoryId.value = id; */
	
	modal.show();
}
</script>
</head>
<body>
   <div class="container-fluid">
      <div class="row">
         <div class="col">
           
         </div>
      </div>
      <div class="row">
         <div class="col-2 scroll-container bg-secondary bg-opacity-10 fw-semibold" style="background-color: #dfe5ed;">

            <div class="row mt-5">
               <div class="col-1"></div>
               <div class="col text-secondary fw-bold fs-5">관리자 

</div>
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
                  <span class="ps-3 text-gray-soft adminSideNavText pt-0">쿠폰 관리</span>
               </a>
               </div>
            </div>
            <div class="row mt-4">
               <div class="col-2"></div>
               <div class="col  pb-0">
               <a href="./manageItemPage" style="text-decoration: none; color: inherit;">
                  <i class="bi bi-bag fs-4 text-secondary pt-5"></i>
                  <span class="ps-3 text-gray-soft adminSideNavText pt-0 text-primary">상품 관리</span>
               </a>
               </div>
               
            <div class="row mt-5">
               <div class="col-1"></div>
               <div class="col text-secondary fw-bold fs-5">짐 관리</div>
            </div>
            
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
         </div>
<!--           <div class="col-1 bg-secondary bg-opacity-10"></div>
 -->         <div class="col px-5">
			<div class="row mt-5 px-4">
				<div class="col fw-semibold fs-3">
					<i class="bi bi-bag me-2"></i>상품 관리	
				</div>
				<div class="col text-end">
					<a class="btn btn-outline-dark  fs-5 fw-semibold" onclick="getRegisterItemModal()">+ 상품 등록</a>	
				</div>
			</div>
			<div class="row mt-4 px-4">
				<div class="col">
					<div class="card border-2">
						<div class="row fw-semibold text-center mx-0 mt-0 fs-5 bg-secondary bg-opacity-10">
							<div class="col border-end border-2 py-2">번호</div>
							<div class="col border-end border-2 py-2">상품이미지</div>
							<div class="col border-end border-2 py-2">상품명</div>
							<div class="col border-end border-2 py-2">카테고리명</div>
							<div class="col border-end border-2 py-2">수량</div>
							<div class="col border-end border-2 py-2">가격</div>
							<div class="col  border-end border-2 py-2">등록일</div>
							<div class="col py-2">수정/삭제</div>
						</div>
						<c:forEach items="${itemList}" var="map">
						
						<div class="row text-center mx-0 my-0 border-top border-2 py-2">
							<div class="col fw-semibold pt-4 fs-6">${map.itemDto.id}</div>
							<div class="col"><img src="/uploadFiles/${map.itemDto.item_thumbnail}" style="width:80px; height:80px;"></div>
							<div class="col fw-semibold pt-4 fs-6">${map.itemDto.item_name}</div>
							<div class="col   pt-4">${map.itemCategoryDto.category}</div>
							<div class="col pt-4 fs-6">${map.quantity}</div>
							<div class="col pt-4 "><fmt:formatNumber value="${map.itemDto.item_price}" pattern="#,###" var="formattedPrice" />
                          			${formattedPrice}P</div>
                          	<div class="col pt-4 "><fmt:formatDate value="${map.itemDto.reg_date}" pattern="yy.MM.dd"/>
                          	</div>
                            <div class="col mt-4">
								<a onclick="getUpdateItemModal('${map.itemDto.id}','${map.itemDto.item_name}','${map.quantity}','${map.itemDto.item_price}','${map.itemDto.item_context}')" class="btn btn-dark me-2 btn-sm" role="button">수정</a>
												<a class="btn btn-danger me-2 btn-sm" style="border-radius: 5px;" href="./deleteItemProcess?id=${map.itemDto.id}">삭제</a>
                             </div>						
                            </div>
						
						
						
				
						</c:forEach>
						
					</div>
				</div>
			</div>

<div class="row mt-3 px-4"><!-- 임시 페이징 버튼 동작x -->
            <div class="col-2"></div>
            <div class="col-8 text-center">
               <nav aria-label="Page navigation example">
                  <ul class="pagination pagination-sm justify-content-center">
                     <c:choose>
                        <c:when test="${startPage <= 1}">
                           <li class="page-item disabled"><a class="page-link border-white bg-white text-dark" href="#"><i class="bi bi-chevron-left"></i></a></li>
                        </c:when>
                        <c:otherwise>
                           <li class="page-item"><a class="page-link border-white bg-white text-dark" href="#"><i class="bi bi-chevron-left"></i></a></li>
                        </c:otherwise>
                     </c:choose>
                     
                     <c:forEach begin="${startPage}" end="${endPage}" var="index">
                        <c:choose>
                           <c:when test="${index == currentPage}">
                              <li class="page-item active"><a class="page-link bg-white border-white text-dark fw-semibold" href="#">1</a></li>                        
                           </c:when>
                           <c:otherwise>
                              <li class="page-item active"><a class="page-link bg-white border-white text-dark fw-semibold" href="#">1</a></li>
                           </c:otherwise>
                        </c:choose>
                     </c:forEach>
                     
                     <c:choose>
                        <c:when test="${endPage >= totalPage }">
                           <li class="page-item disabled"><a class="page-link border-white bg-white text-dark" href="#"><i class="bi bi-chevron-right"></i></a></li>
                        </c:when>
                        <c:otherwise>
                           <li class="page-item"><a class="page-link border-white bg-white text-dark" href="#"><i class="bi bi-chevron-right"></i></a></li>
                        </c:otherwise>
                     </c:choose>
                  </ul>
               </nav>
            </div>
            
         </div>

		</div>
         </div>
      </div>
 <!-- 상품등록 모달 -->
<form action="./itemRegisterProcess" method="post" enctype="multipart/form-data">
<div class="modal fade" id="registerItemModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-3" id="staticBackdropLabel">상품등록</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
 <div class="modal-body">
       	<div class="row ms-2">
       		<div class="col">
       			<div class="row">
       				<div class="col small fw-semibold">
						상품명
       				</div>
       			</div>
       			<div class="row">
       				<div class="col">
						<input type="text" name="item_name">
       				</div>
       			</div>
       			 <div class="row">
       				<div class="col small fw-semibold">
						카테고리
       				</div>
       			</div>
       			<div class="row">
       				 <div class="col-10">
				  <select name="category_id" class="form-control form-control-sm" id="floatingInput">
				    <c:forEach items="${category}" var="category">
				      <option value="${category.id}">
				        ${category.category}
				      </option>
				    </c:forEach>
				  </select>
				  </div>
       			</div>
       			<div class="row">
       				<div class="col small fw-semibold">
						대표 이미지
       				</div>
       			</div>
       			<div class="row">
       				<div class="col-10">
  						<input class="form-control form-control-sm" id="formFileSm" type="file" name="item_thumbnails">
       				</div>
       			</div>
       			<div class="row">
       				<div class="col small fw-semibold">
						상세 이미지
       				</div>
       			</div>
       			<div class="row">
       				<div class="col-10">
						<input class="form-control form-control-sm" type="file" name="images">
       				</div>
       			</div>
       			<div class="row">
       				<div class="col small fw-semibold">
						상품 가격(P)
       				</div>
       			</div>
       			<div class="row">
       				<div class="col">
						<input type="text" name="item_price">
       				</div>
       			</div>
       			<div class="row">
       				<div class="col small fw-semibold">
						상품 수량
       				</div>
       			</div>
       		<div class="row">
       				<div class="col">
						<input type="text" name="item_count">
       				</div>
       			</div>
       			<div class="row">
       				<div class="col small fw-semibold">
						상품 설명
       				</div>
       			</div>
       			<div class="row">
       				<div class="col">
						<input type="text" name="item_context">
       				</div>
       			</div>
       		</div>
       	</div>
      </div>
      
      
      
      <div class="modal-footer">
      	 <button class="btn me-2 btn-sm" style="background-color: #46B8FF; color: #FFFFFF;">생성</button>
        <button type="button" class="btn btn-danger me-2 btn-sm" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>
</form>
  
  
  
 <!-- 상품수정 모달 -->
<form action="./updateItemProcess" method="post" enctype="multipart/form-data">
<div class="modal fade" id="updateItemModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-3" id="staticBackdropLabel">상품 수정</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <input type="hidden" name="id" id="hiddenId">
       	<div class="row ms-2">
       		<div class="col">
       			<div class="row">
       				<div class="col small fw-semibold">
						상품명
       				</div>
       			</div>
       			<div class="row">
       				<div class="col">
						<input type="text" name="item_name" id="name">
       				</div>
       			</div>
       			 <div class="row">
       				<div class="col small fw-semibold">
						카테고리
       				</div>
       			</div>
       			<div class="row">
       				 <div class="col-10">
				  <select name="category_id" class="form-control form-control-sm" id="floatingInput">
				    <c:forEach items="${category}" var="category">
				      <option value="${category.id}">
				        ${category.category}
				      </option>
				    </c:forEach>
				  </select>
				  </div>
       			</div>
       			<div class="row">
       				<div class="col small fw-semibold">
						대표 이미지
       				</div>
       			</div>
       			<div class="row">
       				<div class="col-10">
  						<input class="form-control form-control-sm" id="formFileSm" type="file" name="item_thumbnails">
       				</div>
       			</div>
       			<div class="row">
       				<div class="col small fw-semibold">
						상세 이미지
       				</div>
       			</div>
       			<div class="row">
       				<div class="col-10">
						<input class="form-control form-control-sm" type="file" name="images">
       				</div>
       			</div>
       			<div class="row">
       				<div class="col small fw-semibold">
						상품 가격(P)
       				</div>
       			</div>
       			<div class="row">
       				<div class="col">
						<input type="text" name="item_price" id="price">
       				</div>
       			</div>
       			<div class="row">
       				<div class="col small fw-semibold">
						상품 수량
       				</div>
       			</div>
       		<div class="row">
       				<div class="col">
						<input type="text" name="item_count" id="quan">
       				</div>
       			</div>
       			<div class="row">
       				<div class="col small fw-semibold">
						상품 설명
       				</div>
       			</div>
       			<div class="row">
       				<div class="col">
						<input type="text" name="item_context" id="context">
       				</div>
       			</div>
       		</div>
       	</div>
      </div>
      <div class="modal-footer">
      	 <button class="btn btn-dark">수정</button>
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