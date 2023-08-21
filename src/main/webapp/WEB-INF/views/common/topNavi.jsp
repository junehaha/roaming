<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
  /* 버튼의 배경색을 투명으로 설정 */
  .btn-bg {
    background-color: transparent;
  }

  /* 버튼의 모서리 둥글기를 없앰 */
  .btn-ra {
    border-radius: 0px;
    color: rgb(43,150,237);
    border: 1px solid rgb(167,212,249);
    font-size: 15px;
  }
  

    /* input 요소의 기본 스타일 */
  .form-controll {
    border-radius: 5px; /* border-radius 없앰 */
    background-color: rgb(245, 246, 247); /* 배경색을 회색으로 설정 */
    transition: background-color 0.3s, transform 0.3s; /* 애니메이션 설정 */
    border: none;
  }

  /* input 요소를 눌렀을 때 스타일 변경 */
  .form-controll:focus {
    background-color: #ffffff; /* 배경색을 하얀색으로 변경 */
    transform: scale(1.05); /* 크기를 5% 키우는 애니메이션 설정 */
    outline: none; /* 포커스 테두리 제거 */
  }
.balloon {  
  width: 250px; 
  height: auto;
  background: white; 
  border-radius: 0px;
  text-align: center;
  display: none;
  padding: 0;
  border: 1px solid rgba(0, 0, 0, 0.2);
  
 }
</style>

 <div class="container-fluid p-0 zzin">
    <div class="row mt-2">
         <div class="col-2"></div>
         <div class="col-8">
            <div class="row">
               <c:if test="${empty sessionUser}">
                  <div class="col"></div>
                  <div class="col-auto text-end pt-2 fw-semibold">
                     <c:if test="${empty sessionSeller}">
                        <a href="../seller/sellerLoginPage" style="color: rgb(102, 109, 117); text-decoration: none;">파트너 로그인</a>
                     </c:if>
                     <c:if test="${!empty sessionSeller}">
                        <a href="../sellerboard/sellerHotelListPage" style="color: gray; text-decoration: none;">파트너 페이지</a>
                     </c:if>
                  </div>
                  <div class="col-auto text-end pt-2 fw-semibold">
                     <c:if test="${empty sessionUser}">
                        <a href="../user/loginPage" style="color: rgb(102, 109, 117); text-decoration: none;">로그인</a>
                     </c:if>
                     <c:if test="${!empty sessionUser}">
                        ${sessionUser.user_name}&nbsp;님 
                     </c:if>
                  </div>
                  <div class="col-auto text-end" style="padding-top:2px;" onclick="registerButton()">
                     <c:if test="${empty sessionUser}">
                        <a href="../user/userRegisterPage" class="btn btn-ra  fw-bold" style="text-decoration:none; pointer-events: none; padding:6px 32px;" >회원가입</a>
                     </c:if>
                  </div>
               </c:if>
               
               <c:if test="${!empty sessionUser}">
                  <div class="col"></div>
                  <div class="col-auto fw-semibold me-2 pt-2">
                     <a href="../userboard/couponListPage" style="color: rgb(102, 109, 117); text-decoration: none;">쿠폰</a>
                  </div>
                  <div class="col-auto fw-semibold me-2 pt-2">
                     <a href="../usercsboard/qaBoardPage" style="color: rgb(102, 109, 117); text-decoration: none;">고객센터</a>
                        <%-- ${sessionUser.user_name}&nbsp;님  --%>
                  </div>
                  <div class="col-auto text-end">
                  <a class="bb" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                     <c:if test="${sessionUser.profile_img == null}">
                        <img src="/roaming/resources/img/original.png" class="img-fluid" style="border-radius: 50%; width: 50px; height: 50px;">
                     </c:if>
                     <c:if test="${sessionUser.profile_img != null}">
                     <c:choose>
                              <c:when test="${fn:startsWith(sessionUser.profile_img, 'h')}">
                        <img src="${sessionUser.profile_img}" class="img-fluid" style="border-radius: 50%; width: 40px; height: 40px;">
                              </c:when>
                              <c:otherwise>
                        <img src="/uploadFiles/${sessionUser.profile_img}" class="img-fluid" style="border-radius: 50%; width: 40px; height: 40px;">
                              </c:otherwise>
                           </c:choose>
                     </c:if>
                  </a>
                     <div class="dropdown">
                       <ul class="dropdown-menu balloon mt-2">
                         <li><a class="dropdown-item border-bottom" href="../userboard/myPage?id=${sessionUser.id}">
                            <div class="row py-2">
                               <div class="col-4 text-center">
                                  <c:if test="${sessionUser.profile_img == null}">
                                    <img src="/roaming/resources/img/original.png" class="img-fluid" style="border-radius: 50%; width: 50px; height: 50px;">
                                 </c:if>
                                 <c:if test="${sessionUser.profile_img != null}">
                                    <c:choose>
                                             <c:when test="${fn:startsWith(sessionUser.profile_img, 'h')}">
                                       <img src="${sessionUser.profile_img}" class="img-fluid" style="border-radius: 50%; width: 40px; height: 40px;">
                                             </c:when>
                                             <c:otherwise>
                                       <img src="/uploadFiles/${sessionUser.profile_img}" class="img-fluid" style="border-radius: 50%; width: 40px; height: 40px;">
                                             </c:otherwise>
                                          </c:choose>                                 </c:if>
                               </div>
                               <div class="col text-start pt-2 fw-semibold">${sessionUser.user_name}</div>
                            </div>
                        </a></li>
                         <li><a class="dropdown-item border-bottom" href="#">
                            <div class="row py-3 px-2">
                               <div class="col-1 text-end fs-5"><i class="bi bi-credit-card-2-front"></i></div>
                               <div class="col-4 text-center pt-1">쿠폰</div>
                               <div class="col text-end fw-semibold pt-1 pe-2" style="color: #0078ff;">${myPage.myCouponCount} 장</div>
                            </div>
                            <div class="row pb-3 px-2">
                               <div class="col-1 text-end fs-5"><i class="bi bi-coin"></i></div>
                               <div class="col-4 text-center pt-1 ps-4">포인트</div>
                               <div class="col text-end fw-semibold pt-1" style="color: #0078ff;"><fmt:formatNumber value="${myPage.myPoint}" pattern="#,###" var="formattedPrice" />
                                   ${formattedPrice} P</div>
                            </div>
         
                        </a></li>
                         <li><a class="dropdown-item py-2" href="../user/logoutProcess">로그아웃</a></li>
                       </ul>
                     </div>
                  </div>
               </c:if>
               <script>
window.onload = function() {
    var dropdownElement = document.querySelector('.bb');
    var dropdownMenuElement = document.querySelector('.dropdown-menu');

    new bootstrap.Dropdown(dropdownElement, {
        popperConfig: function(defaults) {
            defaults.placement = 'bottom-start'; // 드롭다운의 위치 조절
            defaults.modifiers = [
            {
                name: 'offset',
                options: {
                    offset: [-200, 14], // x, y offset 설정
                },
            },
            ];
            return defaults;
        },
    });
}

function registerButton(){
   window.location.href = "../user/userRegisterPage"
}
</script>

            </div>
         </div>
         <div class="col-2"></div>
      </div>
      <div class="row">
         <div class="col-2"></div>
         <div class="col-8">
            <div class="row">
               <div class="col-2">
                  <a href="../userboard/mainPage">
                     <img src="../resources/img/originalLogo.png" style="width: 160px; height: 50px;">
                  </a>
               </div>
               <div class="col pt-2">
                  <label style="position: relative;">
                     <input type="text" class="form-control form-controll" style="height: 40px; padding-left: 40px; width:350px"  placeholder="커뮤니티나 동행모집글을 검색해보세요.">
                     <i style="position: absolute; left: 10px; bottom: 7px" class="bi bi-search"></i>
                  </label>
                  
                  
               </div>
               
               <div class="col-1 fs-5 fw-semibold centered-link pt-3 text-center">
                  <a href="../post/postListPage" style="text-decoration: none; color: rgb(73, 80, 86);">동행찾기</a>
               </div>
               <div class="col-1 fs-5 fw-semibold centered-link text-center p-0 pt-3">
                  <a href="../facebook/facebookMain" style="text-decoration: none; color: rgb(73, 80, 86);">커뮤니티</a>
               </div>
               <div class="col-1 fs-5 fw-semibold centered-link text-center pt-3">
                  <a href="../userboard/hotelPage" style="text-decoration: none; color: rgb(73, 80, 86);">숙소예약</a>
               </div>
               <div class="col-1 fs-5 fw-semibold centered-link text-center pt-3">
                  <a href="../userboard/itemListPage" style="text-decoration: none; color: rgb(73, 80, 86);">포인트샵</a>
               </div>
               <div class="col-1 fs-5 fw-semibold centered-link text-center pt-3">
                  <a href="../userzim/zimMainPage" style="text-decoration: none; color: rgb(73, 80, 86);">짐서비스</a>
               </div>
            </div>
         </div>
         <div class="col-2"></div>
      </div>
      <div class="row border-top mt-3"></div>
      
      </div>