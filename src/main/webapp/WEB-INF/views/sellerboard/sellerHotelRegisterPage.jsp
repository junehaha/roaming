<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
   <style>
   .buttonColor {
    background-color: #46B8FF		 !important;
    box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.5);
  }
   
      #previewContainer img {
  max-width: 200px; /* 원하는 가로 크기 */
  max-height: 200px; /* 원하는 세로 크기 */
}
#groupPreviewContainer img{
   max-width: 200px; /* 원하는 가로 크기 */
  max-height: 200px; /* 원하는 세로 크기 */
}

#multiPreviewContainer img{
   max-width: 200px; /* 원하는 가로 크기 */
  max-height: 200px; /* 원하는 세로 크기 */
}
      .scroll-container {
  overflow: hidden; /* 스크롤 숨김 */
  height: 676px; /* 스크롤 영역의 높이 설정 */
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
.form-check-label {
            display: inline-block;
            width: 140px; /* 원하는 공간 크기로 설정하세요 */
         margin: 1px;
        }

      </style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

<meta charset="UTF-8">
<title>Insert title here</title>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	
 const hotelObj = {
		hotel : {
			seller_id : ${id},
			hotel_name : null,
			hotel_category_id : null,
			hotel_loc : null,
			hotel_tel : null,
			content : null,
			system_categorys : []
		},
		groups : [
			{
				index: 0,
				view_id :null,
				room_group_name :null,
				price : null,
				fixed_number: null,
				custom_categorys : [],
				plus_options : [],
				rooms : []
			}
		]
}

 const imgObj = {
		 hotelImg : null,
		 hotelDocu : null,
		 groupImges : [
			 {	
				roomIndex : 0,
				groupMain : null,
			 	groupDetail : []
			 }
		 ]
 }
 
 var currentRoom = 0;

 
  //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
  function sample4_execDaumPostcode() {
     new daum.Postcode({
        oncomplete: function(data) {
           // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
  
           // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
           // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
           var roadAddr = data.roadAddress; // 도로명 주소 변수
           var extraRoadAddr = ''; // 참고 항목 변수
  
           // 법정동명이 있을 경우 추가한다. (법정리는 제외)
           // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
           if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
              extraRoadAddr += data.bname;
           }
           // 건물명이 있고, 공동주택일 경우 추가한다.
           if(data.buildingName !== '' && data.apartment === 'Y'){
             extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
           }
           // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
           if(extraRoadAddr !== ''){
              extraRoadAddr = ' (' + extraRoadAddr + ')';
           }
  
           // 우편번호와 주소 정보를 해당 필드에 넣는다.
           document.getElementById('sample4_postcode').value = data.zonecode;
           document.getElementById("sample4_roadAddress").value = roadAddr;
           document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
           
           // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
           if(roadAddr !== ''){
              document.getElementById("sample4_extraAddress").value = extraRoadAddr;
           } else {
              document.getElementById("sample4_extraAddress").value = '';
           }
  
           var guideTextBox = document.getElementById("guide");
           // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
           if(data.autoRoadAddress) {
              var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
              guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
              guideTextBox.style.display = 'block';
  
           } else if(data.autoJibunAddress) {
              var expJibunAddr = data.autoJibunAddress;
              guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
              guideTextBox.style.display = 'block';
           } else {
              guideTextBox.innerHTML = '';
              guideTextBox.style.display = 'none';
           }
        }
     }).open();
  }
/*   function multiDisplayPreview(input) {
  var fileList = input.files;
  var previewContainer = document.getElementById("multiPreviewContainer");
  previewContainer.innerHTML = ""; // 이전에 표시된 미리보기 이미지를 제거합니다.

  for (var i = 0; i < fileList.length; i++) {
    var file = fileList[i];
    var reader = new FileReader();

    reader.onload = function(e) {
      var previewImage = document.createElement("img");
      previewImage.src = e.target.result;
      previewContainer.appendChild(previewImage);
    };

    reader.readAsDataURL(file);
  }
} */

function displayPreview(input) {
  var fileList = input.files;
  var previewContainer = document.getElementById("previewContainer");
  previewContainer.innerHTML = ""; // 이전에 표시된 미리보기 이미지를 제거합니다.

  for (var i = 0; i < fileList.length; i++) {
    var file = fileList[i];
    var reader = new FileReader();

    reader.onload = function(e) {
      var previewImage = document.createElement("img");
      previewImage.src = e.target.result;
      previewContainer.appendChild(previewImage);
    };

    reader.readAsDataURL(file);
  }
  getImages(1)
}

function groupDisplayPreview(input) {
  var fileList = input.files;
  var previewContainer = document.getElementById("groupPreviewContainer");
  previewContainer.innerHTML = ""; // 이전에 표시된 미리보기 이미지를 제거합니다.

  for (var i = 0; i < fileList.length; i++) {
    var file = fileList[i];
    var reader = new FileReader();

    reader.onload = function(e) {
      var previewImage = document.createElement("img");
      previewImage.src = e.target.result;
      previewContainer.appendChild(previewImage);
    };

    reader.readAsDataURL(file);
  }
  getImages(2)
}

function changeCard(num){
   const cards = document.getElementsByClassName("card");
   for(card of cards){
      card.classList.remove("border-primary")
   }
   const cardTitles = document.getElementsByClassName("cardTitle");
   for(cardTitle of cardTitles){
      cardTitle.classList.remove("text-primary");
      cardTitle.classList.remove("fw-semibold");
      cardTitle.classList.add("text-secondary");
   }
   const targetCard = document.getElementById("card"+num);
   const targetCardTitle = document.getElementById("cardTitle"+num);
   targetCard.classList.add("border-primary")
   targetCardTitle.classList.add("text-primary")
   targetCardTitle.classList.add("fw-semibold")
   targetCardTitle.classList.remove("text-secondary");
}

function getHotelCategory(id){
	hotelObj.hotel.hotel_category_id = id;
	const hotelcates = document.getElementsByClassName("hotelcate");
	for(hotelcate of hotelcates){
		hotelcate.style.backgroundColor = "darkgray";
	}
	console.log(id);
	const target = document.getElementById("hotelcate"+id);
	target.style.backgroundColor = "black";
	
}
function getHotelInfo(){
	const hotelNameInput = document.getElementById("hotel_name");
	const hotelLocInput= document.getElementById("sample6_address");
	const hotelTelInput = document.getElementById("hotel_tel");
	const hotelContentInput = document.getElementById("content");
	const hotelSysInput = document.getElementsByClassName("syscate")

	hotelObj.hotel.hotel_name = hotelNameInput.value;
	hotelObj.hotel.hotel_loc = hotelLocInput.value;
	hotelObj.hotel.hotel_tel = hotelTelInput.value;
	hotelObj.hotel.content = hotelContentInput.value;
	hotelObj.hotel.system_categorys= []
	for(checked of hotelSysInput){
		
		  if (checked.checked) {
			    hotelObj.hotel.system_categorys.push(checked.value);
			  }
	}
	console.log(hotelObj)
	
	const targetObj = hotelObj.groups.find(group => group.index == currentRoom);
	const groupNameInput = document.getElementById("room_group_name");
	const room_priceInput = document.getElementById("room_price");
	const fixedNumberInput = document.getElementById("fixed_number");
	const viewRadioInput = document.getElementsByClassName("viewRadio")
	for(checked of viewRadioInput){
		
		  if (checked.checked) {
			  targetObj.view_id = checked.value;
			  }
	}
	
	targetObj.room_group_name = groupNameInput.value;
	targetObj.price = room_priceInput.value;
	targetObj.fixed_number = fixedNumberInput.value;

}



function addRoomGroup(){
	const navLinkBox = document.getElementById("navLinkBox");
	const newIndex = generateUUID();
	const roomObj = {
			index :  newIndex,
			view_id :null,
			room_group_name :null,
			price : null,
			fixed_number: null,
			custom_categorys : [],
			plus_options : [],
			rooms : []
		}
	hotelObj.groups.push(roomObj);
	
	const li = document.createElement("li");
	li.classList.add("nav-item");
	const span = document.createElement("span");
	span.classList.add("nav-link","text-secondary");
	span.innerText = "객실"
	span.id = newIndex;
	span.setAttribute("onclick", "changeRoomGroup('" + newIndex + "')");
	
	
	
	li.appendChild(span);
	navLinkBox.appendChild(li);
	
	
	const roomImgObj = {
		roomIndex : newIndex,
		groupMain : null,
	 	groupDetail : []
		}
	imgObj.groupImges.push(roomImgObj)
}

function generateUUID() {
	  let uuid = '';
	  const chars = '0123456789abcdef';

	  for (let i = 0; i < 32; i++) {
	    const randomIndex = Math.floor(Math.random() * 16);
	    uuid += chars[randomIndex];
	  }
	  return uuid;
}
	
function changeRoomGroup(id){
	currentRoom = id;
	const navLink = document.getElementsByClassName("nav-link");
	for(nav of navLink){
		nav.classList.remove("active");
		nav.classList.add("text-secondary")
	}
	console.log(id);
	const targetNav = document.getElementById(id);
	targetNav.classList.add("active");
	targetNav.classList.remove("text-secondary");
	
	const buttonBox = document.getElementById("buttonBox");
	buttonBox.innerHTML ="";
	if(currentRoom != 0){
		const button = document.createElement("button");
		button.type = "button";
		button.classList.add("btn","btn-danger");
		button.innerText = "객실 삭제";
		button.setAttribute("onclick","deleteRoomGroup('"+id+"')")
		buttonBox.appendChild(button)
	}
	const targetObj = hotelObj.groups.find(group => group.index == currentRoom);
	const targetImgObj =imgObj.groupImges.find(group => group.roomIndex == currentRoom);
	
	const groupNameInput = document.getElementById("room_group_name");
	groupNameInput.value = targetObj.room_group_name;
	
	const room_priceInput = document.getElementById("room_price");
	room_priceInput.value = targetObj.price
	
	const fixedNumberInput = document.getElementById("fixed_number");
	fixedNumberInput.value = targetObj.fixed_number
	
	const viewRadioInput = document.getElementsByClassName("viewRadio")
	for (let i = 0; i < viewRadioInput.length; i++) {
	  const radio = viewRadioInput[i];
	  if (radio.checked) {	
	    radio.checked = false;
	  }
	}
	if(targetObj.view_id != null){
		const targetRadio = document.getElementById("viewId"+targetObj.view_id);
		targetRadio.checked = true;
	}
	
	const roomImgText = document.getElementById("roomImgText");
	const roomDetailImgText = document.getElementById("roomDetailImgText");	
	
	if(targetImgObj.groupMain != null){
		roomImgText.innerText = "1개 선택 / 이미지 변경"
	}else{
		roomImgText.innerText = "이미지를 선택해주세요."
	}
	if(targetImgObj.groupDetail.length > 0){
		roomDetailImgText.innerText = targetImgObj.groupDetail.length+"개 선택 / 이미지 변경"
	}else{
		roomDetailImgText.innerText = "이미지를 선택해주세요."
	}
	const optionBox =document.getElementById("optionBox")
	const customBox =document.getElementById("customBox")
	const roomBox =document.getElementById("roomBox")

	optionBox.innerHTML ="";
	customBox.innerHTML ="";
	roomBox.innerHTML ="";
	
	for(plusOp of targetObj.plus_options){
		const row = document.createElement("div");
		row.classList.add("ms-1","row","mt-2");
		row.id=plusOp.optionIndex
		optionBox.appendChild(row);
		
		const col1 =document.createElement("div");
		col1.classList.add("col-4","text-start");
		row.appendChild(col1);
		const optionName = document.createElement("input")
		optionName.type ="text";
		optionName.value = plusOp.plus_option
		optionName.id = "optionInput"+plusOp.optionIndex
		optionName.setAttribute("onblur","getOptionOrServiceOrRoom(1,'"+plusOp.optionIndex+"')")

		optionName.classList.add("form-control");
		optionName.setAttribute("placeholder","옵션명");
		col1.appendChild(optionName);
		
		const col2 =document.createElement("div");
		col2.classList.add("col-4","text-start","ps-0");
		row.appendChild(col2);
		
		const optionPrice = document.createElement("input")
		optionPrice.type ="number";
		optionPrice.value = plusOp.option_price

		optionPrice.classList.add("form-control");
		optionPrice.id = "optionPriceInput"+plusOp.optionIndex
		optionPrice.setAttribute("placeholder","가격 (원)");
		optionPrice.setAttribute("onblur","getOptionOrServiceOrRoom(1,'"+plusOp.optionIndex+"')")

		col2.appendChild(optionPrice);
		
		const col3 = document.createElement("div");
		col3.classList.add("col","text-start");
		row.appendChild(col3);

		const deleteButton = document.createElement("button");
		deleteButton.classList.add("btn","btn-sm","btn-danger","border","mt-1");
		deleteButton.style.borderRadius = "40%";
		deleteButton.innerText = "-";
		deleteButton.setAttribute("onclick","deleteOptionOrService(1,'"+plusOp.optionIndex+"')")
		
		col3.appendChild(deleteButton)
	}
	for(cus of targetObj.custom_categorys){		                                
        const row = document.createElement("div");
  		row.classList.add("ms-1","row","mt-2");
  		row.id = cus.categoryIndex
  		customBox.appendChild(row);
  		
  		const col1 =document.createElement("div");
  		col1.classList.add("col-4","text-start");
  		row.appendChild(col1);	
  		const customName = document.createElement("input")
  		customName.type ="text";
  		customName.value =cus.category_name;
  		customName.classList.add("form-control");
  		customName.setAttribute("placeholder","서비스명");
  		customName.id = "customInput"+cus.categoryIndex
  		customName.setAttribute("onblur","getOptionOrServiceOrRoom(2,'"+cus.categoryIndex+"')")

  		col1.appendChild(customName);  
  		
		const col3 = document.createElement("div");
		col3.classList.add("col","text-start");
		row.appendChild(col3);
		
  		const deleteButton = document.createElement("button");
		deleteButton.classList.add("btn","btn-sm","btn-danger","border","mt-1");
		deleteButton.style.borderRadius = "40%";
		deleteButton.innerText = "-";
		deleteButton.setAttribute("onclick","deleteOptionOrService(2,'"+cus.categoryIndex+"')")
		col3.appendChild(deleteButton)
	}
	for(room of targetObj.rooms){
		const row = document.createElement("div");
		row.classList.add("ms-1","row","mt-2");
		row.id = room.roomIndex
		roomBox.appendChild(row);
		
		const col1 =document.createElement("div");
		col1.classList.add("col-4","text-start");
		row.appendChild(col1);	
		const roomNumber = document.createElement("input")
		roomNumber.type ="number";
		roomNumber.classList.add("form-control");
		roomNumber.value = room.room_number;
		roomNumber.id = "roomInput"+room.roomIndex
		roomNumber.setAttribute("onblur","getOptionOrServiceOrRoom(3,'"+room.roomIndex+"')")

		roomNumber.setAttribute("placeholder","방번호");
		col1.appendChild(roomNumber);  
		
		const col3 = document.createElement("div");
		col3.classList.add("col","text-start");
		row.appendChild(col3);
		
			const deleteButton = document.createElement("button");
		deleteButton.classList.add("btn","btn-sm","btn-danger","border","mt-1");
		deleteButton.style.borderRadius = "40%";
		deleteButton.innerText = "-";
		deleteButton.setAttribute("onclick","deleteOptionOrService(3,'"+room.roomIndex+"')")
		col3.appendChild(deleteButton)
	}
	
	
	
}
function deleteRoomGroup(id){
	console.log(id)
	const target = document.getElementById(id);
	target.remove();
	changeRoomGroup(0)

	const targetObj = hotelObj.groups.findIndex(group => group.index == id);
	const targetImgObj = imgObj.groupImges.findIndex(group => group.roomIndex == id);
	hotelObj.groups.splice(targetObj,1);
	imgObj.groupImges.splice(targetImgObj,1);
	
}
function plusOptionOrServiceOrRoom(num){
	const optionBox =document.getElementById("optionBox")
	const customBox =document.getElementById("customBox")
	const roomBox =document.getElementById("roomBox")
	const newOption = generateUUID();
	const newService= generateUUID();
	const newRoom= generateUUID();
	if(num == 1){
		const optionObj = {
				optionIndex :newOption,
				plus_option : null,
				option_price : 0
		}
		const targetObj = hotelObj.groups.find(group => group.index == currentRoom);
		targetObj.plus_options.push(optionObj);

		const row = document.createElement("div");
		row.classList.add("ms-1","row","mt-2");
		row.id=newOption
		optionBox.appendChild(row);
		
		const col1 =document.createElement("div");
		col1.classList.add("col-4","text-start");
		row.appendChild(col1);
		const optionName = document.createElement("input")
		optionName.type ="text";
		optionName.id = "optionInput"+newOption
		optionName.setAttribute("onblur","getOptionOrServiceOrRoom(1,'"+newOption+"')")

		optionName.classList.add("form-control");
		optionName.setAttribute("placeholder","옵션명");
		col1.appendChild(optionName);
		
		const col2 =document.createElement("div");
		col2.classList.add("col-4","text-start","ps-0");
		row.appendChild(col2);
		
		const optionPrice = document.createElement("input")
		optionPrice.type ="number";
		optionPrice.classList.add("form-control");
		optionPrice.id = "optionPriceInput"+newOption
		optionPrice.setAttribute("placeholder","가격 (원)");
		optionPrice.setAttribute("onblur","getOptionOrServiceOrRoom(1,'"+newOption+"')")

		col2.appendChild(optionPrice);
		
		const col3 = document.createElement("div");
		col3.classList.add("col","text-start");
		row.appendChild(col3);

		const deleteButton = document.createElement("button");
		deleteButton.classList.add("btn","btn-sm","btn-danger","border","mt-1");
		deleteButton.style.borderRadius = "40%";
		deleteButton.innerText = "-";
		deleteButton.setAttribute("onclick","deleteOptionOrService(1,'"+newOption+"')")
		
		col3.appendChild(deleteButton)
		
	}else if(num==2){
		const customCategoryObj = {
				categoryIndex : newService,
				category_name : null
		}
		const targetObj = hotelObj.groups.find(group => group.index == currentRoom);
		targetObj.custom_categorys.push(customCategoryObj);

		                                
        const row = document.createElement("div");
  		row.classList.add("ms-1","row","mt-2");
  		row.id = newService
  		customBox.appendChild(row);
  		
  		const col1 =document.createElement("div");
  		col1.classList.add("col-4","text-start");
  		row.appendChild(col1);	
  		const customName = document.createElement("input")
  		customName.type ="text";
  		customName.classList.add("form-control");
  		customName.setAttribute("placeholder","서비스명");
  		customName.id = "customInput"+newService
  		customName.setAttribute("onblur","getOptionOrServiceOrRoom(2,'"+newService+"')")

  		col1.appendChild(customName);  
  		
		const col3 = document.createElement("div");
		col3.classList.add("col","text-start");
		row.appendChild(col3);
		
  		const deleteButton = document.createElement("button");
		deleteButton.classList.add("btn","btn-sm","btn-danger","border","mt-1");
		deleteButton.style.borderRadius = "40%";
		deleteButton.innerText = "-";
		deleteButton.setAttribute("onclick","deleteOptionOrService(2,'"+newService+"')")
		col3.appendChild(deleteButton)
		
	}else if(num ==3){
   const roomObj = {
			roomIndex : newRoom,
			room_number : null
	}
	const targetObj = hotelObj.groups.find(group => group.index == currentRoom);
	targetObj.rooms.push(roomObj);
	
   const row = document.createElement("div");
		row.classList.add("ms-1","row","mt-2");
		row.id = newRoom
		roomBox.appendChild(row);
		
		const col1 =document.createElement("div");
		col1.classList.add("col-4","text-start");
		row.appendChild(col1);	
		const roomNumber = document.createElement("input")
		roomNumber.type ="number";
		roomNumber.classList.add("form-control");
		roomNumber.id = "roomInput"+newRoom
		roomNumber.setAttribute("onblur","getOptionOrServiceOrRoom(3,'"+newRoom+"')")

		roomNumber.setAttribute("placeholder","방번호");
		col1.appendChild(roomNumber);  
		
		const col3 = document.createElement("div");
		col3.classList.add("col","text-start");
		row.appendChild(col3);
		
			const deleteButton = document.createElement("button");
		deleteButton.classList.add("btn","btn-sm","btn-danger","border","mt-1");
		deleteButton.style.borderRadius = "40%";
		deleteButton.innerText = "-";
		deleteButton.setAttribute("onclick","deleteOptionOrService(3,'"+newRoom+"')")
		col3.appendChild(deleteButton)
   		
	}
}

function deleteOptionOrService(num,index){
	const targetgroups = hotelObj.groups.find(group => group.index == currentRoom);
	if(num == 1){
		const targetObj = targetgroups.plus_options.findIndex(option => option.optionIndex == index);
		targetgroups.plus_options.splice(targetObj,1);
		const row = document.getElementById(index);
		row.remove();
		
		
	}else if(num==2){
		const targetObj = targetgroups.custom_categorys.findIndex(category => category.categoryIndex == index);
		targetgroups.custom_categorys.splice(targetObj,1);
		const row = document.getElementById(index);
		row.remove();
	}else if(num ==3){
		const targetObj = targetgroups.rooms.findIndex(room => room.roomIndex == index);
		targetgroups.rooms.splice(targetObj,1);
		const row = document.getElementById(index);
		row.remove();
	}
}

function getOptionOrServiceOrRoom(num,index){
	const targetgroups = hotelObj.groups.find(group => group.index == currentRoom);
	if(num == 1){
		const targetObj = targetgroups.plus_options.find(option => option.optionIndex == index);
		const optionInput = document.getElementById("optionInput"+index);
		const optionPriceInput = document.getElementById("optionPriceInput"+index);
		targetObj.plus_option = optionInput.value;
		targetObj.option_price = optionPriceInput.value;

	}else if(num==2){
		const targetObj = targetgroups.custom_categorys.find(category => category.categoryIndex == index);
		const customInput = document.getElementById("customInput"+index);
		targetObj.category_name = customInput.value;

	}else if(num == 3){
		const targetObj = targetgroups.rooms.find(room => room.roomIndex == index);
		const roomInput = document.getElementById("roomInput"+index);
		targetObj.room_number = roomInput.value;

	}
}
function getImages(num){
	const hotelDocuInput = document.getElementById("hotel_docu");
	const hotelImgInput = document.getElementById("hotel_img");
	const roomImgInput = document.getElementById("room_group_img");
	const roomDetailImgInput = document.getElementById("room_detail_img");
	
	const roomImgText = document.getElementById("roomImgText");
	const roomDetailImgText = document.getElementById("roomDetailImgText");
	
	
	const targetgroups = imgObj.groupImges.find(group => group.roomIndex == currentRoom);

	
	 const files1 = hotelImgInput.files;
	 const files0 = hotelDocuInput.files;
	 const files2 = roomImgInput.files;
	 const files3 = roomDetailImgInput.files;
	 if(num == 0){
		 for (let i = 0; i < files0.length; i++) {
				const file = files0[i];
				imgObj.hotelDocu = file
				console.log(imgObj)   
		  }
	 }
	 else if(num==1){
			for (let i = 0; i < files1.length; i++) {
				const file = files1[i];
				imgObj.hotelImg = file
				console.log(imgObj)   
		  }
	 }else if(num==2){	
			for (let i = 0; i < files2.length; i++) {
				const file = files2[i];
				targetgroups.groupMain = file
				console.log(imgObj)
				roomImgText.innerText = "1개 선택 / 이미지 변경"
		  }
	 }else{
		 targetgroups.groupDetail = [];
			for (let i = 0; i < files3.length; i++) {
				
				const file = files3[i];	
				targetgroups.groupDetail.push(file)
				console.log(imgObj)   
		  }
			roomDetailImgText.innerText = files3.length + "개 선택 / 이미지 변경"
	 }
	 
}
function registHotel() {
	 const xhr = new XMLHttpRequest();
		const hotelObjj =  JSON.stringify(hotelObj);


	  
	  xhr.onreadystatechange = function() {
	    if(xhr.readyState == 4 && xhr.status ==200){
	    	const response = JSON.parse(xhr.responseText);
	    	registReady(response.hotelId,response.groupIdList);
	    	
	    }
	  }

	  xhr.open("POST", "./registHotel");
	  xhr.setRequestHeader("Content-Type", "application/json"); // JSON 형식 설정
	  xhr.send(hotelObjj);
}
function registReady(hotelId,groupIdList){
	const hotelImg = imgObj.hotelImg;
	const hotelDocu = imgObj.hotelDocu;
	console.log(groupIdList)
	for(var i = 0; i<groupIdList.length; i++){
		registImg(i,groupIdList[i],hotelId);
	}
	
	const xhr= new XMLHttpRequest();
	 var formData = new FormData();
	formData.append("hotelImg",hotelImg);
	formData.append("hotelDocu",hotelDocu);
	formData.append("hotel_id",hotelId);
	xhr.readystatechange = function(){
		if(xhr.readyState==4 && xhr.status==200){
			const response = JSON.parse(xhr.responseText);

		}
	}
	xhr.open("post","./registerHotelImgAndDocu");
	xhr.send(formData);
}
function registImg(i,groupId,hotelId){
	const targetImg = imgObj.groupImges[i];
	
	const groupImg = targetImg.groupMain;
	const groupDetailImg = []
	for(detail of targetImg.groupDetail){
		groupDetailImg.push(detail);
	}
	
	const xhr= new XMLHttpRequest();
	var formData = new FormData();
	formData.append("groupImg",groupImg);
	formData.append("groupId",groupId);
	formData.append("hotelId",hotelId);
	 for(var i=0; i< groupDetailImg.length; i++){
		  formData.append('groupDetailImg',groupDetailImg[i]);
	  }
	xhr.readystatechange = function(){
		if(xhr.readyState==4 && xhr.status==200){
			const response = JSON.parse(xhr.responseText);
		}
	}
	xhr.open("post","./registerImg");
	xhr.send(formData);
}


function checkNullPoint(){
	const agreeBox = document.getElementById("agreeBox");
	const isChecked = agreeBox.checked;
	
	if(isChecked == false){
		alert("약관에 동의 해주세요.")
		return;
	}
	else if(hotelObj.hotel.hotel_category_id==null){
		alert("숙소 종류를 선택해주세요.");
		return;
	}else if(hotelObj.hotel.hotel_name ==null){
		alert("숙소명을 입력해주세요.");
		return;
	}else if(imgObj.hotelImg ==null){
		alert("숙소 대표 이미지를 선택해주세요.");
		return;
	}
	else if(hotelObj.hotel.hotel_loc ==null){
		alert("숙소 위치를 입력해주세요.");
		return;
	}else if(hotelObj.hotel.hotel_tel ==null){
		alert("숙소 전화번호를 입력해주세요.");
		return;
	}else if(hotelObj.hotel.content ==null){
		alert("숙소 설명을 입력해주세요.");
		return;
	}else if(imgObj.hotelDocu ==null){
		alert("제출 서류를 선택해주세요.");
		return;
	}
	
	for(var i=0; i<hotelObj.groups.length; i++){
		if(hotelObj.groups[i].room_group_name == ""){
			alert("객실명을 입력해주세요.")
			return;
		}else if(hotelObj.groups[i].price == ""){
			alert(hotelObj.groups[i].room_group_name+" 객실 금액을 입력해주세요.")
			return;
		}else if(imgObj.groupImges[i].groupMain == null){
			alert(hotelObj.groups[i].room_group_name+" 객실 대표 이미지를 선택해주세요.")
			return;
		}else if(imgObj.groupImges[i].groupDetail.length == 0){
			alert(hotelObj.groups[i].room_group_name+" 객실 상세 이미지를 선택해주세요.")
			return;
		}else if(imgObj.groupImges[i].groupDetail.length > 0 && imgObj.groupImges[i].groupDetail.length < 3){
			alert(hotelObj.groups[i].room_group_name+" 최소 3장의 상세 이미지를 선택해주세요.")
			return;
		}else if(hotelObj.groups[i].view_id == null){
			alert(hotelObj.groups[i].room_group_name+" 객실 뷰를 선택해주세요.")
			return;
		}else if(hotelObj.groups[i].fixed_number == ""){
			alert(hotelObj.groups[i].room_group_name+" 객실 최대 인원을 입력해주세요.")
			return;
		}else if(hotelObj.groups[i].rooms.length == 0){
			alert(hotelObj.groups[i].room_group_name+" 객실 방 번호를 추가해주세요.")
			return;
		}else if(hotelObj.groups[i].rooms.length > 0){
			for(var r=0; r<hotelObj.groups[i].rooms.length; r++){
				if(hotelObj.groups[i].rooms[r].room_number == null){
					alert(hotelObj.groups[i].room_group_name+" 객실 방 번호를 입력해주세요.")
					return;
				}
			}
		}else if(hotelObj.groups[i].plus_options.length >0){
			for(var p=0; p<hotelObj.groups[i].plus_options.length; p++){
				if(hotelObj.groups[i].plus_options[p].plus_option == null){
					alert(hotelObj.groups[i].room_group_name+" 객실 유료 옵션명을 입력해주세요.")
					return;
				}
			}
		}else if(hotelObj.groups[i].custom_categorys.length >0){
			for(var c=0; c<hotelObj.groups[i].custom_categorys.length; c++){
				if(hotelObj.groups[i].custom_categorys[c].category_name == null){
					alert(hotelObj.groups[i].room_group_name+" 객실 서비스명을 입력해주세요.")
					return;
				}
			}
		}
	}
	registHotel();
	getModal();
}
function getModal(){
	const modal =bootstrap.Modal.getOrCreateInstance("#modal");
	modal.show();
	
	setTimeout(hideModal, 2000);
}
function hideModal(){
	const modal =bootstrap.Modal.getOrCreateInstance("#modal");
	modal.hide();
    alert("숙소 등록이 완료되었습니다.");
    window.location.replace("./sellerHotelListPage");
}

window.addEventListener("DOMContentLoaded",function(){

});
</script>
</head>
<body>
<div class="container-fluid">
     <div class="row">
            <div class="col-2 bg-black text-white" style="height: 100vh;;">
                <div class="row mt-5">
                    <div class="col-1"></div>
                    <div class="col-8">
                            <div class="row">
                                <div class="col fw-semibold fs-5 pt-2 ps-3 small text-secondary">
                                   판매자명
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
                        <div class="col pb-5 d-grid"><button type="button" class="btn btn-light btn-lg pt-4 pb-4 fw-semibold" onclick="getHotelRegisterPage()">숙소등록</button></div>
                        <div class="col-1"></div>
                </div>
            </div>
            <div class="col bg-secondary bg-opacity-10">
                <div class="row mt-2 ms-2">
                    <div class="col fw-semibold fs-2"><i class="bi bi-house-up"></i>숙소 등록</div>
                </div>
               <div class="row mt-5 ms-2">
               <div class="col-6 text-primary fs-4 fw-semibold me-3 cardTitle" id="cardTitle1">
                  1. 숙소 정보                  
               </div>
               <div class="col ps-0 text-secondary fs-4 cardTitle" id="cardTitle2">2. 객실/방 정보</div>
               <div class="col-2 text-end"><button type="button" class="btn buttonColor text-white fs-5 fw-semibold" onclick="checkNullPoint()"><i class="bi bi-check2"></i>숙소 등록</button></div>
            </div>
            <div class="row mt-3">
               <div class="col-6" >
                  <div class="card border-primary" id="card1" onclick="changeCard(1)">
                     <div class="card-body scroll-container">
                       <div class="row ms-1">
                        <div class="col fs-4">약관</div>
                       </div>
                       <div class="row ms-1">
                        <div class="col">
                           <div class="mb-3">
                           <label for="exampleFormControlTextarea1" class="form-label">제1조(본 약관의 적용)</label>
                           <textarea class="form-control" id="exampleFormControlTextarea1" rows="4">
① 로밍에서 체결하는 숙박 계약 및 이에 관련되는 계약은 이 약관에서 정하는 바에 의하며, 본 약관에 명시되지 않은 사항에 대하여는 법령 또는 관례에 의합니다.
② 로밍에서는 전항의 규정 이외에는 본 약관의 취지, 법력 및 관습에 위배되지 않는 범위 내에서 특약에 응할 수 있습니다.

제2조(숙박 접수의 거절)
로밍는 다음과 같은 경우 숙박을 거절할 수 있습니다.
1.숙박 신청이 본 약관에 의하지 않았을 때
2.로밍에서는 전항의 규정 이외에는 본 약관의 취지, 법령 및 관습에 위배되지 않는 범위 내에서 특약에 의할 수 있습니다.
3.숙박을원하는 객이 숙박함에 있어 법령 또는 공익의 질서와 선량한 풍속을 해칠 우려가 있다고 인정될 때
4.숙박을 원하는 객이 전염병자임이 틀림이 없다고 인정될 때
5.숙박에 관하여 필요 이상의 부담을 갖게 할 경우
6.천재의 지변, 시설의 고장, 기타 부득이한 사유로 인하여 수박을 시킬 수 없을 때

제3조(성명 등의 명시)
로밍는 숙박 일에 앞서 숙박 신청을 받았을 경우 기한을 정하여 숙박예약신청자에 대하여 다음 사항의 확인을 요구할 수 있습니다.
1.숙박자의 성명, 성별, 연령, 소속기관 명, 주소, 주민등록번호(여권번호), 연락처 등
2.기타 로밍에서 필요하다고 인정되는 사항

제4조(예약금)
① 숙박 예약신청을 받았을 경우 체류기간에 해당하는 이용 요금의 10%를 예약금으로 징수할 수 있습니다.
② 전항의 예약금은 제 5조에서 정한 내용에 해당할 때에 위약금에 충당하고 잔액이 있을 때는 반환하여 드립니다.

제5조(예약 해제)
① I-HOTEL은 숙박 예약 신청자가 숙박 예약에 일부 또는 전부를 취소했을 경우에는 다음에 기재하는 바에 의하여 위약금을 청구합니다.
1.개인예약자
가.숙박일 1일전까지 취소한 경우: 위약금 없음
Cancellations made one day prior to the arrival date : No Penalty.
나.당일 취소 또는 무단 취소의 경우 : 숙박 첫날요금의 100%
If canceled on the arrival date or NO SHOW : 100% of the room rate for the first night.
2.단체예약자(5실 이상)
가.별도협의
Separate consultation
② 전항의 예약금은 제5조에서 정한 내용에 해당할 때에 위약금에 충당하고 잔액이 있을 때에는 반환하여 드립니다.

제6조(예약의 취소)
로밍에서는 다음의 경우 예약을 취소할 수 있습니다.
1.제2조 1항부터 6항까지 해당될 때
2.제3조 1항부터 2항까지의 사항이 허위일 때
3.제4조 1항에 규정된 예약금을 지불하지 않았을 때
                           </textarea>
                          </div>
                        </div>
                       </div>
                       <div class="row ms-1">
                        <div class="col-4 me-0">
                              <input class="form-check-input" type="checkbox" value="" id="agreeBox">
                              <label class="form-check-label" for="agreeBox">
                                 약관에 동의합니다.
                              </label>
                        </div>
                       </div>
                       <div class="row ms-1 mt-5">
                        <div class="col-2 fs-4 pe-0 me-0">
                           숙소 정보
                        </div>
                        <div class="col text-start small pt-2 ps-1 ms-0">
                           <span class="text-danger">*</span><span>표시는 필수 작성란 입니다.</span>
                        </div>
                       </div>
                       <div class="row mt-3 ms-1">
                        <div class="col fw-semibold">숙소 종류<span class="text-danger">*</span></div>
                       </div>
                       <div class="row mt-1 ms-1">
                        <div class="col fs-3">
                        <c:forEach items="${hotelcate}" var="hotelcate" varStatus="i">
							<span class="badge hotelcate" style="background-color:darkgray;" id="hotelcate${hotelcate.id}" onclick="getHotelCategory(${hotelcate.id})">${hotelcate.category}</span>          	
                        </c:forEach>
                        </div>                        
                       </div>
                       <div class="row ms-1 mt-5">
                        <div class="col-6">
                           
                              <label for="hotel_name" class="form-label fw-semibold">숙소명<span class="text-danger">*</span></label>
                              <input type="text" class="form-control" id="hotel_name" placeholder="숙소명을 기입해주세요." onblur="getHotelInfo()">
                           
                        </div>
                       </div>
                       <div class="row ms-1 mt-4">
                        <div class="col fw-semibold">
                           숙소 대표 이미지<span class="text-danger">*</span>
                        </div>
                       </div>
                       <div class="row ms-1 mt-3">
                        <div class="col" id="previewContainer">
                           <img alt="이미지를 선택하세요." style="height: 100px; width: 200px;" src="../resources/img/originalLogo.png">
                        </div>

                       </div>
                       <div class="row ms-1 mt-1">
                        <div class="col-2 pe-3" >
                              <input class="form-control" type="file" id="hotel_img" onchange="displayPreview(this)">
                        </div>
                       </div>
                       <div class="row ms-1 mt-4">
                        <div class="col  fw-semibold">숙소 위치<span class="text-danger">*</span> <span class="text-secondary ms-2 small">숙소 위치는 정확하게 기입해주세요.</span></div>
                       </div>
                       <div class="row ms-1 mt-2">
                        <div class="col">
                           <input type="text" id="sample6_postcode" placeholder="우편번호">
                           <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
                           <input class="modalAddress" type="text" id="sample6_address" placeholder="주소" oninput="getHotelInfo()"><br>
                           <input class="modalAddress" type="text" id="sample6_detailAddress" placeholder="상세주소">
                           <input class="modalAddress" type="text" id="sample6_extraAddress" placeholder="참고항목">
                        </div>
                       </div>
                       <div class="row ms-1 mt-4">
                        <div class="col-6">
                           <label for="hotel_tel" class="form-label  fw-semibold">숙소 전화번호<span class="text-danger">*</span></label>
                           <input type="text" class="form-control" id="hotel_tel" placeholder="지역번호와 - 를 포함하여 기입해주세요." onblur="getHotelInfo()">
                        </div>
                       </div>
                       <div class="row ms-1 mt-4">
                        <div class="col fw-semibold">
                           <label for="content" class="form-label">숙소 설명<span class="text-danger">*</span> <span class="text-secondary ms-2 small">숙소 설명은 예약페이지에서 사용되므로 자세히 기입해주세요.</span></label>
                           <textarea class="form-control mt-2" id="content" rows="5" onblur="getHotelInfo()"></textarea>
                        </div>
                       </div>
                       <div class="row ms-1 mt-4">
                        <div class="col fw-semibold">
                           숙소 제공 서비스
                        </div>
                       </div>
                       <div class="row ms-1 mt-2">
                        <div class="col">
                        <c:forEach items="${syscate}" var="cate" varStatus="i">
                        	<div class="form-check form-check-inline">
                              <input class="form-check-input syscate" type="checkbox" id="inlineCheckbox${i.index}" value="${cate.id}"  onchange="getHotelInfo()">
                              <label class="form-check-label" for="inlineCheckbox${i.index}">${cate.category}</label>
                             </div>
                        </c:forEach>
                         

                        </div>
                       </div>
                       <div class="row ms-1 mt-4">
                        <div class="col  fw-semibold">제출 서류<span class="text-danger">*</span> <span class="text-secondary ms-2 small">서류 검토 후 승인 시 사이트에 등록됩니다. 서류 양식은 고객센터에서 확인할 수 있습니다.

                        </span></div>
                       </div>
                       <div class="row ms-1 mt-1">
                        <div class="col-5">
                           <input class="form-control" type="file" id="hotel_docu" onchange="getImages(0)">
                        </div>
                       </div>
                     </div>
                    </div>
               </div>









               <div class="col-6">
                  <div class="card"  id="card2" onclick="changeCard(2)">
                     <div class="card-body scroll-container">
                       <div class="row ms-1 mt-1 ">
                        <div class="col-2 fs-4 pe-0 me-0">
                           객실 정보
                        </div>
                        <div class="col text-start small pt-2 ps-1 ms-0">
                           <span class="text-danger">*</span><span>표시는 필수 작성란 입니다.</span>
                        </div>
                        <div class="col-2 text-end me-0 mt-1" id="buttonBox">
                        </div>
                        <div class="col-2 text-end me-3 mt-1"><button type="button" class="btn btn-light border-secondary" onclick="addRoomGroup()">객실 추가</button>
                        </div>
                       </div>
                       <div class="row ms-1 mt-3">
                        <div class="col">
                           <div class="card text-center border-white">
                              <div class="card-header bg-white">
                                <ul class="nav nav-tabs card-header-tabs"  id="navLinkBox">
                                 <li class="nav-item">
                                   <span class="nav-link active" id="0" aria-current="true" onclick="changeRoomGroup(0)">객실</span>
                                 </li>
                                 
                                </ul>
                              </div>
                              <div class="card-body">
                                <div class="row">
                                    <div class="col-2 fw-semibold">
                                       객실명<span class="text-danger">*</span>
                                    </div>
                                </div>
                                <div class="row mt-2 ms-1">
                                 <div class="col-7">
                                    <input type="text" class="form-control" id="room_group_name" placeholder="객실명을 기입해주세요." onblur="getHotelInfo()">
                                 </div>
                                </div>
                                <div class="row ms-1 mt-4">
                                 <div class="col fw-semibold text-start">
                                    객실 금액<span class="text-danger">*</span>
                                    <span class="text-secondary ms-2 small">금액은 요일/시즌별 변동이 가능합니다.</span>
                                 </div>
                                </div>
                                <div class="row mt-2 ms-1">
                                 <div class="col-7">
                                    <input type="number" class="form-control" id="room_price" placeholder="객실 가격을 기입해주세요." onblur="getHotelInfo()">
                                 </div>
                                </div>
                                <div class="row ms-1 mt-4">
                                 <div class="col fw-semibold text-start">
                                    객실 대표 이미지<span class="text-danger">*</span>
                                 </div>
                                </div>
                                <div class="row ms-1 mt-1">
                                 <div class="col-5 text-start" >
	                                 <label for="room_group_img" class="btn  btn-outline-secondary" id="roomImgText">
										이미지를 선택해주세요.
									</label>
                                      <input class="form-control" type="file" id="room_group_img"  accept="image/*" onchange="getImages(2)" style="display: none;">
                                 </div>
                                </div>
                                <div class="row ms-1 mt-4">
                                 <div class="col fw-semibold text-start">
                                    객실 상세 이미지<span class="text-danger">*</span>
                                    <span class="text-secondary ms-2 small">최소 4장의 객실 내/외부 사진을 등록해주세요.</span>
                                 </div>
                                </div>
                                <div class="row ms-1 mt-1">
                                 <div class="col-5 text-start" >
	                                 <label for="room_detail_img" class="btn  btn-outline-secondary" id="roomDetailImgText">
										이미지를 선택해주세요.
									</label>
                                      <input class="form-control" type="file" id="room_detail_img" multiple accept="image/*" onchange="getImages(3)" style="display: none;">
                                 </div>
                                </div>
                                <div class="row ms-1 mt-4">
                                 <div class="col fw-semibold text-start">
                                    객실 뷰<span class="text-danger">*</span>
                                 </div>
                                </div>
                                <div class="row ms-1 mt-2">
                                 <div class="col text-start">
                                  <c:forEach items="${viewList}" var="view" varStatus="i">
			                               <span class="me-1 view"><input type="radio" id="viewId${view.id}" class="viewRadio" value="${view.id}" name="view" onchange="getHotelInfo()" >${view.room_view }</span>
			                       </c:forEach> 
                                 </div>
                                </div>
                                 <div class="row ms-1 mt-4">
                                 <div class="col fw-semibold text-start">
                                    객실 최대 인원<span class="text-danger">*</span>
                                 </div>
                                </div>
                                <div class="row mt-2 ms-1">
                                 <div class="col-7">
                                    <input type="number" class="form-control" id="fixed_number" placeholder="객실 최대 인원을 기입해주세요."  onblur="getHotelInfo()">
                                 </div>
                                </div>
                                <div class="row ms-1 mt-4">
                                 <div class="col fw-semibold text-start">
                                    객실 서비스
                                    <span class="text-secondary ms-2 small">객실 이용시 포함되는 서비스를 기입해주세요.</span>
                                 </div>
                                 <div class="col-4 text-start ps-0">
                                    <button type="button" class="btn-sm btn border btn-light" style="border-radius: 40%;" onclick="plusOptionOrServiceOrRoom(2)">+</button>
                                 </div>
                                </div>
                                <div class="row">
                                	<div class="col" id="customBox">
                                	
                                	</div>
                                </div>
                                <div class="row ms-1 mt-4">
                                 <div class="col fw-semibold text-start">
                                    유료 옵션
                                    <span class="text-secondary ms-2 small">유료로 추가 할 수 있는 옵션을 기입해주세요.</span>
                                 </div>
                                 <div class="col-4 text-start ps-0">
                                    <button type="button" class="btn-sm btn border btn-light" style="border-radius: 40%;" onclick="plusOptionOrServiceOrRoom(1)">+</button>
                                 </div>
                                </div>
                                 <div class="row">
                                	<div class="col" id="optionBox">
                                	
                                	</div>
                                </div>
                                <div class="row ms-1 mt-4">
                                 <div class="col fw-semibold text-start">
                                    방 번호<span class="text-danger">*</span>
                                    <span class="text-secondary ms-2 small">방 번호가 있다면 방 번호를, 없다면 1부터 차례대로 추가해 주세요.</span>
                                 </div>
                                 <div class="col-2 text-start ps-0">
                                    <button type="button" class="btn-sm btn border btn-light" style="border-radius: 40%;" onclick="plusOptionOrServiceOrRoom(3)">+</button>
                                 </div>
                                </div>
                                <div class="row">
                                	<div class="col" id="roomBox">
                                		   
                                	</div>
                                </div>
                             
                             </div>
                        </div>

                       </div>
                     
                     </div>
                    </div>
               </div>

            </div>
            </div>
    
        </div>
</div>
</div>

<div class="modal" tabindex="-1" id="modal">

	<div class="modal-dialog modal-fullscreen"
		style="opacity: 50%;">
		<div class="modal-content">
			<div class="modal-body text-center" style="color: black;">
			<div class="row mt-5 mb-5">
			</div>
			<div class="row mt-5"></div>
			<div class="row mt-5"></div>
			<div class="row mt-5"></div>
			<div class="row mt-5"></div>
			<div class="row mt-5"></div>
			<div class="row mt-5"></div>
			<div class="row mt-5"></div>
			<div class="row">
				<div class="col text-end pt-2">
				<div class="spinner-border" role="status">
					<span class="visually-hidden">Loading...</span>
				</div>
				</div>
				<div class="col fs-2 fw-semibold text-start pb-2">숙소 등록 중 . .</div>
			</div>
				
					
			</div>

		</div>
	</div>
</div>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
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
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>