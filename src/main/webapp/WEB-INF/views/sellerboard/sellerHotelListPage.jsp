<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<style>
.hotelcard{
box-shadow: rgba(25, 25, 25, 0.2) 0px 6px 10px;
}

.scroll-container {
  overflow: hidden; /* 스크롤 숨김 */
  height: 850px; /* 스크롤 영역의 높이 설정 */
}

.scroll-container:hover {
  overflow: auto; /* 마우스 호버 시 스크롤 보이기 */
}

/* 수직 스크롤 바 스타일 */
.scroll-container::-webkit-scrollbar {
  width: 4px;
}

.scroll-container::-webkit-scrollbar-track {
  background-color: #f1f1f1;
}

.scroll-container::-webkit-scrollbar-thumb {
  background-color: #888;
  border-radius: 4px;
}

.scroll-container::-webkit-scrollbar-thumb:hover {
  background-color: #555;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
let sellerSession = null;
function getMyId(){
	const xhr = new XMLHttpRequest();
	
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			const response = JSON.parse(xhr.responseText);
			//js 작업공간
			if(response.result == "success"){
				sellerSession = response.id; 
			}
		}
	}
	//get방식
	xhr.open("get","./getMyID",false);
	xhr.send();
}
function getHotelList(){
	const xhr = new XMLHttpRequest();
	const listBox = document.getElementById("listBox");
	listBox.innerHTML = "";
	xhr.onreadystatechange = function(){
		if(xhr.readyState==4&&xhr.status==200){
			const response = JSON.parse(xhr.responseText);
			if(response.result =="success"){
			for(list of response.hotelInfo){
			const col = document.createElement("div");
			col.classList.add("col-6","ps-4","pe-4","mt-4");
			listBox.appendChild(col);
			
			
			
			const card = document.createElement("div");
			card.classList.add("card","hotelcard");
			col.appendChild(card)
			
			const cardHeader= document.createElement("div");
			cardHeader.classList.add("card-header");
			card.appendChild(cardHeader);
			
			const leftrow = document.createElement("div");
			leftrow.classList.add("row");
			cardHeader.appendChild(leftrow);
			
			const leftcol =document.createElement("div");
			leftcol.classList.add("col");
			leftrow.appendChild(leftcol);
			
			const rightcol = document.createElement("div");
			rightcol.classList.add("col","text-end","pt-1");
			leftrow.appendChild(rightcol);
			
			const headerTop = document.createElement("div");
			headerTop.classList.add("row");
			leftcol.appendChild(headerTop);
			
			const headerTopCol = document.createElement("div");
			headerTopCol.classList.add("col","text-secondary");
			headerTop.appendChild(headerTopCol);
			
			const topi = document.createElement("i");
			topi.classList.add("bi","bi-house-exclamation-fill")
			const topspan=document.createElement("span");
			topspan.classList.add("ms-2");
			topspan.innerText = "상태"
			headerTopCol.appendChild(topi)
			headerTopCol.appendChild(topspan);
			
			
			const headerrow = document.createElement("div");
			headerrow.classList.add("row");
			leftcol.appendChild(headerrow);
			if(list.docuStatus == "대기"){
				const headercol1 = document.createElement("div");
				headercol1.classList.add("col","text-start","text-primary");
				headerrow.appendChild(headercol1);
				
				const i = document.createElement("i");
				i.classList.add("bi","bi-file-text-fill")
				const span=document.createElement("span");
				span.classList.add("ms-2");
				span.innerText = "서류 심사중"
				headercol1.appendChild(i)
				headercol1.appendChild(span);
				
			}else if(list.docuStatus == "승인거절"){
				const headercol1 = document.createElement("div");
				headercol1.classList.add("col","text-start","text-danger");
				headerrow.appendChild(headercol1);
				
				const i = document.createElement("i");
				i.classList.add("bi","bi-file-earmark-x-fill")
				const span=document.createElement("span");
				span.classList.add("ms-2");
				span.innerText = "반려"
				headercol1.appendChild(i)
				headercol1.appendChild(span);
			
				
			}else{
				if(list.hotelStatus=="휴무"){
					
					const headercol1 = document.createElement("div");
					headercol1.classList.add("col","text-start");
					headerrow.appendChild(headercol1);
					
					const i = document.createElement("i");
					i.classList.add("bi","bi-stop-fill","text-dark")
					const span=document.createElement("span");
					span.classList.add("ms-2","text-dark");
					span.innerText = "휴무"
					headercol1.appendChild(i)
					headercol1.appendChild(span);
					
				}else{
					
					const headercol1 = document.createElement("div");
					headercol1.classList.add("col","text-start");
					headerrow.appendChild(headercol1);
					
					const i = document.createElement("i");
					i.classList.add("bi","bi-caret-right-fill","text-danger")
					const span=document.createElement("span");
					span.classList.add("ms-2","text-danger");
					span.innerText = "영업중"
					headercol1.appendChild(i)
					headercol1.appendChild(span);
				}
			}
		
			if(list.docuStatus == "승인완료" && list.hotelStatus =="휴무"){
				
				const i3 = document.createElement("i");
				i3.classList.add("bi","bi-house-up-fill","text-dark","fs-4")
				i3.setAttribute("onclick","getHotelStatusModal("+list.id+",'"+list.hotelName+"')")
				rightcol.appendChild(i3)
				

			}else if(list.docuStatus == "승인거절"){
				const i3 = document.createElement("i");
				i3.classList.add("bi","bi-envelope-exclamation-fill","text-danger","fs-4")
				i3.setAttribute("onclick","getreasonModal("+list.id+")")
				rightcol.appendChild(i3)
			}
			const i2 = document.createElement("i");
			i2.classList.add("bi","bi-pencil-square","text-dark","fs-4","ms-2")
			rightcol.appendChild(i2)
			
			if(list.docuStatus == "대기" || list.docuStatus == "승인거절"){
				const img = document.createElement("img");
				img.src = "/uploadFiles/"+list.hotelImg;
				img.classList.add("card-img-top");
				img.style.width ="100%";
				img.style.height ="250px";
				card.appendChild(img);
				
				const cardBody = document.createElement("div");
				cardBody.classList.add("card-body");
				card.appendChild(cardBody);
				
				const row1= document.createElement("div");
				row1.classList.add("row");
				cardBody.appendChild(row1);
				
				const cateCol = document.createElement("div");
				cateCol.classList.add("col","text-center","text-secondary");
				cateCol.innerText = list.hotelCategory;
				row1.appendChild(cateCol);
			
				const row2= document.createElement("div");
				row2.classList.add("row");
				cardBody.appendChild(row2);
				
				const nameCol = document.createElement("div");
				nameCol.classList.add("col","text-center","fs-6","text-black","fw-semibold");
				nameCol.innerText= list.hotelName;
				row2.appendChild(nameCol);
			}else{
				const a = document.createElement("a");
				a.href="./sellerMainPage?id=" +list.id;
				a.style.textDecoration = "none";
				card.appendChild(a);
				
				const img = document.createElement("img");
				img.src = "/uploadFiles/"+list.hotelImg;
				img.classList.add("card-img-top");
				img.style.width ="100%";
				img.style.height ="250px";
				a.appendChild(img);
				
				const a2 = document.createElement("a");
				a2.href="./sellerMainPage?id=" +list.id;
				a2.style.textDecoration = "none";
				card.appendChild(a2);
				

				const cardBody = document.createElement("div");
				cardBody.classList.add("card-body");
				a2.appendChild(cardBody);
				
				const row1= document.createElement("div");
				row1.classList.add("row");
				cardBody.appendChild(row1);
				
				const cateCol = document.createElement("div");
				cateCol.classList.add("col","text-center","text-secondary");
				cateCol.innerText = list.hotelCategory;
				row1.appendChild(cateCol);
			
				const row2= document.createElement("div");
				row2.classList.add("row");
				cardBody.appendChild(row2);
				
				const nameCol = document.createElement("div");
				nameCol.classList.add("col","text-center","fs-6","text-black","fw-semibold");
				nameCol.innerText= list.hotelName;
				row2.appendChild(nameCol);
				
			}
			
			
			
			
			}
			}else{
			const col = document.createElement("div");
			col.classList.add("col","mt-5");
			listBox.appendChild(col)
			
			const row1 = document.createElement("div");
			row1.classList.add("row","mt-5")
			col.appendChild(row1)

			const failCol = document.createElement("div");
			failCol.classList.add("col","mt-5","text-center","fw-semibold","fs-2");
			failCol.innerText = "등록된 숙소가 없습니다."
			row1.appendChild(failCol)
			
			const row2 = document.createElement("div");
			row2.classList.add("row")
			col.appendChild(row2)

			const failCol2 = document.createElement("div");
			failCol2.classList.add("col","mt-3","text-center","fw-semibold","fs-2");
			failCol2.innerText = "숙소 등록 후 이용 가능합니다."
			row2.appendChild(failCol2)
			}
		}
	}
	xhr.open("get","./getSellerHotelListAndStatus?seller_id="+sellerSession,false);
	xhr.send();
}

function getHotelStatusModal(id,name){	
	const modal = bootstrap.Modal.getOrCreateInstance("#modal");
	const btn = document.getElementById("modalButton");
	const modalTitle = document.getElementById("modalTitle");
	modalTitle.innerText = name;
	btn.setAttribute("onclick","updateHotelStatus("+id+")")
	modal.show();
}

function updateHotelStatus(id){
	const modal = bootstrap.Modal.getOrCreateInstance("#modal");
	const xhr = new XMLHttpRequest();
	
	xhr.onreadystatechange= function(){
		if(xhr.readyState==4 && xhr.status==200){
			const response = JSON.parse(xhr.responseText);
			modal.hide();
			getHotelList();
			
		}
	}
	xhr.open("get","./updateHotelStatus?hotel_id="+id)
	xhr.send();
}

function getreasonModal(id){	
	const modal = bootstrap.Modal.getOrCreateInstance("#reasonmodal");
	const btn = document.getElementById("modalButton2");
	const modalTitle = document.getElementById("modalTitle");
	const reasonBox =document.getElementById("reasonBox");
	reasonBox.innerHTML = "";
	btn.setAttribute("onclick","updateHotelDocu("+id+")")
	const docuFile = document.getElementById("docuFile");
	docuFile.innerHTML = "";
	const fileInput = document.createElement("input");
	fileInput.type = "file";
	fileInput.id = "reDocu";
	docuFile.appendChild(fileInput);
	const xhr = new XMLHttpRequest();
	
	xhr.onreadystatechange= function(){
		if(xhr.readyState==4 && xhr.status==200){
			const response = JSON.parse(xhr.responseText);
			reasonBox.innerText = response.returnText.docu_return;
			modal.show();
		}
	}
	xhr.open("get","./getReturnDocu?hotel_id="+id)
	xhr.send();
}

function updateHotelDocu(id){
	const modal = bootstrap.Modal.getOrCreateInstance("#reasonmodal");
	const reDocu = document.getElementById("reDocu");
	reDocument = reDocu.files[0];
	
	const xhr = new XMLHttpRequest();
	
	var formData = new FormData();
	formData.append('file', reDocument);
	formData.append("hotel_id",id);
	
	xhr.onreadystatechange= function(){
		if(xhr.readyState==4 && xhr.status==200){
			const response = JSON.parse(xhr.responseText);
			modal.hide();
			getHotelList();
			
		}
	}
	xhr.open('post', './updateHotelDocu');
	xhr.send(formData);
}

/* function getHotelRegisterPage(){
	const modal = bootstrap.Modal.getOrCreateInstance("#registerHotelPage");
	const xhr = new XMLHttpRequest();
	const selectBox = document.getElementById("categori_select");
	const checkBox = document.getElementById("checkbox");
	selectBox.innerHTML ="";
	checkBox.innerHTML ="";
	const FirstOption = document.createElement("option")
	FirstOption.innerText = "숙소분류";
	FirstOption.selected = true;
	selectBox.appendChild(FirstOption);
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			const response = JSON.parse(xhr.responseText);
			for(list of response.cateList){
				var option = document.createElement("option");
				option.value = list.id;
				option.innerText = list.category;
				
				selectBox.appendChild(option);
			}
			for(list of response.syscateList){
				var col = document.createElement("div");
				col.classList.add("col-2");
				col.innerText =list.category;
				var checkbox = document.createElement("input");
				checkbox.type = 'checkbox';
				checkbox.value = list.id;
				checkbox.classList.add("check");
				col.appendChild(checkbox);
				checkBox.appendChild(col);
			}
			modal.show();
		}
	}
	//get방식
	xhr.open("get","./getHotelCategory");
	xhr.send();
} */
/* function uploadFile() {
	const modal = bootstrap.Modal.getOrCreateInstance("#registerHotelPage");
	  var fileInput = document.getElementById('hotel_img');
	  var file = fileInput.files[0]; // 업로드할 파일 가져오기
	  var docuInput =document.getElementById('docu'); 
	  var files = docuInput.files;
	  var nameInput = document.getElementById('hotel_name');
	  var name = nameInput.value; 
	  var selectInput = document.getElementById('categori_select');
	  var select = selectInput.value; 
	  var locInput = document.getElementById('hotel_loc');
	  var loc = locInput.value; 
	  var telInput = document.getElementById('hotel_tel');
	  var tel = telInput.value; 
	  var contentInput = document.getElementById('content');
	  var content = contentInput.value; 
	  var checkList = document.getElementsByClassName("check");
	  var selectedValues = [];
	  for (var i = 0; i < checkList.length; i++) {
	    if (checkList[i].checked) {
	      selectedValues.push(checkList[i].value);
	    }
	  }	
	  var formData = new FormData();
	  for(var i=0; i< files.length; i++){
		  formData.append('files',files[i]);
	  }
	  formData.append('file', file); // 파일 추가
	  formData.append('hotel_name', name); // 다른 데이터 추가
	  formData.append('hotel_category_id', select);
	  formData.append('hotel_loc', loc);
	  formData.append('hotel_tel', tel);
	  formData.append('content', content);
	  formData.append('seller_id', sellerSession);
	  formData.append('checkList', selectedValues.join(','));
	  var xhr = new XMLHttpRequest();
	  xhr.open('post', './registerHotel');
	  
	  xhr.onreadystatechange = function() {
	  if(xhr.readyState == 4 && xhr.status == 200){
		const response = JSON.parse(xhr.responseText);
		modal.hide();
		getHotelList;
	  }	
	  }
	  xhr.send(formData);
	} */
window.addEventListener("DOMContentLoaded",function(){
	getMyId();
	getHotelList();
});
</script>
</head>
<body>
<div class="container-fluid">

	  <div class="row">
            <div class="col-2 bg-black text-white" style="height: 100vh;;">
                <div class="row mt-5">
                    <div class="col-1"></div>
                    <div class="col-10">
                            <div class="row">
                                <div class="col fw-semibold fs-5 pt-2 ps-3 small text-secondary">
                                   판매자명
                                </div>
                               <div class="col-5 text-end small  pt-2">
								<a class="btn btn-dark btn-sm" href="../seller/sellerLogoutProcess">로그아웃</a>
								</div>
                            </div>
                            <div class="row pt-0">
                                <div class="col fw-semibold fs-5 pt-2 ps-3">
                                    ${sessionSeller.seller_name }
                                </div>
                            </div>
                     </div>
                </div>
                <div class="row mt-5">
                    <div class="col-1"></div>
                    <div class="col text-secondary fw-bold fs-5">
                        정보 관리
                    </div>
                </div>
                 <div class="row mt-4">
                    <div class="col-1"></div>
                    <div class="col fw-semibold pb-0">
                        <i class="bi bi-house-check fs-4 text-info pt-5"></i><span class="ps-3 text-white fs-5 pt-0">등록한 숙소</span>
                    </div>
                </div>
                <div class="row mt-4">
                    <div class="col-1"></div>
                    <div class="col fw-semibold pb-0">
                        <i class="bi bi-card-list fs-4 text-secondary pt-5"></i><span class="ps-3 text-white fs-5 pt-0">내 정보</span>
                    </div>
                </div>
                <div class="row mt-4">
                    <div class="col-1"></div>
                    <div class="col fw-semibold pb-0">
                        <i class="bi bi-wallet fs-4 text-secondary pt-5"></i><span class="ps-3 text-white fs-5 pt-0">수익</span>
                    </div>
                </div>
                <div class="row mt-4">
                    <div class="col-1"></div>
                    <div class="col fw-semibold pb-0">
                        <i class="bi bi-graph-up-arrow fs-4 text-secondary pt-5"></i><span class="ps-3 text-white fs-5 pt-0">대시보드</span>
                    </div>
                </div>
                <div class="row mt-5">
                    <div class="col-1"></div>
                    <div class="col text-secondary fw-bold fs-5">
                        서비스
                    </div>
                </div>
                <div class="row mt-4">
                    <div class="col-1"></div>
                    <div class="col fw-semibold pb-0">
                        <i class="bi bi-signpost fs-4 text-secondary pt-5"></i><span class="ps-3 text-white fs-5 pt-0">고객센터</span>
                    </div>
                </div>
                <div class="row mt-4 mb-5">
                    <div class="col-1"></div>
                    <div class="col fw-semibold pb-0">
                        <i class="bi bi-question-circle fs-4 text-secondary pt-5"></i><span class="ps-3 text-white fs-5 pt-0">문의/요청</span>
                    </div>
                </div>
                <div class="row mt-5">
                        <div class="col-1"></div>
                        <div class="col pb-5 d-grid"><a type="button" class="btn btn-light btn-lg pt-4 pb-4 fw-semibold" href="./sellerHotelRegisterPage">숙소등록</a></div>
                        <div class="col-1"></div>
                </div>
            </div>
            <div class="col bg-secondary bg-opacity-10">
                <div class="row mt-2 ms-2">
                    <div class="col fw-semibold fs-2"><i class="bi bi-house-check pe-3"></i>등록한 숙소</div>
                </div>
               <div class="row mt-1">
                    <div class="col-2"></div>
                    <div class="col-8">
                        <div class="row scroll-container" id="listBox">
                        
                        </div>
                    </div> 
                    <div class="col-2"></div>
               </div>
            </div>
    
        </div>
</div>





<div class="modal" tabindex="-1" id="modal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header" style="background-color: #46B8FF;">
        <h5 class="modal-title  text-white" id="modalTitle"></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      	<div class="row">
      		<div class="col fw-semibold fs-5">
      			영업을 시작하시겠습니까?
      		</div>
      	</div>
        <div class="row">
      		<div class="col fw-secondary small text-secondary">
      			영업 종료/휴무는 로밍 고객센터에 문의하세요.
      		</div>
      	</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn  text-white" style="background-color: #46B8FF;" id="modalButton">영업 시작</button>
      </div>
    </div>
  </div>
</div>

<div class="modal" tabindex="-1" id="reasonmodal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header bg-danger">
        <h5 class="modal-title  text-white">승인 거절</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      	<div class="row">
      		<div class="col fw-semibold fs-5">
      			반려 사유를 확인 후 양식에 맞춰 제출해주세요.
      		</div>
      	</div>
        <div class="row">
      		<div class="col mt-3" id="reasonBox">
      			
      		</div>
      	</div>
      </div>
      <div class="modal-footer" >
      	<div class="col" id="docuFile"></div>
        <button type="button" class="btn btn-outline-dark" id="modalButton2">서류 재제출</button>
      </div>
    </div>
  </div>
</div>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>