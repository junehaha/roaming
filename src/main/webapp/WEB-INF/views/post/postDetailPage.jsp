<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<script>
const postId = new URLSearchParams(location.search).get("id");


	function xml() {
		const xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function () {
		if(xhr.readyState == 4 && xhr.status == 200) {
			const response = JSON.parse(xhr.responseText);
		}
	}
		
		xhr.open("get", "./getPostCommentList?id=" + postId);
		xhr.send();
		
		xhr.open("post", "");
		xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded"); 
		xhr.send();
}



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



	





  
	function commentTotalCount() {
	   const xhr = new XMLHttpRequest();
	   xhr.onreadystatechange = function () {
	      if(xhr.readyState == 4 && xhr.status == 200) {
	         const response = JSON.parse(xhr.responseText);
		     const total = response.comment_total
		     const commentCountBox = document.getElementById("commentCountBox"); 
		     commentCountBox.innerText = "댓글 " + total;
		     
		   }
		}
		
		xhr.open("get", "./commentTotalCount?postId=" + postId);
		xhr.send();
	}

	/* 게시판 좋아요 */
	function clickLike() {
		if(!mySessionId) {
			alert("로그인 해주세요");
		      return;
		   }
		   const xhr = new XMLHttpRequest();
		   xhr.onreadystatechange = function () {
		      if(xhr.readyState == 4 && xhr.status == 200) {
		         const response = JSON.parse(xhr.responseText);
		         checkLike();
		         likeTotalCount();
			   }
			}
			
			xhr.open("get", "./likeClick?post_id=" + postId);
			xhr.send();
		}

	function checkLike() {
		
		   const xhr = new XMLHttpRequest();
		   xhr.onreadystatechange = function () {
		      if(xhr.readyState == 4 && xhr.status == 200) {
		         const response = JSON.parse(xhr.responseText);
			     const likeIconBox = document.getElementById("likeIconBox"); 
			     console.log("f5")
		         if(response.liked >= 1) {
		        	 likeIconBox.classList.remove("bi-heart");
		        	 likeIconBox.classList.add("bi-heart-fill");
		        	 console.log("하트실행")
		         }else {
		        	 likeIconBox.classList.remove("bi-heart-fill");
		        	 likeIconBox.classList.add("bi-heart");
		         }
		         likeTotalCount();
			   }
			}
			
			xhr.open("get", "./myCheckLike?post_id=" + postId);
			xhr.send();
		}

	function likeTotalCount() {
		   const xhr = new XMLHttpRequest();
		   xhr.onreadystatechange = function () {
		      if(xhr.readyState == 4 && xhr.status == 200) {
		         const response = JSON.parse(xhr.responseText);
			     const likeTotalCountBox = document.getElementById("likeTotalCountBox");
			     likeTotalCountBox.innerText = "좋아요 " + response.totalCount;
			   }
			}
			
			xhr.open("get", "./likedTotalCount?postId=" + postId);
			xhr.send();
		}
	
	
	
	
	
	
	
	
		 
	/* 댓글 출력 */
	function readCommentList() {
		const xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function () {
		if(xhr.readyState == 4 && xhr.status == 200) {
			const response = JSON.parse(xhr.responseText);
			const commentContainer = document.getElementById("commentContainer");
			commentContainer.innerHTML = "";
			
			response.commentList.forEach(function(item){
				const col99 = document.createElement("div");
				col99.classList.add("col");
				col99.id = "col99" + item.commentDto.id;
				const row77 = document.createElement("div");
				row77.classList.add("row");
				row77.id = "row77" + item.commentDto.id;
				const col1 = document.createElement("div");
				col1.classList.add("col-11", "d-flex");
				col1.id = "replyModify" + item.commentDto.id;
				const img1 = document.createElement("img");
				img1.src = "/uploadFiles/" + item.commentUserDto.profile_img;
				img1.classList.add("img-fluid", "rounded-circle", "p-3");
				img1.style.height = "80px";
				img1.style.width = "80px";
				col1.appendChild(img1);
				const div1 = document.createElement("div");
				const p1 =  document.createElement("p");
				p1.classList.add("m-0", "pt-3");
				p1.innerText = item.commentUserDto.user_name;
				const p2 =  document.createElement("p");
				p2.style.wordBreak = "break-all";
				p2.innerText = item.commentDto.post_comment;
				
				div1.appendChild(p1);
				div1.appendChild(p2);
				col1.appendChild(div1);
				row77.appendChild(col1);
				col99.appendChild(row77);
				const col2 = document.createElement("div");
				col2.classList.add("col-1");
				col2.id = "comment_modal" + item.commentDto.id;
				
				const i1 = document.createElement("i");
				i1.classList.add("float-end", "bi", "bi-three-dots-vertical");
				i1.onclick = () => {
					/* 모달위치 */
					commentModal(item.commentDto.id, item.commentDto.user_id, item.commentDto.post_comment, item.commentUserDto.user_name);
					const modal = bootstrap.Modal.getOrCreateInstance("#commentModal")
					const i1Rect = i1.getBoundingClientRect();
					const modalDialog = document.getElementById("commentModal").querySelector(".modal-dialog");
					  
					const i1Top = i1Rect.top + i1Rect.height -50;
					const i1Left = i1Rect.left + (i1Rect.width / 2) - (modalDialog.offsetWidth / 2) +7;
					
					modalDialog.style.top = i1Top +  "px";
					modalDialog.style.left = i1Left + "px";
					modal.show();
				};

				
				col2.appendChild(i1);
				
				commentContainer.appendChild(col1);
				commentContainer.appendChild(col2);
				
				
				const row99 = document.createElement("div");
				row99.classList.add("row");
				row99.id = "row99" + item.commentDto.id;
				const col3 = document.createElement("div");
				col3.classList.add("col");
				
				const div2 = document.createElement("div");
				div2.classList.add("row");
				
				const col4 = document.createElement("div");
				col4.classList.add("col", "ms-3");
				col4.id = "parentElement" + item.commentDto.id;
				
				const small1 = document.createElement("small");
				small1.classList.add("ms-5");
				small1.style.color = "gray";
				small1.innerText = item.commentDto.reg_date;
				
				const small2 = document.createElement("small");
				small2.classList.add("ms-1");
				small2.style.color = "gray";
				small2.id = "commentLikeTotalCountBox" + item.commentDto.id;
				
				const small3 = document.createElement("small");
				small3.classList.add("ms-2");
				small3.id = "replyLink" + item.commentDto.id;
				small3.style.color = "gray";
				small3.innerText = "답글쓰기";
				small3.onclick = () => {
					toggleReplyField(item.commentDto.id);	
				}
				
				const i2 = document.createElement("i");
				i2.id = "commentlikeIconBox" + item.commentDto.id;
				i2.classList.add("bi", "bi-heart", "text-danger", "float-end");
				i2.onclick = () => {
					clickCommentLike(item.commentDto.id);
				}
				
				col4.appendChild(small1);
				col4.appendChild(small2);
				col4.appendChild(small3);
				col4.appendChild(i2);
				div2.appendChild(col4);
				col3.appendChild(div2);
				row99.appendChild(col3)
				
				const row88 = document.createElement("div");
				row88.classList.add("row");
				const col5 = document.createElement("div");
				col5.classList.add("col", "p-0");
				const hr1 = document.createElement("hr");
				hr1.classList.add("m-0", "mt-2");
				
				col5.appendChild(hr1);
				row88.appendChild(col5);

				col99.appendChild(row77);
				col99.appendChild(row99);
				col99.appendChild(row88);
				
				commentContainer.appendChild(col99);
				checkCommentLike(item.commentDto.id);
				commentLikeTotalCount(item.commentDto.id);
				
				item.reCommentList.forEach(function(reItem){
					
					const col10 = document.createElement("div");
					col10.classList.add("col");
					const row10 = document.createElement("div");
					row10.classList.add("row");
					row10.id = "row10" + reItem.reCommentDto.id;;
					const col11 = document.createElement("div");
					col11.classList.add("col-2");
					const col12 = document.createElement("div");
					col12.classList.add("col", "d-flex");
					const img10 = document.createElement("img");
					img10.src = "/uploadFiles/" + reItem.reCommentUserDto.profile_img;
					img10.classList.add("img-fluid", "rounded-circle", "p-3");
					img10.style.height = "80px";
					img10.style.width = "80px";
					const div10 = document.createElement("div");
					const p10 = document.createElement("p");
					p10.classList.add("m-0", "pt-3");
					p10.innerText = reItem.reCommentUserDto.user_name;
					div10.appendChild(p10);
					if(reItem.reCommentUserDto && reItem.reCommentReUserDto && reItem.reCommentUserDto.id !== reItem.reCommentReUserDto.id && reItem.reCommentUserDto.id !== null) { 
						const b5 = document.createElement("b");
						b5.innerText = reItem.frontUserDto.user_name + " ";
						const p11 = document.createElement("p");
						p11.style.wordBreak = "break-all";
						p11.style.display = "inline";
						p11.innerText = reItem.reCommentDto.re_comment;
						div10.appendChild(b5);
						div10.appendChild(p11);
						
					}else if(reItem.frontUserDto && reItem.frontUserDto.user_name !== null && reItem.reCommentUserDto && reItem.reCommentUserDto.user_name !== null) {
						const p12 = document.createElement("p");
						p12.style.wordBreak = "break-all";
						p12.innerText = reItem.reCommentDto.re_comment;
						div10.appendChild(p12);
						
					}else {
						const p13 = document.createElement("p");
						p13.style.wordBreak = "break-all";
						p13.innerText = reItem.reCommentDto.re_comment;
						div10.appendChild(p13);
						
					}
					const col13 = document.createElement("div");
					col13.classList.add("col-1");
					const i5 = document.createElement("i");
					i5.classList.add("float-end", "bi", "bi-three-dots-vertical");
					i5.id = "reComment_modal" + reItem.reCommentDto.id; 
					
					i5.onclick = () => {
						/* 대댓글 모달위치 */
						reCommentModal(reItem.reCommentDto.id, reItem.reCommentDto.user_id, reItem.reCommentDto.re_comment, reItem.reCommentUserDto.user_name);
						const modal = bootstrap.Modal.getOrCreateInstance("#reCommentModal")
						const i5Rect = i5.getBoundingClientRect();
						const modalDialog = document.getElementById("reCommentModal").querySelector(".modal-dialog");
						  
						const i5Top = i5Rect.top + i5Rect.height -50;
						const i5Left = i5Rect.left + (i5Rect.width / 2) - (modalDialog.offsetWidth / 2) +8;
						
						modalDialog.style.top = i5Top +  "px";
						modalDialog.style.left = i5Left + "px";
						modal.show();
					}
					col13.appendChild(i5);
					col12.appendChild(img10);
					col12.appendChild(div10);
					row10.appendChild(col11);
					row10.appendChild(col12);
					row10.appendChild(col13);
					col10.appendChild(row10);
					
					col99.appendChild(col10);
					
					const row11 = document.createElement("div");
					row11.classList.add("row");
					row11.id = "row11";
					const col14 = document.createElement("div");
					col14.classList.add("col");
					const row12 = document.createElement("div");
					row12.classList.add("row");
					const col15 = document.createElement("div");
					col15.classList.add("col-2");
					const col16 = document.createElement("div");
					col16.classList.add("col", "ms-3");
					col16.id = "reparentElement" + reItem.reCommentDto.id; 
					const small5 = document.createElement("small");
					small5.classList.add("ms-5", "mb-1");
					small5.style.color = "gray";
					small5.innerText = reItem.reCommentDto.reg_date;
					const small6 = document.createElement("small");
					small6.classList.add("ms-1");
					small6.id = "recommentLikeTotalCountBox" + reItem.reCommentDto.id;
					small6.style.color = "gray";
					
					const small7 = document.createElement("small");
					small7.classList.add("ms-2");
					small7.style.color = "gray";
					small7.id = "reReplyLink" + reItem.reCommentDto.id;
					small7.innerText = "답글쓰기";
					small7.onclick = () => {
						toggleReReplyField(item.commentDto.id, reItem.reCommentDto.id, reItem.reCommentUserDto.id);
					}
					const i3 = document.createElement("i");
					i3.id = "reCommentlikeIconBox" + reItem.reCommentDto.id;
					i3.classList.add("bi", "bi-heart", "text-danger", "float-end");
					i3.onclick = () => {
						clickReCommentLike(reItem.reCommentDto.id);
					}
					const row13 = document.createElement("div");
					row13.classList.add("row");
					const col17 = document.createElement("div");
					col17.classList.add("col", "p-0");
					const hr2 = document.createElement("hr");
					hr2.classList.add("m-0", "mt-2");
					
					col17.appendChild(hr2);
					row13.appendChild(col17);
					col16.appendChild(small5);
					col16.appendChild(small6);
					col16.appendChild(small7);
					col16.appendChild(i3);
					row12.appendChild(col15);
					row12.appendChild(col16);
					col14.appendChild(row12);
					col14.appendChild(row13);
					row11.appendChild(col14);
					col10.appendChild(row11);
					checkReCommentLike(reItem.reCommentDto.id);
					reCommentLikeTotalCount(reItem.reCommentDto.id);
				});
			});
			
			
		}
	}
		
		xhr.open("get", "./getPostCommentList?id=" + postId);
		xhr.send();
}
	
	function comment() {
		let commentBox = document.getElementById("commentBox");
		let commentBoxValue = commentBox.value;
		if(!mySessionId) {
		      alert("로그인 해주세요");
		      commentBox.value = "";
		      return;
		   }
		if(commentBoxValue == '') {
			  alert("내용을 입력해주세요.");  
			  return;
		  }
	   const xhr = new XMLHttpRequest();   
	   xhr.onreadystatechange = function () {
	      if(xhr.readyState == 4 && xhr.status == 200) {
	         const response = JSON.parse(xhr.responseText);
	         
	           if(response.result == "success"){
	              commentBox.value = "";
	              commentTotalCount();
	              readCommentList();
	           }
	           
	      }
	   }

	   xhr.open("post", "./insertPostComment");
	   xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded"); 
	   xhr.send("post_id=" + postId + "&post_comment=" + commentBoxValue);
	}


		
		function toggleReplyField(to_comment_id) {
			const parentElement = document.getElementById("parentElement" + to_comment_id);
			const replyLink = document.getElementById("replyLink" + to_comment_id);
			if(replyLink.innerText === "답글쓰기") {
				replyLink.innerText = "닫기";
			
			const row20 = document.createElement("div");
			row20.classList.add("row");
			const col20 = document.createElement("div");
			col20.classList.add("col-2");
			const col21 = document.createElement("div");
			col21.classList.add("col");
			const div20 = document.createElement("label");
			div20.style.position = "relative"
			const text1 = document.createElement("textarea");
			text1.classList.add("form-control");
			text1.rows = "5";
			text1.cols = "70";
			text1.placeholder = "답글을 입력하세요";
			text1.id = "replyInput" + to_comment_id;
			const btn1 = document.createElement("button");
			btn1.classList.add("btn", "btn-outline-secondary", "btn-sm", "mt-1");
			btn1.style.position = "absolute"
			btn1.style.bottom = "10px"
			btn1.style.right = "60px"
			
			btn1.innerText = "취소"
			btn1.onclick = () => {
				readCommentList();
			}/* 여기수정 */
			
			const btn2 = document.createElement("button");
			btn2.classList.add("btn", "btn-outline-success", "btn-sm");
			btn2.style.position = "absolute"
			btn2.style.bottom = "10px"
			btn2.style.right = "10px"
			btn2.innerText = "작성"
			btn2.onclick = () => {
				const replyInputBox = document.getElementById("replyInput" + to_comment_id);
				const replyInput = replyInputBox.value;
				submitReply(to_comment_id, replyInput);
			}
			
			div20.appendChild(text1);
			div20.appendChild(btn1);
			div20.appendChild(btn2);
			col21.appendChild(div20);
			row20.appendChild(col20);
			row20.appendChild(col21);
			
			parentElement.appendChild(row20);
			
			}else {
				replyLink.innerText = "답글쓰기";
				parentElement.removeChild(parentElement.lastChild);
			}		
		}

	function submitReply(to_commentId, replyInput) {
	   if(!mySessionId) {
	      alert("로그인 해주세요");
	      commentBox.value = "";
	      return;
	   }
	  if(replyInput == '') {
		  alert("내용을 입력해주세요.");  
		  return;
	  }
	  
	   const xhr = new XMLHttpRequest();
	   xhr.onreadystatechange = function () {
	      if(xhr.readyState == 4 && xhr.status == 200) {
	         const response = JSON.parse(xhr.responseText);
	         const parentElement = document.getElementById("parentElement" + to_commentId);
	         parentElement.removeChild(parentElement.lastChild);
	         readCommentList();
	         commentTotalCount();
	         
	      
	   }
	}

	   xhr.open("post", "./insertRePostComment");
	   xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded"); 
	   xhr.send("comment_id=" + to_commentId + "&re_comment=" + replyInput); 
	}

	
	/* 대대댓글 */

	   function toggleReReplyField(to_comment_id, to_reCommentId, re_user_id) {
		console.log("reUserId : " + re_user_id)
		console.log("reCommentId : " + to_reCommentId)
		   const reparentElement = document.getElementById("reparentElement" + to_reCommentId);
			const reReplyLink = document.getElementById("reReplyLink" + to_reCommentId);
			if(reReplyLink.innerText === "답글쓰기") {
				reReplyLink.innerText = "닫기";
			
			const row20 = document.createElement("div");
			row20.classList.add("row");
			const col20 = document.createElement("div");
			col20.classList.add("col-2");
			const col21 = document.createElement("div");
			col21.classList.add("col");
			const div20 = document.createElement("label");
			div20.style.position = "relative"
			const text1 = document.createElement("textarea");
			text1.classList.add("form-control");
			text1.rows = "5";
			text1.cols = "70";
			text1.placeholder = "답글을 입력하세요";
			text1.id = "reReplyInput" + to_reCommentId;
			const btn1 = document.createElement("button");
			btn1.classList.add("btn", "btn-outline-secondary", "btn-sm", "mt-1");
			btn1.style.position = "absolute"
			btn1.style.bottom = "10px"
			btn1.style.right = "60px"
			
			btn1.innerText = "취소"
			btn1.onclick = () => {
				readCommentList();
			}
			
			const btn2 = document.createElement("button");
			btn2.classList.add("btn", "btn-outline-success", "btn-sm");
			btn2.style.position = "absolute"
			btn2.style.bottom = "10px"
			btn2.style.right = "10px"
			btn2.innerText = "작성"

			btn2.onclick = () => {
				const reReplyInputBox = document.getElementById("reReplyInput" + to_reCommentId);
				const reReplyInput = reReplyInputBox.value;
				
				submitReReply(to_comment_id, re_user_id, reReplyInput, to_reCommentId);
			}
			
			div20.appendChild(text1);
			div20.appendChild(btn1);
			div20.appendChild(btn2);
			col21.appendChild(div20);
			row20.appendChild(col20);
			row20.appendChild(col21);
			
			reparentElement.appendChild(row20);
			
			}else {
				reReplyLink.innerText = "답글쓰기";
				reparentElement.removeChild(reparentElement.lastChild);
			}	
	}

		function submitReReply(to_comment_id, re_user_id, reReplyInput, to_reCommentId) {
		   if(!mySessionId) {
		      alert("로그인 해주세요");
		      commentBox.value = "";
		      return;
		   }
		   if(reReplyInput == '') {
				  alert("내용을 입력해주세요.");  
				  return;
			  }
		   const xhr = new XMLHttpRequest();
		   xhr.onreadystatechange = function () {
		      if(xhr.readyState == 4 && xhr.status == 200) {
		         const response = JSON.parse(xhr.responseText);
		         const reparentElement = document.getElementById("reparentElement" + to_reCommentId);
		         reparentElement.removeChild(reparentElement.lastChild);
		         readCommentList();
		         commentTotalCount();
		   }
		}

	   xhr.open("post", "./insertReRePostComment");
	   xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded"); 
	   xhr.send("comment_id=" + to_comment_id + "&re_user_id=" + re_user_id + "&re_comment=" + reReplyInput);
	}
			
		
		
		/* 댓글 좋아요 */
		function clickCommentLike(commentId) {
			if(!mySessionId) {
				alert("로그인 해주세요");
			      return;
			   }
			   const xhr = new XMLHttpRequest();
			   xhr.onreadystatechange = function () {
			      if(xhr.readyState == 4 && xhr.status == 200) {
			         const response = JSON.parse(xhr.responseText);
			         checkCommentLike(commentId);
			         commentLikeTotalCount(commentId);
				   }
				}
				
				xhr.open("get", "./commentLikeClick?comment_id=" + commentId);
				xhr.send();
			}

		function checkCommentLike(commentId) {
				if(!mySessionId) {
				      return;
				   }
				const commentlikeIconBox = document.getElementById("commentlikeIconBox" + commentId);
				const xhr = new XMLHttpRequest();
				   xhr.onreadystatechange = function () {
				      if(xhr.readyState == 4 && xhr.status == 200) {
				         const response = JSON.parse(xhr.responseText);
				         if(response.liked >= 1) {
				        	 commentlikeIconBox.classList.remove("bi-heart");
				        	 commentlikeIconBox.classList.add("bi-heart-fill");
				         }else {
				        	 commentlikeIconBox.classList.remove("bi-heart-fill");
				        	 commentlikeIconBox.classList.add("bi-heart");
				         }
				         commentLikeTotalCount(commentId);
					   }
				}
			    
				xhr.open("get", "./commentMyCheckLike?comment_id=" + commentId);
				xhr.send();
			}
		
			 function commentLikeTotalCount(commentId) {
			   const xhr = new XMLHttpRequest();
			   xhr.onreadystatechange = function () {
			      if(xhr.readyState == 4 && xhr.status == 200) {
			         const response = JSON.parse(xhr.responseText);
				     const commentLikeTotalCountBox = document.getElementById("commentLikeTotalCountBox" + commentId);
				     if(response.totalCount > 0) {
				    	 commentLikeTotalCountBox.innerText = " 좋아요 " + response.totalCount + " ";	 
				     }else {
				    	 commentLikeTotalCountBox.innerText = "";
			            }
				     
				   }
				}
				xhr.open("get", "./commentLikedTotalCount?commentId=" + commentId);
				xhr.send();
			}
		
			 /* 대댓글 좋아요 */
				function clickReCommentLike(reCommentId) {
					if(!mySessionId) {
						alert("로그인 해주세요");
					      return;
					   }
					   const xhr = new XMLHttpRequest();
					   xhr.onreadystatechange = function () {
					      if(xhr.readyState == 4 && xhr.status == 200) {
					         const response = JSON.parse(xhr.responseText);
					         checkReCommentLike(reCommentId);
					         reCommentLikeTotalCount(reCommentId);
						   }
						}
						
						xhr.open("get", "./reCommentLikeClick?recomment_id=" + reCommentId);
						xhr.send();
					}

				function checkReCommentLike(reCommentId) {
					if(!mySessionId) {
					      return;
					   }
						const reCommentlikeIconBox = document.getElementById("reCommentlikeIconBox" + reCommentId);
						const xhr = new XMLHttpRequest();
						   xhr.onreadystatechange = function () {
						      if(xhr.readyState == 4 && xhr.status == 200) {
						         const response = JSON.parse(xhr.responseText);
						         if(response.liked >= 1) {
						        	 reCommentlikeIconBox.classList.remove("bi-heart");
						        	 reCommentlikeIconBox.classList.add("bi-heart-fill");
						         }else {
						        	 reCommentlikeIconBox.classList.remove("bi-heart-fill");
						        	 reCommentlikeIconBox.classList.add("bi-heart");
						         }
						         reCommentLikeTotalCount(reCommentId);
							   }
						}
					    
						xhr.open("get", "./reCommentMyCheckLike?recomment_id=" + reCommentId);
						xhr.send();
					}
				
		function reCommentLikeTotalCount(reCommentId) {
		   const xhr = new XMLHttpRequest();
		   xhr.onreadystatechange = function () {
		      if(xhr.readyState == 4 && xhr.status == 200) {
		         const response = JSON.parse(xhr.responseText);
			     const recommentLikeTotalCountBox = document.getElementById("recommentLikeTotalCountBox" + reCommentId);
			     if(response.totalCount > 0) {
			     recommentLikeTotalCountBox.innerText = " 좋아요 " + response.totalCount + " ";
			     }else {
		                recommentLikeTotalCountBox.innerText = "";
		            }
			   }
			}
			xhr.open("get", "./reCommentLikedTotalCount?recommentId=" + reCommentId);
			xhr.send();
		}
		
		
		/* 댓글 모달 */ 
		 function commentModal(commentId, commentUserId, commentText, userName) {
			if(commentUserId == mySessionId) {
				 /* 수정, 삭제 */
				const modal = document.createElement("div");
				modal.classList.add("modal", "fade");
				modal.id = "commentModal";
				modal.tabIndex = "-1";
				modal.setAttribute("aria-labelledby", "exampleModalLabel");
				modal.setAttribute("aria-hidden", "true");
				
				const modalDialog = document.createElement("div");
				modalDialog.classList.add("modal-dialog", "modal-dialog-top");
				modalDialog.style.width = "70px";
				modalDialog.style.position = "absolute";
				modalDialog.style.top = "40%";
				modalDialog.style.left = "60%";
				
				const modalContent = document.createElement("div");
				modalContent.classList.add("modal-content");
				
				const modalBody = document.createElement("div");
				modalBody.classList.add("modal-body");
				
				const span1 = document.createElement("span");
				span1.textContent = "수정";
				span1.classList.add("text-center");
				span1.onclick = () => {
					console.log("댓글 수정")
					modifyHtml(commentId, commentUserId, commentText, userName);
				}
				const span2 = document.createElement("span");
				span2.textContent = "삭제";
				span2.classList.add("text-center");
				span2.onclick = () => {
					console.log("댓글 삭제")
					commentDelete(commentId);
					commentTotalCount();
					
				} 
				modalBody.appendChild(span1);
				modalBody.appendChild(span2);
				modalContent.appendChild(modalBody);
				modalDialog.appendChild(modalContent);
				modal.appendChild(modalDialog);
				
				const comment_modal = document.getElementById("comment_modal" + commentId);
				comment_modal.appendChild(modal);
				
				
			 }else {
				 /* 신고 */
				
				const modal = document.createElement("div");
				modal.classList.add("modal", "fade");
				modal.id = "commentModal";
				modal.tabIndex = "-1";
				modal.setAttribute("aria-labelledby", "exampleModalLabel");
				modal.setAttribute("aria-hidden", "true");
				
				const modalDialog = document.createElement("div");
				modalDialog.classList.add("modal-dialog", "modal-dialog-top");
				modalDialog.style.width = "70px";
				modalDialog.style.position = "absolute";
				modalDialog.style.top = "40%";
				modalDialog.style.left = "60%";
				
				const modalContent = document.createElement("div");
				modalContent.classList.add("modal-content");
				
				const modalBody = document.createElement("div");
				modalBody.classList.add("modal-body");
				
				const span1 = document.createElement("span");
				span1.textContent = "신고";
				span1.classList.add("text-center");
				span1.onclick = () => {
					/* 신고 모달 HTML*/
				}
				
				modalBody.appendChild(span1);
				modalContent.appendChild(modalBody);
				modalDialog.appendChild(modalContent);
				modal.appendChild(modalDialog);
				
				const comment_modal = document.getElementById("comment_modal" + commentId);
				comment_modal.appendChild(modal);
 				
			 }
		 }
		
		function modifyHtml(commentId, commentUserId, commentText, userName) {
			/* 수정 html */
			console.log("댓글수정 확인")
			const modal = bootstrap.Modal.getOrCreateInstance("#commentModal");
			modal.hide();
			const col12 = document.createElement("div");
			col12.classList.add("col-11", "d-grid");
			
			const label = document.createElement("label");
			label.style.position = "relative";
			const spanName = document.createElement("span");
			spanName.classList.add("mt-1", "ms-2");
			spanName.style.position = "absolute"
			spanName.innerText = userName;
			const commentInput = document.createElement("input");
			commentInput.type = "text";
			commentInput.classList.add("form-control", "pt-5", "pb-5", "mt-1");
			commentInput.id = "commentInput"
			commentInput.style.height = "75px";
			commentInput.style.width = "100%";
			commentInput.value = commentText;
			const cancelBtn = document.createElement("button");
			cancelBtn.classList.add("btn", "btn-outline-secondary", "btn-sm");
			cancelBtn.style.position = "absolute"
			cancelBtn.style.bottom = "10px";
			cancelBtn.style.right = "60px";
			cancelBtn.innerText = "취소";
			cancelBtn.onclick = () => {
				console.log("댓글 취소")
				readCommentList();
			}
			
			
			const insertBtn = document.createElement("button");
			insertBtn.classList.add("btn", "btn-outline-success", "btn-sm");
			insertBtn.style.position = "absolute";
			insertBtn.style.bottom = "10px";
			insertBtn.style.right = "10px";
			insertBtn.innerText = "수정";
			insertBtn.onclick = () => {
				console.log("댓글 수정")
				const commentInput = document.getElementById("commentInput");
				const commentValue = commentInput.value;
				commentModify(commentId, commentValue);
				
			}
			
			label.appendChild(spanName);
			label.appendChild(commentInput);
			label.appendChild(cancelBtn);
			label.appendChild(insertBtn);
			
			
			const comment_modal = document.getElementById("comment_modal" + commentId);
			const replyModify = document.getElementById("replyModify" + commentId);
			const row77 = document.getElementById("row77" + commentId);
			const parentElement = document.getElementById("parentElement" + commentId);
			
			

			
			parentElement.innerHTML = "";			
			comment_modal.innerHTML = "";
			replyModify.innerHTML = "";
			row77.innerHTML = "";
			
			
			
			col12.appendChild(label);

			row77.appendChild(col12);
			
			
			/* commentId, commentValue 보내기 */
		}
		 
		 function commentModify(commentId, commentValue) {
  				
				const xhr = new XMLHttpRequest();
				xhr.onreadystatechange = function () {
				if(xhr.readyState == 4 && xhr.status == 200) {
					const response = JSON.parse(xhr.responseText);
					readCommentList();
				}
			}
				xhr.open("post", "./commentModify");
				xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded"); 
				xhr.send("id=" + commentId + "&post_comment=" + commentValue);
		} 
		 
		 function commentDelete(commentId) {
			 	const modal = bootstrap.Modal.getOrCreateInstance("#commentModal");
				modal.hide();
				const xhr = new XMLHttpRequest();
				xhr.onreadystatechange = function () {
				if(xhr.readyState == 4 && xhr.status == 200) {
					const response = JSON.parse(xhr.responseText);
					readCommentList();
					commentTotalCount();
				}
			}
				xhr.open("get", "./commentDelete?commentId=" + commentId);
				xhr.send();
		} 	
		 
		 
		 
		 /* 대댓글 모달 */ 
		 function reCommentModal(reCommentId, reCommentUserId, reCommentText, userName) {
			if(reCommentUserId == mySessionId) {
				 /* 수정, 삭제 */
				const modal = document.createElement("div");
				modal.classList.add("modal", "fade");
				modal.id = "reCommentModal";
				modal.tabIndex = "-1";
				modal.setAttribute("aria-labelledby", "exampleModalLabel");
				modal.setAttribute("aria-hidden", "true");
				
				const modalDialog = document.createElement("div");
				modalDialog.classList.add("modal-dialog", "modal-dialog-top");
				modalDialog.style.width = "70px";
				modalDialog.style.position = "absolute";
				modalDialog.style.top = "40%";
				modalDialog.style.left = "60%";
				
				const modalContent = document.createElement("div");
				modalContent.classList.add("modal-content");
				
				const modalBody = document.createElement("div");
				modalBody.classList.add("modal-body");
				
				const span1 = document.createElement("span");
				span1.textContent = "수정";
				span1.classList.add("text-center");
				span1.onclick = () => {
					reModifyHtml(reCommentId, reCommentUserId, reCommentText, userName);
				}
				const span2 = document.createElement("span");
				span2.textContent = "삭제";
				span2.classList.add("text-center");
				span2.onclick = () => {
					console.log("리댓글 삭제 에러")
					reCommentDelete(reCommentId);
					
				} 
				modalBody.appendChild(span1);
				modalBody.appendChild(span2);
				modalContent.appendChild(modalBody);
				modalDialog.appendChild(modalContent);
				modal.appendChild(modalDialog);
				
				const reComment_modal = document.getElementById("reComment_modal" + reCommentId);
				
				reComment_modal.appendChild(modal);

				
				
				
			 }else {
				 /* 신고 */
				
				const modal = document.createElement("div");
				modal.classList.add("modal", "fade");
				modal.id = "reCommentModal";
				modal.tabIndex = "-1";
				modal.setAttribute("aria-labelledby", "exampleModalLabel");
				modal.setAttribute("aria-hidden", "true");
				
				const modalDialog = document.createElement("div");
				modalDialog.classList.add("modal-dialog", "modal-dialog-top");
				modalDialog.style.width = "70px";
				modalDialog.style.position = "absolute";
				modalDialog.style.top = "40%";
				modalDialog.style.left = "60%";
				
				const modalContent = document.createElement("div");
				modalContent.classList.add("modal-content");
				
				const modalBody = document.createElement("div");
				modalBody.classList.add("modal-body");
				
				const span1 = document.createElement("span");
				span1.textContent = "신고";
				span1.classList.add("text-center");
				span1.onclick = () => {
					/* 신고 모달 HTML*/
				}
				
				modalBody.appendChild(span1);
				modalContent.appendChild(modalBody);
				modalDialog.appendChild(modalContent);
				modal.appendChild(modalDialog);
				
				const reComment_modal = document.getElementById("reComment_modal" + reCommentId);
				reComment_modal.appendChild(modal);
 				
			 }
		 }
		
		function reModifyHtml(reCommentId, reCommentUserId, reCommentText, userName) {
			/* 수정 html */
			const modal = bootstrap.Modal.getOrCreateInstance("#reCommentModal");
			modal.hide();
			const col11 = document.createElement("div");
			col11.classList.add("col-2");
			const col12 = document.createElement("div");
			col12.classList.add("col", "d-grid");
			
			const label = document.createElement("label");
			label.style.position = "relative";
			const spanName = document.createElement("span");
			spanName.classList.add("mt-1", "ms-2");
			spanName.style.position = "absolute"
			spanName.innerText = userName;
			const reCommentInput = document.createElement("input");
			reCommentInput.type = "text";
			reCommentInput.classList.add("form-control", "pt-5", "pb-5", "mt-1");
			reCommentInput.id = "reCommentInput"
			reCommentInput.style.height = "75px";
			reCommentInput.style.width = "100%";
			reCommentInput.value = reCommentText;
			const cancelBtn = document.createElement("button");
			cancelBtn.classList.add("btn", "btn-outline-secondary", "btn-sm");
			cancelBtn.style.position = "absolute"
			cancelBtn.style.bottom = "10px";
			cancelBtn.style.right = "60px";
			cancelBtn.innerText = "취소";
			cancelBtn.onclick = () => {
				console.log("리댓글 취소")
				readCommentList();
			}
			
			
			const insertBtn = document.createElement("button");
			insertBtn.classList.add("btn", "btn-outline-success", "btn-sm");
			insertBtn.style.position = "absolute";
			insertBtn.style.bottom = "10px";
			insertBtn.style.right = "10px";
			insertBtn.innerText = "수정";
			insertBtn.onclick = () => {
				console.log("리댓글 수정")
				const reCommentInput = document.getElementById("reCommentInput");
				const reCommentValue = reCommentInput.value;
				reCommentModify(reCommentId, reCommentValue);
				
			}
			
			label.appendChild(spanName);
			label.appendChild(reCommentInput);
			label.appendChild(cancelBtn);
			label.appendChild(insertBtn);
			
			
			const reparentElement = document.getElementById("reparentElement" + reCommentId);
			reparentElement.innerHTML = "";
			const row10 = document.getElementById("row10" + reCommentId);
			row10.innerHTML = "";
			const row11 = document.getElementById("row11");
			row11.innerHTML = "";
			
			col12.appendChild(label);
			row10.appendChild(col11);
			row10.appendChild(col12);
			
			
			
			
			
			/* commentId, commentValue 보내기 */
		}
		 
		 function reCommentModify(reCommentId, reCommentValue) {
  				
				const xhr = new XMLHttpRequest();
				xhr.onreadystatechange = function () {
				if(xhr.readyState == 4 && xhr.status == 200) {
					const response = JSON.parse(xhr.responseText);
					readCommentList();
				}
			}
				xhr.open("post", "./reCommentModify");
				xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded"); 
				xhr.send("id=" + reCommentId + "&re_comment=" + reCommentValue);
		} 
		 
		 function reCommentDelete(reCommentId) {
			 	console.log("삭제 실행")
			 	console.log("reCommentId : " + reCommentId)
			 	
			 	const modal = bootstrap.Modal.getOrCreateInstance("#reCommentModal");
				modal.hide();
				const xhr = new XMLHttpRequest();
				xhr.onreadystatechange = function () {
				if(xhr.readyState == 4 && xhr.status == 200) {
					const response = JSON.parse(xhr.responseText);
					readCommentList();
				}
			}
				xhr.open("get", "./reCommentDelete?reCommentId=" + reCommentId);
				xhr.send();
		} 
		 
		 
		function partyButtonView() {
			const xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function () {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText);
				const joinConfirmDto = response.joinConfirmDto;
				const partyBtn = document.getElementById("partyBtn");
				const count = response.joinUserCount;
				const schCount = response.schCount;
				const postDto = response.postDto;
				const joinUserCount = response.joinUserCount;
				const statusCount = response.statusCount;
				
				if(joinConfirmDto != null) {
					const status = joinConfirmDto.status;
					
					
					if(status == "r") {
						console.log("신청중인 유저");
						partyBtn.textContent = "신청확인중";
					}else if(status == "y") {
						console.log("가입 유저");
						partyBtn.textContent = "상세일정보기";
						partyBtn.onclick = () => {
							/* 파티방 구현 */
							if(postDto.create_id === mySessionId) {
								if(schCount > 0) {
									window.location.href= "./postPartyRoom?id=" +postId;	
								}else {
									alert("스케줄을 작성해주세요.")
									window.location.href= "./testPost?id=" +postId;
								}	
							}else {
								if(schCount > 0) {
									window.location.href= "./postPartyRoom?id=" +postId;
								}else {
									alert("아직 스케줄이 없습니다.")
									return;
								}
							}
							
							
						}
					}else if(status == "n") {
						if(statusCount === postDto.person_count) {
							partyBtn.textContent = "동행 신청이 마감되었습니다."	
						}else {
							console.log("거절당한 유저");
							partyBtn.onclick = () => {
								openPartyModal();	
							}	
						}
						
					}else{
						if(statusCount === postDto.person_count) {
							partyBtn.textContent = "동행 신청이 마감되었습니다."	
						}else {
							console.log("로그인 유저1");
							partyBtn.onclick = () => {
								openPartyModal();	
							}	
						}
						
					}
				}else if(count > 0) {
					console.log("count 가입 유저");
					partyBtn.textContent = "상세일정보기";
					partyBtn.onclick = () => {
						/* 파티방 구현 */
						console.log("파티방클릭");
						if(postDto.create_id === mySessionId) {
							if(schCount > 0) {
								window.location.href= "./postPartyRoom?id=" +postId;	
								console.log("cout : " + schCount);
							}else {
								alert("스케줄을 작성해주세요.")
								window.location.href= "./testPost?id=" +postId;
								
							}	
						}else {
							if(schCount > 0) {
								window.location.href= "./postPartyRoom?id=" +postId;
							}else {
								return;
							}
						}
						
					}
				}else if(mySessionId){
					if(statusCount === postDto.person_count) {
						console.log("동행마감mySess");
						partyBtn.textContent = "동행 신청이 마감되었습니다."
						partyBtn.classList.remove("btn-primary");
						partyBtn.classList.add("btn-secondary");
					}else {
						console.log("로그인 유저2");
						partyBtn.onclick = () => {
							console.log("로그인 유저 클릭");
							openPartyModal();	
						}	
					}
						
				}else {
					partyBtn.onclick = () => {
						console.log("비로그인 유저 클릭");
						if(!mySessionId) {
							alert("로그인 해주세요");
						      return;
					}
					
					   }
				}
					
			}
			
		}
			
			
			xhr.open("get", "./getPostJoinStatus?post_id=" + postId);
			xhr.send();
	}
		
		
		function openPartyModal() {
			  const modal = new bootstrap.Modal(document.getElementById("partyModal"));
			  modal.show();
			  const insertSbmit = document.getElementById("insertSbmit");

			  
			  insertSbmit.onclick = () => {
					partyJoinSubmit();
					modal.hide();
			  }
			  
			}
		
		
		function closePartyModal() {
			  const modal = new bootstrap.Modal(document.getElementById("partyModal"));
			  modal.hide();
			}
		 
		 /* 파티참가 신청 */
		function partyJoinSubmit() {
			  const form = document.getElementById("submitModalForm");
			  const create_id = document.getElementById("create_id").value;
			  const mentValue = form.querySelector("textarea[name='welcome_ment']").value;
			  const fileInputElement = form.querySelector("input[name='confirm_image1']");
			  const formData = new FormData(form);
			  formData.append("post_id", postId);
			  			
			const xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function () {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText);
				closePartyModal();
				partyButtonView();
				
			}
		}
			
			xhr.open("post", "./joinProcess");
			xhr.send(formData);
			
		}
		 
		 
		/* 함께하는 동행 리스트 */ 
		function joinMemberList() {
			const xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function () {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText);
				const togetherUser = document.getElementById("togetherUser");
				const col1 = document.createElement("div");
				col1.classList.add("col");	
				const div1 = document.createElement("div");
				div1.classList.add("card");
				div1.style.width = "auto";
				const ul1 = document.createElement("ul");
				ul1.classList.add("list-group", "list-group-flush");
				const li1 = document.createElement("li");
				li1.classList.add("list-group-item");
				const span1 = document.createElement("span");
				span1.innerText = "함께하는 동행 ( " + response.joinCount + " / " + response.postDto.person_count + " )";
				li1.appendChild(span1);
				ul1.appendChild(li1);
				
				response.list.forEach(function(item){
					
					
					const li2 = document.createElement("li");
					li2.classList.add("list-group-item");
					const row1 = document.createElement("div");
					row1.classList.add("row", "mb-1");
					const col2 = document.createElement("div");
					col2.classList.add("col-3", "d-flex", "align-items-center", "justify-content-center");
					const img1 = document.createElement("img");
					img1.classList.add("img-fluid", "rounded-circle");
					img1.style.height = "50px";
					img1.style.width = "50px";
					img1.src = "/uploadFiles/" + item.userDto.profile_img;
					img1.onclick = () => {
						profileModal(item.userDto.id)
					}
					col2.appendChild(img1);
					
					const col3 = document.createElement("div");
					col3.classList.add("col-9");
					const row2 = document.createElement("div");
					row2.classList.add("row", "d-flex", "align-items-center", "justify-content-center");
					row2.style.height = "100%";
					const col4 = document.createElement("div");
					col4.classList.add("col-5");
					const span2 = document.createElement("span");
					span2.innerText = item.userDto.user_name;
					const col5 = document.createElement("div");
					col5.classList.add("col-4");
					const span3 = document.createElement("span");
					span3.innerText = item.birthday
					const col6 = document.createElement("div");
					col6.classList.add("col-3");
					const span4 = document.createElement("span");
					if(item.userDto.gender === "M") {
						span4.innerText = "남자";	
					}else {
						span4.innerText = "여자";
					}
					 ;
					col4.appendChild(span2);
					col5.appendChild(span3);
					col6.appendChild(span4);
					
					row2.appendChild(col4);
					row2.appendChild(col5);
					row2.appendChild(col6);
					col3.appendChild(row2);
					row1.appendChild(col2);
					row1.appendChild(col3);
					li2.appendChild(row1);
					ul1.appendChild(li2);
					div1.appendChild(ul1);
					col1.appendChild(div1);
					
					togetherUser.appendChild(col1);
				});
				
			}
		}
			
			xhr.open("get", "./getTogetherMemberList?id=" + postId);
			xhr.send();
	}	 
		
		
		
		/* 게시물 신고하기 */
		function postReport() {
			
				const modal = bootstrap.Modal.getOrCreateInstance("#postReport");
				
				const image = document.getElementById("image_file");
				  const title = document.getElementById("inputTitle").value; 
				  const textarea = document.getElementById("inputTextarea").value;
				  console.log("신고 실행")
				  const formData = new FormData();
				  formData.append("post_id", postId);
				  formData.append("user_id", mySessionId);
				  formData.append("title", title);
				  formData.append("content", textarea);
				  formData.append("image1", image.files[0]);	
			  		
			 
			  
			  
			const xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function () {
			if(xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText);
				modal.hide();
				resetReportForm();
			}
		}
			
			xhr.open("post", "./postReportProcess");
			xhr.send(formData);
			
		}
		
		
		function userCheck() {
			if(!mySessionId) {
			      alert("로그인 해주세요");
			      commentBox.value = "";
			      return;
			}
		}	
		
		
		
		
		
		
		
		
		
		
		
		
/*    ------------------------------------------------- Board -------------------------------------------------    */
		
		
		
		
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
			if(!mySessionId) {
				alert("로그인 해주세요");
			      return;
			   }
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
			  const modal = bootstrap.Modal.getOrCreateInstance("#chatModal");
			  if (!mySessionId) {
			    alert("로그인 해주세요");
			    modal.hide();
			    return;
			  } else {
				  console.log("모달 오픈")
			    modal.show();
			    chatModal();
			  }
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
							
							const maxTitleLength = 20; // 최대 글자수
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
			
			/* profileModal */
			function profileModal(userId) {
					const forContainer = document.getElementById("forContainer");
				    forContainer.innerHTML = "";
				const xhr = new XMLHttpRequest();
				xhr.onreadystatechange = function () {
				if(xhr.readyState == 4 && xhr.status == 200) {
					const response = JSON.parse(xhr.responseText);
						const userDto = response.userDto;
						const temp = response.temperature;
						const birthday = response.birthday;
						
						const forContainer = document.getElementById("forContainer");
						const countContainer = document.getElementById("countContainer");
						countContainer.innerText = "받은 후기 " + response.count;
						const profileContainer = document.getElementById("profileContainer");
						profileContainer.src = "/uploadFiles/" + userDto.profile_img 
						
						const tempContainer = document.getElementById("tempContainer");
						tempContainer.style.width = temp.score + "%"
						const nameContainer = document.getElementById("nameContainer");
						nameContainer.innerText = userDto.user_name;
						const ageBox = document.getElementById("ageBox");
						ageBox.innerText = birthday + " · ";
						const genderBox = document.getElementById("genderBox");
						if(userDto.gender == "M") {
							genderBox.innerText = "남자"
						}else {
							genderBox.innerText = "여자"
						}
						
						
						const temperatureContainer = document.getElementById("temperatureContainer");
						temperatureContainer.innerText = temp.score + "℃";
						
						const imoBox = document.getElementById("imoBox");
						if(temp.score <= 30) {
							imoBox.innerText =	"😱"
						}else if(temp.score <= 34) {
							imoBox.innerText =	"😭"
						}else if(temp.score <= 36.5) {
							imoBox.innerText =	"😄"
						}else if(temp.score >= 40) {
							imoBox.innerText =	"😍"
						}else if(temp.score >= 60) {
							imoBox.innerText =	"😎"
						}
						
						if (response.list == null || response.list.length === 0) {
							const forDiv = document.createElement("div");
								forDiv.classList.add("for")
								const row1 = document.createElement("div");
								row1.classList.add("row", "mt-3", "border-bottom")
								const row1_col1 = document.createElement("div");
								row1_col1.classList.add("col", "d-flex", "align-items-center", "justify-content-center")
								const row1_col1_label = document.createElement("label");
								row1_col1_label.style.color = "rgb(154, 154, 154)"
								row1_col1_label.style.textAlign = "center"
								const row1_col1_label_i = document.createElement("i");
								row1_col1_label_i.classList.add("bi", "bi-chat-dots-fill")
								row1_col1_label_i.style.fontSize = "35px"
								const row1_col1_label_p = document.createElement("p");
								row1_col1_label_p.style.marginBottom = "25px"
								row1_col1_label_p.innerText = "동행 후기 내역이 없습니다."
								
								row1_col1_label.appendChild(row1_col1_label_i)
								row1_col1_label.appendChild(row1_col1_label_p)
								row1_col1.appendChild(row1_col1_label)
								row1.appendChild(row1_col1)
								forDiv.appendChild(row1)
								forContainer.appendChild(forDiv)
			
						}else {
						response.list.forEach(function(list){
							
							const forDiv = document.createElement("div");
							forDiv.classList.add("for")
							
							const row1 = document.createElement("div");
							row1.classList.add("row", "mt-3")
							const row1_col1 = document.createElement("div");
							row1_col1.classList.add("col-2", "d-flex", "align-items-center", "justify-content-center")
							const row1_col1_img = document.createElement("img");
							row1_col1_img.src = "/uploadFiles/" + list.sendDto.profile_img;
							row1_col1_img.onclick = () => {
								profileModal(list.sendDto.id)
							}
							row1_col1_img.style.width = "40px" 
							row1_col1_img.style.height = "40px"
							row1_col1_img.style.borderRadius = "50%"
							row1_col1.appendChild(row1_col1_img)
							row1.appendChild(row1_col1)
							
							const row1_col2 = document.createElement("div");
							row1_col2.classList.add("col")
							const row1_col2_row1 = document.createElement("div");
							row1_col2_row1.classList.add("row")
							const row1_col2_row1_col = document.createElement("div");
							row1_col2_row1_col.classList.add("col", "p-0", "mt-1")
							const row1_col2_row1_col_span = document.createElement("span");
							row1_col2_row1_col_span.innerText = list.sendDto.user_name;
							row1_col2_row1_col.appendChild(row1_col2_row1_col_span)
							row1_col2_row1.appendChild(row1_col2_row1_col)
							row1_col2.appendChild(row1_col2_row1)
			
							const row1_col2_row2 = document.createElement("div");
							row1_col2_row2.classList.add("row")
							const row1_col2_row2_col = document.createElement("div");
							row1_col2_row2_col.classList.add("col", "p-0")
							const row1_col2_row2_col_span = document.createElement("span");
							
							const inputDate = new Date(list.sendDto.reg_date);
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
			
						   var regDate = syear + "." + smonth + "." + sday + " " + shour + ":" + sminute; 
							row1_col2_row2_col_span.innerText = regDate;
							row1_col2_row2_col.appendChild(row1_col2_row2_col_span)
							row1_col2_row2.appendChild(row1_col2_row2_col)
							row1_col2.appendChild(row1_col2_row2)
							row1.appendChild(row1_col2)
							
							const row2 = document.createElement("div");
							row2.classList.add("row", "border-bottom")
							const row2_col = document.createElement("div");
							row2_col.classList.add("col")
							row2_col.style.marginLeft = "53px";
							const row2_col_p = document.createElement("p");
							row2_col_p.innerText = list.postReviewDto.content;
							
							row2_col.appendChild(row2_col_p)
							row2.appendChild(row2_col)
							forDiv.appendChild(row1)
							forDiv.appendChild(row2)
							forContainer.appendChild(forDiv)
						});
					}
						
					
					const modal = bootstrap.Modal.getOrCreateInstance("#profileModal")
						modal.show();
						console.log("모달오픈")
					
				    	}         
				   }
					xhr.open("get", "../post/getProfileModal?userId=" + userId);
					xhr.send();   
				}
		
		
	
window.addEventListener("DOMContentLoaded", function(){
   getSession();
   joinMemberList();
   readCommentList();
   commentTotalCount();
   likeTotalCount();
   checkLike();
   partyButtonView();
   chatModal()

   
   
});


</script>
<style>
li {
	list-style-type: none;
}

a {
	color: black;
}

.spanStyle p {
	display: block;
}

body {
    font-family: 'Roboto', sans-serif;
  }
</style>
<title>Insert title here</title>
</head>
<body>

	<div class="container-fluid">
		<div class="row">
			<div class="col">
				<jsp:include page="../common/topNavi.jsp"></jsp:include>
			</div>
		</div>
	</div>
	
	
	<div class="container-fluid">
		<div class="row">
			<div class="col-2"></div>
			<div class="col-8">



				<!-- 게시글 foreach -->

				<div class="row">
					<div class="col mt-3 mb-3 ps-0">
						<c:forEach items="${postImageDto}" var="item">
							<img src="/uploadFiles/${item.post_image}" alt="사진"
								style="width: 100%; height: 400px; border-radius: 10px" />
						</c:forEach>
					</div>
				</div>
				<div class="row">
					<div class="col-9 border rounded">
						<div class="row mt-4">
							<div class="col me-2">
								<h4>${postDto.title}</h4>
							</div>
						</div>
						<div class="row mt-5 p-1">
							<div class="col" style="margin-right: 11px;">
								<div class="border rounded" style="width: 600px; padding: 15px">
									<!-- 지역 모집인원 날짜 -->
									<span style="color: #6A6A6A; font-size: 17px;">지역 </span><span>${postDto.going}</span>
									<span style="color: #6A6A6A; font-size: 17px; margin-left: 13px;">모집인원 </span><span>${postDto.person_count}명</span>
									<p style="margin: 0px"><span style="font-size: 17px;">
										<i class="bi bi-briefcase-fill me-1" style="color: #6A6A6A"></i>
										<fmt:formatDate var="start" value="${postDto.day_start}" pattern="yyyy.MM.dd"/>
										<fmt:formatDate var="end" value="${postDto.day_end}" pattern="yyyy.MM.dd"/>
										${start} ~ ${end}
									</span></p>
								</div>
							</div>
						</div>


						

						<div class="row mt-4">
							<div class="col-10">
								<p>${postDto.content}</p>
							</div>
						</div>





						<div class="row mt-4">
							<div class="col">
								<fmt:formatDate value="${postDto.reg_date}"
									pattern="yyyy.MM.dd HH:mm" var="date" />
								<span>${date}</span> <span class="ms-2 me-2">|</span> <span>조회수
									${postDto.hit}</span> <span class="ms-2 me-2">|</span>
								<c:if test="${!empty sessionUser}">
									<span><a id="" href="#" data-bs-toggle="modal" data-bs-target="#postReport">신고하기</a></span>
									
									<%-- <span><a href="./reportPage?post_id=${postDto.id}">신고하기</a></span> --%>
								</c:if>
								<c:if test="${empty sessionUser}">
									<span><a href="#" onclick="userCheck();">신고하기</a></span>
								</c:if>
							</div>
						</div>


						
							<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="postReport" aria-hidden="true">
							  <div class="modal-dialog">
							    <div class="modal-content">
							      <div class="modal-header">
							        <h1 class="modal-title fs-5" id="exampleModalLabel">신고하기</h1>
							        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							      </div>
							      <div class="modal-body">
							        <form>
							          <div class="mb-3">
							            <label for="recipient-name" class="col-form-label">Recipient:</label>
							            <input type="text" class="form-control" id="partyTitle" placeholder="제목을 입력해주세요.">
							          </div>
							          <div class="mb-3">
							            <label for="message-text" class="col-form-label">Message:</label>
							            <textarea class="form-control" id="message-text" placeholder="내용을 입력해주세요."></textarea>
							          </div>
							        </form>
							      </div>
							      <div class="modal-footer">
							        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
							        <button type="button" class="btn btn-primary" id="reportSubmit">신고하기</button>
							      </div>
							    </div>
							  </div>
							</div>
							
							
							
							
							
							<div class="modal fade" id="postReport" tabindex="-1" aria-labelledby="postReport" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content text-center">
										<div class="modal-header">
											<h1 class="modal-title fs-5" id="partyModalLabel">신고하기</h1>
											<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
										</div>
										<div class="modal-body">
											<div class="row">
												<div class="col">
													<label class="d-flex justify-content-start" for="partyTitle">동행 제목:</label>
													<input class="form-control" id="partyTitle" type="text" value="${postDto.title}" disabled>
												</div>
											</div>
											<div class="row mt-2">
												<div class="col">
													<label class="d-flex justify-content-start" for="reportName">신고자 이름 :</label>
													<input class="form-control" id="reportName" type="text" value="${sessionUser.user_name}" disabled>
												</div>
											</div>
											<div class="row mt-2">
												<div class="col">
													<label class="d-flex justify-content-start" for="title">제목 :</label>
													<input class="form-control" type="text" name="title" id="inputTitle" placeholder="제목을 입력해주세요.">
												</div>
											</div>
											<div class="row mt-2">
												<div class="col">
													<label class="d-flex justify-content-start" for="textarea">내용 :</label>
													<textarea class="form-control" name="content" id="inputTextarea" cols="50" rows="7" placeholder="내용을 입력해주세요"></textarea>
												</div>
											</div>
											<div class="row mt-3">
												<div class="col">
													<input class="form-control" type="file" id="image_file" name="image_file" style="margin-right: 110px;" multiple accept="image/*"> 
												</div>
											</div>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소하기</button>
											<button id="insertSubmit" type="button" class="btn btn-primary" onclick="postReport();">신고하기</button>
										</div>
									</div>
								</div>
							</div>
						






						<div class="row mt-2">
							<div class="col">
								<i onclick="clickLike();" id="likeIconBox"
									class="bi bi-heart text-danger"></i> <span
									id="likeTotalCountBox">좋아요 5</span> <i
									class="ms-3 bi bi-chat-dots"></i> <span id="commentCountBox">댓글
									3</span>
							</div>
						</div>





						<!-- 댓글 달기 -->

						<div class="row mt-3">
							<div class="col">
								<div class="row">
									<div class="col-10">
										<input id="commentBox" class="form-control" type="text"
											placeholder="댓글을 입력해주세요.">
									</div>
									<div class="col-2">
										<input type="button" class="btn btn-primary"
											onclick="comment()" value="게시">
									</div>
								</div>
								<div class="row mt-3 mb-2">
									<div class="col p-0 ">
										<!-- <hr class="m-0 mt-3"> -->
									</div>
								</div>
							</div>
						</div>


						<div id="commentContainer" class="row mt-1"></div>

						<div id="reCommentContainer" class="row mt-1"></div>
						
					</div>
					<div class="col-3">
						<div class="row">
							<div class="col">
								<div class="card mb-3" style="max-width: 540px; height: 105px;">
									<div class="row">
										<div class="col-4 d-flex align-items-center justify-content-center">
											<c:choose>
												<c:when test="${userDto.profile_img.startsWith('http')}">
													<img src="${userDto.profile_img}" class="img-fluid rounded-circle p-3 mt-2" alt="프로필" style="height: 90px; width: 90px;" onclick="profileModal(${userDto.id});">		
												</c:when>
												<c:otherwise>
													<img src="/uploadFiles/${userDto.profile_img}" class="img-fluid rounded-circle p-3 mt-2" alt="프로필" style="height: 90px; width: 90px;" onclick="profileModal(${userDto.id});">
												</c:otherwise>
											</c:choose>
											
										</div>
										<div class="col-md-6">
											<div class="row- mt-4">
												<div class="col">${userDto.user_name}</div>
											</div>
											<div class="row mt-2">
												<div class="col">
													<span>${birthday}</span> 
													<span class="ms-2">·</span>
													<c:choose>
                                                   		<c:when test="${userDto.gender  == 'M'}">
                                                   			<span class="ms-2">남자</span>		
                                                   		</c:when>
                                                   		<c:otherwise>
                                                   			<span class="ms-2">여자</span>
                                                   		</c:otherwise>
                                                   	</c:choose>
													
												</div>
											</div>
										</div>
										<div class="col-2"></div>
									</div>
								</div>
							</div>
						</div>




						<div id="partyButtonRow" class="row">

							<div class="col">
								<div class="card" style="width: auto;">
									<ul class="list-group list-group-flush">
										<li class="list-group-item ">
											<button type="button" class="btn btn-primary d-grid" id="partyBtn" style="width: 100%;">파티참가</button>
										</li>
									</ul>
								</div>
							</div>
						</div>


						<!-- 파티참가 모달 -->
						<form id="submitModalForm" method="post"
							enctype="multipart/form-data">
							<div class="modal fade" id="partyModal" tabindex="-1"
								aria-labelledby="partyModal" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content text-center">
										<div class="modal-header">
											<h1 class="modal-title fs-5" id="partyModalLabel">파티 참가신청</h1>
											<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
										</div>
										<div class="modal-body">
											<div class="row">
												<div class="col ">
													<textarea class="form-control" name="welcome_ment" cols="50" rows="7" placeholder="가입인사를 입력해주세요."></textarea>
												</div>
											</div>
											<div class="row mt-3">
												<div class="col">
													<input class="form-control" type="file" name="confirm_image1" style="margin-right: 110px;" multiple accept="image/*"> 
													<input type="hidden" id="create_id" name="create_id" value="${postDto.create_id}">
												</div>
											</div>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소하기</button>
											<button id="insertSbmit" type="button" class="btn btn-primary">신청하기</button>
										</div>
									</div>
								</div>
							</div>
						</form>







						<!-- 함께하는 동행 -->

						<div id="togetherUser" class="row mt-3"></div>
						<!-- /함께하는 동행 -->
						
					</div>
				</div>

			</div>
			<div class="col-2">
				
			</div>
			
				<div class="row">
					<div class="col"
						style="position: fixed; fixed; bottom: 15%; right: -90.6%; z-index: 9999;">
						<i class="bi bi-chat-left-text-fill" style="font-size: 40px"
							data-bs-toggle="modal" data-bs-target="#boardModal"
							onclick="getBoardList();"></i>
					</div>
				</div>
				<div class="row">
					<div class="col justify-content-center"
						style="position: fixed; bottom: 8%; right:-90.2%; font-size: 40px; z-index: 9999;">
						<label class="text-center"
							style="background-color: yellow; height: 60px; width: 60px; border-radius: 50%;">
							<i class="bi bi-chat-dots-fill" onclick="clickChatModal();"></i>
						</label>
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




		<!-- 프로필 모달 -->
		<div class="modal fade" id="profileModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content" style="width: 400px; height: 500px;">
					<div class="modal-header" style="height: 30px;">
						<h1 class="modal-title fs-5 content-center" id="exampleModalLabel">프로필</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body" style="overflow-y: auto; padding: 15px;">
						<div class="row">
							<div class="col-2 p-0 m-0"
								style="margin-left: 10px; justify-content: center;">
								<img id="profileContainer" alt=""
									style="width: 70px; height: 70px; border-radius: 50%; margin-left: 10px;">
							</div>
							<div class="col ms-3" style="margin-top: 11px;">
				                  <p class="m-0 mb-1" style="font-size: 15px;" id="nameContainer">닉네임</p>
				                  <span id="ageBox" style="font-size: 15px; color: #008FF6;">20대 ·</span>
				                  <span id="genderBox" style="font-size: 15px; color: #008FF6;">남자</span>
			                </div>
						</div>
						<div class="row mt-2">
							<div class="col">
								<span>매너온도</span> <i class="bi bi-info-lg"></i>
							</div>
						</div>
						<div class="row mt-2">
							<div class="col-12" style="position: relative;">
								<small
									style="position: absolute; left: 30%; bottom: 27px; color: gray;">첫
									온도 36.5</small>
								<div class="text-end mb-1 me-1">
									<b style="color: #36ad37;" id="temperatureContainer">36.5℃</b> <span id="imoBox">😄</span>
								</div>
								<i class="bi bi-caret-down-fill"
									style="position: absolute; left: 35.8%; bottom: 10px;"></i>
								<div class="progress" role="progressbar"
									aria-label="Basic example" aria-valuenow="0" aria-valuemin="0"
									aria-valuemax="100" style="height: 12px;">
									<div id="tempContainer" class="progress-bar"
										style="width: 36.5%; background-color: #36ad37;"></div>
								</div>
							</div>
						</div>
						<div class="row mt-3">
							<div class="col border-top border-bottom pt-3 pb-3">
								<span id="countContainer">받은거래 후기 4</span>
							</div>
						</div>
						<div id="forContainer"></div>
						
					</div>
				</div>
			</div>
		</div>





<script
src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
crossorigin="anonymous"></script>
<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>