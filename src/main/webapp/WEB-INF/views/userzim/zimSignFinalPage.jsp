<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" integrity="sha512-bLT0Qm9VnAYZDflyKcBaQ2gg0hSYNQrJ8RilYldYQ1FxQYoCLtUjuuRuZo+fjqhx/qtq/1itJ0C2ejDxltZVFg==" crossorigin="anonymous" type="text/javascript"></script>
<script src ="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" type="text/javascript"></script>

<title>zimSignFinalPage</title>
<style>
</style>

</head>
<body>
<jsp:include page="../common/topNavi.jsp" />
<div class="container-fluid">
	
	<div class="row border-top border-bottom border-light-subtle py-4 my-5">
		<div class="col-2"></div>
		<div class="col-8">
			<div class="row fs-3 text-info text-center line">
				<div class="col-4">
					<i class="bi bi-1-circle"></i>
				</div>
				<div class="col-4">
					<i class="bi bi-2-circle"></i>
				</div>
				<div class="col-4">
					<i class="bi bi-3-circle-fill"></i>
				</div>
			</div>
			<div class="row text-center">
				<div class="col-4 text-secondary text-opacity-75"><strong>장소 및 날짜</strong></div>
				<div class="col-4 text-secondary text-opacity-75"><strong>짐 종류 및 수량</strong></div>
				<div class="col-4 pb-2 border-bottom border-info text-info"><strong>최종 확인 및 결제</strong></div>
			</div>
		</div>
		<div class="col-2"></div>
	</div>
	
	<div class="row mt-5">
		<div class="col-2"></div>
		<div class="col-8">
         	<div class="row mb-2 fs-6 text-info">
				<div class="col">짐 배송 서비스</div>
			</div>
			<div class="row text-start mb-5">
				<div class="col">
					<h3><strong>최종 확인 및 결제</strong></h3>
				</div>
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
				</div>
			</div>
				
			<div class="row my-4">
				<div class="col-4"></div>
				<div class="col-2 d-flex justify-content-center">
					<a href="./cancelZimSignUpProcess?id=${signUpDto.id}" role="button" class="btn btn-danger" >취소하기</a>
				</div>
				<div class="col-2 d-flex justify-content-center">
					<a href="./completeZimSignUpPage?id=${signUpDto.id}" role="button" id="check" class="btn" style="background-color: #46B8FF !important; color : white;">결제하기</a>
				</div>
				<div class="col-4"></div>
			</div>	
		</div>
		<div class="col-2"></div>
	</div>
</div>

<!-- 결제하기 -->
<script type="text/javascript">
$(document).ready(function(){
	   var pay = ${total};
	   console.log(pay);
	   	  
		var IMP = window.IMP;
		var code = "imp24044473"; //가맹점 식별코드
		IMP.init(code);
		
		$("#check").click(function(e){
			//결제요청
			IMP.request_pay({
				//name과 amount만있어도 결제 진행가능
				//pg : 'kakao', //pg사 선택 (kakao, kakaopay 둘다 가능)
				pay_method: 'card',
				merchant_uid : 'merchant_' + new Date().getTime(),
				name : '짐 배송비', // 상품명
				amount : ${total},
				buyer_email : '',
				buyer_name : 테스트~,
				buyer_tel : '',  //필수항목
				//결제완료후 이동할 페이지 kko나 kkopay는 생략 가능
				//m_redirect_url : 'https://localhost:8181/payments/complete'
			}, function(rsp){
				if(rsp.success){//결제 성공시
					var msg = '결제가 완료되었습니다';
					var result = {
					"imp_uid" : rsp.imp_uid,
					"merchant_uid" : rsp.merchant_uid,
					"biz_email" : '',
					"pay_date" : new Date().getTime(),
					"amount" : rsp.paid_amount,
					"card_no" : rsp.apply_num,
					"refund" : 'payed'
					}
					console.log("결제성공 " + msg);
					$.ajax({
						url : '/samsam/insertPayCoupon.do', 
				        type :'POST',
				        data : JSON.stringify(result,
				        		['imp_uid', 'merchant_uid', 'biz_email', 
				        			'pay_date', 'amount', 'card_no', 'refund']),
				        contentType:'application/json;charset=utf-8',
				        dataType: 'json', //서버에서 보내줄 데이터 타입
				        success: function(res){
				        			        	
				          if(res == 1){
							 console.log("추가성공");	
							 pay += 5;
							 $('#pay_coupon').html(pay);			           
				          }else{
				             console.log("Insert Fail!!!");
				          }
				        },
				        error:function(){
				          console.log("Insert ajax 통신 실패!!!");
				        }
					}) //ajax
					
				}
				else{//결제 실패시
					var msg = '결제에 실패했습니다';
					msg += '에러 : ' + rsp.error_msg
				}
				console.log(msg);
			});//pay
		}); //check1 클릭 이벤트
	}); //doc.ready
</script>

<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>