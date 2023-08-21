<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>	
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<title>zimSignFirstPage</title>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
// 출발주소 api
	function st_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var addr = ''; // 주소 변수
						var extraAddr = ''; // 참고항목 변수

						//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							addr = data.roadAddress;
						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							addr = data.jibunAddress;
						}

						// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
						if (data.userSelectedType === 'R') {
							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraAddr !== '') {
								extraAddr = ' (' + extraAddr + ')';
							}
							// 조합된 참고항목을 해당 필드에 넣는다.
							document.getElementById("st_extraAddress").value = extraAddr;

						} else {
							document.getElementById("st_extraAddress").value = '';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('st_postcode').value = data.zonecode;
						document.getElementById("st_address").value = addr;
						// 커서를 상세주소 필드로 이동한다.
						document.getElementById("st_detailAddress")
								.focus();
					}
				}).open();
	}

// 도착주소 api
	function arr_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var addr = ''; // 주소 변수
						var extraAddr = ''; // 참고항목 변수

						//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							addr = data.roadAddress;
						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							addr = data.jibunAddress;
						}

						// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
						if (data.userSelectedType === 'R') {
							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraAddr !== '') {
								extraAddr = ' (' + extraAddr + ')';
							}
							// 조합된 참고항목을 해당 필드에 넣는다.
							document.getElementById("arr_extraAddress").value = extraAddr;

						} else {
							document.getElementById("arr_extraAddress").value = '';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('arr_postcode').value = data.zonecode;
						document.getElementById("arr_address").value = addr;
						// 커서를 상세주소 필드로 이동한다.
						document.getElementById("arr_detailAddress")
								.focus();
					}
				}).open();
	}
	
	<!-- 주소 정보를 start_address, arrive_address에 넣어주기 -->
	function fillAddress(){
		var st_address = document.getElementById("st_address").value;
		var st_detailAddress = document.getElementById("st_detailAddress").value;
		var st_extraAddress = document.getElementById("st_extraAddress").value;
		var startAddressField = document.getElementById("start_address");
		
		startAddressField.value = st_address + " " + st_detailAddress + " " + st_extraAddress;
		
		var arr_address = document.getElementById("arr_address").value;
		var arr_detailAddress = document.getElementById("arr_detailAddress").value;
		var arr_extraAddress = document.getElementById("arr_extraAddress").value;
		var arriveAddressField = document.getElementById("newArrRadio");
		
		arriveAddressField.value = arr_address + " " + arr_detailAddress + " " + arr_extraAddress;
	}
	
</script>

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
					<i class="bi bi-1-circle-fill"></i>
				</div>
				<div class="col-4">
					<i class="bi bi-2-circle"></i>
				</div>
				<div class="col-4">
					<i class="bi bi-3-circle"></i>
				</div>
			</div>
			<div class="row text-center">
				<div class="col-4 pb-2 border-bottom border-info text-info"><strong>장소 및 날짜</strong></div>
				<div class="col-4 text-secondary text-opacity-75"><strong>짐 종류 및 수량</strong></div>
				<div class="col-4 text-secondary text-opacity-75"><strong>최종 확인 및 결제</strong></div>
			</div>
		</div>
		<div class="col-2"></div>
	</div>
	
	<div class="row my-4">
		<div class="col-2"></div>
		<div class="col-8">
			<div class="row mb-2 fs-6 text-info">
				<div class="col">짐 배송 서비스</div>
			</div>
			<div class="row">
				<div class="col">
					<form action="./zimSignFirstProcess" method="post" enctype="multipart/form-data" onsubmit="fillAddress()">
						<div class="row text-start mb-5">
							<div class="col">
								<h3><strong>장소 및 날짜 입력</strong></h3>
							</div>
						</div>
						
						<div class="row mb-3">
							<div class="col">
								<strong><i class="bi bi-house"></i> 출발주소</strong>
							</div>
						</div>
						<div class="row mb-3">
							<div class="col-2">
								<input type="text" id="st_postcode" placeholder="우편번호" class="form-control">
							</div>
							<div class="col-2">
								<input type="button" onclick="st_execDaumPostcode()" value="우편번호 찾기" class="form-control btn" style=" background-color: #46B8FF !important; color : white;">
							</div>
							<div class="col-8"></div>
						</div>
						<div class="row mb-3">
							<div class="col-8">
								<input type="text" id="st_address" placeholder="주소" class="form-control">
							</div>
							<div class="col-4"></div>
						</div>
						<div class="row mb-4">
							<div class="col-4">
								<input type="text" id="st_detailAddress" placeholder="상세주소" class="form-control">
							</div>
							<div class="col-4">
								<input type="text" id="st_extraAddress" placeholder="참고항목" class="form-control">
							</div>
						</div>
						<div class="row">
							<div class="col">
								<input type="hidden" name="start_address" placeholder="출발주소를 입력하세요" class="form-control" id="start_address" value="" >
							</div>
						</div>
						
						<div class="row mb-3">
							<div class="col">
								<strong><i class="bi bi-house"></i> 도착주소</strong>
							</div>
						</div>
						<c:choose>
							<c:when test="${!empty totalAddress}">
							<div class="row mb-3">
								<div class="col">
									<input class="form-check-input" type="radio" name="arrive_address" value="${totalAddress}" id="recentAddRadio" checked>
									<label class="form-check-label" for="recentAddRadio">
									 최근 예약한 숙소 주소 사용 <strong> (${totalAddress})</strong>
									</label>
								</div>
							</div>
							
							<div class="row mb-3">
								<div class="col">
									<input class="form-check-input" type="radio" name="arrive_address" value="" id="newArrRadio">
									<label class="form-check-label" for="newArrRadio">
									신규 배송지
									</label>
								</div>
							</div>
							</c:when>
							<c:otherwise>
								<div class="row mb-3">
									<div class="col">
										<input class="form-check-input" type="radio" name="arrive_address" value="" id="newArrRadio" checked>
										<label class="form-check-label" for="newArrRadio">
										신규 배송지
										</label>
									</div>
								</div>								
							</c:otherwise>
						</c:choose>
						<div class="row mb-3">
							<div class="col-2">
								<input type="text" id="arr_postcode" placeholder="우편번호" class="form-control">
							</div>
							<div class="col-2">
								<input type="button" onclick="arr_execDaumPostcode()" value="우편번호 찾기" class="form-control btn buttonColor" style=" background-color: #46B8FF !important; color : white;">
							</div>
							<div class="col-8"></div>
						</div>
						<div class="row mb-3">
							<div class="col-8">
								<input type="text" id="arr_address" placeholder="주소" class="form-control">
							</div>
							<div class="col-4"></div>
						</div>
						<div class="row mb-4">
							<div class="col-4">
								<input type="text" id="arr_detailAddress" placeholder="상세주소" class="form-control">
							</div>
							<div class="col-4">
								<input type="text" id="arr_extraAddress" placeholder="참고항목" class="form-control">
							</div>
						</div>
			


						<div class="row mb-3">
							<div class="col">
								<strong><i class="bi bi-calendar"></i> 맡길날짜 및 시간</strong>
							</div>
						</div>
						<div class="row mb-4">
							<div class="col">

							<%
							// 현재시간 기준으로 시간 기본값 넣기
							Date now = new Date();
							Calendar calendar = Calendar.getInstance();
							calendar.setTime(now);

							// 반올림
							int minute = calendar.get(Calendar.MINUTE);
							int roundedMinute = (minute / 30) * 30;
							calendar.set(Calendar.MINUTE, roundedMinute);

							// 시간단위 23:30을 넘어가면 다음날로 넘어감
							if (roundedMinute >= 30 && calendar.get(Calendar.HOUR_OF_DAY) == 23) {
								calendar.add(Calendar.DAY_OF_MONTH, 1);
							}

							SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
							String formattedDateTime = formatter.format(calendar.getTime());
							%>
								<input type="datetime-local" id="start_date" name="start_date" class="form-control" value="<%=formattedDateTime%>" required>							
							</div>
						</div>
						
						<div class="row mb-3">
							<div class="col">
								<strong><i class="bi bi-calendar"></i> 찾을날짜 및 시간</strong>
							</div>
						</div>
						<div class="row mb-4">
							<div class="col">
								<input type="datetime-local" id="arrive_date" name="arrive_date" class="form-control" value="<%=formattedDateTime%>" required>							
							</div>
						</div>

						<div class="row mb-4">
							<div class="col-6">
								<label for="zimImage"><strong><i class="bi bi-file-image"></i> 사진</strong><sup style="color: red;">*회수할 장소 및 짐 사진 첨부시 더 원활한 서비스 제공가능</sup></label>
							</div>
							<div class="col-6">
								<input type="file" name="zimImage" id="zimImage" accept="image/*" class="form-control">
							</div>
						</div>
						
						<div class="row my-5">
							<div class="col-4"></div>
							<div class="col-2 d-flex justify-content-center">
								<a class="btn" href="./zimMainPage" role="button" style=" background-color: #46B8FF !important; color : white;">홈으로</a>
							</div>
							<div class="col-2 d-flex justify-content-center">
								<button class="btn" style="background-color: #46B8FF !important; color : white;">다음 단계로</button>
							</div>
							<div class="col-4"></div>
						</div>
					</form>
				</div>
			</div>
		</div>
		<div class="col-2"></div>
	</div>
</div>
	
<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>