

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
.form-control-plain {
		    border: none;
		    outline: none;
		    box-shadow: none;
		    resize: none;
  			height: 25px !important;
		}
.scroll-container {
  overflow: hidden; /* 스크롤 숨김 */
  height: 611px; /* 스크롤 영역의 높이 설정 */
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


.info-scroll-container {
  overflow: hidden; /* 스크롤 숨김 */
  height: 936px; /* 스크롤 영역의 높이 설정 */
}

.info-scroll-container:hover {
  overflow: auto; /* 마우스 호버 시 스크롤 보이기 */
}

/* 수직 스크롤 바 스타일 */
.info-scroll-container::-webkit-scrollbar {
  width: 4px;
}

.info-scroll-container::-webkit-scrollbar-track {
  background-color: #f1f1f1;
}

.info-scroll-container::-webkit-scrollbar-thumb {
  background-color: #888;
  border-radius: 4px;
}

.info-scroll-container::-webkit-scrollbar-thumb:hover {
  background-color: #555;
}
.buttonColor {
    background-color: #46B8FF	 !important;
    box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.5);
  }
.back-color-black{
	 background-color:black;
}
.back-color-gray{
	 background-color:gray;
	 opacity : 0.5;
}

.weather-icon{
	font-size: 600%;
}
</style>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	const hotelId = new URLSearchParams(location.search).get("id");
	var groupId = null;
	const dayPriceObj = {
		groups : [],
		hotel_id : hotelId
	};
	
function getGroupList(){
	const xhr = new XMLHttpRequest();
	const groupListBox = document.getElementById("groupListBox")
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			const response =JSON.parse(xhr.responseText);
			response.groupList.forEach(function(group,index){			
				
				const span = document.createElement("span");
				if(index == 0){
					groupId = group.id;
					span.classList.add("badge","back-color-black","me-1","groupBadge");
				}else{
					span.classList.add("badge","back-color-gray","me-1","groupBadge");
				}
				span.setAttribute("onclick","getGroupDayPrice("+group.id+")");
				span.id="badge"+group.id;
				span.innerText = group.room_group_name;
				groupListBox.appendChild(span);
				
			})
			getDayPriceList()
			getGroupDayPrice(groupId);
		}
	}
	xhr.open("get","./getGroupList?hotel_id="+hotelId);
	xhr.send();
}
	

function getGroupDayPrice(id){
	const groupBadge = document.getElementsByClassName("groupBadge");
	for(badge of groupBadge){
		badge.classList.remove("back-color-black","back-color-gray");
		badge.classList.add("back-color-gray");
	}
	const target = document.getElementById("badge"+id);
	target.classList.add("back-color-black")
	target.classList.remove("back-color-gray")
	groupId = id;
	
	
	
	const xhr = new XMLHttpRequest();
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status==200){
			const response = JSON.parse(xhr.responseText);
			for(var i=0; i<7; i++){
				const groupObj = dayPriceObj.groups.find(groups => groups.group == groupId);
				const daysObj = groupObj.days.find(days => days.day == i);
				const percent = daysObj.change_price;
				const increasedPrice = response.groupInfo.price * (100 + percent) / 100;
				
				const priceBox = document.getElementById("priceBox"+i);
				priceBox.innerHTML ="";
				const priceSpan = document.createElement("span");
				priceSpan.innerText = response.groupInfo.price.toLocaleString();
				priceBox.appendChild(priceSpan);
				const wonSpan = document.createElement("span");
				wonSpan.classList.add("text-secondary","small");
				wonSpan.innerText = "원";
				priceBox.appendChild(wonSpan);
				if(increasedPrice != response.groupInfo.price){
					wonSpan.innerText = "";
					const dirSpan = document.createElement("span");
					dirSpan.innerText = "→";
					priceBox.appendChild(dirSpan);
					
					const increaseSpan = document.createElement("span");
					if(increasedPrice > response.groupInfo.price){
						increaseSpan.classList.add("text-primary")
					}else{
						increaseSpan.classList.add("text-danger")
					}
					
					increaseSpan.innerText = increasedPrice.toLocaleString();
					priceBox.appendChild(increaseSpan);
					
					const won2Span = document.createElement("span");
					won2Span.classList.add("text-secondary","small");
					won2Span.innerText = "원";
					priceBox.appendChild(won2Span);
				}
				
			}
			
			const groupObj = dayPriceObj.groups.find(groups => groups.group == groupId);
			groupObj.days.forEach(function(day){
				const pricePerBox = document.getElementById("day"+day.day+"per");
				pricePerBox.value = day.change_price;
			})
		
		}
	}
	xhr.open("get","./getGroupInfo?id="+id);
	xhr.send();
}

function changePrice(day){

	const xhr = new XMLHttpRequest();
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status==200){
			const response = JSON.parse(xhr.responseText);
				const groupObj = dayPriceObj.groups.find(groups => groups.group == groupId);
				const daysObj = groupObj.days.find(days => days.day == day);
				const percent = daysObj.change_price;
				const increasedPrice = response.groupInfo.price * (100 + percent) / 100;
				
				const priceBox = document.getElementById("priceBox"+day);
				priceBox.innerHTML ="";
				const priceSpan = document.createElement("span");
				priceSpan.innerText = response.groupInfo.price.toLocaleString();
				priceBox.appendChild(priceSpan);
				const wonSpan = document.createElement("span");
				wonSpan.classList.add("text-secondary","small");
				wonSpan.innerText = "원";
				priceBox.appendChild(wonSpan);
				if(increasedPrice != response.groupInfo.price){
					wonSpan.innerText = "";
					const dirSpan = document.createElement("span");
					dirSpan.innerText = "→";
					priceBox.appendChild(dirSpan);
					
					const increaseSpan = document.createElement("span");
					if(increasedPrice > response.groupInfo.price){
						increaseSpan.classList.add("text-primary")
					}else{
						increaseSpan.classList.add("text-danger")
					}
					
					increaseSpan.innerText = increasedPrice.toLocaleString();
					priceBox.appendChild(increaseSpan);
					
					const won2Span = document.createElement("span");
					won2Span.classList.add("text-secondary","small");
					won2Span.innerText = "원";
					priceBox.appendChild(won2Span);
				}
		}
	}
	xhr.open("get","./getGroupInfo?id="+groupId);
	xhr.send();
}

function inputPercent(day){
	const groupObj = dayPriceObj.groups.find(groups => groups.group == groupId);
	const daysObj = groupObj.days.find(days => days.day == day);
     var input = document.getElementById("day" + day + "per");
	    if (input.value === "") {
	      input.value = "0";
	    }
	
	
	daysObj.change_price = parseInt(input.value);
	changePrice(day)
	/* getGroupDayPrice(groupId); */
}


function getDayPriceList(){
	const xhr = new XMLHttpRequest();
	
	xhr.onreadystatechange = function(){
		if(xhr.readyState ==4 && xhr.status==200){
			const response = JSON.parse(xhr.responseText);
			if(response.result == "success"){
				const groupList = response.groupList;
				const dayPriceList = response.dayPriceList;
				groupList.forEach(function(group){
					//객체 배열안에 객실 리스트 넣기
					const groupObj = {};
					groupObj["group"] = group.id;
					groupObj["days"] = [];
					
					dayPriceList.forEach(function(dayPrice){
						if(dayPrice.room_group_id == group.id){
							const day = {
									day : dayPrice.day,
									change_price : dayPrice.change_price
							}
							groupObj.days.push(day);
						}
						
					})
					dayPriceObj.groups.push(groupObj)
					
					
				})
			}else{
				const groupList = response.groupList;
				groupList.forEach(function(group){
					//객체 배열안에 객실 리스트 넣기
					const groupObj = {};
					groupObj["group"] = group.id;
					groupObj["days"] = [];
					for(var i=0; i<7; i++){
						const day = {
							day : i,
							change_price : 0
						}
						groupObj.days.push(day);
					}
					dayPriceObj.groups.push(groupObj);
				})
			}
				
		}
	}
	xhr.open("get","./getDayPriceList?hotel_id="+hotelId,false);
	xhr.send();
}


function saveDayPrice(){
	const xhr = new XMLHttpRequest();
	const dayPrice = JSON.stringify(dayPriceObj);
	xhr.onreadystatechange = function(){
		if(xhr.readyState ==4 && xhr.status == 200){
			const response = JSON.parse(xhr.responseText);		
			toastTest()
		}
	}
	xhr.open("post","./saveDayPrice");
	xhr.setRequestHeader("Content-Type", "application/json"); // JSON 형식 설정
	xhr.send(dayPrice);	
}

function getSeasonModal(){
	const modal = bootstrap.Modal.getOrCreateInstance("#seasonModal");
	const xhr = new XMLHttpRequest();
	const targetGroupBox = document.getElementById("targetGroupBox");
	targetGroupBox.innerHTML = ""; 
	seasonTargetGroups = [0];
	const inputs = document.querySelectorAll('#seasonModal input');
	  inputs.forEach(input => {
	    input.value = '';
	  });
	
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			const response =JSON.parse(xhr.responseText);
				const allSpan = document.createElement("span");
				allSpan.classList.add("badge","back-color-black","me-1","targetBadge");
				allSpan.setAttribute("onclick","getSeasonTargetGroup(0)");
				allSpan.id = "seasonGroup0"
				allSpan.innerText ="전체";
				targetGroupBox.appendChild(allSpan);
			response.groupList.forEach(function(group,index){			
				const span = document.createElement("span");
				span.classList.add("badge","back-color-gray","me-1","targetBadge");
				span.setAttribute("onclick","getSeasonTargetGroup("+group.id+")");
				span.id = "seasonGroup"+group.id;
				span.innerText = group.room_group_name;
				targetGroupBox.appendChild(span);
				
			})
			modal.show();
		}
	}
	xhr.open("get","./getGroupList?hotel_id="+hotelId);
	xhr.send();
}



var seasonTargetGroups = [0];

function getSeasonTargetGroup(id){	
	console.log(id)
	if(id == 0){
		seasonTargetGroups = [0];
		const badges = document.getElementsByClassName("targetBadge");
		for(badge of badges){
			badge.classList.remove("back-color-black");
			badge.classList.add("back-color-gray");
		}
		const allSpan = document.getElementById("seasonGroup0");
		allSpan.classList.remove("back-color-gray");
		allSpan.classList.add("back-color-black");
	}else{
		if (seasonTargetGroups.includes(id)) {
		      seasonTargetGroups = seasonTargetGroups.filter(group => group !== id);
				const groupSpan = document.getElementById("seasonGroup"+id);
				groupSpan.classList.remove("back-color-black");
				groupSpan.classList.add("back-color-gray");
		    } else {
		    	seasonTargetGroups = seasonTargetGroups.filter(group => group !== 0);
		      seasonTargetGroups.push(id);
		      const allSpan = document.getElementById("seasonGroup0");
				allSpan.classList.remove("back-color-black");
				allSpan.classList.add("back-color-gray");
		      const groupSpan = document.getElementById("seasonGroup"+id);
				groupSpan.classList.remove("back-color-gray");
				groupSpan.classList.add("back-color-black");
		    }	
	}
	
}

function regiEventPrice(){
	const xhr = new XMLHttpRequest();
	const modal = bootstrap.Modal.getOrCreateInstance("#seasonModal");
	const fluctNameInput =document.getElementById("fluctName");
	const fluctNumberInput =document.getElementById("fluctNumber");
	const fluctStartInput =document.getElementById("fluctStart");
	const fluctEndInput =document.getElementById("fluctEnd");
	
	const fluctName = fluctNameInput.value;
	const change_price = fluctNumberInput.value;
	const start_date = fluctStartInput.value;
	const end_date = fluctEndInput.value;
	
	xhr.onreadystatechange = function(){
		if(xhr.readyState ==4 && xhr.status ==200){
			const response = JSON.parse(xhr.responseText);
			modal.hide();
			getSeasonEvent();
			toastTest2();
		}
	}
	xhr.open("get","./regiEventPrice?seasonTargetGroups="+seasonTargetGroups+"&fluct_name="+fluctName+"&change_price="+change_price+"&start_date="+start_date+"&end_date="+end_date+"&hotelId="+hotelId);
	xhr.send();
}


function getSeasonEvent(){
	const xhr = new XMLHttpRequest();
	const seasonPriceListBox = document.getElementById("seasonPriceListBox");
	seasonPriceListBox.innerHTML ="";
	xhr.onreadystatechange = function(){
		if(xhr.readyState ==4 && xhr.status ==200){
			const response = JSON.parse(xhr.responseText);
			response.seasonPriceList.forEach(function(seasonPrice){
				const col1 = document.createElement("div");
				col1.classList.add("col-2","mb-2");
				seasonPriceListBox.appendChild(col1);
				
				const card = document.createElement("div");
				card.classList.add("card");
				card.style.width = "12rem";
				col1.appendChild(card);
				
				const cardBody = document.createElement("div");
				cardBody.classList.add("card-body");
				card.appendChild(cardBody);
				
				const row1 =document.createElement("div");
				row1.classList.add("row","border-bottom","pb-1");
				cardBody.appendChild(row1);
				
				const col2 = document.createElement("div");
				if(seasonPrice.changePrice > 0){
					col2.classList.add("col","text-primary","fw-semibold");
					col2.innerText = "인상";
				}else{
					col2.classList.add("col","text-danger","fw-semibold");
					col2.innerText = "인하";
				}
				row1.appendChild(col2);
				
				const col3 = document.createElement("div");
				col3.classList.add("col","text-end");
				row1.appendChild(col3);
				
				const span1 = document.createElement("span");
				span1.classList.add("me-2");
				col3.appendChild(span1);
				
				const i1 = document.createElement("i");
				i1.classList.add("bi","bi-pencil-square");
				i1.setAttribute("onclick", "updateSeasonPriceModal(" + seasonPrice.id + ", '" + seasonPrice.fluctName + "', " + seasonPrice.changePrice + ", '" + seasonPrice.startDate + "', '" + seasonPrice.endDate + "','"+seasonPrice.roomGroupNameList+"')");
				span1.appendChild(i1);
				
				const span2 = document.createElement("span");
				col3.appendChild(span2);
				
				const i2 = document.createElement("i");
				i2.classList.add("bi","bi-trash3-fill");
				i2.setAttribute("onclick","deleteSeasonPriceModal("+seasonPrice.id+")")
				span2.appendChild(i2);
				
				const row2 = document.createElement("div");
				row2.classList.add("row","mt-2");
				cardBody.appendChild(row2);
				
				const col4 = document.createElement("div");
				col4.classList.add("col","small","text-secondary");
				col4.innerText = "변동명"
				row2.appendChild(col4);
				
				const row3 = document.createElement("div");
				row3.classList.add("row")
				cardBody.appendChild(row3);
				
				const titleCol = document.createElement("div");
				titleCol.classList.add("col","small","fw-semibold");
				titleCol.innerText = seasonPrice.fluctName;
				row3.appendChild(titleCol)
				
				const row4 = document.createElement("div");
				row4.classList.add("row","mt-2")
				cardBody.appendChild(row4);
				
				const groupCol = document.createElement("div");
				groupCol.classList.add("col","small","text-secondary");
				groupCol.innerText = "적용객실";
				row4.appendChild(groupCol);
				
				const row5= document.createElement("div");
				row5.classList.add("row")
				cardBody.appendChild(row5);
				
				const groupListCol =document.createElement("div");
				groupListCol.classList.add("col");
				row5.appendChild(groupListCol);
				
				var groupNumber= seasonPrice.roomGroupNameList.length;
				console.log(seasonPrice.roomGroupNameList[0].roomGroupName);
				if(groupNumber > 1){
					const badge = document.createElement("span");
					badge.classList.add("badge","back-color-black","dropdown-toggle");
					badge.setAttribute("data-bs-toggle","dropdown");
					badge.setAttribute("aria-expanded","false");
					badge.innerText = seasonPrice.roomGroupNameList[0].roomGroupName + " 외 " + (groupNumber-1);
					groupListCol.appendChild(badge);
					
					const ul = document.createElement("ul");
					ul.classList.add("dropdown-menu");
					groupListCol.appendChild(ul);
					
					for(group of seasonPrice.roomGroupNameList){
						const li = document.createElement("li");
						li.classList.add("li");
						ul.appendChild(li);
						
						const a =document.createElement("a");
						a.classList.add("dropdown-item");
						a.innerText= group.roomGroupName;
						li.appendChild(a);
					}
				}else{
					const badge = document.createElement("span");
					badge.classList.add("badge","back-color-black");
					badge.innerText = seasonPrice.roomGroupNameList[0].roomGroupName
					groupListCol.appendChild(badge);
				}
				
				const row6 = document.createElement("div");
				row6.classList.add("row","mt-2");
				cardBody.appendChild(row6);
				
				const changeCol = document.createElement("col");
				changeCol.classList.add("col","small","text-secondary");
				changeCol.innerText = "변동률";
				row6.appendChild(changeCol);
				
				const row7 = document.createElement("div");
				row7.classList.add("row");
				cardBody.appendChild(row7);
				
				const changeNumberCol =document.createElement("div");
				changeNumberCol.classList.add("col","small","fw-semibold")
				changeNumberCol.innerText = seasonPrice.changePrice +"%";
				if(seasonPrice.changePrice > 0){
					changeNumberCol.classList.add("text-primary");
				}else{
					changeNumberCol.classList.add("text-danger");
				}
				row7.appendChild(changeNumberCol);
				
				const row8 = document.createElement("div");
				row8.classList.add("row","mt-2");
				cardBody.appendChild(row8);
				
				const startTitleCol =document.createElement("div");
				startTitleCol.classList.add("col","small","text-secondary");
				startTitleCol.innerText = "변동시작일";
				row8.appendChild(startTitleCol);
				
				const row9 = document.createElement("div");
				row9.classList.add("row");
				cardBody.appendChild(row9);
				
				const startCol =document.createElement("div");
				startCol.classList.add("col","small","fw-semibold");
				startCol.innerText = seasonPrice.startDate
				row9.appendChild(startCol);
				
				const row10 = document.createElement("div");
				row10.classList.add("row","mt-2");
				cardBody.appendChild(row10);
				
				const endTitleCol =document.createElement("div");
				endTitleCol.classList.add("col","small","text-secondary");
				endTitleCol.innerText = "변동종료일";
				row10.appendChild(endTitleCol);
				
				const row11 = document.createElement("div");
				row11.classList.add("row");
				cardBody.appendChild(row11);
				
				const endCol =document.createElement("div");
				endCol.classList.add("col","small","fw-semibold");
				endCol.innerText = seasonPrice.endDate
				row11.appendChild(endCol);			
			})
			const plusCol = document.createElement("div");
			plusCol.classList.add("col-2");
			seasonPriceListBox.appendChild(plusCol);
			
			const plusCard =document.createElement("div");
			plusCard.classList.add("card");
			plusCard.style.width ="12rem";
			plusCard.style.height = "316px";
			plusCard.setAttribute("onclick","getSeasonModal()");
			plusCol.appendChild(plusCard);
			
			const plusCardBody =document.createElement("div");
			plusCardBody.classList.add("card-body");
			plusCard.appendChild(plusCardBody);
			
			const plusrow = document.createElement("div");
			plusrow.classList.add("row","mt-5","mb-5");
			plusCardBody.appendChild(plusrow);
			
			const plusTextCol = document.createElement("div");
			plusTextCol.classList.add("col","mt-5","mb-5","text-secondary","fs-1","text-center");
			plusTextCol.innerText = "+";
			plusrow.appendChild(plusTextCol);
			
		}
	}
	xhr.open("get","./getSeasonPriceList?hotel_id="+hotelId);
	xhr.send();
}



function toastTest(){
	const toast = bootstrap.Toast.getOrCreateInstance("#dayToast");
	
	toast.show()
	
}
function toastTest2(){
	const toast = bootstrap.Toast.getOrCreateInstance("#seasonToast");
	
	toast.show()
	
}
function toastTest3(){
	const toast = bootstrap.Toast.getOrCreateInstance("#updateToast");
	
	toast.show()
	
}
function deleteSeasonPriceModal(id){
	const modal = bootstrap.Modal.getOrCreateInstance("#deleteModal")
	const seasonDeleteButton= document.getElementById("seasonDeleteButton");
	seasonDeleteButton.setAttribute("onclick","deleteSeasonProcess("+id+")");
	modal.show();
}
function deleteSeasonProcess(id){
	const modal = bootstrap.Modal.getOrCreateInstance("#deleteModal")
	
	const xhr = new XMLHttpRequest();
	
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status==200){
			const response = JSON.parse(xhr.responseText);
			modal.hide();
			getSeasonEvent()
		}
	}
	xhr.open("get","./deleteSeasonProcess?id="+id);
	xhr.send();
}

function updateSeasonPriceModal(id,name,price,sd,ed,list){
	const modal = bootstrap.Modal.getOrCreateInstance("#updateModal")
	const seasonUpdateButton= document.getElementById("seasonUpdateButton");
	const xhr = new XMLHttpRequest();
	seasonUpdateButton.setAttribute("onclick","updateEventPrice("+id+")");
	updateTargetGroupBox.innerHTML = ""; 
	updateSeasonTargetGroups = [0];
	const inputs = document.querySelectorAll('#updateModal input');
	  inputs.forEach(input => {
	    input.value = '';
	  });
	const updateFluctName = document.getElementById("updateFluctName")
	const updateFluctNumber = document.getElementById("updateFluctNumber")
	const updateFluctStart = document.getElementById("updateFluctStart")
	const updateFluctEnd = document.getElementById("updateFluctEnd")
	
	const start = new Date(sd);
	const end = new Date(ed);

	updateFluctName.value = name;
	updateFluctNumber.value = price;
	updateFluctStart.value = start.toISOString().slice(0, 10);
	updateFluctEnd.value = end.toISOString().slice(0, 10);
	 
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			const response =JSON.parse(xhr.responseText);
				const allSpan = document.createElement("span");
				allSpan.classList.add("badge","back-color-black","me-1","targetBadge");
				allSpan.setAttribute("onclick","getUpdateSeasonTargetGroup(0)");
				allSpan.id = "updateSeasonGroup0"
				allSpan.innerText ="전체";
				updateTargetGroupBox.appendChild(allSpan);
			response.groupList.forEach(function(group,index){			
				const span = document.createElement("span");
				span.classList.add("badge","back-color-gray","me-1","targetBadge");
				span.setAttribute("onclick","getUpdateSeasonTargetGroup("+group.id+")");
				span.id = "updateSeasonGroup"+group.id;
				span.innerText = group.room_group_name;
				updateTargetGroupBox.appendChild(span);
				
			})
			modal.show();
		}
	}
	xhr.open("get","./getGroupList?hotel_id="+hotelId);
	xhr.send();
}


var updateSeasonTargetGroups = [0];
function getUpdateSeasonTargetGroup(id){
	if(id == 0){
		updateSeasonTargetGroups = [0];
		const badges = document.getElementsByClassName("targetBadge");
		for(badge of badges){
			badge.classList.remove("back-color-black");
			badge.classList.add("back-color-gray");
		}
		const allSpan = document.getElementById("updateSeasonGroup0");
		allSpan.classList.remove("back-color-gray");
		allSpan.classList.add("back-color-black");
	}else{
		if (updateSeasonTargetGroups.includes(id)) {
			updateSeasonTargetGroups = updateSeasonTargetGroups.filter(group => group !== id);
				const groupSpan = document.getElementById("updateSeasonGroup"+id);
				groupSpan.classList.remove("back-color-black");
				groupSpan.classList.add("back-color-gray");
		    } else {
		    	updateSeasonTargetGroups = updateSeasonTargetGroups.filter(group => group !== 0);
		    	updateSeasonTargetGroups.push(id);
		      const allSpan = document.getElementById("updateSeasonGroup0");
				allSpan.classList.remove("back-color-black");
				allSpan.classList.add("back-color-gray");
		      const groupSpan = document.getElementById("updateSeasonGroup"+id);
				groupSpan.classList.remove("back-color-gray");
				groupSpan.classList.add("back-color-black");
		    }	
	}
	
}

function updateEventPrice(id){
	const xhr = new XMLHttpRequest();
	const modal = bootstrap.Modal.getOrCreateInstance("#updateModal");
	const updateFluctNameInput = document.getElementById("updateFluctName")
	const updateFluctNumberInput = document.getElementById("updateFluctNumber")
	const updateFluctStartInput = document.getElementById("updateFluctStart")
	const updateFluctEndInput = document.getElementById("updateFluctEnd")
	
	const updateFluctName = updateFluctNameInput.value;
	const updateFluctNumber = updateFluctNumberInput.value;
	const updateFluctStart = updateFluctStartInput.value;
	const updateFluctEnd = updateFluctEndInput.value;
	
	xhr.onreadystatechange = function(){
		if(xhr.readyState ==4 && xhr.status ==200){
			const response = JSON.parse(xhr.responseText);
			modal.hide();
			getSeasonEvent();
			toastTest3();
		}
	}
	xhr.open("get","./updateEventPrice?updateSeasonTargetGroups="+updateSeasonTargetGroups+"&fluct_name="+updateFluctName+"&change_price="+updateFluctNumber+"&start_date="+updateFluctStart+"&end_date="+updateFluctEnd+"&hotelId="+hotelId+"&id="+id);
	xhr.send();
}
function domainLink(){
	//현재 날짜 생성
	var currentLink = new Date();
	// 내일
	var nextLink = new Date(currentLink);
	nextLink.setDate(currentLink.getDate() + 1);

	// 월 이름 배열
	var month = [
	  "01", "02", "03", "04", "05", "06",
	  "07", "08", "09", "10", "11", "12"
	];

	// 요일 이름 배열
	var day = [
	  "일", "월", "화", "수", "목", "금", "토"
	];

	// 월, 일, 요일 추출
	var currentLinkMonth = month[currentLink.getMonth()];
	var currentLinkDay = currentLink.getDate().toString().padStart(2, '0');
	var currentLinkDayOfWeek = day[currentLink.getDay()];
	var currentLinkYear = currentLink.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기
	//내일
	var nextLinkMonth = month[nextLink.getMonth()];
	var nextLinkDay = nextLink.getDate().toString().padStart(2, '0');
	var nextLinkDayOfWeek = day[nextLink.getDay()];
	var nextLinkYear = nextLink.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기

	// 변환된 값 출력
	var startDay = currentLinkYear + "/" + currentLinkMonth + "/" + currentLinkDay + "/(" + currentLinkDayOfWeek + ")";
	var endDay = nextLinkYear + "/" + nextLinkMonth + "/" + nextLinkDay + "/(" + nextLinkDayOfWeek + ")";
	var dayDifference = 1;
	
	const domainLink = document.getElementById("domainLink");
	domainLink.href ="../userboard/hotelInfoPage?id="+hotelId+"&startDate="+startDay+"&endDate="+endDay+"&people="+2+"&dayDifference="+dayDifference;
}
	window.addEventListener("DOMContentLoaded", function() {
		getGroupList()
		domainLink()
		getSeasonEvent()
	});
</script>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-2 bg-black text-white" style="height: 100;">
				<div class="row mt-5">
					<div class="col-3 mt-4 ps-4 pt-3">
						<img src="/uploadFiles/${hotelInfo.hotelDto.hotel_img }"
							style="width: 50px; height: 50px; border-radius: 50%;">
					</div>
					<div class="col-9">
						<div class="row">
							<div class="col fw-semibold fs-6 pt-3 ps-3 small text-secondary">
								${hotelInfo.category.category }</div>
							<div class="col text-end small pe-3 fs-6 pt-2">
								<a class="btn btn-dark btn-sm" href="./sellerHotelListPage">숙소변경</a>
							</div>
						</div>
						<div class="row pt-0">
							<div class="col fw-semibold fs-6 pt-2 ps-3">
								${hotelInfo.hotelDto.hotel_name}</div>
						</div>
					</div>
				</div>
				<div class="row mt-5">
					<div class="col-1"></div>
					<div class="col text-secondary fw-bold fs-5">숙소/예약관리</div>
				</div>
				<div class="row mt-4">
					<div class="col-1"></div>
					<div class="col fw-semibold pb-0">
						<a href="./sellerMainPage?id=${hotelInfo.hotelDto.id}" style="text-decoration: none">
						<i class="bi bi-house fs-4 text-secondary pt-5"></i><span
							class="ps-3 text-white fs-5 pt-0">홈</span>
							</a>
					</div>
				</div>
				<div class="row mt-4">
					<div class="col-1"></div>
					<div class="col fw-semibold pb-0">
						<a href="./sellerReserveListPage?id=${hotelInfo.hotelDto.id}" style="text-decoration: none">
						<i class="bi bi-card-list fs-4 text-secondary pt-5"></i><span
							class="ps-3 text-white fs-5 pt-0">예약목록</span>
					</a>
					</div>
				</div>
				<div class="row mt-4">
					<div class="col-1"></div>
					<div class="col fw-semibold pb-0">
						<a href="./sellerTimeLinePage?id=${hotelInfo.hotelDto.id}" style="text-decoration: none">
						<i class="bi bi-calendar fs-4 text-secondary pt-5"></i><span
							class="ps-3 text-white fs-5 pt-0">타임라인</span>
						</a>
					</div>
				</div>

				<div class="row mt-4">
					<div class="col-1"></div>
					<div class="col fw-semibold pb-0">
						<a href="./sellerPriceSettingPage?id=${hotelInfo.hotelDto.id}" style="text-decoration: none">
						<i class="bi bi-wallet fs-4 text-info pt-5"></i><span
							class="ps-3 text-white fs-5 pt-0">날짜별 요금조정</span>
						</a>
					</div>
				</div>
				<div class="row mt-4">
					<div class="col-1"></div>
					<div class="col fw-semibold pb-0">
						<a href="./sellerHotelManagePage?id=${hotelInfo.hotelDto.id}" style="text-decoration: none">
						<i class="bi bi-gear fs-4 text-secondary pt-5"></i><span
							class="ps-3 text-white fs-5 pt-0">방 관리</span>
						</a>
					</div>
				</div>
				<div class="row mt-4">
					<div class="col-1"></div>
					<div class="col fw-semibold pb-0">
						<a href="./sellerDashBoardPage?id=${hotelInfo.hotelDto.id}" style="text-decoration: none">
						<i class="bi bi-graph-up-arrow fs-4 text-secondary pt-5"></i><span
							class="ps-3 text-white fs-5 pt-0">대시보드</span>
							</a>
					</div>
				</div>
				<div class="row mt-5">
					<div class="col-1"></div>
					<div class="col text-secondary fw-bold fs-5">홈페이지 관리</div>
				</div>
				<div class="row mt-4">
					<div class="col-1"></div>
					<div class="col fw-semibold pb-0">
						<a  style="text-decoration: none" id="domainLink">
<i class="bi bi-signpost fs-4 text-secondary pt-5"></i><span
class="ps-3 text-white fs-5 pt-0">도메인 연결</span>
</a>
					</div>
				</div>
				<div class="row mt-4">
					<div class="col-1"></div>
					<div class="col fw-semibold pb-0">
						<i class="bi bi-clipboard fs-4 text-secondary pt-5"></i><span
							class="ps-3 text-white fs-5 pt-0">리뷰 관리</span>
					</div>
				</div>
				<div class="row mt-4">
					<div class="col-1"></div>
					<div class="col fw-semibold pb-0">
						<i class="bi bi-question-circle fs-4 text-secondary pt-5"></i><span
							class="ps-3 text-white fs-5 pt-0">문의/요청</span>
					</div>
				</div>
			</div>
			<div class="col bg-secondary bg-opacity-10 info-scroll-container">
				<div class="row mt-4"></div>
				<div class="row ms-3 border-bottom pb-3">
					<div class="col fw-bold fs-3">
						<i class="bi bi-wallet pe-4"></i>날짜별 요금조정
					</div>
				</div>
		
				<div class="row mt-3">
					<!-- 날짜, 숫자정보 -->
					<div class="col">
						<div class="card">
							<div class="card-body">
								<div class="row ms-1 mt-1">
									<div class="col text-secondary">
										객실명
									</div>
								</div>
								<div class="row ms-1 mt-1">
									<div class="col-9  fs-3" id="groupListBox">
										
									</div>
									<div class="col text-end" id="saveButtonBox">
										<button type="button" class="btn buttonColor text-white fs-5 fw-semibold" onclick="saveDayPrice()"><i class="bi bi-check2"></i> 변경사항 저장</button>
									</div>
								</div>
								<div class="row ms-1 mt-3">
									<div class="col text-secondary fs-4">요일별 요금조정/%</div>
								</div>
								<div class="row ms-1 mt-4">
									<div class="col">
										<div class="card" style="width: 12rem;">
										  <div class="card-body">
										    <div class="row">
										    	<div class="col  fs-5 fw-semibold">월요일</div>
										    </div>
										    <div class="row mt-1">
										    	<div class="col small text-secondary">가격</div>
										    </div>
										    <div class="row">
										    	<div class="col fw-semibold" id="priceBox1">
										    		<span id="price1">50,000</span><span class="text-secondary small">원</span>
										    	</div>
										    </div>
										    <div class="row mt-2">
										    	<div class="col text-secondary">
										    		변동률
												</div>	
										    </div>
										     <div class="row">
										    	<div class="col">
										    		<div class="input-group">
													  <input type="text" class="form-control" id="day1per" oninput="inputPercent(1)">
													  <span class="input-group-text">%</span>
													</div>
												</div>	
										    </div>
										  </div>
										</div>
									</div>
									<div class="col">
										<div class="card" style="width: 12rem;">
										  <div class="card-body">
										    <div class="row">
										    	<div class="col  fs-5 fw-semibold">화요일</div>
										    </div>
										    <div class="row mt-1">
										    	<div class="col small text-secondary">가격</div>
										    </div>
										    <div class="row">
										    	<div class="col fw-semibold" id="priceBox2">
										    		<span id="price2">50,000</span><span class="text-secondary small">원</span>
										    	</div>
										    </div>

										    <div class="row mt-2">
										    	<div class="col text-secondary">
										    		변동률
												</div>
										    </div>
										     <div class="row">
										    	<div class="col">
										    		<div class="input-group">
													  <input type="text" class="form-control"  id="day2per" oninput="inputPercent(2)">
													  <span class="input-group-text">%</span>
													</div>
												</div>	
										    </div>
										  </div>
										</div>
									</div>
									<div class="col">
										<div class="card" style="width: 12rem;">
										  <div class="card-body">
										    <div class="row">
										    	<div class="col  fs-5 fw-semibold">수요일</div>
										    </div>
										    <div class="row mt-1">
										    	<div class="col small text-secondary">가격</div>
										    </div>
										    <div class="row">
										    	<div class="col fw-semibold" id="priceBox3">
										    		<span id="price3">50,000</span><span class="text-secondary small">원</span>
										    	</div>
										    </div>
										    <div class="row mt-2">
										    	<div class="col text-secondary">
										    		변동률
												</div>	
										    </div>
										     <div class="row">
										    	<div class="col">
										    		<div class="input-group">
													  <input type="text" class="form-control" id="day3per" oninput="inputPercent(3)">
													  <span class="input-group-text">%</span>
													</div>
												</div>	
										    </div>
										  </div>
										</div>
									</div>
									<div class="col">
										<div class="card" style="width: 12rem;">
										  <div class="card-body">
										    <div class="row">
										    	<div class="col  fs-5 fw-semibold">목요일</div>
										    </div>
										    <div class="row mt-1">
										    	<div class="col small text-secondary">가격</div>
										    </div>
										    <div class="row">
										    	<div class="col fw-semibold" id="priceBox4">
										    		<span id="price4">50,000</span><span class="text-secondary small">원</span>
										    	</div>
										    </div>
										    <div class="row mt-2">
										    	<div class="col text-secondary">
										    		변동률
												</div>
													
										    </div>
										     <div class="row">
										    	<div class="col">
										    		<div class="input-group">
													  <input type="text" class="form-control" id="day4per" oninput="inputPercent(4)">
													  <span class="input-group-text">%</span>
													</div>
												</div>	
										    </div>
										  </div>
										</div>
									</div>
									<div class="col">
										<div class="card" style="width: 12rem;">
										  <div class="card-body">
										    <div class="row">
										    	<div class="col  fs-5 fw-semibold">금요일</div>
										    </div>
										    <div class="row mt-1">
										    	<div class="col small text-secondary">가격</div>
										    </div>
										    <div class="row">
										    	<div class="col fw-semibold" id="priceBox5">
										    		<span id="price5">50,000</span><span class="text-secondary small">원</span>
										    	</div>
										    </div>
										    <div class="row mt-2">
										    	<div class="col text-secondary">
										    		변동률
												</div>	
										    </div>
										     <div class="row">
										    	<div class="col">
										    		<div class="input-group">
													  <input type="number" class="form-control" id="day5per" oninput="inputPercent(5)"  min="0" max="100">
													  <span class="input-group-text">%</span>
													</div>
												</div>	
										    </div>
										  </div>
										</div>
									</div>
									<div class="col">
										<div class="card" style="width: 12rem;">
										  <div class="card-body">
										    <div class="row">
										    	<div class="col  fs-5 fw-semibold text-primary">토요일</div>
										    </div>
										    <div class="row mt-1">
										    	<div class="col small text-secondary">가격</div>
										    </div>
										    <div class="row">
										    	<div class="col fw-semibold" id="priceBox6">
										    		<span id="price6">50,000</span><span class="text-secondary small">원</span>
										    	</div>
										    </div>
										    <div class="row mt-2">
										    	<div class="col text-secondary">
										    		변동률
												</div>	
										    </div>
										     <div class="row">
										    	<div class="col">
										    		<div class="input-group">
													  <input type="number" class="form-control" id="day6per" oninput="inputPercent(6)"  min="0" max="100">
													  <span class="input-group-text">%</span>
													</div>
												</div>	
										    </div>
										  </div>
										</div>
									</div>
									<div class="col">
										<div class="card" style="width: 12rem;">
										  <div class="card-body">
										    <div class="row">
										    	<div class="col  fs-5 fw-semibold text-danger">일요일</div>
										    </div>
										    <div class="row mt-1">
										    	<div class="col small text-secondary">가격</div>
										    </div>
										    <div class="row">
										    	<div class="col fw-semibold" id="priceBox0">
										    	
										    		<span id="price0">50,000</span><span class="text-secondary small">원</span><span>→</span><span >50,000</span><span class="text-secondary small">원</span>
										    	</div>
										    </div>
										    <div class="row mt-2">
										    	<div class="col text-secondary">
										    		변동률
												</div>	
										    </div>
										     <div class="row">
										    	<div class="col">
										    		<div class="input-group">
													  <input type="number" class="form-control" id="day0per" oninput="inputPercent(0)"  min="0" max="100">
													  <span class="input-group-text">%</span>
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
				
				
				<div class="row mt-3">
					<!-- 날짜, 숫자정보 -->
					<div class="col">
						<div class="card">
							<div class="card-body">
								  <div class="row ms-1 mt-1">
									<div class="col text-secondary fs-4">시즌/이벤트 요금조정/%</div>
								</div>
								<div class="row ms-1 mt-4 mb-2"  id="seasonPriceListBox">
								<div class="col-2">
										<div class="card" style="width: 12rem;">
										  <div class="card-body">
										  <div class="row border-bottom pb-1">
										  	<div class="col text-primary fw-semibold">
										  		인상
										  	</div>
										  	<div class="col text-end">
										  		<span class="me-2"><i class="bi bi-pencil-square"></i></span>
										  		<span><i class="bi bi-trash3-fill"></i></span>
										  	</div>
										  </div>
										  	<div class="row mt-2">
										  		<div class="col small text-secondary ">
										  			변동명
										  		</div>
										  	</div>
										  	<div class="row">
										  		<div class="col small fw-semibold">성수기기기기기가</div>
										  	</div>
										  	<div class="row mt-2">
										  		<div class="col small text-secondary ">
										  			적용객실
										  		</div>
										  	</div>
										  	<div class="row">
										  		<div class="col">
										  			<span class="badge  back-color-black dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">디럭스 더블 외 3</span>	
										  			<ul class="dropdown-menu">
													    <li><a class="dropdown-item" href="#">Action</a></li>
													    <li><a class="dropdown-item" href="#">Another action</a></li>
													    <li><a class="dropdown-item" href="#">Something else here</a></li>
													 </ul>
										  		</div>
										  	</div>
										  	<div class="row mt-2">
										  		<div class="col small text-secondary">변동률</div>
										  	</div>
										  	<div class="row">
										  		<div class="col small fw-semibold text-primary">
										  			50%
										  		</div>
										  	</div>
										  	<div class="row mt-2">
										  		<div class="col small text-secondary">변동시작일</div>
										  	</div>
										  		<div class="row">
										  		<div class="col small fw-semibold">
										  			23/07/15
										  		</div>
										  	</div>
										  	<div class="row mt-2">
										  		<div class="col small text-secondary">변동종료일</div>
										  	</div>
										  		<div class="row">
										  		<div class="col small fw-semibold">
										  			23/08/21
										  		</div>
										  	</div>
										  </div>
										</div>
									</div>
									<div class="col-2">
										<div class="card" style="width: 12rem;">
										  <div class="card-body">
										  <div class="row border-bottom pb-1">
										  	<div class="col text-danger fw-semibold">
										  		인하
										  	</div>
										  	<div class="col text-end">
										  		<span class="me-2"><i class="bi bi-pencil-square"></i></span>
										  		<span><i class="bi bi-trash3-fill"></i></span>
										  	</div>
										  </div>
										  	<div class="row mt-2">
										  		<div class="col small text-secondary ">
										  			변동명
										  		</div>
										  	</div>
										  	<div class="row">
										  		<div class="col small fw-semibold">비수기세일</div>
										  	</div>
										  	<div class="row mt-2">
										  		<div class="col small text-secondary ">
										  			적용객실
										  		</div>
										  	</div>
										  	<div class="row">
										  		<div class="col">
										  			<span class="badge  back-color-black dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">디럭스 더블 외 3</span>	
										  			<ul class="dropdown-menu">
													    <li><a class="dropdown-item" href="#">Action</a></li>
													    <li><a class="dropdown-item" href="#">Another action</a></li>
													    <li><a class="dropdown-item" href="#">Something else here</a></li>
													 </ul>
										  		</div>
										  	</div>
										  	<div class="row mt-2">
										  		<div class="col small text-secondary">변동률</div>
										  	</div>
										  	<div class="row">
										  		<div class="col small fw-semibold text-danger">
										  			-50%
										  		</div>
										  	</div>
										  	<div class="row mt-2">
										  		<div class="col small text-secondary">변동시작일</div>
										  	</div>
										  		<div class="row">
										  		<div class="col small fw-semibold">
										  			23/07/15
										  		</div>
										  	</div>
										  	<div class="row mt-2">
										  		<div class="col small text-secondary">변동종료일</div>
										  	</div>
										  		<div class="row">
										  		<div class="col small fw-semibold">
										  			23/08/21
										  		</div>
										  	</div>
										  </div>
										</div>
									</div>
							
									<div class="col-2">
										<div class="card" style="width: 12rem; height: 316px;" onclick ="getSeasonModal()">
										  <div class="card-body">
										  	<div class="row mt-5 mb-5">
										  		<div class="col mt-5 mb-5 text-secondary fs-1 text-center">
										  			+
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





<div class="modal" tabindex="-1" id="seasonModal">
  <div class="modal-dialog modal-dialog-centered modal-sm" >
    <div class="modal-content">
      <div class="modal-body">
      	<div class="row mt-2">
      		<div class="col text-secondary small">
        		적용객실
        	</div>
        	<div class="col text-end">
        		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        	</div>
      	</div>
      	<div class="row ps-1">
      		<div class="col" id="targetGroupBox"></div>
      	</div>
        <div class="row mt-2">
        	<div class="col text-secondary small">
        		변동명
        	</div>

        </div>
        <div class="row ps-1">
        	<div class="col-10"><input type="text" class="form-control" placeholder="최대 8자" id="fluctName"></div>
        </div>
         <div class="row mt-2">
        	<div class="col text-secondary small">
				변동률/%
        	</div>
        </div>
         <div class="row ps-1">
        	<div class="col-6">
        		<div class="input-group">
				  <input type="number" class="form-control" id="fluctNumber">
				  <span class="input-group-text">%</span>
				</div>
			</div>
        </div>
         <div class="row mt-2">
        	<div class="col text-secondary small">
				변동시작일
        	</div>
        </div>
        <div class="row ps-1">
        	<div class="col"><input type="date" id="fluctStart"></div>
        </div>
         <div class="row mt-2">
        	<div class="col text-secondary small">
        		변동종료일
        	</div>
        </div>
        <div class="row ps-1">
        	<div class="col"><input type="date" id="fluctEnd"></div>
        </div>
      </div>
      <div class="modal-footer">
         <button type="button" class="btn btn-primary" onclick="regiEventPrice()">추가</button>
      </div>
    </div>
  </div>
</div>
	
	
	
	
	
	
	
  <!--요일별 완료-->
  <div class="toast-container top-0 start-50 translate-middle-x p-3" >
    <div class="toast" id="dayToast">
      <div class="toast-header">
        <img src="../resources/img/minilogo.jpg" class="rounded me-2" alt="..." style="width:20px; height: 20px;">
        <strong class="me-auto">Roaming</strong>
        <small>방금 전</small>
      </div>
      <div class="toast-body">
        요일별 요금조정이 저장되었습니다.
      </div>
    </div>
  </div>
  <!--시즌이벤트 완료-->
 <div class="toast-container top-50 start-50 translate-middle-x p-3" >
    <div class="toast" id="seasonToast">
      <div class="toast-header">
        <img src="../resources/img/minilogo.jpg" class="rounded me-2" alt="..." style="width:20px; height: 20px;">
        <strong class="me-auto">Roaming</strong>
        <small>방금 전</small>
      </div>
      <div class="toast-body">
       시즌/이벤트 요금조정이 추가되었습니다.
      </div>
    </div>
  </div>

  <!--업뎃 완료-->
 <div class="toast-container top-50 start-50 translate-middle-x p-3" >
    <div class="toast" id="updateToast">
      <div class="toast-header">
        <img src="../resources/img/minilogo.jpg" class="rounded me-2" alt="..." style="width:20px; height: 20px;">
        <strong class="me-auto">Roaming</strong>
        <small>방금 전</small>
      </div>
      <div class="toast-body">
       시즌/이벤트 요금조정이 수정되었습니다.
      </div>
    </div>
  </div>

<!-- 삭제모달 -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header bg-secondary text-white">
        <h1 class="modal-title fs-5" id="exampleModalLabel">삭제</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body fw-semibold">
        <i class="bi bi-exclamation-diamond"></i>&nbsp; 시즌/이벤트 요금 조정 삭제 시 복구 할 수 없습니다.
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-danger" id="seasonDeleteButton">삭제</button>
      </div>
    </div>
  </div>
</div>

<!-- 수정모달 -->
<div class="modal" tabindex="-1" id="updateModal">
  <div class="modal-dialog modal-dialog-centered modal-sm" >
    <div class="modal-content">
      <div class="modal-body">
      	<div class="row mt-2">
      		<div class="col text-secondary small">
        		적용객실
        	</div>
        	<div class="col text-end">
        		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        	</div>
      	</div>
      	<div class="row ps-1">
      		<div class="col" id="updateTargetGroupBox"></div>
      	</div>
        <div class="row mt-2">
        	<div class="col text-secondary small">
        		변동명
        	</div>

        </div>
        <div class="row ps-1">
        	<div class="col-10"><input type="text" class="form-control" placeholder="최대 8자" id="updateFluctName"></div>
        </div>
         <div class="row mt-2">
        	<div class="col text-secondary small">
				변동률/%
        	</div>
        </div>
         <div class="row ps-1">
        	<div class="col-6">
        		<div class="input-group">
				  <input type="number" class="form-control" id="updateFluctNumber">
				  <span class="input-group-text">%</span>
				</div>
			</div>
        </div>
         <div class="row mt-2">
        	<div class="col text-secondary small">
				변동시작일
        	</div>
        </div>
        <div class="row ps-1">
        	<div class="col"><input type="date" id="updateFluctStart"></div>
        </div>
         <div class="row mt-2">
        	<div class="col text-secondary small">
        		변동종료일
        	</div>
        </div>
        <div class="row ps-1">
        	<div class="col"><input type="date" id="updateFluctEnd"></div>
        </div>
      </div>
      <div class="modal-footer">
         <button type="button" class="btn btn-primary" id="seasonUpdateButton">수정</button>
      </div>
    </div>
  </div>
</div>
	<link rel="stylesheet"
		href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>

</body>
</html>