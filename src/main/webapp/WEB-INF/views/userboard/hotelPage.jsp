<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.choiceDay{
   background-color: #5ABEFF;
   border-radius :14px 0px 0px 14px;
   color: white !important;
}
.choiceDay2 {
 border-radius :0px 14px 14px 0px;
  /* 원형 테두리 내부를 투명하게 만듭니다. */
  background-color: #5ABEFF;
  color: white !important;
}

#dropBox {
  background: none;
  border: none;
  color: inherit;
  cursor: pointer;
  text-decoration: none;
}
 .scroll-container {
  overflow: hidden; /* 스크롤 숨김 */
  height: 250px; /* 스크롤 영역의 높이 설정 */
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

.date-container {
  overflow: hidden; /* 스크롤 숨김 */
  height: 400px; /* 스크롤 영역의 높이 설정 */
}
.date-container:hover {
  overflow: auto; /* 마우스 호버 시 스크롤 보이기 */
}

/* 수직 스크롤 바 스타일 */
.date-container::-webkit-scrollbar {
  width: 0px;
}

.date-container::-webkit-scrollbar-track {
  background-color: #white;
}

.date-container::-webkit-scrollbar-thumb {
  background-color: #white;
  border-radius: 0px;
}

.date-container::-webkit-scrollbar-thumb:hover {
  background-color: #white;
}
  
  .custom-text-color {
   color: #46B8FF; !important;
  }
 .review-star{
 color:   #226edf;  !important;
 }
 .orderby{
    font-size: 90%;
    
 }
   
  .catebutton {
    background-color: #black !important;
  }
  
  


.starsize{
   font-size: 120%;

}

.icon-text-wrapper {
  position: relative;
  display: inline-block;
}


.text-overlay {
  position: absolute;
  top: 15px;
  left: 10px;
  color: black;
  font-size: 16px;
  /* 다른 스타일링 옵션을 추가로 적용할 수 있습니다 */
}

#stickyColumn {
  position: sticky;
  top: 10px; /* 요소가 고정될 스크롤 위치 */
}

input[type=checkbox], input[type=radio] {
    accent-color:black;
     cursor: pointer;
 
} 



</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

<script>



//현재 날짜 생성
var current = new Date();
// 내일
var next = new Date(current);
next.setDate(current.getDate() + 1);

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
var currentMonth = month[current.getMonth()];
var currentDay = current.getDate().toString().padStart(2, '0');
var currentDayOfWeek = day[current.getDay()];
var currentYear = current.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기
//내일
var nexttMonth = month[next.getMonth()];
var nextDay = next.getDate().toString().padStart(2, '0');
var nextDayOfWeek = day[next.getDay()];
var nextYear = next.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기

// 변환된 값 출력
var startDay = currentYear + "/" + currentMonth + "/" + currentDay + "/(" + currentDayOfWeek + ")";
var endDay = nextYear + "/" + nexttMonth + "/" + nextDay + "/(" + nextDayOfWeek + ")";

 
let categoryValue = '전체';
let starValue = 0;   
let checkedValues = []; 
let orderByNumber = 1;

let searchLoc = '';
let searchStart = startDay;
let searchEnd = endDay;
let searchPeople = 2;

function getHotelCategory(category){
   categoryValue = category;
   // JavaScript 코드
   getHotelListByStar(starValue)
}   


function getHotelListByStar(star){
   starValue = star;
   const xhr = new XMLHttpRequest();
   const hotelBox = document.getElementById("hotelBox");
   hotelBox.innerHTML ="";

   var star0 = document.getElementById('star0');
   var star2 = document.getElementById('star2');
   var star3 = document.getElementById('star3');
   var star4 = document.getElementById('star4');
   var star5 = document.getElementById('star5');
  star0.classList.add("custom-text-color");
   star2.classList.add("custom-text-color");
   star3.classList.add("custom-text-color");
   star4.classList.add("custom-text-color");
   star5.classList.add("custom-text-color"); 
   
   var starText = document.getElementById("starText");
   star0.addEventListener('click', function() {
      starText.innerText = "전체 등급";
      star0.classList.remove('bi-star');
      star0.classList.add('bi-star-fill'); 
      star2.classList.remove('bi-star-fill');
      star2.classList.add('bi-star');
      star3.classList.remove('bi-star-fill');
      star3.classList.add('bi-star');
      star4.classList.remove('bi-star-fill');
      star4.classList.add('bi-star');
      star5.classList.remove('bi-star-fill');
      star5.classList.add('bi-star');
      
      
      
   });

   star2.addEventListener('click', function() {
      starText.innerText = "2성급 이상";
      star0.classList.add('bi-star-fill'); 
      star0.classList.remove('bi-star');
      star2.classList.add('bi-star-fill');
      star2.classList.remove('bi-star');
      star3.classList.add('bi-star');
      star3.classList.remove('bi-star-fill');
      star4.classList.add('bi-star');
      star4.classList.remove('bi-star-fill');
      star5.classList.add('bi-star');
      star5.classList.remove('bi-star-fill');
   });

   star3.addEventListener('click', function() {
      starText.innerText = "3성급 이상";
      star0.classList.add('bi-star-fill'); 
      star0.classList.remove('bi-star');
      star2.classList.add('bi-star-fill');
      star2.classList.remove('bi-star');
      star3.classList.add('bi-star-fill');
      star3.classList.remove('bi-star');
      star4.classList.add('bi-star');
      star4.classList.remove('bi-star-fill');
      star5.classList.add('bi-star');
      star5.classList.remove('bi-star-fill');
   });

   star4.addEventListener('click', function() {
      starText.innerText = "4성급 이상";
      star0.classList.add('bi-star-fill'); 
      star0.classList.remove('bi-star');
      star2.classList.add('bi-star-fill');
      star2.classList.remove('bi-star');
      star3.classList.add('bi-star-fill');
      star3.classList.remove('bi-star');
      star4.classList.add('bi-star-fill');
      star4.classList.remove('bi-star');
      star5.classList.add('bi-star');
      star5.classList.remove('bi-star-fill');
   });

   star5.addEventListener('click', function() {
      starText.innerText = "5성급";
      star0.classList.add('bi-star-fill'); 
      star0.classList.remove('bi-star');
      star2.classList.add('bi-star-fill');
      star2.classList.remove('bi-star');
      star3.classList.add('bi-star-fill');
      star3.classList.remove('bi-star');
      star4.classList.add('bi-star-fill');
      star4.classList.remove('bi-star');
      star5.classList.add('bi-star-fill');
      star5.classList.remove('bi-star');
   });
   
   
   const inputDateBox = document.getElementById("checkInput");
   const inputPeopleBox = document.getElementById("people");
   
   const inputDate = inputDateBox.value;
   const [inputStart,inputEnd] = inputDate.split("-");
   const inputPeople = inputPeopleBox.value;
   
   xhr.onreadystatechange = function(){
      if(xhr.readyState == 4 && xhr.status == 200){
         const response = JSON.parse(xhr.responseText);
         if(response.result == "success"){
            for(list of response.list){
               const row = document.createElement("div");
               row.classList.add("row");
               row.classList.add("mt-3");
               row.classList.add("border-bottom");
               
               const imgdiv = document.createElement("div");
               imgdiv.classList.add("col-4","p-0");
               
               const action = document.createElement("a");
               action.href = "./hotelInfoPage?id="+list.hotelDto.id+"&startDate="+inputStart+"&endDate="+inputEnd+"&people="+inputPeople+"&days="+weekDays;
               action.style.textDecoration = "none";
               const img = document.createElement("img");
               img.src = "/uploadFiles/" + list.hotelDto.hotel_img;
               img.style.width = "300px";
               img.style.borderRadius = "10px";
               img.style.height = "200px";
               action.appendChild(row);
               imgdiv.appendChild(img);
               
               const col = document.createElement("div");
               col.classList.add("col");
               
               
               const namediv = document.createElement("div");
               namediv.classList.add("row");
               namediv.classList.add("mt-0");
               namediv.classList.add("fs-5");
               namediv.classList.add("fw-semibold");
               
               const namebox = document.createElement("div");
               namebox.classList.add("col");
               namebox.classList.add("text-start");
               namebox.innerText = list.hotelDto.hotel_name;
               namebox.style.color = "black";
               namediv.appendChild(namebox);
         
               const infodiv = document.createElement("div");
               infodiv.classList.add("row");
               infodiv.classList.add("mt-1");
               infodiv.classList.add("mb-1");
               
               const infobox = document.createElement("div");
               infobox.classList.add("col");
               infobox.classList.add("text-start","text-secondary");

               
               const textNode = document.createTextNode(list.category.category + " · " + list.hotelDto.hotel_loc);
               infobox.appendChild(textNode);
               
               infodiv.appendChild(infobox);
               
               const infodiv2 = document.createElement("div");
               infodiv2.classList.add("row");
               infodiv2.classList.add("mt-1");
               infodiv2.classList.add("mb-5");
               
               const infobox2 = document.createElement("div");
               infobox2.classList.add("col");
               infobox2.classList.add("text-start","fw-semibold","text-dark");
               const starBox =document.createElement("i");
               starBox.classList.add("bi","bi-star-fill","review-star")
               infobox2.appendChild(starBox);
               
               const textNode2 = document.createTextNode(" "+list.star);
               infobox2.appendChild(textNode2);
               
               const rtextNode = document.createTextNode("(" + list.review + ")");

               infobox2.appendChild(rtextNode);
               
               infodiv2.appendChild(infobox2);
               
               const pricediv = document.createElement("div");
               pricediv.classList.add("row");
               pricediv.classList.add("mt-5");
               
               
               const badgediv = document.createElement("div");
               badgediv.classList.add("col","mt-4","pt-3");
               
               const badge1 = document.createElement("span");
               badge1.classList.add("badge","text-white");
               badge1.style.backgroundColor ="#1b84c5";
            
               
               badge1.innerText = "무료취소";
               badgediv.appendChild(badge1)
               

               pricediv.appendChild(badgediv);
               if(list.oriPrice > list.changePrice){
               const badge3 = document.createElement("span");
               badge3.classList.add("badge","text-bg-danger","ms-2");
               badge3.innerText = "초특가";
               badgediv.appendChild(badge3)
               }
               
               const pricebox = document.createElement("div");
               pricebox.classList.add("col","text-end");
               pricediv.appendChild(pricebox);

               const priceInRow = document.createElement("div");
               priceInRow.classList.add("row");
               pricebox.appendChild(priceInRow)
               const priceInCol = document.createElement("div");
               priceInCol.classList.add("col","mt-2");
               priceInRow.appendChild(priceInCol)
               
                  const salePrice = document.createElement("p");
                  salePrice.classList.add("text-decoration-line-through","opacity-50","mb-0","text-black");
                  salePrice.innerText = list.oriPrice.toLocaleString() +"원";
                  
                   if(list.oriPrice <= list.changePrice){
                      salePrice.classList.add("text-white");
                   }
               
                  priceInCol.appendChild(salePrice)
               
                  
               
               
               
               const priceInRow2 = document.createElement("div");
               priceInRow2.classList.add("row");
               pricebox.appendChild(priceInRow2)
               
               const priceInCol2 = document.createElement("div");
               priceInCol2.classList.add("col","fs-5","fw-semibold");
               priceInRow2.appendChild(priceInCol2)
               if(list.oriPrice > list.changePrice){
                  const salePerSpan = document.createElement("span");            
                  salePerSpan.classList.add("text-danger")
                  priceInCol2.appendChild(salePerSpan);
                  const discountRate = Math.round((list.oriPrice - list.changePrice) / list.oriPrice * 100) + "%";
                  salePerSpan.innerText = discountRate;
               }   
               const price = list.changePrice;
               const formattedPrice = new Intl.NumberFormat('ko-KR').format(price);
               const priceSpan = document.createElement("span");            
               priceSpan.classList.add("ms-1")
               priceSpan.innerText = formattedPrice +"원";
               priceSpan.style.color = "black";

               
               const parkSpan = document.createElement("span");
               parkSpan.classList.add("opacity-50")
               parkSpan.style.color = "black";
               parkSpan.innerText = " 1박 "
               parkSpan.style.fontSize = "15px"
               priceInCol2.appendChild(priceSpan);
               priceInCol2.appendChild(parkSpan);
               
               
               const priceInRow3 = document.createElement("div");
               priceInRow3.classList.add("row");
               pricebox.appendChild(priceInRow3)
               
               const priceInCol3 = document.createElement("div");
               priceInCol3.classList.add("col","fw-semibold","opacity-50","small");
               priceInCol3.style.color = "black";

               priceInCol3.innerText = "세금 포함 가격"
               priceInRow3.appendChild(priceInCol3)
               
               row.appendChild(imgdiv);
               col.appendChild(namediv);
               col.appendChild(infodiv);
               col.appendChild(infodiv2);
               col.appendChild(pricediv);
               row.appendChild(col);
               
               hotelBox.appendChild(action);
               
               }
            }else if(response.result == "fail"){
               const div = document.createElement("div");
               div.classList.add("row")
               div.classList.add("mt-5")
               const col = document.createElement("div");
               col.classList.add("col");
               col.classList.add("mt-5");
               col.classList.add("text-center");
               col.classList.add("fw-semibold");
               col.classList.add("fs-4");
               col.innerText = "예약할 수 있는 숙소가 없습니다.";
               div.appendChild(col);
               hotelBox.appendChild(div);
               
            }
         
      }
   }
   xhr.open("get","./getHotelListByStar?category="+categoryValue+"&star="+star+"&checkBoxValues="+checkedValues+"&orderByNumber="+orderByNumber+"&startDay="+searchStart+
         "&endDay="+searchEnd+"&fixed_number="+searchPeople+"&loc="+searchLoc+"&weekDays="+weekDays);
   xhr.send();
}

function hotelSearch(){
   const dayFilterBox = document.getElementById("checkInput");
   const peopleFilterBox = document.getElementById("people");
   const locFilterBox  = document.getElementById("locInput");
   
   const filterDate = dayFilterBox.value;
   const [filterStart,filterEnd] = filterDate.split("-");
   
   searchStart = filterStart; 
   searchEnd = filterEnd;
   searchPeople = peopleFilterBox.value;
   if(locFilterBox.value !='여행지를 입력하세요.'){
   searchLoc = locFilterBox.value;
   }
   
   getHotelListByStar(starValue);
   
}




function getCategoryList(){
   const xhr = new XMLHttpRequest();
   const categoryBox = document.getElementById("categoryBox");
   const collapse= document.createElement("div");
   collapse.classList.add("collapse");
   xhr.onreadystatechange = function(){
      if(xhr.readyState == 4 && xhr.status==200){
         const response = JSON.parse(xhr.responseText);
         response.cateList.forEach(function(list,index){
            if(index > 5){
               const div = document.createElement("div");
               div.classList.add("row");
               div.classList.add("mt-2");
               
               const col = document.createElement("div");
               col.classList.add("col");
               
               const checkBox = document.createElement("input");
               checkBox.type= "checkbox";
               checkBox.value= list.id;
               checkBox.classList.add("checkbox");
               checkBox.setAttribute("onclick","getCheckList()");
               col.appendChild(checkBox);
               const textSpan = document.createElement("span");
               textSpan.innerText = "  " + list.category;
               col.appendChild(textSpan);
               div.appendChild(col);
               
               collapse.appendChild(div);
            }else{
               const div = document.createElement("div");
               div.classList.add("row");
               div.classList.add("mt-2");
               
               const col = document.createElement("div");
               col.classList.add("col");
               
               const checkBox = document.createElement("input");
               checkBox.type= "checkbox";
               checkBox.value= list.id;
               checkBox.classList.add("checkbox");
               checkBox.setAttribute("onclick","getCheckList()");
               col.appendChild(checkBox);
               const textSpan = document.createElement("span");
               textSpan.innerText = "  " + list.category;
               col.appendChild(textSpan);
               div.appendChild(col);
               
               categoryBox.appendChild(div);
            }
            
            
            
            if(index == 5){
               const dropRow = document.createElement("div");
               dropRow.classList.add("row");
               dropRow.classList.add("mt-2");
               dropRow.id= "dropRow";
               categoryBox.appendChild(dropRow);
               const dropCol = document.createElement("div");
               dropCol.classList.add("col","fw-semibold","btn");
               dropCol.innerText = "더보기"
               dropRow.appendChild(dropCol)
               const icon = document.createElement("i");
               icon.classList.add("bi","bi-chevron-down","ms-1");
               dropCol.appendChild(icon);
               categoryBox.appendChild(collapse);
               collapse.id = "categoryCollapse"
               dropRow.setAttribute("onclick","showCategoryCollapse()")
               
            }
            
            
         })
         const hideRow = document.createElement("div");
               hideRow.classList.add("row");
               hideRow.classList.add("mt-2");
               hideRow.id ="hideRow"
               collapse.appendChild(hideRow);
               const hideCol = document.createElement("div");
               hideCol.classList.add("col","fw-semibold","btn");
               hideCol.innerText = "접기"
               hideRow.appendChild(hideCol)
               const upicon = document.createElement("i");
               upicon.classList.add("bi","bi-chevron-up","ms-1");
               hideCol.appendChild(upicon);
               hideRow.setAttribute("onclick","hideCategoryCollapse()")
            
            
            
         
      }
   }
   xhr.open("get","./getCategoryList");
   xhr.send();   
}




function getCheckList() {
  const checkBoxes = document.getElementsByClassName("checkbox");
  checkedValues = []; // 함수 실행마다 초기화
  
  for (let i = 0; i < checkBoxes.length; i++) {
    if (checkBoxes[i].checked) {
      checkedValues.push(checkBoxes[i].value);
    }
  }
  
  console.log(checkedValues);
  getHotelListByStar(starValue)
 
}

function deleteFilter(){
   checkedValues = []; 
   const checkBoxes = document.getElementsByClassName("checkbox");
   for (let i = 0; i < checkBoxes.length; i++) {
        checkBoxes[i].checked = false;
      }
   
   categoryValue = '전체';
   var btnall =flexRadioDefault1 = document.getElementById('flexRadioDefault1')
   btnall.checked=true;
   /* var btnAll = document.getElementById('btn-all');
   var btnHotel = document.getElementById('btn-hotel');
   var btnPension = document.getElementById('btn-pension');
   var btnVilla = document.getElementById('btn-villa');
   var btnGuesthouse = document.getElementById('btn-guesthouse');
    btnAll.classList.add('catebutton'); 
    btnHotel.classList.remove('catebutton'); 
    btnPension.classList.remove('catebutton');
    btnVilla.classList.remove('catebutton');
    btnGuesthouse.classList.remove('catebutton'); */

   starValue = 0;
   var star0 = document.getElementById('star0');
   var star2 = document.getElementById('star2');
   var star3 = document.getElementById('star3');
   var star4 = document.getElementById('star4');
   var star5 = document.getElementById('star5');
   
   var starText = document.getElementById("starText");

      starText.innerText = "전체 등급";
      star0.classList.remove('bi-star');
      star0.classList.add('bi-star-fill'); 
      star2.classList.remove('bi-star-fill');
      star2.classList.add('bi-star');
      star3.classList.remove('bi-star-fill');
      star3.classList.add('bi-star');
      star4.classList.remove('bi-star-fill');
      star4.classList.add('bi-star');
      star5.classList.remove('bi-star-fill');
      star5.classList.add('bi-star');


    orderByNumber = 1;
    const reviewOrderBy= document.getElementById("reviewOrderBy");
   const starOrderBy= document.getElementById("starOrderBy");
   const rowPriceOrderBy= document.getElementById("rowPriceOrderBy");
   const highPriceOrderBy= document.getElementById("highPriceOrderBy");
   reviewOrderBy.classList.add("fw-bold");
   starOrderBy.classList.remove("fw-bold");
   rowPriceOrderBy.classList.remove("fw-bold");
   highPriceOrderBy.classList.remove("fw-bold");
   
   getHotelListByStar(starValue)
}


function orderBy(number){
   orderByNumber = number;
   const reviewOrderBy= document.getElementById("reviewOrderBy");
   const starOrderBy= document.getElementById("starOrderBy");
   const rowPriceOrderBy= document.getElementById("rowPriceOrderBy");
   const highPriceOrderBy= document.getElementById("highPriceOrderBy");
   if(number == 1){
      reviewOrderBy.classList.add("fw-bold");
      starOrderBy.classList.remove("fw-bold");
      rowPriceOrderBy.classList.remove("fw-bold");
      highPriceOrderBy.classList.remove("fw-bold");
   }else if(number == 2){
      reviewOrderBy.classList.remove("fw-bold");
      starOrderBy.classList.add("fw-bold");
      rowPriceOrderBy.classList.remove("fw-bold");
      highPriceOrderBy.classList.remove("fw-bold");
   }else if(number ==3){
      reviewOrderBy.classList.remove("fw-bold");
      starOrderBy.classList.remove("fw-bold");
      rowPriceOrderBy.classList.add("fw-bold");
      highPriceOrderBy.classList.remove("fw-bold");
   }else if(number ==4){
      reviewOrderBy.classList.remove("fw-bold");
      starOrderBy.classList.remove("fw-bold");
      rowPriceOrderBy.classList.remove("fw-bold");
      highPriceOrderBy.classList.add("fw-bold");
   }
   getHotelListByStar(starValue)
   
}
/* //날짜 collapse
function getDateCollapse(){
   const collapse = bootstrap.Collapse.getOrCreateInstance("#dateCollapse");
   
   collapse.show();
   
   
   
}

function hideDateCollapse(){
   const collapse = bootstrap.Collapse.getOrCreateInstance("#dateCollapse");
   const dayBox = document.getElementById("checkInput");

   const startDay = document.getElementById("startDay");
   const endDay = document.getElementById("endDay");

   const inputStart = new Date(startDay.value);
   const inputEnd = new Date(endDay.value);
   
   const timeDiff = Math.abs(inputEnd.getTime() - inputStart.getTime());
   const diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));
   dayDifference = diffDays;
   
   var monthNames = [
     "01", "02", "03", "04", "05", "06",
     "07", "08", "09", "10", "11", "12"
   ];

   var dayNames = [
     "일", "월", "화", "수", "목", "금", "토"
   ];

   var smonth = monthNames[inputStart.getMonth()];
   var sday = inputStart.getDate().toString().padStart(2, '0');
   var sdayOfWeek = dayNames[inputStart.getDay()];
   var syear = inputStart.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기

   var emonth = monthNames[inputEnd.getMonth()];
   var eday =  inputEnd.getDate().toString().padStart(2, '0');
   var edayOfWeek = dayNames[inputEnd.getDay()];
   var eyear = inputEnd.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기

   var start = syear + "/" + smonth + "/" + sday + "/(" + sdayOfWeek + ")";
   var end = eyear + "/" + emonth + "/" + eday + "/(" + edayOfWeek + ")";

   dayBox.value = start + " - " + end;
   
   collapse.hide();
} */

function showCategoryCollapse(){
   const collapse = bootstrap.Collapse.getOrCreateInstance("#categoryCollapse");
   collapse.show();
   
   const dropRow = document.getElementById("dropRow");
   dropRow.remove();
}

function hideCategoryCollapse(){
   const collapse = bootstrap.Collapse.getOrCreateInstance("#categoryCollapse");
   collapse.hide();
   
   const dropRow = document.createElement("div");
   dropRow.classList.add("row");
   dropRow.classList.add("mt-2");
   dropRow.id= "dropRow";
   categoryBox.appendChild(dropRow);
   const dropCol = document.createElement("div");
   dropCol.classList.add("col","fw-semibold","btn");
   dropCol.innerText = "더보기"
   dropRow.appendChild(dropCol)
   const icon = document.createElement("i");
   icon.classList.add("bi","bi-chevron-down","ms-1");
   dropCol.appendChild(icon);
   dropRow.setAttribute("onclick","showCategoryCollapse()")

}






function getCalander(){
   dates=[];
   const dateBox = document.getElementById("dates");
   dateBox.innerHTML ="";
   const forYear = new Date;
   
   for(var p=0; p<7; p++){
      const viewYear = forYear.getFullYear();
      const viewMonth = forYear.getMonth();
      const forMonth = forYear.setMonth(forYear.getMonth()+1)

      console.log(viewMonth);
      //현재 년/월 넣기
      //지난달 마지막날 , 이번 달 마지막날
      const prevLast = new Date(viewYear, viewMonth,0); // get month는 0부터시작 day는 1부터시작
      const thisLast = new Date(viewYear, viewMonth+1,0);
      
      const PLDate = prevLast.getDate(); // 지난달 마지막날
      const PLDay = prevLast.getDay(); // 지난달 마지막 요일
      
      const TLDate = thisLast.getDate(); // 이번달 마지막날 
      const TLDay = thisLast.getDay(); // 이번달 마지막 요일
      
      //const thisDates = [...Array(TLDate + 1).keys()].slice(1) 에서 인덱스는 0부터 시작하므로 
      //TLDate에 +1 해주어 요소 하나가 추가된 배열을 만들고, slice(1) 을 이용해 1일부터 마지막날까지의 배열로 만든다.
      const prevDates = [];
      const thisDates = [...Array(TLDate + 1).keys()].slice(1);
      const nextDates = [];
      
      if(PLDay != 6){ // 지난달 마지막 요일이 토요일이 아니면(요일 시작이 일요일부터니까) 지난달 날짜들을 넣어준다
         for(var i=0; i< PLDay+1; i++){
            prevDates.unshift(PLDate -i); //지난달 날짜
         }
      }
      for(var i=1; i<7-TLDay; i++){
         nextDates.push(i) // 다음달 날짜 넣어줌 ex) TLday가 5면 금요일이 이번달 마지막이니까, 1일 넣어주기.
      }
      const dates = prevDates.concat(thisDates,nextDates); //concat으로 지난달 이번달 다음달 배열을 합쳐준다.
      
      //화면에 넣어주기
      const firstDateIndex= dates.indexOf(1); // 이번달 1일 인덱스 찾기
      const lastDateIndex = dates.lastIndexOf(TLDate); // 이번달 막날이 인덱스 찾기
      //indexOf(1): dates 배열에서 숫자 1이 처음으로 등장하는 인덱스를 찾습니다. 이는 이번 달의 1일의 인덱스를 반환합니다.
      //lastIndexOf(TLDate): dates 배열에서 TLDate 변수에 저장된 값(이번 달의 막날)이 마지막으로 등장하는 인덱스를 찾습니다. 이는 이번 달의 막날의 인덱스를 반환합니다.
   
   
         const yearMonthBox  = document.createElement("div");
   yearMonthBox.classList.add("col-12","text-start","fw-semibold","mt-2");

   
   yearMonthBox.innerText = viewYear + "년" +(viewMonth+1)+"월"
   dateBox.appendChild(yearMonthBox);
   dates.forEach((date,i) => { //date는  배열 요소의 값 i는 인덱스
      if(viewMonth == current.getMonth() && date< current.getDate() && i < lastDateIndex){
         const col = document.createElement("div");
         col.classList.add("d-inline","text-center","fs-5");
         col.style.width = "58px";
         col.style.height = "58px";
         dateBox.appendChild(col);
         
         const span = document.createElement("div");
         span.classList.add("text-secondary","date");
         span.style.opacity ="0.2"; 
         span.innerText = date;
         col.appendChild(span);
      }else if(i >=firstDateIndex && i < lastDateIndex+1){


         const col = document.createElement("div");
         col.classList.add("d-inline","text-center","fs-5","px-0");
         col.style.width = "58px";
         col.style.height = "58px";
         dateBox.appendChild(col);
         
         const span = document.createElement("div");
         span.classList.add("this","date");
         span.innerText = date;
         span.id = parseInt(viewYear +""+(viewMonth+1).toString().padStart(2, '0')+ "" +  date.toString().padStart(2, '0'),10);
         span.setAttribute("onclick","getClickDates1("+parseInt(viewYear +""+(viewMonth+1).toString().padStart(2, '0')+ "" + date.toString().padStart(2, '0'),10)+")")
         col.appendChild(span);
         if(p == 6){
            lastDate =  parseInt(viewYear +""+(viewMonth+1).toString().padStart(2, '0')+ "" +  date.toString().padStart(2, '0'),10);
         }
      }else{
         const col = document.createElement("div");
         col.classList.add("d-inline","text-center","fs-5","px-0");
         dateBox.appendChild(col);
         col.style.width = "58px"
      }
   })
   const today = new Date();
   
   if(viewMonth == today.getMonth() && viewYear == today.getFullYear()){
      for(date of document.getElementsByClassName("this")){
         if(date.innerText == today.getDate()){
            date.classList.add("fw-semibold","text-primary");
         }
      }
   }
   }
   
   

   
}

function prevMonth(){
   current.setMonth(current.getMonth()-1);
   getCalander();
}

function nextMonth(){
   current.setMonth(current.getMonth()+1);
   getCalander();
}


function goToday(){
   current = new Date();
   getCalander();
}
var lastDate = 0;

var dates = [];
dates.length = 2;

var beforeDates =[]
beforeDates.length = 2;

function getClickDates1(num){
   dates=[];
   const button = document.getElementById("dateButton");
   button.setAttribute("disabled","");
   const date = document.getElementsByClassName("date");
   for(d of date){
      d.classList.remove("choiceDay2");
      d.classList.remove("choiceDay");
      d.classList.remove("bg-secondary","bg-opacity-25");
   }
    const target = document.getElementById(num);

   dates[0] = num;
   getClickDates2(num);
   target.classList.add("choiceDay");
}
function resetDates() {
   /*   const dates = document.getElementsByClassName("date");
     for (const date of dates) {
       date.classList.remove("choiceDay");
       date.classList.remove("bg-secondary", "bg-opacity-50");
       date.removeAttribute("onmouseover");
     } */
     getCalander()
}
   
function getClickDates2(num){
    for(var i=num+1; i<=lastDate; i++){
       const target = document.getElementById(i);
       if(target){
          target.setAttribute("onmouseover","mouseover(this)");
       } 
    }
}
function mouseover(target){
   const date = document.getElementsByClassName("date");
   for(d of date){
      d.classList.remove("choiceDay2");
      d.classList.remove("choiceDay");
      d.classList.remove("bg-secondary","bg-opacity-25");
      d.removeAttribute("onclick")
   }
   const day1 = document.getElementById(dates[0]);
   day1.classList.add("choiceDay")
   for(var i=dates[0]+1; i<target.id; i++){
      const target2 = document.getElementById(i);
      if(target2){
         target2.classList.add("bg-secondary","bg-opacity-25");
         
      }
      
   }
   for(var i=dates[0]+1; i<=target.id; i++){
      const target2 = document.getElementById(i);
      if(target2){
         target2.setAttribute("onclick","getClickDates3(this)")
         
      }
      
   }
   target.classList.add("choiceDay2")
}

function getClickDates3(target){
   dates[1] = parseInt(target.id,10);
   target.classList.remove("choiceDay")
   target.classList.add("choiceDay2")
      const date = document.getElementsByClassName("date");

   for(d of date){
      d.removeAttribute("onmouseover")
      d.setAttribute("onclick","getClickDates1("+d.id+")")
   }
   if(dates.length ==2){
      const button = document.getElementById("dateButton");
      button.removeAttribute("disabled")
   }

}
function getDateButton(){
   const dayBox = document.getElementById("checkInput");
   
   const inputStart = new Date(dates[0].toString().replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3'));
   const inputEnd = new Date(dates[1].toString().replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3'));
   getAllWeekdays(inputStart, inputEnd)
   /* const timeDiff = Math.abs(inputEnd.getTime() - inputStart.getTime());
   const diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));
   dayDifference = diffDays; */
   
   var monthNames = [
     "01", "02", "03", "04", "05", "06",
     "07", "08", "09", "10", "11", "12"
   ];

   var dayNames = [
     "일", "월", "화", "수", "목", "금", "토"
   ];

   var smonth = monthNames[inputStart.getMonth()];
   var sday = inputStart.getDate().toString().padStart(2, '0');
   var sdayOfWeek = dayNames[inputStart.getDay()];
   var syear = inputStart.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기

   var emonth = monthNames[inputEnd.getMonth()];
   var eday =  inputEnd.getDate().toString().padStart(2, '0');
   var edayOfWeek = dayNames[inputEnd.getDay()];
   var eyear = inputEnd.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기

   var start = syear + "/" + smonth + "/" + sday + "/(" + sdayOfWeek + ")";
   var end = eyear + "/" + emonth + "/" + eday + "/(" + edayOfWeek + ")";

   dayBox.value = start + " - " + end;
   
   beforeDates = dates 
    const dropdownElement = document.getElementById("checkInput");
     const bootstrapDropdown = new bootstrap.Dropdown(dropdownElement);
     bootstrapDropdown.hide();
} 
var weekDays = [current.getDay()];

function getAllWeekdays(start, end) {
     const result = [];
     weekDays = [];
     const current = new Date(start);
     while (current < end) {
       const day = current.getDay();
       result.push(day);
       current.setDate(current.getDate() + 1);
     }

     weekDays = result;
}
window.addEventListener("DOMContentLoaded",function(){
   getHotelListByStar(0);
   getCategoryList();
   getCalander()
   
});   
</script>


</head>
<body>
            <jsp:include page="../common/topNavi.jsp"></jsp:include>

<div class="container-fluid">

      <div class="row  py-1"   id="searchGround" style="background-color: #0a9ffc;">
         <div class="col-2"></div>
         <div class="col-3  pt-2 pb-2 pe-1 form-floating">
            <input type="text" class="form-control shadow form-control-lg fw-semibold fs-6" id="locInput">
            <label for="people" class="pt-4 ps-4">여행지/숙소이름</label>
         </div>
         <div class="col-3 ps-0 pt-2 pb-2 pe-1 form-floating"  id="dateBox">
            <input type="text"  class="form-control shadow  form-control-lg fw-semibold fs-6" id="checkInput" onclick="getCalander()" data-bs-toggle="dropdown" aria-expanded="false" data-bs-auto-close="outside"> <!-- onclick="getDateCollapse()" -->
            <label for="people" class="pt-4 ps-2">체크인/체크아웃 날짜</label>
                           <ul class="dropdown-menu mt-4" aria-labelledby="checkInput" id="searchDropDown" style="border-radius:10%">
                                     <li>
                                     <div class="dropdown-item" id="dropBox">
                                       <div class="row mb-3 fw-semibold border-bottom pb-2 text-center">
                                          <div class="col text-danger" style="margin-left:12px;">일</div>
                                          <div class="col">월</div>
                                          <div class="col">화</div>
                                          <div class="col">수</div>
                                          <div class="col">목</div>
                                          <div class="col">금</div>
                                          <div class="col text-primary" style="margin-right:23px;">토</div>
                                       </div>
                                       <div class="row date-container" id="dates" style ="width:420px; height:480px; margin:0px 0px 0px 0px;">
                                          
                                       </div>
                                       <div class="row border-top pt-2">
                                          <div class="col-7 ps-5 fw-semibold pt-3"  onclick="resetDates()" style="font-size:18px;">
                                             <i class="bi bi-arrow-counterclockwise"></i>초기화
                                          </div>
                                          <div class="col pt-1"><button id="dateButton" type="button" disabled class="btn btn-dark btn-lg" style="border-radius:20px" onclick="getDateButton()">일정 적용</button></div>
                                          <div class="col-1"></div>
                                       </div>
                                    </div></li>
                                   </ul>
         </div>

         <div class="col-1 ps-0 pt-2 pb-2 pe-1 form-floating">
            <input type="number" class="form-control shadow   form-control-lg fw-semibold fs-6" id="people" value="2">
            <label for="people" class="pt-4 ps-2">인원</label>
         </div>
         <div class="col-2 ps-0 pt-2 pb-2 form-floating" >
            <button type="button" class="btn  text-white shadow fs-6 fw-semibold" style="--bs-btn-padding-y: 0.5rem; --bs-btn-padding-x: 4.1rem; --bs-btn-font-size: .75rem; height: 3.55rem;  background-color: #46B8FF" onclick="hotelSearch()">
              검색
            </button>
         </div>
         <div class="col-2"></div>
      </div>
       <div class="row">
          <div class="col">
             <div class="collapse" id="dateCollapse">
              <div class="row">
                 <div class="col-5"></div>
                 <div class="col">
                    <input type="date" id="startDay">부터
                    <input type="date" id="endDay">
                    <button type="button" class="btn btn-outline-primary" onclick="hideDateCollapse()">적용</button>
                 </div>
              </div>
            </div>
           </div>
      </div>
      <div class="row mt-4 mb-5">
         <div class="col-2"></div>
         <div class="col">
            <div class="row">
               <div class="col-3">
                  <div class="row"  id="stickyColumn">
                     <div class="col">
                        <!-- <div class="row">
                     <div class="col d-grid">
                        <button type="button" class="btn btn-outline-secondary btn-lg text-primary fw-semibold"><i class="bi bi-geo-alt-fill"></i> 지도로 보기</button>
                     </div>
                  </div> -->
                  <div class="row mt-4">
                     <div class="col fw-bold fs-5">숙소 종류</div>
                  </div>
                  <div class="row mt-3">
                      <div class="col fw-semibold">
                       <input  type="radio" name="flexRadioDefault" id="flexRadioDefault1" onchange="getHotelCategory('전체')" checked>
                       <label  for="flexRadioDefault1">
                        &nbsp; 전체
                       </label>
<!--                           <button type="button" class="btn btn-white border rounded-pill catebutton" onclick="getHotelCategory('전체')" id="btn-all">전체</button>
 -->                      </div>
                  </div>
                  <div class="row mt-2">
                      <div class="col fw-semibold">
                       <input  type="radio" name="flexRadioDefault" id="flexRadioDefault2" onchange="getHotelCategory('호텔')">
                       <label  for="flexRadioDefault2">
                        &nbsp; 호텔
                       </label>
<!--                           <button type="button" class="btn  btn-white border rounded-pill" onclick="getHotelCategory('호텔')" id="btn-hotel">#호텔</button> -->   
                      </div>
                  </div>
                  <div class="row mt-2">
                      <div class="col fw-semibold">
                       <input  type="radio" name="flexRadioDefault" id="flexRadioDefault3" onchange="getHotelCategory('펜션')">
                       <label  for="flexRadioDefault3">
                         &nbsp; 펜션
                       </label>
                        <!--   <button type="button" class="btn  btn-white border rounded-pill" onclick="getHotelCategory('펜션')" id="btn-pension">#펜션</button> -->
                      </div>
                  </div>
                  <div class="row mt-2">
                      <div class="col  fw-semibold">
                       <input  type="radio" name="flexRadioDefault" id="flexRadioDefault4" onchange="getHotelCategory('풀빌라')">
                       <label  for="flexRadioDefault4">
                      &nbsp;  풀빌라
                       </label>
                          <!--  <button type="button" class="btn  btn-white border rounded-pill" onclick="getHotelCategory('풀빌라')" id="btn-villa">#풀빌라</button>-->
                      </div>
                  </div>
                  <div class="row mt-2">
                      <div class="col fw-semibold">
                       <input  type="radio" name="flexRadioDefault" id="flexRadioDefault5" onchange="getHotelCategory('게하')">
                       <label  for="flexRadioDefault5">
                       &nbsp; 게스트 하우스
                       </label>
                          <!--  <button type="button" class="btn  btn-white border rounded-pill" onclick="getHotelCategory('게하')" id="btn-guesthouse">#게하</button>-->
                      </div>
                  </div>

                  <div class="row mt-4 border-top border-bottom">
                  
                     <div class="col-4 pt-3 pb-3 text-start fw-semibold fs-5">필터</div><div class="col text-end" style="
    padding-top: 12px;
"><button style="border-radius:20px" class="btn bg-secondary bg-opacity-10 fw-semibold" onclick="deleteFilter()"><i class="bi bi-arrow-repeat"></i> 필터 초기화</button> </div>
                  </div>
                  <div class="row mt-3 fw-semibold">
                     <div class="col fs-6">호텔 등급</div>
                  </div>
                  <div class="row mt-1">
                     <div class="col fs-7 text-secondary small" id="starText">전체 등급</div>
                  </div>
                  <div class="row mt-1 border-bottom pb-4">
                     <div class="col">
                        <span class="icon-text-wrapper">
                          <i class="bi bi-star-fill starsize custom-text-color" onclick="getHotelListByStar('0')" id="star0"></i>
                          <span class="text-overlay text-secondary fw-semibold"></span>
                        </span>
                        <span class="icon-text-wrapper">
                          <i class="bi bi-star starsize" onclick="getHotelListByStar('2')" id="star2"></i>
                          <span class="text-overlay text-secondary fw-semibold"></span>
                        </span>      
                        <span class="icon-text-wrapper">
                          <i class="bi bi-star starsize"  onclick="getHotelListByStar('3')" id="star3"></i>
                          <span class="text-overlay text-secondary fw-semibold"></span>
                        </span>      
                        <span class="icon-text-wrapper">
                          <i class="bi bi-star starsize" onclick="getHotelListByStar('4')" id="star4"></i>
                          <span class="text-overlay text-secondary fw-semibold"></span>
                        </span>      
                        <span class="icon-text-wrapper">
                          <i class="bi bi-star starsize" onclick="getHotelListByStar('5')" id="star5"></i>
                          <span class="text-overlay text-secondary fw-semibold"></span>
                        </span>                     
                     </div>
                  </div>
               <div class="row mt-4">
                  <div class="col fs-5 fw-semibold">카테고리</div>
               </div>
               <div class="row mt-2" > <!-- 여기에 체크박스 넣어주기 -->
                  <div class="col scroll-container" id="categoryBox">
                     
                  </div>
               </div>
                     </div>
                  </div>
               </div>
               <div class="col ms-3"><!-- 숙소 -->
                  <div class="row mt-1 mb-3">
                     <div class="col px-0">
                        <div id="carouselExampleSlidesOnly" class="carousel slide" data-bs-ride="carousel">
                          <div class="carousel-inner">
                            <div class="carousel-item active">
                              <img  src="../resources/img/add4.jpg" class="d-block w-100" alt="...">
                            </div>
                            <div class="carousel-item">
                              <img src="../resources/img/add5.jpg" class="d-block w-100" alt="...">
                            </div>
                          </div>
                        </div>
                     </div>
                  </div>
                  <div class="row orderby mb-1">
                     <div class="col-7">
                     </div>
                     <div class="col text-end pe-0">
                        <span class="ms-1 me-0 btn btn-sm fw-bold pe-0" onclick="orderBy(1)" id="reviewOrderBy">많은 후기순</span>
                        <span class="ms-1 me-0 btn btn-sm pe-0" onclick="orderBy(2)" id="starOrderBy">평점순</span>
                        <span class="ms-1 me-0 btn btn-sm pe-0" onclick="orderBy(3)" id="rowPriceOrderBy">낮은 가격순</span>
                        <span class="ms-1 me-0 btn btn-sm pe-0" onclick="orderBy(4)" id="highPriceOrderBy">높은 가격순</span>
                     </div>
                  
                  </div>
                  <div class="row">
                     <div class="col"  id="hotelBox">
                        
                     </div>
                  </div>
               
               
               </div> 
            </div>
         </div>
         <div class="col-2">
            <div class="row mt-5">
               <div class="col">
                  <img >
               </div>
            </div>
         </div>
      </div>
</div>
<jsp:include page="../common/footer.jsp"></jsp:include>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script>

//현재 날짜 생성
var current = new Date();
// 내일
var next = new Date(current);
next.setDate(current.getDate() + 1);

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
var currentMonth = month[current.getMonth()];
var currentDay = current.getDate().toString().padStart(2, '0');
var currentDayOfWeek = day[current.getDay()];
var currentYear = current.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기
//내일
var nexttMonth = month[next.getMonth()];
var nextDay = next.getDate().toString().padStart(2, '0');
var nextDayOfWeek = day[next.getDay()];
var nextYear = next.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기

// 변환된 값 출력
var startDay = currentYear + "/" + currentMonth + "/" + currentDay + "/(" + currentDayOfWeek + ")";
var endDay = nextYear + "/" + nexttMonth + "/" + nextDay + "/(" + nextDayOfWeek + ")";

var checkInput = document.getElementById("checkInput");

checkInput.value = startDay +" - "+endDay;

const locBox = document.getElementById("locInput");
const locList = ["서울","대구","부산","여수","강릉","평창"];

const random = Math.floor(Math.random() * 6)
locBox.value = locList[random];

/* const imgBox = document.getElementById("searchGround");
const imgList = ["../resources/img/sky.jpg","../resources/img/noel.jpg","../resources/img/busan.jpg","../resources/img/f.jpg","../resources/img/city2.jpg"];
const random2 = Math.floor(Math.random() * 5)
searchGround.style.backgroundImage = "url('"+imgList[random2]+"')" */
</script>
</body>
</html>