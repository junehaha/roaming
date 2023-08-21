<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<title>Insert title here</title>
<script>
const postId = new URLSearchParams(location.search).get("id");

let mySessionId = null;

		function getSession() {
		   const xhr = new XMLHttpRequest();
		   xhr.onreadystatechange = function () {
		      if(xhr.readyState == 4 && xhr.status == 200) {
		         const response = JSON.parse(xhr.responseText);
		      if(response.result == "success") {
		         mySessionId = response.id;
		      }         
		   }
		}
		
		xhr.open("get", "./getMyId");
		xhr.send();      
	}


	function xml() {
		const xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText);
			}
		}

		xhr.open("get", "./getPostCommentList?id=" + postId);
		xhr.send();

		xhr.open("post", "");
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhr.send();
	}
	

	
	function insertBoard() {
		const title = document.getElementById("title");
		const titleValue = title.value;
		const content = document.getElementById("content");
		const contentValue = content.value;
		
		const formData = new FormData();
		formData.append("title", titleValue);
		formData.append("content", contentValue);
		formData.append("post_id", postId);
		const xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText);
				
				title.value = "";
				content.value = "";
				reLoadBoard()
			}
		}

	 	xhr.open("post", "./partyCreateBoard");
		xhr.send(formData);
	}
	
	
	function boardModal() {
		const modal = bootstrap.Modal.getOrCreateInstance("#boardModal");
		
		const pageNum = 1;
		getBoardList();
		modal.show();
		
		
	}
	
	
	function getBoardList() {
		
		const xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText);
				const listContainer = document.getElementById("listContainer");
				if(listContainer){
					listContainer.innerHTML = "";	
				}
				
				const table = document.createElement("table");
				table.classList.add("table");
				const thead = document.createElement("thead");
				const theadTr = document.createElement("tr");
				theadTr.classList.add("text-center");
				
				const theadTh1 = document.createElement("th");
				theadTh1.classList.add("text-center");
				theadTh1.scope = "col";
				theadTh1.style.width = "50px";
				
				const theadTh2 = document.createElement("th");
				theadTh2.scope = "col";
				theadTh2.style.width = "270px";
				theadTh2.innerText = "제목";
				
				const theadTh3 = document.createElement("th");
				theadTh3.classList.add("text-center");
				theadTh3.scope = "col";
				theadTh3.style.width = "150px";
				theadTh3.innerText = "작성자";
				
				const theadTh4 = document.createElement("th");
				theadTh4.classList.add("text-center");
				theadTh4.scope = "col";
				theadTh4.style.width = "150px";
				theadTh4.innerText = "게시일";
				
				const theadTh5 = document.createElement("th");
				theadTh5.classList.add("text-center");
				theadTh5.scope = "col";
				theadTh5.style.width = "80px";
				theadTh5.innerText = "조회수";
				
				theadTr.appendChild(theadTh1);
				theadTr.appendChild(theadTh2);
				theadTr.appendChild(theadTh3);
				theadTr.appendChild(theadTh4);
				theadTr.appendChild(theadTh5);
				
				thead.appendChild(theadTr);
				table.appendChild(thead);
				
				
				response.list.forEach(function(list){
					
					const tr = document.createElement("tr");
					const th = document.createElement("th");
					th.setAttribute("scope", "row");
					th.textContent = list.partyBoardDto.id;
					th.classList.add("text-center");
					const td1 = document.createElement("td");
					const maxLength = 16;
					const titleLength = list.partyBoardDto.title
					const subTitle = titleLength.length > maxLength ? titleLength.substring(0, maxLength) + "..." : titleLength; 
					td1.textContent = subTitle;

					td1.onclick = () => {
						boardDetail(list.partyBoardDto.id);
						console.log("온클릭 : " + list.partyBoardDto.id)
					}
					
					const td2 = document.createElement("td");
					td2.textContent = list.userDto.user_name;
					td2.classList.add("text-center");	
					const td3 = document.createElement("td");
					td3.textContent = list.partyBoardDto.reg_date;  
					td3.classList.add("text-center");
					const td4 = document.createElement("td");
					td4.textContent = list.partyBoardDto.hit;
					td4.classList.add("text-center");
					
					tr.appendChild(th);
					tr.appendChild(td1);
					tr.appendChild(td2);
					tr.appendChild(td3);
					tr.appendChild(td4);
					listContainer.appendChild(tr);
				})
				
			}
		}

	 	xhr.open("post", "./getPartyBoardList");
	 	xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhr.send("post_id=" + postId);
	}
	
	
	function createBoard() {
		const boardListContainer = document.getElementById("boardListContainer");
		boardListContainer.innerHTML = "";
		const boardHeader = document.getElementById("boardHeader");
		boardHeader.innerHTML = "";
		const boardFooter = document.getElementById("boardFooter");
		boardFooter.innerHTML = "";
		
		const i = document.createElement("i");
		i.classList.add("bi", "bi-chevron-left");
		i.style.paddingBottom = "2px"
		i.style.fontSize = "20px"
		i.onclick = () => {
			/* 뒤로가기 */
			reLoadBoard()
		}
		boardHeader.appendChild(i)
		
		const header1 = document.createElement("span");
		header1.classList.add("ms-2")
		header1.innerText = "게시글 작성";
		header1.style.fontSize = "20px"
		boardHeader.appendChild(header1)
		
		const headerBtn = document.createElement("button");
		headerBtn.classList.add("btn-close")
		headerBtn.onclick = () => {
			const modal = bootstrap.Modal.getOrCreateInstance("#boardModal");
			modal.hide();
		}
		boardHeader.appendChild(headerBtn)
		
		
		const footerBtn = document.createElement("button");
		footerBtn.classList.add("btn", "btn-primary")
		footerBtn.style.float = "end";
		footerBtn.innerText = "등 록"
		footerBtn.onclick = () => {
			insertBoard()
		}
		boardFooter.appendChild(footerBtn)
		
		const label1 = document.createElement("label");
		label1.classList.add("mt-2")
		label1.for = "title";
		label1.innerText = "제목 :"
		label1.style.marginLeft = "32px";
		
		const input1 = document.createElement("input");
		input1.classList.add("form-control", "mt-1");
		input1.placeholder = "제목을 입력해주세요.";
		input1.style.width = "600px"
		input1.style.margin = "0 auto"
		input1.id = "title"
		
		const label2 = document.createElement("label");
		label2.classList.add("mt-2")
		label2.for = "content";
		label2.innerText = "내용 :"
		label2.style.marginLeft = "32px";
		
		const textarea = document.createElement("textarea");
		textarea.classList.add("form-control", "mt-1");
		textarea.placeholder = "내용을 입력해주세요.";
		textarea.style.height = "400px"
		textarea.style.width = "600px"
		textarea.style.margin = "0 auto"
		textarea.id = "content"
		
		label1.appendChild(input1);
		boardListContainer.appendChild(label1);
		
		label2.appendChild(textarea);
		boardListContainer.appendChild(label2);
		
	}
	
	
		function reLoadBoard() {
			const boardListContainer = document.getElementById("boardListContainer");
			if(boardListContainer){
				boardListContainer.innerHTML = "";	
			}
			const boardHeader = document.getElementById("boardHeader");
			if(boardHeader){
				boardHeader.innerHTML = "";
			}
			const boardFooter = document.getElementById("boardFooter");
			if(boardFooter){
				boardFooter.innerHTML = "";
			}
			const xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					const response = JSON.parse(xhr.responseText);
					
					
					const table = document.createElement("table");
					table.classList.add("table");
					const thead = document.createElement("thead");
					const theadTr = document.createElement("tr");
					theadTr.classList.add("text-center");
					
					const theadTh1 = document.createElement("th");
					theadTh1.classList.add("text-center");
					theadTh1.scope = "col";
					theadTh1.style.width = "50px";
					
					const theadTh2 = document.createElement("th");
					theadTh2.scope = "col";
					theadTh2.style.width = "270px";
					theadTh2.innerText = "제목";
					
					const theadTh3 = document.createElement("th");
					theadTh3.classList.add("text-center");
					theadTh3.scope = "col";
					theadTh3.style.width = "150px";
					theadTh3.innerText = "작성자";
					
					const theadTh4 = document.createElement("th");
					theadTh4.classList.add("text-center");
					theadTh4.scope = "col";
					theadTh4.style.width = "150px";
					theadTh4.innerText = "게시일";
					
					const theadTh5 = document.createElement("th");
					theadTh5.classList.add("text-center");
					theadTh5.scope = "col";
					theadTh5.style.width = "80px";
					theadTh5.innerText = "조회수";
					
					theadTr.appendChild(theadTh1);
					theadTr.appendChild(theadTh2);
					theadTr.appendChild(theadTh3);
					theadTr.appendChild(theadTh4);
					theadTr.appendChild(theadTh5);
					
					thead.appendChild(theadTr);
					table.appendChild(thead);
					
					/* 페이징 */
					
					const nav = document.createElement("nav");
					nav.ariaLabel = "Page navigation example";
					nav.style.display = "flex";
					nav.style.justifyContent = "center";
					
					const ul = document.createElement("ul");
					ul.classList.add("pagination");
					
					const li1 = document.createElement("li");
					li1.classList.add("page-item");
					const a1 = document.createElement("a");
					a1.classList.add("page-link");
					a1.href = "#"
					a1.ariaLabel = "Previous";
					
					const span1 = document.createElement("span");
					span1.ariaHidden = "ture";
					span1.innerText = "<";
					
					a1.appendChild(span1)
					li1.appendChild(a1)
					
					const li2 = document.createElement("li");
					li2.classList.add("page-item");
					const a2 = document.createElement("a");
					a2.classList.add("page-link", "active");
					a2.href = "#";
					a2.innerText = "1";
					
					li2.appendChild(a2);
					
					const li3 = document.createElement("li");
					li3.classList.add("page-item");
					const a3 = document.createElement("a");
					a3.classList.add("page-link");
					a3.href = "#";
					a3.innerText = "2";
					
					li3.appendChild(a3);
					
					const li4 = document.createElement("li");
					li2.classList.add("page-item");
					const a4 = document.createElement("a");
					a4.classList.add("page-link");
					a4.href = "#";
					a4.innerText = "3";
					
					li4.appendChild(a4);
					
					const li5 = document.createElement("li");
					li5.classList.add("page-item");
					const a5 = document.createElement("a");
					a5.classList.add("page-link");
					a5.href = "#";
					a5.innerText = "4";
					
					li5.appendChild(a5);
					
					const li6 = document.createElement("li");
					li5.classList.add("page-item");
					const a6 = document.createElement("a");
					a6.classList.add("page-link");
					a6.href = "#";
					a6.innerText = "5";
					
					li6.appendChild(a6);
					
					const li7 = document.createElement("li");
					li7.classList.add("page-item");
					
					const a7 = document.createElement("a");
					a7.classList.add("page-link");
					a7.href = "#"
					a7.ariaLabel = "Next";
					
					const span2 = document.createElement("span");
					span2.ariaHidden = "ture";
					span2.innerText = ">";
					
					a7.appendChild(span2)
					li7.appendChild(a7)
					
					ul.appendChild(li1)
					ul.appendChild(li2)
					ul.appendChild(li3)
					ul.appendChild(li4)
					ul.appendChild(li5)
					ul.appendChild(li6)
					ul.appendChild(li7)
					
					nav.appendChild(ul)
					
					const header1 = document.createElement("span");
					header1.classList.add("ms-2")
					header1.innerText = "게시글";
					header1.style.fontSize = "20px"
					boardHeader.appendChild(header1)
					
					const headerBtn = document.createElement("button");
					headerBtn.classList.add("btn-close")
					headerBtn.onclick = () => {
						const modal = bootstrap.Modal.getOrCreateInstance("#boardModal");
						modal.hide();
					}
					boardHeader.appendChild(headerBtn)
					
					
					const footerBtn = document.createElement("button");
					footerBtn.classList.add("btn", "btn-primary")
					footerBtn.style.float = "end";
					footerBtn.innerText = "게시글 작성"
					footerBtn.onclick = () => {
						createBoard();
					}
					boardFooter.appendChild(footerBtn)
					
					response.list.forEach(function(list){
						
						const tbody = document.createElement("tbody");
						const tr = document.createElement("tr");
						const th = document.createElement("th");
						th.setAttribute("scope", "row");
						th.textContent = list.partyBoardDto.id;
						th.classList.add("text-center");
						const td1 = document.createElement("td");
						const maxLength = 16;
						const titleLength = list.partyBoardDto.title
						const subTitle = titleLength.length > maxLength ? titleLength.substring(0, maxLength) + "..." : titleLength; 
						td1.textContent = subTitle;
						td1.onclick = () => {
							boardDetail(list.partyBoardDto.id);
						}
						
						const td2 = document.createElement("td");
						td2.textContent = list.userDto.user_name;
						td2.classList.add("text-center");	
						const td3 = document.createElement("td");
						td3.textContent = list.partyBoardDto.reg_date;  
						td3.classList.add("text-center");
						const td4 = document.createElement("td");
						td4.textContent = list.partyBoardDto.hit;
						td4.classList.add("text-center");
						
						tr.appendChild(th);
						tr.appendChild(td1);
						tr.appendChild(td2);
						tr.appendChild(td3);
						tr.appendChild(td4);
						
						tbody.appendChild(tr);
						
						table.appendChild(tbody);
						boardListContainer.appendChild(table)
						boardListContainer.appendChild(nav)
						
					})
					
				}
			}
	
		 	xhr.open("post", "./getPartyBoardList");
		 	xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			xhr.send("post_id=" + postId);
		}
	
	
	
	function boardDetail(board_id) {
		console.log("id = " + board_id)
		const boardListContainer = document.getElementById("boardListContainer");
		if(boardListContainer){
			boardListContainer.innerHTML = "";	
		}
		const boardHeader = document.getElementById("boardHeader");
		if(boardHeader){
			boardHeader.innerHTML = "";
		}
		const boardFooter = document.getElementById("boardFooter");
		if(boardFooter){
			boardFooter.innerHTML = "";
		}
		const xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText);
				
				const i = document.createElement("i");
				i.classList.add("bi", "bi-chevron-left");
				i.style.paddingBottom = "2px"
				i.style.fontSize = "20px"
				i.onclick = () => {
					/* 뒤로가기 */
					reLoadBoard()
				}
				boardHeader.appendChild(i)
				
				const header1 = document.createElement("span");
				header1.classList.add("ms-2")
				header1.innerText = "게시물 상세";
				header1.style.fontSize = "20px"
				boardHeader.appendChild(header1)
				
				const headerBtn = document.createElement("button");
				headerBtn.classList.add("btn-close")
				headerBtn.onclick = () => {
					const modal = bootstrap.Modal.getOrCreateInstance("#boardModal");
					modal.hide();
				}
				boardHeader.appendChild(headerBtn)
				
				const footerBtn1 = document.createElement("button");
				footerBtn1.classList.add("btn", "btn-primary")
				footerBtn1.style.float = "end";
				footerBtn1.innerText = "수정"
				footerBtn1.onclick = () => {
					/* 수정 구현 */
				}
				boardFooter.appendChild(footerBtn1)
				
				
				const footerBtn2 = document.createElement("button");
				footerBtn2.classList.add("btn", "btn-primary")
				footerBtn2.style.float = "end";
				footerBtn2.innerText = "삭제"
				footerBtn2.onclick = () => {
					/* 삭제 구현 */
				}
				boardFooter.appendChild(footerBtn2)
				
					const data = response.data;					
					const container = document.createElement("div");
					container.classList.add("container-fluid")

					const row1 = document.createElement("div");
					row1.classList.add("row")
					const row1_col = document.createElement("div");
					row1_col.classList.add("col")
					const row1_col_p = document.createElement("p");
					row1_col_p.innerText = data.partyBoardDto.title;
					row1_col_p.style.fontSize = "25px"
					row1_col.appendChild(row1_col_p)
					row1.appendChild(row1_col) //
					
					const row2 = document.createElement("div");
					row2.classList.add("row")
					const row2_col1 = document.createElement("div");
					row2_col1.classList.add("col-1", "text-center")
					const row2_col1_img = document.createElement("img");
					row2_col1_img.src = "/uploadFiles/" + data.userDto.profile_img;
					row2_col1_img.style.height = "50px"
					row2_col1_img.style.width = "50px"
					row2_col1_img.style.borderRadius = "50%"
					
					row2_col1.appendChild(row2_col1_img)
					row2.appendChild(row2_col1) //
				
					const row2_col2 = document.createElement("div");
					row2_col2.classList.add("col-11", "ps-4")
					const row2_col2_row1 = document.createElement("div");
					row2_col2_row1.classList.add("row")
					const row2_col2_row1_col = document.createElement("div");
					row2_col2_row1_col.classList.add("col")
					const row2_col2_row1_col_b = document.createElement("b");
					row2_col2_row1_col_b.innerText = data.userDto.user_name
					row2_col2_row1_col.appendChild(row2_col2_row1_col_b)
					row2_col2_row1.appendChild(row2_col2_row1_col)
					row2_col2.appendChild(row2_col2_row1)
					row2.appendChild(row2_col2)
					
					const row2_col2_row2 = document.createElement("div");
					row2_col2_row2.classList.add("row")
					const row2_col2_row2_col = document.createElement("div");
					row2_col2_row2_col.classList.add("col")
					const row2_col2_row2_col_small1 = document.createElement("small");
					row2_col2_row2_col_small1.innerText = data.partyBoardDto.reg_date
					row2_col2_row2_col_small1.style.marginRight = "10px"
					const row2_col2_row2_col_small2 = document.createElement("small");
					row2_col2_row2_col_small2.innerText = "조회 " + data.partyBoardDto.hit
					row2_col2_row2_col.appendChild(row2_col2_row2_col_small1)
					row2_col2_row2_col.appendChild(row2_col2_row2_col_small2)
					row2_col2_row2.appendChild(row2_col2_row2_col)
					
					row2_col2.appendChild(row2_col2_row2)
					
				
					const row3 = document.createElement("div");
					row3.classList.add("row", "ms-1", "me-1", "mt-4")
					const row3_col1 = document.createElement("div");
					row3_col1.classList.add("col", "border-bottom")
					
					row3.appendChild(row3_col1)
				
					const row4 = document.createElement("div");
					row4.classList.add("row", "mt-3")
					const row4_col1 = document.createElement("div");
					row4_col1.classList.add("col")	
					const row4_col1_p = document.createElement("p");
					
					row4_col1_p.innerText = data.partyBoardDto.content
					
					row4_col1.appendChild(row4_col1_p)
					row4.appendChild(row4_col1)
					
					container.appendChild(row1)
					container.appendChild(row2)
					container.appendChild(row3)
					container.appendChild(row4)
					
					boardListContainer.appendChild(container)
					
					/* partyBoardDto */
					/* userDto */
				
			}
		}

	 	xhr.open("get", "./getPartyBoardDetail?board_id=" + board_id);
		xhr.send();
	}	
	
	
	function boardPaging() {
		const pagingBtn = document.getElementById("pagingBtn");
		const nav = document.createElement("nav");
		const ul = document.createElement("ul");
		ul.classList.add("pagination");
		
		// 이전 페이지 버튼 요소
		const left_li = document.createElement("li");
		left_li.classList.add("page-item");
		const left_a = document.createElement("a");
		left_a.classList.add("page-link");
		left_a.href = "";
		left_a.setAttribute("aria-label", "Previous");
		const left_span = document.createElement("span");
		left_span.setAttribute("aria-hidden", "true");
		left_span.innerText = "<";
		left_a.appendChild(left_span);
		left_li.appendChild(left_a);
		ul.appendChild(left_li);

		// 페이지 번호 요소 1
		const li1 = document.createElement("li");
		const li1_a = document.createElement("a");
		li1.classList.add("page-item");
		li1_a.classList.add("page-link");
		li1_a.textContent = "1";
		li1_a.onclick = () => {
			getBoardList(1);
		};
		li1.appendChild(li1_a);
		// 페이지 번호 요소 2
		const li2 = document.createElement("li");
		const li2_a = document.createElement("a");
		li2.classList.add("page-item");
		li2_a.classList.add("page-link");
		li2_a.textContent = "2";
		li2.appendChild(li2_a);
		li2_a.onclick = () => {
			getBoardList(2);
		};
		
		// 페이지 번호 요소 3
		const li3 = document.createElement("li");
		const li3_a = document.createElement("a");
		li3.classList.add("page-item");
		li3_a.classList.add("page-link");
		li3_a.textContent = "3";
		li3.appendChild(li3_a);
		li3_a.onclick = () => {
			getBoardList(3);
		};
		
		// 페이지 번호 요소 4
		const li4 = document.createElement("li");
		const li4_a = document.createElement("a");
		li4.classList.add("page-item");
		li4_a.classList.add("page-link");
		li4_a.textContent = "4";
		li4.appendChild(li4_a);
		li4_a.onclick = () => {
			getBoardList(4);
		};
		
		// 페이지 번호 요소 5
		const li5 = document.createElement("li");
		const li5_a = document.createElement("a");
		li5.classList.add("page-item");
		li5_a.classList.add("page-link");
		li5_a.textContent = "5";
		li5.appendChild(li5_a);
		li5_a.onclick = () => {
			getBoardList(5);
		};
		
		
		ul.appendChild(li1);
		ul.appendChild(li2);
		ul.appendChild(li3);
		ul.appendChild(li4);
		ul.appendChild(li5);

		// 다음 페이지 버튼 요소
		const right_li = document.createElement("li");
		right_li.classList.add("page-item");
		const right_a = document.createElement("a");
		right_a.classList.add("page-link");
		right_a.href = "";
		right_a.setAttribute("aria-label", "Next");
		const right_span = document.createElement("span");
		right_span.setAttribute("aria-hidden", "true");
		right_span.innerText = ">";
		right_a.appendChild(right_span);
		right_li.appendChild(right_a);
		ul.appendChild(right_li);

		nav.appendChild(ul);
		pagingBtn.appendChild(nav);
	}
	
	
	
	
	
	
	
	
	
	
	
	let clickAddress = '서울 강남구 테헤란로 7길 7';
	let clickLocation = '중앙정보처리학원';
	
	function scheduleList() {
		  const xhr = new XMLHttpRequest();
		  xhr.onreadystatechange = function () {
		    if (xhr.readyState == 4 && xhr.status == 200) {
		      const response = JSON.parse(xhr.responseText);
		      const userDto = response.data[0].userDto;  
		      const inputStart = new Date(response.data[0].postDto.day_start);
		      const inputEnd = new Date(response.data[0].postDto.day_end);
		      const postDto = response.data[0].postDto;
		      
		      
		      
		      /* addressMarker(); 마커 여러개*/
		      
		      var monthNames = [
		        "01", "02", "03", "04", "05", "06",
		        "07", "08", "09", "10", "11", "12"
		      ];

		      var dayNames = [
		        "일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"
		      ];

		      var smonth = monthNames[inputStart.getMonth()];
		      var sday = inputStart.getDate().toString().padStart(2, '0');
		      var sdayOfWeek = dayNames[inputStart.getDay()];
		      var syear = inputStart.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기

		      var emonth = monthNames[inputEnd.getMonth()];
		      var eday =  inputEnd.getDate().toString().padStart(2, '0');
		      var edayOfWeek = dayNames[inputEnd.getDay()];
		      var eyear = inputEnd.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기

		      var startA = smonth + "월 " + sday + "일 " + sdayOfWeek;
		      var endA = emonth + "월 " + eday + "일 " + edayOfWeek;
		      
		      var startB = syear + "." + smonth + "." + sday;
		      var endB = eyear + "." + emonth + "." + eday;
		      

			const scheduleBox = document.getElementById("scheduleBox");
			
		      const row1 = document.createElement("div");
		      row1.classList.add("row", "mt-3", "mb-2");
		      const row1_col = document.createElement("div");
		      row1_col.classList.add("col", "text-center");
		      const row1_col_span = document.createElement("span");
		      row1_col_span.style.fontSize = "20px";
		      row1_col_span.innerText =  userDto.user_name + "님의 여행일정";
				
		      const row1_col_div = document.createElement("span");
		      row1_col_div.style.width = "50%"
		      
		      const row1_col_div_i = document.createElement("i");
		      row1_col_div_i.classList.add("bi", "bi-three-dots-vertical", "dropdown", "pe-3")
		    row1_col_div_i.dataset.bsToggle = "dropdown"; 
			row1_col_div_i.setAttribute("aria-expanded", "false");
				row1_col_div_i.style.float = "right"
				const row1_col_div_ul = document.createElement("ul");
		      row1_col_div_ul.classList.add("dropdown-menu")
		      row1_col_div_ul.style.width = "100px"
		      
		      
		      
		      row1_col_div_ul.id = "dropdown__style";
		      	const row1_col_div_ul_li1 = document.createElement("li");
		      	row1_col_div_ul_li1.style.width = "100px"
		  	const row1_col_div_ul_li1_a = document.createElement("a");
		  	row1_col_div_ul_li1_a.classList.add("dropdown-item", "text-center", "me-0")
		  	row1_col_div_ul_li1_a.style.fontSize = "14px"
		  	row1_col_div_ul_li1_a.style.width = "100px"
		  	
		  	row1_col_div_ul_li1_a.innerText = "스케줄 수정"
		  	
		      	const row1_col_div_ul_li2 = document.createElement("li");
		  	row1_col_div_ul_li2.style.width = "100px"
		      	const row1_col_div_ul_li2_a = document.createElement("a");
		      	row1_col_div_ul_li2_a.classList.add("dropdown-item", "text-center", "me-0")
		      	row1_col_div_ul_li2_a.style.fontSize = "14px"
		      	row1_col_div_ul_li2_a.style.width = "100px"
			  	row1_col_div_ul_li2_a.innerText = "스케줄 삭제"  	
			  		row1_col_div_ul_li2_a.onclick = () => {
			  			
			  			scheduleDelete()
			  			
			  		}
			  	
			  	
			  		row1_col_div_ul_li1.appendChild(row1_col_div_ul_li1_a)
			  		row1_col_div_ul_li2.appendChild(row1_col_div_ul_li2_a)
			  		row1_col_div_ul.appendChild(row1_col_div_ul_li1)
			  		row1_col_div_ul.appendChild(row1_col_div_ul_li2)
		      		
		      row1_col_div.appendChild(row1_col_div_i)
		      row1_col_div.appendChild(row1_col_div_ul)
		      
		      
		      
		      
		      row1_col.appendChild(row1_col_span);
		      row1_col.appendChild(row1_col_div);
		      
		      row1.appendChild(row1_col);
		      scheduleBox.appendChild(row1);
		      const row2 = document.createElement("div");
		      row2.classList.add("row");
		      
		      const row2_col = document.createElement("div");
		      row2_col.classList.add("col");
		      
		      const row2_col_div = document.createElement("div");
		      row2_col_div.classList.add("m-3");
		      row2_col_div.style.height = "90px";
		      row2_col_div.style.backgroundColor = "rgb(251, 251, 251)";
		      row2_col_div.style.justifyContent = "center";
		      row2_col_div.style.display = "flex";
		      row2_col_div.style.alignItems = "center";
		      row2_col_div.style.borderRadius = "15px";
		      row2_col_div.onclick = () => {
		    	  
		      }
		      
		      
		      const row2_i1 = document.createElement("i");
		      row2_i1.classList.add("me-4", "bi", "bi-calendar2-check");
		      const row2_span = document.createElement("span");
		      row2_span.innerText = startA + " - " + endA;
		      const row2_i2 = document.createElement("i");
		      row2_i2.classList.add("ms-4", "bi", "bi-chevron-down");
				
		      row2_col_div.appendChild(row2_i1);
		      row2_col_div.appendChild(row2_span);
		      row2_col_div.appendChild(row2_i2);
		      row2_col.appendChild(row2_col_div);
		      row2.appendChild(row2_col);
		      scheduleBox.appendChild(row2);
		      const row3 = document.createElement("div");
		      row3.classList.add("row", "mt-3", "mb-3");
		      const row3_col = document.createElement("div");
		      row3_col.classList.add("col");
		      const row3_col_label = document.createElement("label");
		      row3_col_label.classList.add("ms-3", "pt-1", "pb-1", "d-flex", "content-start");
		      row3_col_label.style.fontSize = "18px";
		      const row3_col_label_div = document.createElement("div");
		      row3_col_label_div.classList.add("text-center");
		      row3_col_label_div.style.width = "40px";
		      row3_col_label_div.style.backgroundColor = "#d5f0ff";
		      row3_col_label_div.style.borderRadius = "8px";
		      const row3_col_label_div_i = document.createElement("i");
		      row3_col_label_div_i.classList.add("bi", "bi-geo-alt-fill");
		      row3_col_label_div_i.style.color = "#00A3FF";
		      row3_col_label_div_i.style.fontSize = "23px";
		      const row3_col_label_span = document.createElement("span");
		      row3_col_label_span.classList.add("ms-3", "pt-1", "pb-1");
		      row3_col_label_span.innerText = postDto.going;
		      row3_col_label_div.appendChild(row3_col_label_div_i);
		      row3_col_label.appendChild(row3_col_label_div);
		      row3_col_label.appendChild(row3_col_label_span);
		      row3_col.appendChild(row3_col_label);
		      row3.appendChild(row3_col);
		      scheduleBox.appendChild(row3);
		      const row4 = document.createElement("div");
		      row4.classList.add("row", "mt-3", "mb-3");
		      const row4_col = document.createElement("div");
		      row4_col.classList.add("col");
		      const row4_col_label = document.createElement("label");
		      row4_col_label.classList.add("ms-3", "pt-1", "pb-1", "d-flex", "content-start");
		      row4_col_label.style.fontSize = "18px";
		      
		      const row4_col_label_div = document.createElement("div");
		      row4_col_label_div.classList.add("text-center");
		      row4_col_label_div.style.width = "40px";
		      row4_col_label_div.style.backgroundColor = "#d5f0ff";
		      row4_col_label_div.style.borderRadius = "8px";
		      
		      const row4_col_label_div_i = document.createElement("i");
		      row4_col_label_div_i.classList.add("bi", "bi-calendar2-check");
		      row4_col_label_div_i.style.color = "#00A3FF";
		      row4_col_label_div_i.style.fontSize = "23px";
		      
		      const row4_col_label_span = document.createElement("span");
		      row4_col_label_span.classList.add("ms-3", "pt-1", "pb-1");
		      row4_col_label_span.innerText = startB + " - " + endB;

		      row4_col_label_div.appendChild(row4_col_label_div_i);
		      row4_col_label.appendChild(row4_col_label_div);
		      row4_col_label.appendChild(row4_col_label_span);
		      row4_col.appendChild(row4_col_label);
		      row4.appendChild(row4_col);
		      scheduleBox.appendChild(row4);
		      

		      response.data.forEach(function(item) {
		        const dayDto = item.dayDto;
		        const schedulerDto = item.schedulerDtoList;
		    	const div_1 = document.createElement("div");
		        div_1.classList.add("dayForEach");
		        const row5 = document.createElement("div");
		        row5.classList.add("row", "mt-4");
		        const row5_col = document.createElement("div");
		        row5_col.classList.add("col");
		        
		        const row5_col_label = document.createElement("label");
		        row5_col_label.classList.add("p-2");
		        row5_col_label.style.backgroundColor = "black";
		        row5_col_label.style.borderRadius = "15px";
		        row5_col_label.style.marginLeft = "80px";
		        row5_col_label.onclick = () => {
		        	/* 일차보내기 */
		        	dayListCreate(dayDto.id)
		        	
		        	console.log("클릭 id : " + dayDto.id);
		        }
		        
		        
		        const row5_col_label_i = document.createElement("i");
		        row5_col_label_i.classList.add("bi", "bi-send-fill", "me-1");
		        row5_col_label_i.style.color = "white";
		        const row5_col_label_span = document.createElement("span");
		        row5_col_label_span.style.color = "white";
		        row5_col_label_span.innerText = "Day" + dayDto.trip_day;
		        
		        const row5_col_span1 = document.createElement("span");
		        row5_col_span1.classList.add("ms-2", "me-2");
		        row5_col_span1.style.color = "gray";
		        row5_col_span1.innerText = " | ";
		        const row5_col_span2 = document.createElement("span");
		        row5_col_span2.style.color = "gray";
		        const date = dayDto.todayDate;
				const toDate = new Date(date);
				var monthNames = [
				     "01", "02", "03", "04", "05", "06",
				     "07", "08", "09", "10", "11", "12"
				   ];

				var smonth = monthNames[toDate.getMonth()];
				var sday = toDate.getDate().toString().padStart(2, '0');
				var dateParts = smonth + "." + sday;
		        row5_col_span2.innerText = dateParts;

		        row5_col_label.appendChild(row5_col_label_i);
		        row5_col_label.appendChild(row5_col_label_span);
		        
		        row5_col.appendChild(row5_col_label);
		        row5_col.appendChild(row5_col_span1);
		        row5_col.appendChild(row5_col_span2);
		        row5.appendChild(row5_col);
		        div_1.appendChild(row5);
		        
		        schedulerDto.forEach(function(data) {
		          	
		            const row6 = document.createElement("div");
		            row6.classList.add("row", "mt-3");
		            const row6_col1 = document.createElement("div");
		            row6_col1.classList.add("col");
		            const row6_1 = document.createElement("div");
		            row6_1.classList.add("row");
		            
		            const row6_col2 = document.createElement("div");
		            row6_col2.classList.add("col");
		            
		            const row6_col_label1 = document.createElement("label");
		            row6_col_label1.style.backgroundColor = "#00A3FF";
		            row6_col_label1.style.borderRadius = "50%";
		            row6_col_label1.style.color = "white";
		            row6_col_label1.style.marginLeft = "100px";
		            
		            const row6_col_label_span = document.createElement("span");
		            row6_col_label_span.classList.add("p-2");
		            row6_col_label_span.innerText = data.order_no + 1;

		            const row6_col_label2 = document.createElement("label");
		            row6_col_label2.classList.add("ms-2", "p-2");
		            row6_col_label2.style.border = "1px solid #00A3FF";
		            row6_col_label2.style.borderRadius = "10px";
		            row6_col_label2.style.width = "70%";
		            
		            const row6_col_label2_span0 = document.createElement("span");
		            row6_col_label2_span0.style.fontSize = "15px";
		            row6_col_label2_span0.onclick = () => {
		            	searchAddress(data.address, data.name)
		            }
		            if(data.name) {
		            	row6_col_label2_span0.innerText = data.name;	
		            }
		            
		            const row6_col_label2_span1 = document.createElement("span");
		            row6_col_label2_span1.style.fontSize = "12px";
		            row6_col_label2_span1.onclick = () => {
		            	searchAddress(data.address, data.name)
		            }
		            if(data.address) {
		            	row6_col_label2_span1.innerText = "(" + data.address + ")";	
		            }
		            
		            row6_col_label1.appendChild(row6_col_label_span);
		            row6_col_label2.appendChild(row6_col_label2_span0);
		            row6_col_label2.appendChild(row6_col_label2_span1);
		            
		            row6_col2.appendChild(row6_col_label1);
		            row6_col2.appendChild(row6_col_label2);
		            row6_1.appendChild(row6_col2);
		            row6_col1.appendChild(row6_1);
		            row6.appendChild(row6_col1);
		            
		            div_1.appendChild(row6);
		            
		            const row7 = document.createElement("div");
		            row7.classList.add("row", "mt-3");
		            const row7_col1 = document.createElement("div");
		            row7_col1.classList.add("col");
		            const row7_row = document.createElement("div");
		            row7_row.classList.add("row");
		            const row7_row_col1 = document.createElement("div");
		            row7_row_col1.classList.add("col");
		            const row7_row_col1_label1 = document.createElement("label");
		            row7_row_col1_label1.style.marginLeft = "130px";
		            const row7_row_col1_label_i = document.createElement("i");
		            row7_row_col1_label_i.classList.add("bi", "bi-check-circle");
		            row7_row_col1_label_i.style.color = "#00A3FF";
		            row7_row_col1_label_i.style.fontSize = "22px";
		            const row7_row_col1_label2 = document.createElement("label");
		            row7_row_col1_label2.classList.add("ms-2", "p-2");
		            row7_row_col1_label2.style.backgroundColor = "rgb(251, 251, 251)";
		            row7_row_col1_label2.style.borderRadius = "10px";
		            row7_row_col1_label2.style.width = "65%";
		            const row7_row_col1_label2_span1 = document.createElement("span");
		            row7_row_col1_label2_span1.style.fontSize = "15px";
		            row7_row_col1_label2_span1.style.color = "#5599f2";
		            row7_row_col1_label2_span1.classList.add("me-2");
		            if(data.trip_time){
		            	row7_row_col1_label2_span1.innerText = data.trip_time;	
		            }
		            
		            const row7_row_col1_label2_span2 = document.createElement("span");
		            row7_row_col1_label2_span2.style.fontSize = "13px";
		            row7_row_col1_label2_span2.style.color = "#e8a33c";
		            if(data.trip_memo){
		            	row7_row_col1_label2_span2.innerText = data.trip_memo;	
		            }
		            
		            
		            row7_row_col1_label1.appendChild(row7_row_col1_label_i);
		            row7_row_col1_label2.appendChild(row7_row_col1_label2_span1);
		            row7_row_col1_label2.appendChild(row7_row_col1_label2_span2);
		            
		            if(data.trip_time || data.trip_memo){
			            row7_row_col1.appendChild(row7_row_col1_label1);
			            row7_row_col1.appendChild(row7_row_col1_label2);
		            }
		            row7_row.appendChild(row7_row_col1);
		            row7_col1.appendChild(row7_row);
		            row7.appendChild(row7_col1);
		            div_1.appendChild(row7)
		            
		            
		            scheduleBox.appendChild(div_1);
		            
		            
		          
		        });
		        
		        
		      });
		    }
		  };

		  xhr.open("get", "./getScheduleList?post_id=" + postId);
		  xhr.send();
		}
	
	
	
	 
	function scheduleDelete() {
		   const xhr = new XMLHttpRequest();
		   xhr.onreadystatechange = function () {
		      if(xhr.readyState == 4 && xhr.status == 200) {
		         const response = JSON.parse(xhr.responseText);
		      	/* 동행 디테일 페이지 이동 */
		         window.location.href = "postDetailPage?id=" + postId;
		         /* 동행 스케줄 입력 페이지 이동 */
		         window.location.href = "testPost?id=" + postId;
		         
		   }
		}
		
		xhr.open("get", "./scheduleDelete?post_id=" + postId);
		xhr.send();      
	}
	
	
	
	
	let addressList = [];
	let nameList = [];
	let markers = []; 
	let lines = [];
		function dayListCreate(id) {
			const xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					const response = JSON.parse(xhr.responseText);
					const data = response.data;
					addressList = [];
					nameList = [];
					for(item of data) {
						nameList.push(item.name);
						addressList.push(item.address);
						
					}
					geocoder(addressList)
				}
			}
	
			xhr.open("get", "./getDayListIndex?day_id=" + id);
			xhr.send();
		}
	
	
		function geocoder(addressList) {
		    let path = [];
		    var map = new kakao.maps.Map(mapContainer, mapOption);
		    var geocoder = new kakao.maps.services.Geocoder(); // 주소 -> 좌표변환API

		    for (let i = 0; i < addressList.length; i++) {
		    	console.log("주소 = " + addressList)
		        geocoder.addressSearch(addressList[i], function (result, status) {
		            if (status === kakao.maps.services.Status.OK) {
		                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		                path.push(coords);
		                if (path.length === addressList.length) {
		                    var polyline = new kakao.maps.Polyline({
		                        map: map,
		                        path: path,
		                        strokeWeight: 3,
		                        strokeColor: '#f51866',
		                        strokeOpacity: 0.8,
		                        strokeStyle: 'solid'
		                    });
							
		                    var customOverlay = [];
		                    for (var j = 0; j < path.length; j++) {
		                    	var customOverlay = new kakao.maps.CustomOverlay({
		                    		map: map,
		                            position: path[j],
		                    	    content: '<label class="overlayBox">' +
		                    	    			'<span class="overlayBox_span">' +(j+1)+ '</span>' +
		                    	    		'</label>',
		                    	    xAnchor: 0.3,
		                    	    yAnchor: 0.91
		                    	});
		                    	customOverlay.setMap(map);
		                    }

		                    var bounds = new kakao.maps.LatLngBounds();
		                    path.forEach(function (coord) {
		                        bounds.extend(coord);
		                    });
		                    bounds.extend(path[0]);
		                    bounds.extend(path[path.length - 1]);
		                    map.setBounds(bounds);
		                }
		            }
		        });
		    }
		}

	
		function searchAddress(clickAddress, clickLocation) {
			console.log("서치clickAddress : " + clickAddress)
			
			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption); 

			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder();

			// 주소로 좌표를 검색합니다
			geocoder.addressSearch(clickAddress, function(result, status) {
				
			    // 정상적으로 검색이 완료됐으면 
			     if (status === kakao.maps.services.Status.OK) {

			        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

			        // 결과값으로 받은 위치를 마커로 표시합니다
			        var marker = new kakao.maps.Marker({
			            map: map,
			            position: coords
			        });

			        // 인포윈도우로 장소에 대한 설명을 표시합니다
			        var infowindow = new kakao.maps.InfoWindow({
			            content: '<div style="width:150px;text-align:center;padding:6px 0;"></div>'
			        });
			        infowindow.setContent('<div style="width:150px;text-align:center;padding:6px 0;">' + clickLocation + '</div>');
			        infowindow.open(map, marker);

			        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			        map.setCenter(coords);
			    } 
			}); 
		}
	
		 
		
		
		
	


		
		
		
		
		
		
	/* 채팅 구현 */
	/*    ------------------------------------------------- Group -------------------------------------------------    */
	/*    ------------------------------------------------- Group -------------------------------------------------    */
	/*    ------------------------------------------------- Group -------------------------------------------------    */
	/*    ------------------------------------------------- Group -------------------------------------------------    */
	
	
	
	let readPostId; // 그룹
	let readOneChatId; // 1:1
	let isFirstLoad = true;
	let intervalId;
	let intervalOneId;
	let viewNumber = 0;
	console.log("viewNumber : " + viewNumber)
	function clickChatModal() {
		 /* resetModal(); */	
		const modal = bootstrap.Modal.getOrCreateInstance("#chatModal")
		modal.show();
		chatModal();
	}		
		
		function chatModal() {
			
			const xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					const response = JSON.parse(xhr.responseText);
					
				const divMain = document.createElement("div");
				divMain.classList.add("modal", "fade");
				divMain.id = "chatModal";
				divMain.tabindex = "-1";
				divMain.ariaLabelledby = "exampleModalLabel";
				divMain.ariaHidden = "false";
				
				
				const div1 = document.createElement("div");
				div1.classList.add("modal-dialog");
				div1.style.width = "410px";
				 
				
				const div2 = document.createElement("div");
				div2.classList.add("modal-content");
				div2.id = "resetContainer";
				const div3 = document.createElement("div");
				div3.classList.add("modal-header", "p-0", "m-0");
				div3.style.overflowX = "auto";
				const row1 = document.createElement("div");
				row1.classList.add("row", "mt-1");
				const row1_col1 = document.createElement("div");
				row1_col1.classList.add("col-12");
				const row1_col1_row1 = document.createElement("div");
				row1_col1_row1.classList.add("row");
				const row1_col1_row1_col1 = document.createElement("div");
				row1_col1_row1_col1.classList.add("col");
				const row1_col1_row1_col1_span = document.createElement("span");
				row1_col1_row1_col1_span.classList.add("ms-3");
				row1_col1_row1_col1_span.style.color = "gray";
				row1_col1_row1_col1_span.style.fontSize = "13px";
				row1_col1_row1_col1_span.innerText = "동행 대화 참여자";
				
				row1_col1_row1_col1.appendChild(row1_col1_row1_col1_span);
				row1_col1_row1.appendChild(row1_col1_row1_col1);
				row1_col1.appendChild(row1_col1_row1);
				
				/* for 파티참가 유저 리스트 */
				if(response.partyList != null){
				response.partyList.forEach(function(item){
					const row1_col1_row2 = document.createElement("div");
					row1_col1_row2.classList.add("row", "mt-2");
					row1_col1_row2.id = "postPartyUserBox";
					row1_col1_row2.style.float = "left";
					
					const row1_col1_row2_col1 = document.createElement("div");
					row1_col1_row2_col1.classList.add("col");
					row1_col1_row2_col1.onclick = () => {
						if(mySessionId === item.id) {
							console.log("같은 유저 리턴")
							return;
						}else {
							insertOneChat(item.id)
							 /* 1:1대화방 인서트 */
							viewNumber = 1;
						}
					}
					
					const row1_col1_row2_col1_div = document.createElement("div");
					row1_col1_row2_col1_div.style.width = "80px";
					row1_col1_row2_col1_div.style.justifyContent = "center";
					row1_col1_row2_col1_div.style.textAlign = "center";
					row1_col1_row2_col1_div.style.alignItems = "center";
					
					const row1_col1_row2_col1_div_img = document.createElement("img");
					row1_col1_row2_col1_div_img.src = "/uploadFiles/" + item.profile_img;/* "파티참여자사진"; */
					row1_col1_row2_col1_div_img.style.height = "50px";
					row1_col1_row2_col1_div_img.style.width = "50px";
					row1_col1_row2_col1_div_img.style.borderRadius = "50%";
					
					const row1_col1_row2_col1_div_p = document.createElement("div");
					row1_col1_row2_col1_div_p.classList.add("mt-1");
					row1_col1_row2_col1_div_p.style.fontSize = "14px";
					row1_col1_row2_col1_div_p.innerText = item.user_name;
					
					row1_col1_row2_col1_div.appendChild(row1_col1_row2_col1_div_img);
					row1_col1_row2_col1_div.appendChild(row1_col1_row2_col1_div_p);
					
					row1_col1_row2_col1.appendChild(row1_col1_row2_col1_div);
					
					row1_col1_row2.appendChild(row1_col1_row2_col1);
					row1_col1.appendChild(row1_col1_row2);
					
					row1.appendChild(row1_col1);
					div3.appendChild(row1);
					div2.appendChild(div3);
				
				});
				}
				
				const body_div = document.createElement("div");
				body_div.classList.add("modal-body", "p-0", "m-0");
				const body_div_container = document.createElement("div");
				body_div_container.classList.add("container-fluid");
				body_div_container.id = "body_div_container";
				
				const row2 = document.createElement("div");
				row2.classList.add("row", "mt-1");
				const row2_col1 = document.createElement("div");
				row2_col1.classList.add("col", "text-center", "ms-4", "pt-1", "pb-1");
				row2_col1.style.backgroundColor = "black";
				row2_col1.style.color = "white";
				row2_col1.style.borderRadius = "5px 0 0 5px";
	
				const row2_col1_span1 = document.createElement("div");
				row2_col1_span1.innerText = "그룹대화";
				row2_col1_span1.onclick = () => {
					if(row2_col1.style.backgroundColor === "black") {
						row2_col1.style.backgroundColor = "gray";
						row2_col1.style.color = "white";
						row2_col2.style.backgroundColor = "black";
						row2_col2.style.color = "white";
					}else {
						row2_col1.style.backgroundColor = "black";
						row2_col1.style.color = "white";
						row2_col2.style.backgroundColor = "gray";
						row2_col2.style.color = "white";
					}
					
					
					const chatingList = document.getElementById("chatingList");
					chatingList.innerHTML = "";
					viewNumber = 0;
					groupList()
					
					console.log("뷰넘버 : " + viewNumber);
				}
				
				row2_col1.appendChild(row2_col1_span1);
				
				const row2_col2 = document.createElement("div");
				row2_col2.classList.add("col", "text-center", "me-4", "pt-1", "pb-1");
				row2_col2.style.backgroundColor = "gray";
				row2_col2.style.color = "white";
				row2_col2.style.borderRadius = "0 5px 5px 0";
				const row2_col2_span1 = document.createElement("div");
				row2_col2_span1.innerText = "1:1대화";
				row2_col2_span1.onclick = () => {
					if(row2_col2.style.backgroundColor === "gray") {
						row2_col2.style.backgroundColor = "black";
						row2_col2.style.color = "white";
						row2_col1.style.backgroundColor = "gray";
						row2_col1.style.color = "white";
					}else {
						row2_col2.style.backgroundColor = "gray";
						row2_col2.style.color = "white";
						row2_col1.style.backgroundColor = "black";
						row2_col1.style.color = "white";
					}
						
					const chatingList = document.getElementById("chatingList");
					chatingList.innerHTML = "";
					viewNumber = 1;
					oneToOne()
					
					console.log("뷰넘버 : " + viewNumber);
				}
				
				row2_col2.appendChild(row2_col2_span1);
				row2.appendChild(row2_col1);
				row2.appendChild(row2_col2);
				
				body_div_container.appendChild(row2);
				
				const row99 = document.createElement("div");
				row99.style.height = "420px";
				row99.classList.add("row");
				const col99 = document.createElement("div");
				col99.classList.add("col");
				col99.id = "chatingList";
				
				/* for 파티리스트 */
					if(isFirstLoad) {
						console.log("isFirstLoad 실행전")
						groupList();							
						isFirstLoad = false;
						console.log("isFirstLoad 실행후")
						
					}
				
					row99.appendChild(col99);
					body_div_container.appendChild(row99)
				
					body_div.appendChild(body_div_container);
					div2.appendChild(body_div);
					div1.appendChild(div2);
					divMain.appendChild(div1);
					
					const chatModalBox = document.getElementById("chatModalBox");
					chatModalBox.appendChild(divMain);
	}
	}
	
	xhr.open("get", "./chatInformation?id=" + postId);
	xhr.send();
	}
			
			function initializeChatModal() {
				const resetContainer = document.getElementById("resetContainer");
			    resetContainer.innerHTML = "";
			    console.log("재진입 리셋실행")
				const xhr = new XMLHttpRequest();
				xhr.onreadystatechange = function() {
					if (xhr.readyState == 4 && xhr.status == 200) {
						const response = JSON.parse(xhr.responseText);

					const div3 = document.createElement("div");
					div3.classList.add("modal-header", "p-0", "m-0");
					div3.style.overflowX = "auto";
					const row1 = document.createElement("div");
					row1.classList.add("row", "mt-1");
					const row1_col1 = document.createElement("div");
					row1_col1.classList.add("col-12");
					const row1_col1_row1 = document.createElement("div");
					row1_col1_row1.classList.add("row");
					const row1_col1_row1_col1 = document.createElement("div");
					row1_col1_row1_col1.classList.add("col");
					const row1_col1_row1_col1_span = document.createElement("span");
					row1_col1_row1_col1_span.classList.add("ms-3");
					row1_col1_row1_col1_span.style.color = "gray";
					row1_col1_row1_col1_span.style.fontSize = "13px";
					row1_col1_row1_col1_span.innerText = "동행 대화 참여자";
					
					row1_col1_row1_col1.appendChild(row1_col1_row1_col1_span);
					row1_col1_row1.appendChild(row1_col1_row1_col1);
					row1_col1.appendChild(row1_col1_row1);
					
					/* for 파티참가 유저 리스트 */
					response.partyList.forEach(function(item){
						
						const row1_col1_row2 = document.createElement("div");
						row1_col1_row2.classList.add("row", "mt-2");
						row1_col1_row2.id = "postPartyUserBox";
						row1_col1_row2.style.float = "left";
						
						const row1_col1_row2_col1 = document.createElement("div");
						row1_col1_row2_col1.classList.add("col");
						row1_col1_row2_col1.onclick = () => {
							viewNumber = 1;
							insertOneChat(item.id) /* 1:1대화방 인서트 */
							/* 채팅방 보여주기 */
						}
						
						const row1_col1_row2_col1_div = document.createElement("div");
						row1_col1_row2_col1_div.style.width = "80px";
						row1_col1_row2_col1_div.style.justifyContent = "center";
						row1_col1_row2_col1_div.style.textAlign = "center";
						row1_col1_row2_col1_div.style.alignItems = "center";
						
						const row1_col1_row2_col1_div_img = document.createElement("img");
						row1_col1_row2_col1_div_img.src = "/uploadFiles/" + item.profile_img;/* "파티참여자사진"; */
						row1_col1_row2_col1_div_img.style.height = "50px";
						row1_col1_row2_col1_div_img.style.width = "50px";
						row1_col1_row2_col1_div_img.style.borderRadius = "50%";
						
						const row1_col1_row2_col1_div_p = document.createElement("div");
						row1_col1_row2_col1_div_p.classList.add("mt-1");
						row1_col1_row2_col1_div_p.style.fontSize = "16px";
						row1_col1_row2_col1_div_p.innerText = item.user_name;
						
						row1_col1_row2_col1_div.appendChild(row1_col1_row2_col1_div_img);
						row1_col1_row2_col1_div.appendChild(row1_col1_row2_col1_div_p);
						
						row1_col1_row2_col1.appendChild(row1_col1_row2_col1_div);
						
						row1_col1_row2.appendChild(row1_col1_row2_col1);
						row1_col1.appendChild(row1_col1_row2);
						
						row1.appendChild(row1_col1);
						div3.appendChild(row1);
						/* modal-content에 */
						resetContainer.appendChild(div3);
					
					});
					
					const body_div = document.createElement("div");
					body_div.classList.add("modal-body", "p-0", "m-0");
					const body_div_container = document.createElement("div");
					body_div_container.classList.add("container-fluid");
					body_div_container.id = "body_div_container";
					
					const row2 = document.createElement("div");
					row2.classList.add("row", "mt-1");
					const row2_col1 = document.createElement("div");
					row2_col1.classList.add("col", "text-center", "ms-4", "pt-1", "pb-1");
					if(viewNumber === 0) {
						row2_col1.style.backgroundColor = "black";
						row2_col1.style.color = "white";	
					}else {
						row2_col1.style.backgroundColor = "gray";
						row2_col1.style.color = "white";
					}
					
					row2_col1.style.borderRadius = "5px 0 0 5px";
					const row2_col1_span1 = document.createElement("div");
					row2_col1_span1.innerText = "그룹대화";
					row2_col1_span1.onclick = () => {
						viewNumber = 0;
							row2_col1.style.backgroundColor = "black";
							row2_col1.style.color = "white";
							row2_col2.style.backgroundColor = "gray";		
							row2_col2.style.color = "white";
						
						const chatingList = document.getElementById("chatingList");
						chatingList.innerHTML = "";
						groupList()
					}
					
					row2_col1.appendChild(row2_col1_span1);
					
					const row2_col2 = document.createElement("div");
					row2_col2.classList.add("col", "text-center", "me-4", "pt-1", "pb-1");
					if(viewNumber === 1) {
						console.log("이거확인")
						row2_col2.style.backgroundColor = "black";
						row2_col2.style.color = "white";
					}else {
						console.log("저거확인")
						row2_col2.style.backgroundColor = "gray";
						row2_col2.style.color = "white";	
					}
					
					row2_col2.style.borderRadius = "0 5px 5px 0";
					const row2_col2_span1 = document.createElement("div");
					row2_col2_span1.innerText = "1:1대화";
					row2_col2_span1.onclick = () => {
						viewNumber = 1;
							row2_col2.style.backgroundColor = "black";		
							row2_col2.style.color = "white";
							row2_col1.style.backgroundColor = "gray";
							row2_col1.style.color = "white";		
						const chatingList = document.getElementById("chatingList");
						chatingList.innerHTML = "";
						oneToOne()
					}
					
					row2_col2.appendChild(row2_col2_span1);
					row2.appendChild(row2_col1);
					row2.appendChild(row2_col2);
					
					body_div_container.appendChild(row2);
					
					const row99 = document.createElement("div");
					row99.style.height = "417px";
					row99.classList.add("row");
					const col99 = document.createElement("div");
					col99.classList.add("col");
					col99.id = "chatingList";
					
					if(viewNumber === 0) {
						groupList();	
					}else {
						oneToOne();
					}

					row99.appendChild(col99);
					body_div_container.appendChild(row99)
				
					body_div.appendChild(body_div_container);
					resetContainer.appendChild(body_div);
				}
			}
		
			xhr.open("get", "./chatInformation?id=" + postId);
			xhr.send();
		}
			
			
			function groupList() {
				
				const xhr = new XMLHttpRequest();
				xhr.onreadystatechange = function() {
					if (xhr.readyState == 4 && xhr.status == 200) {
						const response = JSON.parse(xhr.responseText);
						const row3 = document.createElement("div");
						row3.classList.add("row", "mt-4");
						row3.style.height = "390px";
						row3.style.overflowY = "auto";
						row3.id = "row3";
						
						const row3_col = document.createElement("div");
						row3_col.classList.add("col-12");
						row3_col.id = "chatRoomListBox";
						
					response.list.forEach(function(item){
						
						const teamDiv = document.createElement("div");
						teamDiv.classList.add("mb-3");
						teamDiv.id = "teamDiv" + item.postChatGroupDto.post_id;
						teamDiv.addEventListener('mouseover', function(){
							const backGround = document.getElementById("teamDiv" + item.postChatGroupDto.post_id);
							/* backGround.style.backgroundColor = "rgb(251, 251, 251)"; */
							backGround.style.backgroundColor = "#f0f0f0";
						})
						teamDiv.addEventListener('mouseout', function(){
							const backGround = document.getElementById("teamDiv" + item.postChatGroupDto.post_id);
							backGround.style.backgroundColor = "white";
						})
						teamDiv.onclick = () => {
							chatDetail(item.postChatGroupDto.post_id, item.postChatGroupDto.title);
							readPostId = item.postChatGroupDto.post_id;
						}
						const teamDiv_row = document.createElement("div");
						teamDiv_row.classList.add("row");
						const teamDiv_row_col1 = document.createElement("div");
						teamDiv_row_col1.classList.add("col-2", "ps-3", "pt-2"); // 채팅클릭 넓이
						const teamDiv_row_col1_img = document.createElement("img");
						teamDiv_row_col1_img.src = "/uploadFiles/" + item.postChatGroupDto.profile_img;
						teamDiv_row_col1_img.style.height = "50px";
						teamDiv_row_col1_img.style.width = "50px";
						teamDiv_row_col1_img.style.borderRadius = "50%";
						
						teamDiv_row_col1.appendChild(teamDiv_row_col1_img);
						
						const teamDiv_row_col2 = document.createElement("div");
						teamDiv_row_col2.classList.add("col-10");
						
						const maxTitleLength = 23; // 최대 글자수
						const teamDiv_row_col2_p = document.createElement("p");
						teamDiv_row_col2_p.classList.add("p-0", "m-0", "pt-1");
						const oriTitle = item.postChatGroupDto.title;
						const titleText = oriTitle.length > maxTitleLength ? oriTitle.substring(0, maxTitleLength) + "..." : oriTitle; 
						teamDiv_row_col2_p.innerText = "[동행]" + titleText
						const teamDiv_row_col2_small = document.createElement("small");
						teamDiv_row_col2_small.classList.add("p-0", "m-0");
						teamDiv_row_col2_small.style.color = "gray";
						const teamDiv_row_col2_small2 = document.createElement("small");
						teamDiv_row_col2_small2.classList.add("float-end");
						
						if(item.count) { 
							teamDiv_row_col2_small2.style.width = "20px";
							teamDiv_row_col2_small2.style.height = "20px";
							teamDiv_row_col2_small2.style.lineHeight = "20px";
							teamDiv_row_col2_small2.style.borderRadius = "50%";
							teamDiv_row_col2_small2.style.backgroundColor = "#e00245";
							teamDiv_row_col2_small2.style.color = "white";
							teamDiv_row_col2_small2.style.display = "inline-flex";
							teamDiv_row_col2_small2.style.justifyContent = "center";
							teamDiv_row_col2_small2.style.alignItems = "center";
							teamDiv_row_col2_small2.style.borderRadius = "50%";
							teamDiv_row_col2_small2.style.backgroundColor = "#e00245";
							teamDiv_row_col2_small2.style.color = "white";
							teamDiv_row_col2_small2.innerText = item.count;
						}
						if(item.postChatDto) {
							const maxChatLength = 25;
							const oriChat = item.postChatDto.chating;
							const chatText = oriChat.length > maxChatLength ? oriChat.substring(0, maxChatLength) + "..." : oriChat;
							
							teamDiv_row_col2_small.innerText = chatText;
						}else {
							teamDiv_row_col2_small.innerText = '';
						}
						
						teamDiv_row_col2.appendChild(teamDiv_row_col2_p);
							teamDiv_row_col2.appendChild(teamDiv_row_col2_small);
							teamDiv_row_col2.appendChild(teamDiv_row_col2_small2);
						teamDiv_row.appendChild(teamDiv_row_col1);
						teamDiv_row.appendChild(teamDiv_row_col2);
						
						teamDiv.appendChild(teamDiv_row);
						
						const teamDiv_row2 = document.createElement("div");
						teamDiv_row2.classList.add("row");
						const teamDiv_row2_div = document.createElement("div");
						teamDiv_row2_div.classList.add("col", "text-end", "me-1", "mb-1");
						const teamDiv_row2_div_small = document.createElement("small");
						teamDiv_row2_div_small.style.color = "gray";
						
						if(item.postChatDto) {
							const inputDate = new Date(item.postChatDto.reg_date);
							   
							   var monthNames = [
							     "01", "02", "03", "04", "05", "06",
							     "07", "08", "09", "10", "11", "12"
							   ];

							   var dayNames = [
							     "일", "월", "화", "수", "목", "금", "토"
							   ];

							   var smonth = monthNames[inputDate.getMonth()]; // 월
							   var sday = inputDate.getDate().toString().padStart(2, '0'); // 일
							   var sdayOfWeek = dayNames[inputDate.getDay()]; // 요일
							   var syear = inputDate.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기

							   var shour = inputDate.getHours().toString().padStart(2, '0'); // 시간
							   var sminute = inputDate.getMinutes().toString().padStart(2, '0'); // 분

							   var registerDate = shour + ":" + sminute; /* 시간만 변환함 추후 변경*/
							   
							teamDiv_row2_div_small.innerText = registerDate; 	
						}else {
							teamDiv_row2_div_small.innerText = '';
						}
							teamDiv_row2_div.appendChild(teamDiv_row2_div_small);
							
						teamDiv_row2.appendChild(teamDiv_row2_div);
						teamDiv.appendChild(teamDiv_row2);
						
						
						row3_col.appendChild(teamDiv);
						row3.appendChild(row3_col);
						
						
						const chatingList = document.getElementById("chatingList");
						chatingList.appendChild(row3);
						
					});
				}
			}
			
				xhr.open("get", "./groupChatInfo?id=" + postId);
				xhr.send();
			}
		
		
			
		
		function chatDetail(readPostId, postTitle) {
			console.log("chatDetail postId : " + readPostId)
			const resetContainer = document.getElementById("resetContainer");
			resetContainer.innerHTML = "";
			console.log("초기화 완료");
	
			const divHeader = document.createElement("div");
			divHeader.classList.add("modal-header", "p-0", "m-0");
			divHeader.style.float = "left";
			
			const container1 = document.createElement("div");
			container1.classList.add("container-fluid");
			const container1_row = document.createElement("div");
			container1_row.classList.add("row");
			const container1_row_col1 = document.createElement("div");
			container1_row_col1.classList.add("col-1");
			const container1_row_col1_i = document.createElement("i");
			container1_row_col1_i.classList.add("bi", "bi-chevron-left");
			container1_row_col1_i.style.fontSize = "21px";
			container1_row_col1_i.onclick = () => {
				/* 뒤로가기 버튼 구현 */
			    initializeChatModal()
			    clearInterval(intervalId);
			}
			
			container1_row_col1.appendChild(container1_row_col1_i);
						
			const container1_row_col2 = document.createElement("div");
			container1_row_col2.classList.add("col-9", "ms-3", "p-0", "pt-1");
			container1_row_col2.style.paddingTop = "8px";
			
			const container1_row_col2_span1 = document.createElement("span");
			container1_row_col2_span1.fontSize = "23px"
			
			const maxTitleLength = 21; // 최대 글자수
			const oriTitle = postTitle;
			const titleText = oriTitle.length > maxTitleLength ? oriTitle.substring(0, maxTitleLength) + "..." : oriTitle; 
			
			
			container1_row_col2_span1.innerText = "[동행] " + titleText;
			
			const container1_row_col2_span2 = document.createElement("span");
			/* 파티참여 카운트 */
			/* container1_row_col2_span2.innerText = response.personCount; */
			
			container1_row_col2.appendChild(container1_row_col2_span1);
			container1_row_col2.appendChild(container1_row_col2_span2);
			
			const container1_row_col3 = document.createElement("div");
			container1_row_col3.classList.add("col");
			const container1_row_col3_i = document.createElement("i");
			container1_row_col3_i.classList.add("bi", "bi-list");
			container1_row_col3_i.style.fontSize = "21px";
			
			container1_row_col3.appendChild(container1_row_col3_i);
			
			container1_row.appendChild(container1_row_col1);
			container1_row.appendChild(container1_row_col2);
			container1_row.appendChild(container1_row_col3);
			
			container1.appendChild(container1_row);
			divHeader.appendChild(container1);
			
			const divBody = document.createElement("div");
			divBody.classList.add("modal-body", "p-0", "m-0");
			const container2 = document.createElement("div");
			container2.style.height = "483px";
			container2.style.overflowY = "auto";
			/* 채팅방 높이수정 */
			
			const container2_chatView = document.createElement("div");
			container2_chatView.classList.add("chatView");
			container2_chatView.id = "chatContainer";
			
			
			/* 채팅방 리로드 */
			updateChatView(readPostId);
			
			
			
			container2.appendChild(container2_chatView);
			
			
			const chatInputRow = document.createElement("div");
			chatInputRow.classList.add("row", "m-0", "p-0");
			
			const chatInputRow_col1 = document.createElement("div");
			chatInputRow_col1.classList.add("col-2", "p-0", "m-0", "text-center");
			chatInputRow_col1.style.justifyContent = "center";
			chatInputRow_col1.style.height = "52px";
			chatInputRow_col1.style.alignItems = "center";
			chatInputRow_col1.style.display = "flex";
			const chatInputRow_col1_i = document.createElement("i");
			chatInputRow_col1_i.classList.add("bi", "bi-plus-lg");
			chatInputRow_col1_i.style.fontSize = "22px";
			chatInputRow_col1.appendChild(chatInputRow_col1_i);

			const chatInputRow_col2 = document.createElement("div");			
			chatInputRow_col2.classList.add("col-10", "m-0", "p-0");
			chatInputRow_col2.style.alignItems = "center";
			chatInputRow_col2.style.display = "flex";
			const chatInputRow_col2_label = document.createElement("label");
			const chatInputRow_col2_label_input = document.createElement("input");
			chatInputRow_col2_label_input.classList.add("form-control");
			chatInputRow_col2_label_input.style.width = "310px";
			chatInputRow_col2_label_input.style.borderRadius = "15px";
			chatInputRow_col2_label_input.type = "text";
			chatInputRow_col2_label_input.placeholder = "메세지를 입력해주세요.";
			chatInputRow_col2_label_input.id = "chatInputBox";
			chatInputRow_col2_label_input.addEventListener("keyup", function(event) {
		        if (event.key === "Enter" && !event.shiftKey) {
		        	
		            event.preventDefault();

		            const inputValue = chatInputBox.value;
		            if (inputValue !== "") {
		                insertChating(inputValue);
		                chatInputBox.value = "";
		            }
		        }
		    });
			const chatInputRow_col2_label_i = document.createElement("i");
			chatInputRow_col2_label_i.classList.add("bi", "bi-check-square-fill");
			chatInputRow_col2_label_i.style.position = "absolute";
			chatInputRow_col2_label_i.style.bottom = "7px";
			chatInputRow_col2_label_i.style.right = "42px";
			chatInputRow_col2_label_i.style.fontSize = "25px";
			chatInputRow_col2_label_i.onclick = () => {
				/* 채팅 인서트 */
				const inputValue = chatInputRow_col2_label_input.value;
				if(inputValue === ''){
					return;
				}else {
					insertChating(inputValue);
					chatInputRow_col2_label_input.value = '';	
				}
				
			}
			
			chatInputRow_col2_label.appendChild(chatInputRow_col2_label_input);
			chatInputRow_col2_label.appendChild(chatInputRow_col2_label_i);
			chatInputRow_col2.appendChild(chatInputRow_col2_label);
			
			
			chatInputRow.appendChild(chatInputRow_col1);
			chatInputRow.appendChild(chatInputRow_col2);
			
			divBody.appendChild(container2);
			divBody.appendChild(chatInputRow);
			resetContainer.appendChild(divHeader);
			resetContainer.appendChild(divBody);
			
		}
		
		
		
		function updateChatView(readPostId) {
			intervalId = setInterval(function(){
			const xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					const response = JSON.parse(xhr.responseText);
					const container2_chatView = document.getElementById("chatContainer");
					if(container2_chatView !== null) {
						container2_chatView.innerHTML = "";	
					}
					response.list.forEach(function(item){
				
				   const inputDate = new Date(item.postChatDto.reg_date);
				   
				   var monthNames = [
				     "01", "02", "03", "04", "05", "06",
				     "07", "08", "09", "10", "11", "12"
				   ];

				   var dayNames = [
				     "일", "월", "화", "수", "목", "금", "토"
				   ];

				   var smonth = monthNames[inputDate.getMonth()]; // 월
				   var sday = inputDate.getDate().toString().padStart(2, '0'); // 일
				   var sdayOfWeek = dayNames[inputDate.getDay()]; // 요일
				   var syear = inputDate.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기

				   var shour = inputDate.getHours().toString().padStart(2, '0'); // 시간
				   var sminute = inputDate.getMinutes().toString().padStart(2, '0'); // 분

				   var registerDate = shour + ":" + sminute; /* 시간만 변환함 추후 변경*/
				   
				if(mySessionId === item.userDto.id){
					/* if chat T id == sessionId */
					const container2_chatView_group2 = document.createElement("div");
					container2_chatView_group2.classList.add("chatGroup2");
					const container2_chatView_row2 = document.createElement("div");
					container2_chatView_row2.classList.add("row", "mt-3", "p-0", "m-0");
					const container2_chatView_row2_col = document.createElement("div");
					container2_chatView_row2_col.classList.add("col-11");
					container2_chatView_row2_col.style.width = "80%";
					container2_chatView_row2_col.style.marginLeft = "auto";
					const container2_chatView_row2_col_row = document.createElement("div");
					container2_chatView_row2_col_row.classList.add("row");
					const container2_chatView_row2_col_row_col = document.createElement("div");
					container2_chatView_row2_col_row_col.classList.add("col", "p-0", "m-0");
					const container2_chatView_row2_col_row_col_div = document.createElement("div");
					container2_chatView_row2_col_row_col_div.style.display = "flex";
					container2_chatView_row2_col_row_col_div.style.alignItems = "flex-end";
					container2_chatView_row2_col_row_col_div.style.justifyContent = "flex-end";
					container2_chatView_row2_col_row_col_div.style.width = "100%";
					const container2_chatView_row2_col_row_col_div_small = document.createElement("small");
					container2_chatView_row2_col_row_col_div_small.classList.add("me-1");
					container2_chatView_row2_col_row_col_div_small.innerText = registerDate;
					const container2_chatView_row2_col_row_col_div_small2 = document.createElement("small");
					container2_chatView_row2_col_row_col_div_small2.classList.add("me-2");
					container2_chatView_row2_col_row_col_div_small2.style.fontSize = "13px";
					container2_chatView_row2_col_row_col_div_small2.style.color = "#deb512";
					if(item.count) {
						container2_chatView_row2_col_row_col_div_small2.innerText = item.count;
					}
					
					
					const container2_chatView_row2_col_row_col_div_span = document.createElement("span");
					container2_chatView_row2_col_row_col_div_span.classList.add("ps-2", "pe-2", "pt-1", "pb-1", "me-2");
					container2_chatView_row2_col_row_col_div_span.style.backgroundColor = "yellow";
					container2_chatView_row2_col_row_col_div_span.style.borderRadius = "7px";
					container2_chatView_row2_col_row_col_div_span.innerText = item.postChatDto.chating;
					
					container2_chatView_row2_col_row_col_div.appendChild(container2_chatView_row2_col_row_col_div_small2);
					container2_chatView_row2_col_row_col_div.appendChild(container2_chatView_row2_col_row_col_div_small);
					container2_chatView_row2_col_row_col_div.appendChild(container2_chatView_row2_col_row_col_div_span);
					
					container2_chatView_row2_col_row_col.appendChild(container2_chatView_row2_col_row_col_div);
					container2_chatView_row2_col_row.appendChild(container2_chatView_row2_col_row_col);
					container2_chatView_row2_col.appendChild(container2_chatView_row2_col_row);
					container2_chatView_row2.appendChild(container2_chatView_row2_col);
				
					container2_chatView_group2.appendChild(container2_chatView_row2);
					
					if(container2_chatView.appendChild(container2_chatView_group2) !== null){
						container2_chatView.appendChild(container2_chatView_group2);	
					}
					
				}else {
					const container2_chatView_group1 = document.createElement("div");
					container2_chatView_group1.classList.add("chatGroup1");
					const container2_chatView_row1 = document.createElement("div");
					container2_chatView_row1.classList.add("row", "mt-3");
					
					const container2_chatView_row1_col1 = document.createElement("div");
					container2_chatView_row1_col1.classList.add("col-1", "ms-2");
					const container2_chatView_row1_col1_img = document.createElement("img");
					container2_chatView_row1_col1_img.src = "/uploadFiles/" + item.userDto.profile_img; /* 채팅친 유저 사진 */
					container2_chatView_row1_col1_img.style.height = "40px";
					container2_chatView_row1_col1_img.style.width = "40px";
					container2_chatView_row1_col1_img.style.borderRadius = "50%";
					
					container2_chatView_row1_col1.appendChild(container2_chatView_row1_col1_img);
					container2_chatView_row1.appendChild(container2_chatView_row1_col1);
					
					const container2_chatView_row1_col2 = document.createElement("div");
					container2_chatView_row1_col2.classList.add("col-11", "ps-4");
					container2_chatView_row1_col2.style.width = "80%";
					const container2_chatView_row1_col2_row1 = document.createElement("div");
					container2_chatView_row1_col2_row1.classList.add("row");
					const container2_chatView_row1_col2_row1_col = document.createElement("div");
					container2_chatView_row1_col2_row1_col.classList.add("col");
					const container2_chatView_row1_col2_row1_col_span = document.createElement("span");
					container2_chatView_row1_col2_row1_col_span.innerText = item.userDto.user_name;
					container2_chatView_row1_col2_row1_col.appendChild(container2_chatView_row1_col2_row1_col_span);
					container2_chatView_row1_col2_row1.appendChild(container2_chatView_row1_col2_row1_col);
					container2_chatView_row1_col2.appendChild(container2_chatView_row1_col2_row1);
					
					const container2_chatView_row1_col2_row2 = document.createElement("div");
					container2_chatView_row1_col2_row2.classList.add("row");
					const container2_chatView_row1_col2_row2_div = document.createElement("div");
					container2_chatView_row1_col2_row2_div.style.display = "flex";
					container2_chatView_row1_col2_row2_div.style.alignItems = "flex-end";
					const container2_chatView_row1_col2_row2_div_span = document.createElement("span");
					container2_chatView_row1_col2_row2_div_span.classList.add("ps-2", "pe-2", "pt-1", "pb-1", "me-2");
					container2_chatView_row1_col2_row2_div_span.style.backgroundColor = "yellow";
					container2_chatView_row1_col2_row2_div_span.style.borderRadius = "7px";
					container2_chatView_row1_col2_row2_div_span.innerText = item.postChatDto.chating;
					const container2_chatView_row1_col2_row2_div_small = document.createElement("small");
					container2_chatView_row1_col2_row2_div_small.classList.add("ms-1");
					container2_chatView_row1_col2_row2_div_small.innerText = registerDate;
					const container2_chatView_row1_col2_row2_div_small2 = document.createElement("small");
					container2_chatView_row1_col2_row2_div_small2.classList.add("ms-2");
					container2_chatView_row1_col2_row2_div_small2.style.fontSize = "13px";
					container2_chatView_row1_col2_row2_div_small2.style.color = "#deb512";
					if(item.count){
						container2_chatView_row1_col2_row2_div_small2.innerText = item.count;
					}
					
					container2_chatView_row1_col2_row2_div.appendChild(container2_chatView_row1_col2_row2_div_span);
					container2_chatView_row1_col2_row2_div.appendChild(container2_chatView_row1_col2_row2_div_small2);
					container2_chatView_row1_col2_row2_div.appendChild(container2_chatView_row1_col2_row2_div_small);
					container2_chatView_row1_col2_row2.appendChild(container2_chatView_row1_col2_row2_div);
					container2_chatView_row1_col2.appendChild(container2_chatView_row1_col2_row2);
					
					container2_chatView_row1.appendChild(container2_chatView_row1_col2);
					container2_chatView_group1.appendChild(container2_chatView_row1);
					container2_chatView.appendChild(container2_chatView_group1);
					
						
				}
			});
					container2_chatView.lastElementChild.scrollIntoView();
		}
				
	}
			
	xhr.open("get", "./chatList?post_id=" + readPostId);
	xhr.send();
	}, 1000);  //10초 셋팅 */
}
	
		
		function insertChating(inputValue) {
			console.log("텍스트!!!!!!!! : " + inputValue);
			const xhr = new XMLHttpRequest();
				xhr.onreadystatechange = function () {
				if(xhr.readyState == 4 && xhr.status == 200) {
					const response = JSON.parse(xhr.responseText);
					
					
			      }         
			   }
			
			
			xhr.open("post", "./insertChat");
			xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			xhr.send("post_id=" + readPostId + "&user_id=" + mySessionId + "&chating=" + inputValue); 
		}
			
	
		
	/*    ------------------------------------------------- 1:1 -------------------------------------------------    */	
	/*    ------------------------------------------------- 1:1 -------------------------------------------------    */
	/*    ------------------------------------------------- 1:1 -------------------------------------------------    */
	/*    ------------------------------------------------- 1:1 -------------------------------------------------    */
	/*    ------------------------------------------------- 1:1 -------------------------------------------------    */
						
		function insertOneChat(receiveId) {
			const xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					const response = JSON.parse(xhr.responseText);
					const receiveDto = response.check.receiveDto;
					const sendDto = response.check.sendDto;
					const chatRoomId = response.check.chatRoom.id;
					if(sendDto.id === mySessionId) {
						readOneChatId = chatRoomId;
						oneChatDetail(chatRoomId, receiveDto.user_name)
					}else {
						readOneChatId = chatRoomId;
						oneChatDetail(chatRoomId, sendDto.user_name)
					}
				}
			}

			xhr.open("get", "./insertOneChatRoom?send_id=" + mySessionId + "&receive_id=" + receiveId);
			xhr.send();

		}
		
		
		/* 1:1 대화방 리스트 */
		function oneToOne() {
			const xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					const response = JSON.parse(xhr.responseText);
					const row3 = document.createElement("div");
					row3.classList.add("row", "mt-4");
					row3.style.height = "390px";
					row3.style.overflowY = "auto";
					row3.id = "row3";
					
					const row3_col = document.createElement("div");
					row3_col.classList.add("col-12");
					row3_col.id = "chatRoomListBox";
			response.list.forEach(function(item){
				
				
				const teamDiv = document.createElement("div");
				teamDiv.classList.add("mb-3");
				teamDiv.id = "teamDiv" + item.chatRoomDto.id;
				teamDiv.addEventListener('mouseover', function(){
					const backGround = document.getElementById("teamDiv" + item.chatRoomDto.id);
					backGround.style.backgroundColor = "#f0f0f0";
				})
				teamDiv.addEventListener('mouseout', function(){
					const backGround = document.getElementById("teamDiv" + item.chatRoomDto.id);
					backGround.style.backgroundColor = "white";
				})
				teamDiv.onclick = () => {
					if(mySessionId === item.sendDto.id){
						oneChatDetail(item.chatRoomDto.id, item.receiveDto.user_name);	
					}else {
						oneChatDetail(item.chatRoomDto.id, item.sendDto.user_name);
					}
						readOneChatId = item.chatRoomDto.id;
				}
				const teamDiv_row = document.createElement("div");
				teamDiv_row.classList.add("row");
				const teamDiv_row_col1 = document.createElement("div");
				teamDiv_row_col1.classList.add("col-2", "ps-3", "pt-2");
				const teamDiv_row_col1_img = document.createElement("img");
				if(mySessionId === item.sendDto.id){
					teamDiv_row_col1_img.src = "/uploadFiles/" + item.receiveDto.profile_img;	
				}else {
					teamDiv_row_col1_img.src = "/uploadFiles/" + item.sendDto.profile_img;
				}
				
				teamDiv_row_col1_img.style.height = "50px";
				teamDiv_row_col1_img.style.width = "50px";
				teamDiv_row_col1_img.style.borderRadius = "50%";
				
				teamDiv_row_col1.appendChild(teamDiv_row_col1_img);
				
				const teamDiv_row_col2 = document.createElement("div");
				teamDiv_row_col2.classList.add("col-10");
				const teamDiv_row_col2_p = document.createElement("p");
				teamDiv_row_col2_p.classList.add("p-0", "m-0", "pt-1", "ms-3");
				
				if(mySessionId === item.sendDto.id){
					teamDiv_row_col2_p.innerText = item.receiveDto.user_name;	
				}else {
					teamDiv_row_col2_p.innerText = item.sendDto.user_name;
				}
				 
				const teamDiv_row_col2_small = document.createElement("small");
				teamDiv_row_col2_small.classList.add("p-0", "m-0", "ms-3");
				teamDiv_row_col2_small.style.color = "gray";
				
				const teamDiv_row_col2_small2 = document.createElement("small");
				teamDiv_row_col2_small2.classList.add("float-end")
				
				if(item.count) {
					teamDiv_row_col2_small2.style.width = "20px";
					teamDiv_row_col2_small2.style.height = "20px";
					teamDiv_row_col2_small2.style.lineHeight = "20px";
					teamDiv_row_col2_small2.style.borderRadius = "50%";
					teamDiv_row_col2_small2.style.backgroundColor = "#e00245";
					teamDiv_row_col2_small2.style.color = "white";
					teamDiv_row_col2_small2.style.display = "inline-flex";
					teamDiv_row_col2_small2.style.justifyContent = "center";
					teamDiv_row_col2_small2.style.alignItems = "center";
					teamDiv_row_col2_small2.style.borderRadius = "50%";
					teamDiv_row_col2_small2.style.backgroundColor = "#e00245";
					teamDiv_row_col2_small2.style.color = "white";
					teamDiv_row_col2_small2.innerText = item.count;
				}
				
				if(item.newChat) {
					const maxChatLength = 26;
					const oriChat = item.newChat.chating;
					const chatText = oriChat.length > maxChatLength ? oriChat.substring(0, maxChatLength) + "..." : oriChat;
					
					teamDiv_row_col2_small.innerText = chatText;
				}else {
					teamDiv_row_col2_small.innerText = '';
				}

				teamDiv_row_col2.appendChild(teamDiv_row_col2_p);
					teamDiv_row_col2.appendChild(teamDiv_row_col2_small);
					teamDiv_row_col2.appendChild(teamDiv_row_col2_small2);
				teamDiv_row.appendChild(teamDiv_row_col1);
				teamDiv_row.appendChild(teamDiv_row_col2);
				
				teamDiv.appendChild(teamDiv_row);
				
				const teamDiv_row2 = document.createElement("div");
				teamDiv_row2.classList.add("row");
				const teamDiv_row2_div = document.createElement("div");
				teamDiv_row2_div.classList.add("col", "text-end", "me-1", "mb-1");
				const teamDiv_row2_div_small = document.createElement("small");
				teamDiv_row2_div_small.style.color = "gray";
				if(item.newChat) {
					const inputDate = new Date(item.newChat.reg_date);
					   
					   var monthNames = [
					     "01", "02", "03", "04", "05", "06",
					     "07", "08", "09", "10", "11", "12"
					   ];

					   var dayNames = [
					     "일", "월", "화", "수", "목", "금", "토"
					   ];

					   var smonth = monthNames[inputDate.getMonth()]; // 월
					   var sday = inputDate.getDate().toString().padStart(2, '0'); // 일
					   var sdayOfWeek = dayNames[inputDate.getDay()]; // 요일
					   var syear = inputDate.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기

					   var shour = inputDate.getHours().toString().padStart(2, '0'); // 시간
					   var sminute = inputDate.getMinutes().toString().padStart(2, '0'); // 분

					   var registerDate = shour + ":" + sminute; /* 시간만 변환함 추후 변경*/
					teamDiv_row2_div_small.innerText = registerDate;
				}else {
					teamDiv_row2_div_small.innerText = '';
				}
					teamDiv_row2_div.appendChild(teamDiv_row2_div_small);	
				teamDiv_row2.appendChild(teamDiv_row2_div);
				teamDiv.appendChild(teamDiv_row2);
				
				
				row3_col.appendChild(teamDiv);
				row3.appendChild(row3_col);
				
				
				const chatingList = document.getElementById("chatingList");
				chatingList.appendChild(row3);
				
			});
		}
	}
	
		xhr.open("get", "./getOneChatRoom?user_id=" + mySessionId);
		xhr.send();
}
		
		
		
		/* 1:1 채팅 */
	
		function oneChatDetail(readOneChatId, userName) {
			console.log("oneChatDetail readOneChatId : " + readOneChatId)
			const resetContainer = document.getElementById("resetContainer");
			resetContainer.innerHTML = "";
			console.log("초기화 완료");	
			
			const divHeader = document.createElement("div");
			divHeader.classList.add("modal-header", "p-0", "m-0");
			divHeader.style.float = "left";
			
			const container1 = document.createElement("div");
			container1.classList.add("container-fluid");
			const container1_row = document.createElement("div");
			container1_row.classList.add("row");
			const container1_row_col1 = document.createElement("div");
			container1_row_col1.classList.add("col-1");
			const container1_row_col1_i = document.createElement("i");
			container1_row_col1_i.classList.add("bi", "bi-chevron-left");
			container1_row_col1_i.style.fontSize = "21px";
			container1_row_col1_i.onclick = () => {
				/* 뒤로가기 버튼 구현 */
				initializeChatModal();
			    clearInterval(intervalOneId); 
			}
			
			container1_row_col1.appendChild(container1_row_col1_i);
						
			const container1_row_col2 = document.createElement("div");
			container1_row_col2.classList.add("col-9", "ms-3", "p-0", "pt-1");
			container1_row_col2.style.paddingTop = "8px";
			
			const container1_row_col2_span1 = document.createElement("span");
			container1_row_col2_span1.innerText = userName;
			const container1_row_col2_span2 = document.createElement("span");
			/* 파티참여 카운트 */
			/* container1_row_col2_span2.innerText = response.personCount; */
			
			container1_row_col2.appendChild(container1_row_col2_span1);
			container1_row_col2.appendChild(container1_row_col2_span2);
			
			const container1_row_col3 = document.createElement("div");
			container1_row_col3.classList.add("col");
			const container1_row_col3_i = document.createElement("i");
			container1_row_col3_i.classList.add("bi", "bi-list");
			container1_row_col3_i.style.fontSize = "21px";
			
			container1_row_col3.appendChild(container1_row_col3_i);
			
			container1_row.appendChild(container1_row_col1);
			container1_row.appendChild(container1_row_col2);
			container1_row.appendChild(container1_row_col3);
			
			container1.appendChild(container1_row);
			divHeader.appendChild(container1);
			
			const divBody = document.createElement("div");
			divBody.classList.add("modal-body", "p-0", "m-0");
			const container2 = document.createElement("div");
			container2.style.height = "483px";
			container2.style.overflowY = "auto";
			
			
			const container2_chatView = document.createElement("div");
			container2_chatView.classList.add("chatView");
			container2_chatView.id = "chatContainer";
			
			
			/* 채팅방 리로드 */
			updateOneChatView(readOneChatId);
			
			
			
			container2.appendChild(container2_chatView);
			
			
			const chatInputRow = document.createElement("div");
			chatInputRow.classList.add("row", "m-0", "p-0");
			
			const chatInputRow_col1 = document.createElement("div");
			chatInputRow_col1.classList.add("col-2", "p-0", "m-0", "text-center");
			chatInputRow_col1.style.justifyContent = "center";
			chatInputRow_col1.style.height = "52px";
			chatInputRow_col1.style.alignItems = "center";
			chatInputRow_col1.style.display = "flex";
			const chatInputRow_col1_i = document.createElement("i");
			chatInputRow_col1_i.classList.add("bi", "bi-plus-lg");
			chatInputRow_col1_i.style.fontSize = "22px";
			chatInputRow_col1.appendChild(chatInputRow_col1_i);

			const chatInputRow_col2 = document.createElement("div");			
			chatInputRow_col2.classList.add("col-10", "m-0", "p-0");
			chatInputRow_col2.style.alignItems = "center";
			chatInputRow_col2.style.display = "flex";
			const chatInputRow_col2_label = document.createElement("label");
			const chatInputRow_col2_label_input = document.createElement("input");
			chatInputRow_col2_label_input.classList.add("form-control");
			chatInputRow_col2_label_input.style.width = "310px";
			chatInputRow_col2_label_input.style.borderRadius = "15px";
			chatInputRow_col2_label_input.type = "text";
			chatInputRow_col2_label_input.placeholder = "메세지를 입력해주세요.";
			chatInputRow_col2_label_input.id = "chatInputBox";
			chatInputRow_col2_label_input.addEventListener("keyup", function(event) {
		        if (event.key === "Enter" && !event.shiftKey) {
		            event.preventDefault();

		            const inputValue = chatInputBox.value;
		            if (inputValue !== "") {
		            	insertOneChating(inputValue);
		                chatInputBox.value = "";
		            }
		        }
		    });
			const chatInputRow_col2_label_i = document.createElement("i");
			chatInputRow_col2_label_i.classList.add("bi", "bi-check-square-fill");
			chatInputRow_col2_label_i.style.position = "absolute";
			chatInputRow_col2_label_i.style.bottom = "7px";
			chatInputRow_col2_label_i.style.right = "42px";
			chatInputRow_col2_label_i.style.fontSize = "25px";
			chatInputRow_col2_label_i.onclick = () => {
				/* 채팅 인서트 */
				const inputValue = chatInputRow_col2_label_input.value;
				if(inputValue === ''){
					return;
				}else {
					insertOneChating(inputValue);
					chatInputRow_col2_label_input.value = '';	
				}
				
			}
			
			chatInputRow_col2_label.appendChild(chatInputRow_col2_label_input);
			chatInputRow_col2_label.appendChild(chatInputRow_col2_label_i);
			chatInputRow_col2.appendChild(chatInputRow_col2_label);
			
			
			chatInputRow.appendChild(chatInputRow_col1);
			chatInputRow.appendChild(chatInputRow_col2);
			
			divBody.appendChild(container2);
			divBody.appendChild(chatInputRow);
			resetContainer.appendChild(divHeader);
			resetContainer.appendChild(divBody);
			
		}
	
		function updateOneChatView(readOneChatId) {
			
			intervalOneId = setInterval(function(){
				
			const xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					const response = JSON.parse(xhr.responseText);
					
					const container2_chatView = document.getElementById("chatContainer");
					if(container2_chatView !== null) {
						container2_chatView.innerHTML = "";	
					}
					
					response.list.forEach(function(item){
				
				   const inputDate = new Date(item.chatDto.reg_date);
				   
				   var monthNames = [
				     "01", "02", "03", "04", "05", "06",
				     "07", "08", "09", "10", "11", "12"
				   ];

				   var dayNames = [
				     "일", "월", "화", "수", "목", "금", "토"
				   ];

				   var smonth = monthNames[inputDate.getMonth()]; // 월
				   var sday = inputDate.getDate().toString().padStart(2, '0'); // 일
				   var sdayOfWeek = dayNames[inputDate.getDay()]; // 요일
				   var syear = inputDate.getFullYear().toString().slice(-2); // 두 자리 수 연도 가져오기

				   var shour = inputDate.getHours().toString().padStart(2, '0'); // 시간
				   var sminute = inputDate.getMinutes().toString().padStart(2, '0'); // 분

				   var registerDate = shour + ":" + sminute; /* 시간만 변환함 추후 변경*/
				   
				if(mySessionId === item.userDto.id){
					/* if chat T id == sessionId */
					const container2_chatView_group2 = document.createElement("div");
					container2_chatView_group2.classList.add("chatGroup2");
					const container2_chatView_row2 = document.createElement("div");
					container2_chatView_row2.classList.add("row", "mt-3", "p-0", "m-0");
					const container2_chatView_row2_col = document.createElement("div");
					container2_chatView_row2_col.classList.add("col-11");
					container2_chatView_row2_col.style.width = "80%";
					container2_chatView_row2_col.style.marginLeft = "auto";
					const container2_chatView_row2_col_row = document.createElement("div");
					container2_chatView_row2_col_row.classList.add("row");
					const container2_chatView_row2_col_row_col = document.createElement("div");
					container2_chatView_row2_col_row_col.classList.add("col", "p-0", "m-0");
					const container2_chatView_row2_col_row_col_div = document.createElement("div");
					container2_chatView_row2_col_row_col_div.style.display = "flex";
					container2_chatView_row2_col_row_col_div.style.alignItems = "flex-end";
					container2_chatView_row2_col_row_col_div.style.justifyContent = "flex-end";
					container2_chatView_row2_col_row_col_div.style.width = "100%";
					const container2_chatView_row2_col_row_col_div_small = document.createElement("small");
					container2_chatView_row2_col_row_col_div_small.classList.add("me-1");
					container2_chatView_row2_col_row_col_div_small.innerText = registerDate;
					const container2_chatView_row2_col_row_col_div_small2 = document.createElement("small");
					container2_chatView_row2_col_row_col_div_small2.classList.add("me-2");					
					container2_chatView_row2_col_row_col_div_small2.style.fontSize = "13px"
					container2_chatView_row2_col_row_col_div_small2.style.color = "#deb512";
					if(item.count) {
						container2_chatView_row2_col_row_col_div_small2.innerText = item.count;	
					}
					const container2_chatView_row2_col_row_col_div_span = document.createElement("span");
					container2_chatView_row2_col_row_col_div_span.classList.add("ps-2", "pe-2", "pt-1", "pb-1", "me-2");
					container2_chatView_row2_col_row_col_div_span.style.backgroundColor = "yellow";
					container2_chatView_row2_col_row_col_div_span.style.borderRadius = "7px";
					container2_chatView_row2_col_row_col_div_span.innerText = item.chatDto.chating;
					
					container2_chatView_row2_col_row_col_div.appendChild(container2_chatView_row2_col_row_col_div_small2);
					container2_chatView_row2_col_row_col_div.appendChild(container2_chatView_row2_col_row_col_div_small);
					
					
					container2_chatView_row2_col_row_col_div.appendChild(container2_chatView_row2_col_row_col_div_span);
					
					container2_chatView_row2_col_row_col.appendChild(container2_chatView_row2_col_row_col_div);
					container2_chatView_row2_col_row.appendChild(container2_chatView_row2_col_row_col);
					container2_chatView_row2_col.appendChild(container2_chatView_row2_col_row);
					container2_chatView_row2.appendChild(container2_chatView_row2_col);
				
					container2_chatView_group2.appendChild(container2_chatView_row2);
					if(container2_chatView.appendChild(container2_chatView_group2) !== null){
						container2_chatView.appendChild(container2_chatView_group2);	
					}
					
					
				}else {
					const container2_chatView_group1 = document.createElement("div");
					container2_chatView_group1.classList.add("chatGroup1");
					const container2_chatView_row1 = document.createElement("div");
					container2_chatView_row1.classList.add("row", "mt-3");
					
					const container2_chatView_row1_col1 = document.createElement("div");
					container2_chatView_row1_col1.classList.add("col-1", "ms-2");
					const container2_chatView_row1_col1_img = document.createElement("img");
					container2_chatView_row1_col1_img.src = "/uploadFiles/" + item.userDto.profile_img; /* 채팅친 유저 사진 */
					container2_chatView_row1_col1_img.style.height = "40px";
					container2_chatView_row1_col1_img.style.width = "40px";
					container2_chatView_row1_col1_img.style.borderRadius = "50%";
					
					container2_chatView_row1_col1.appendChild(container2_chatView_row1_col1_img);
					container2_chatView_row1.appendChild(container2_chatView_row1_col1);
					
					const container2_chatView_row1_col2 = document.createElement("div");
					container2_chatView_row1_col2.classList.add("col-11", "ps-4");
					container2_chatView_row1_col2.style.width = "80%";
					const container2_chatView_row1_col2_row1 = document.createElement("div");
					container2_chatView_row1_col2_row1.classList.add("row");
					const container2_chatView_row1_col2_row1_col = document.createElement("div");
					container2_chatView_row1_col2_row1_col.classList.add("col");
					const container2_chatView_row1_col2_row1_col_span = document.createElement("span");
					container2_chatView_row1_col2_row1_col_span.innerText = item.userDto.user_name;
					container2_chatView_row1_col2_row1_col.appendChild(container2_chatView_row1_col2_row1_col_span);
					container2_chatView_row1_col2_row1.appendChild(container2_chatView_row1_col2_row1_col);
					container2_chatView_row1_col2.appendChild(container2_chatView_row1_col2_row1);
					
					const container2_chatView_row1_col2_row2 = document.createElement("div");
					container2_chatView_row1_col2_row2.classList.add("row");
					const container2_chatView_row1_col2_row2_div = document.createElement("div");
					container2_chatView_row1_col2_row2_div.style.display = "flex";
					container2_chatView_row1_col2_row2_div.style.alignItems = "flex-end";
					const container2_chatView_row1_col2_row2_div_span = document.createElement("span");
					container2_chatView_row1_col2_row2_div_span.classList.add("ps-2", "pe-2", "pt-1", "pb-1", "me-2");
					container2_chatView_row1_col2_row2_div_span.style.backgroundColor = "yellow";
					container2_chatView_row1_col2_row2_div_span.style.borderRadius = "7px";
					container2_chatView_row1_col2_row2_div_span.innerText = item.chatDto.chating;
					const container2_chatView_row1_col2_row2_div_small = document.createElement("small");
					container2_chatView_row1_col2_row2_div_small.classList.add("ms-1");
					container2_chatView_row1_col2_row2_div_small.innerText = registerDate;
					const container2_chatView_row1_col2_row2_div_small2 = document.createElement("small");
					container2_chatView_row1_col2_row2_div_small2.classList.add("ms-2");
					container2_chatView_row1_col2_row2_div_small2.style.fontSize = "13px";
					container2_chatView_row1_col2_row2_div_small2.style.color = "#deb512";
					if(item.count) {
						container2_chatView_row1_col2_row2_div_small2.innerText = item.count;	
					}
					
					container2_chatView_row1_col2_row2_div.appendChild(container2_chatView_row1_col2_row2_div_span);
					container2_chatView_row1_col2_row2_div.appendChild(container2_chatView_row1_col2_row2_div_small2);
					container2_chatView_row1_col2_row2_div.appendChild(container2_chatView_row1_col2_row2_div_small);
					container2_chatView_row1_col2_row2.appendChild(container2_chatView_row1_col2_row2_div);
					container2_chatView_row1_col2.appendChild(container2_chatView_row1_col2_row2);
					
					container2_chatView_row1.appendChild(container2_chatView_row1_col2);
					container2_chatView_group1.appendChild(container2_chatView_row1);
					container2_chatView.appendChild(container2_chatView_group1);
					
						
				}
			});
					container2_chatView.lastElementChild.scrollIntoView();
		}
				
	}
			
	xhr.open("get", "./oneChatList?chat_id=" + readOneChatId);
	xhr.send();
	}, 1000); //10초 셋팅 */
}
		
		function insertOneChating(inputValue) {
			console.log("1:1 텍스트 : " + inputValue);
			console.log("readOneChatId : " + readOneChatId);
			const xhr = new XMLHttpRequest();
				xhr.onreadystatechange = function () {
				if(xhr.readyState == 4 && xhr.status == 200) {
					const response = JSON.parse(xhr.responseText);
					
					
			      }         
			   }
			
			
			xhr.open("post", "./oneInsertChat");
			xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			xhr.send("chat_id=" + readOneChatId + "&user_id=" + mySessionId + "&chating=" + inputValue); 
		}
		
		
window.addEventListener("DOMContentLoaded", function(){

	
	getSession()
	scheduleList()
	searchAddress(clickAddress, clickLocation)
	

	
	chatModal()
	
	
	
	
	
	
	
	
});


	
	
	
</script>


<style>
body {
	-ms-overflow-style: none;
}
body {
    font-family: 'Roboto', sans-serif;
  }

::-webkit-scrollbar {
	display: none;
}

.overlayBox {
	background-color: #00A3FF;
	border-radius: 50%;
	color: white;
	width: 25px;
	height: 25px;
	display: flex;
	justify-content: center;
	align-items: center;
}

.overlayBox_span {
	text-align: center;
}



</style>


</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col">
				<jsp:include page="../common/topNavi.jsp"></jsp:include>
			</div>
		</div>
	</div>


	<div class="container-fluid mt-5">
		<div class="row">
			<div class="col-2"></div>
			<div class="col-8">
				<div class="row" id="mainContainer">
					<div class="col-6 ps-0">
						<div class="border pr-1" id="map"
							style="width: 100%; height: 85vh; border-radius: 15px;"></div>
					</div>
					<!-- AJAX -->
					<div class="col-6 pe-0">
						<div id="scheduleBox" class=" pl-1"
							style="height: 85vh; border-radius: 15px; border-radius: 15px; overflow-y: auto; white-space: nowrap;">
						</div>
					</div>
				</div>
			</div>
			<div class="col-2">
				<div class="row">
					<div class="col"
						style="position: fixed; fixed; bottom: 15%; right: -90.6%; z-index: 9999;">
						<i class="bi bi-chat-left-text-fill" style="font-size: 40px"
							data-bs-toggle="modal" data-bs-target="#boardModal"
							onclick="getBoardList();"></i>
					</div>
				</div>
				<div class="row">
					<div class="col d-flex justify-content-center"
						style="position: fixed; bottom: 8%; right: -42%; font-size: 40px; z-index: 9999;">
						<label class="text-center"
							style="background-color: yellow; height: 60px; width: 60px; border-radius: 50%;">
							<i class="bi bi-chat-dots-fill" data-bs-toggle="modal"
							data-bs-target="#chatModal" onclick="clickChatModal();"></i>
						</label>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id="chatModalBox"></div>



	<div class="modal fade" id="boardModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog " style="max-width: 700px;">
			<div class="modal-content" style="height: 700px;">
				<div class="modal-header" id="boardHeader">
					<h1 class="modal-title fs-5" id="exampleModalLabel">게시판</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div id="boardListContainer">
						<table class="table">
							<thead>
								<tr class="text-center">
									<th class="text-center" scope="col" style="width: 50px"></th>
									<th scope="col" style="width: 270px">제목
									</td>
									<th class="text-center" scope="col" style="width: 150px">작성자</th>
									<th class="text-center" scope="col" style="width: 150px">게시일</th>
									<th class="text-center" scope="col" style="width: 80px">조회수</th>
								</tr>
							</thead>
							<tbody id="listContainer"></tbody>
						</table>
						<nav aria-label="Page navigation example"
							style="display: flex; justify-content: center;">
							<ul class="pagination">
								<li class="page-item"><a class="page-link" href="#"
									aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
								</a></li>
								<li class="page-item"><a class="page-link active" href="#">1</a></li>
								<li class="page-item"><a class="page-link" href="#">2</a></li>
								<li class="page-item"><a class="page-link" href="#">3</a></li>
								<li class="page-item"><a class="page-link" href="#">4</a></li>
								<li class="page-item"><a class="page-link" href="#">5</a></li>
								<li class="page-item"><a class="page-link" href="#"
									aria-label="Next"> <span aria-hidden="true">&raquo;</span>
								</a></li>
							</ul>
						</nav>
					</div>
				</div>
				<div class="modal-footer" id="boardFooter">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary"
						onclick="createBoard();">게시글 작성</button>
				</div>
			</div>
		</div>
	</div>

	




<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6bb230f942595875a71c9910b889e653&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
</script>






	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
		crossorigin="anonymous"></script>
</body>
</html>