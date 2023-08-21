<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>

<title>zimSignSecondPage</title>
<style>
.card-img-top{
	width : 205.5 px;
	height : 220px;
}

</style>
</head>
<body>
<jsp:include page="../common/topNavi.jsp"/>

<div class="container-fluid">

	<div class="row border-top border-bottom border-light-subtle py-4 my-5">
		<div class="col-2"></div>
		<div class="col-8">
			<div class="row fs-3 text-info text-center line">
				<div class="col-4">
					<i class="bi bi-1-circle"></i>
				</div>
				<div class="col-4">
					<i class="bi bi-2-circle-fill"></i>
				</div>
				<div class="col-4">
					<i class="bi bi-3-circle"></i>
				</div>
			</div>
			<div class="row text-center">
				<div class="col-4 text-secondary text-opacity-75"><strong>장소 및 날짜</strong></div>
				<div class="col-4 pb-2 border-bottom border-info text-info"><strong>짐 종류 및 수량</strong></div>
				<div class="col-4 text-secondary text-opacity-75"><strong>최종 확인 및 결제</strong></div>
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
			
        	<div class="row">
        		<div class="col">
					<div class="row">
						<div class="row text-start mb-5">
							<div class="col">
								<h3><strong>짐 종류 및 수량 입력</strong></h3>
							</div>
						</div>
						
						<form action="./zimSignSecondProcess"  method="post">
				            <input type = "hidden" name="id" value="${id}">
      
						    <c:forEach items="${zimCategory}" var="category">
						    <div class="row mb-3">
								<div class="col-6">
						        	<div class="form-check">
										<input class="form-check-input" id="form-check-label${category.id }" type="checkbox" name="zim_category_id" value="${category.id }">
										<label class="form-check-label" for="form-check-label${category.id }">
								  		${category.name}
										</label>
									</div>				                	
					            </div>
					            <div class="col-6">
									<select class="form-select" name="zim_amount">
										<option value="" selected disabled>수량을 입력해주세요</option>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="6">6</option>
										<option value="7">7</option>
										<option value="8">8</option>
										<option value="9">9</option>
										<option value="10">10</option>
									</select>
								</div>
					        </div>
					        </c:forEach>

				            <div class="row my-5">
				          		<div class="col-4"></div>
				            	<div class="col-2 d-flex justify-content-center"><a class="btn" href="./zimSignFirstPage" role="button" style="background-color: #46B8FF !important; color : white;">이전으로</a></div>
				            	<div class="col-2 d-flex justify-content-center"><button class="btn" style="background-color: #46B8FF !important; color : white;">다음 단계로</button></div>
				          		<div class="col-4"></div>
				            </div>
				            
				            <div class="row my-4">
				            	<div class="col-3">
				            		<div class="card">
								    	<img src="/roaming/resources/img/zimLittle.png" class="card-img-top" alt="...">
								    	<div class="card-body d-flex justify-content-center align-items-center">
								    		<div class="row text-center">
								    			<div class="col text-center">
								    				<div class="row">
								    					<div class="col">소형/쇼핑백/레디백</div>
								    				</div>
								    				<div class="row fw-semibold">
								    					<div class="col">5000원</div>
								    				</div>
								    			</div>
								    		</div>
								    	</div>
									</div>
				            	</div>
				            	<div class="col-3">
				            		<div class="card">
								    	<img src="/roaming/resources/img/zimSmall.png" class="card-img-top" alt="...">
								    	<div class="card-body d-flex justify-content-center align-items-center">
								    		<div class="row text-center">
								    			<div class="col">
								    				<div class="row">
								    					<div class="col">기내용 캐리어/백팩</div>
								    				</div>
								    				<div class="row fw-semibold">
								    					<div class="col">9000원</div>
								    				</div>
								    			</div>
								    		</div>
								    	</div>
									</div>
				            	</div>
				            	<div class="col-3">
				            		<div class="card">
								    	<img src="/roaming/resources/img/zimMiddle.png" class="card-img-top" alt="...">
								    	<div class="card-body d-flex justify-content-center align-items-center">
								    		<div class="row text-center">
								    			<div class="col">
								    				<div class="row">
								    					<div class="col">화물용 캐리어</div>
								    				</div>
								    				<div class="row fw-semibold">
								    					<div class="col">14000원</div>
								    				</div>
								    			</div>
								    		</div>
								    	</div>
									</div>
				            	</div>
				            	<div class="col-3">
				            		<div class="card">
								    	<img src="/roaming/resources/img/zimBig.png" class="card-img-top" alt="...">
								    	<div class="card-body d-flex justify-content-center align-items-center">
								    		<div class="row text-center">
								    			<div class="col">
								    				<div class="row">
								    					<div class="col">특대형 캐리어/골프백</div>
								    				</div>
								    				<div class="row fw-semibold">
								    					<div class="col">19000원</div>
								    				</div>
								    			</div>
								    		</div>
								    	</div>
									</div>
				            	</div>
				            </div>
			            </form>					
					</div>
        		</div>
        	</div>
        	<div class="row"></div>
        </div>
        <div class="col-2"></div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>