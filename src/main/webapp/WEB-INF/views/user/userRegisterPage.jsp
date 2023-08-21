<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<title>userRegisterPage</title>
<style>
	.custom-border {
		border: 1px solid rgba(128, 128, 128, 0.5);
  		/* border-radius: 15px; */
	}
	.col-login {
		border-bottom: 1px solid gray;
	}
	.gray-line {
        position: relative;
    }

    .gray-line::before {
        content: "";
        position: absolute;
        top: 50%;
        left: 0;
        transform: translateY(-50%);
        width: 100%;
        height: 1px;
        background-color: rgba(128, 128, 128, 0.5);
    }
	.custom-box {
  position: relative;
  display: flex;
  /* 다른 스타일들 */
}

.custom-box::before {
  content: "";
  flex-grow: 1;
  border-top: 1px solid black; /* 선의 색상을 설정합니다 */
}	


</style>
<script>

function checkNullPoint(){
   const userId = document.getElementById("userId");
   const userPw = document.getElementById("userPw");
   const userEmail = document.getElementById("userEmail");
   const userPhone = document.getElementById("userPhone");
   const userName = document.getElementById("userName");
   const userBirth = document.getElementById("userBirth");
   
   const prm = document.getElementById("prm");
   
   if(userId.value == ""){
      alert("아이디를 입력 해주세요.")
      return;
   }else if(userPw.value == ""){
      alert("패스워드를 입력 해주세요.")
      return;
   }else if(userEmail.value == ""){
      alert("이메일을 입력 해주세요.")
      return;
   }else if(userPhone.value == ""){
      alert("전화번호를 입력 해주세요.")
      return;
   }else if(userName.value == ""){
      alert("이름을 입력 해주세요.")
      return;
   }else if(userBirth.value == ""){
	  alert("생일을 입력해주세요")
	  return;
   }
   
   
   const importantAgrees = document.getElementsByClassName("importantAgree");
   for(importantAgree of importantAgrees){
      const isChecked = importantAgree.checked;
      if(isChecked == false){
         alert("필수 약관에 동의 해주세요.")
         return;
      }
   }
   if(ableid==0){
      alert("아이디가 중복 되었습니다.")
      return;
   }else if(ablepw ==0){
      alert("비밀번호 확인이 일치하지 않습니다.")
      return;
   }
   prm.submit();
}

var ableid = 0;
var ablepw= 0;
function useAbleId(){
   const xhr = new XMLHttpRequest();
   const userId = document.getElementById("userId")
   const idConfirm = document.getElementById("idConfirm")

   xhr.onreadystatechange=function(){
      if(xhr.readyState==4 && xhr.status==200){
         const response = JSON.parse(xhr.responseText);
         if(response.data == false){
            idConfirm.classList.add("text-primary");
            idConfirm.classList.remove("text-danger");
            idConfirm.innerText = "사용 가능한 아이디"
            ableid = 1;
         }else{
            idConfirm.classList.add("text-danger");
            idConfirm.classList.remove("text-primary");
            idConfirm.innerText = "사용 불가능한 아이디"
               ableid = 0;
         }
      }
   }
   xhr.open("get","./existsUserId?id="+userId.value);
   xhr.send();
}

function passwordConfirm(){
   const password = document.getElementById("userPw");
   const passConfirm = document.getElementById("userPwConfirm");
   const pwConfirm = document.getElementById("pwConfirm")
   if(password.value != passConfirm.value){
      pwConfirm.classList.add("text-danger");
      pwConfirm.classList.remove("text-primary");
      pwConfirm.innerText = "비밀번호가 일치하지 않습니다."
         ablepw=0;
   }else{
      pwConfirm.classList.add("text-primary");
      pwConfirm.classList.remove("text-danger");
      pwConfirm.innerText = "비밀번호가 일치합니다."
         ablepw=1;
   }
}








</script>
</head>
<body>
<jsp:include page="../common/topNavi.jsp"></jsp:include>
	<div class="container-fluid">
        <div class="row">
            <div class="col-3"></div>
            <div class="col">
                <div class="row">
                    <div class="col"></div>
                    <div class="col-10">
                        <div class="row">
                            <div class="col-2"></div>
                            <div class="col-8">
								<div class="row text-center">
									<div class="col mt-5 fw-bold fs-4 text-center">회원가입</div>
								</div>
								<!-- 회원가입폼 -->
								<div class="row">
									<div class="col">
										<form id="prm" action="./userRegisterProcess" method="post" enctype="multipart/form-data">
											<div class="row mt-5">
												<div class="col"></div>
												<div class="col-10">
													<label for="userId"><span class="small fw-semibold">아이디 *</span></label>
													<input name="user_id" type="text" placeholder="아이디를 입력해주세요" class="form-control mt-2" id="userId" onblur="useAbleId()">
													<div id="idConfirm"></div>
												</div>
												<div class="col"></div>
											</div>
											<div class="row mt-2">
												<div class="col"></div>
												<div class="col-10">
													<label for="userPw"><span class="small fw-semibold">비밀번호 *</span></label>
													<input name="user_pw" type="password" placeholder="비밀번호를 입력해주세요" class="form-control mt-2" id="userPw">
												</div>
												<div class="col"></div>
											</div>
											<div class="row mt-2">
                                                <div class="col"></div>
												<div class="col-10">
                                                    <label for="userPwConfirm"><span class="small fw-semibold">비밀번호 확인 *</span></label>
													<input name="#" type="password" placeholder="비밀번호를 한번더 입력해주세요" class="form-control mt-2" id="userPwConfirm" onblur="passwordConfirm()">
                                                    <div id="pwConfirm"></div>
												</div>
												<div class="col"></div>
											</div>
											<div class="row mt-2">
												<div class="col"></div>
												<div class="col-10">
													<label for="userName"><span class="small fw-semibold">이름 *</span></label>
													<input name="user_name" type="text" placeholder="이름을 입력해주세요" class="form-control mt-2" id="userName">
												</div>
												<div class="col"></div>
											</div>
											<div class="row mt-2">
												<div class="col"></div>
												<div class="col-10">
													<div class="row mt-2">
														<div class="col-4">
															<span class="small fw-semibold">성별 *</span>
														</div>
														<div class="col-4 form-check">
															<input class="form-check-input" type="radio" name="gender" value="M" id="M" checked>
															<label class="form-check-label" for="M">남자</label>
														</div>
														<div class="col-4 form-check justify-content-end">
															<input class="form-check-input" type="radio" name="gender" value="F" id="F">
															<label class="form-check-label" for="F">여자</label>
														</div>
													</div>
												</div>
												<div class="col"></div>
											</div>
											<div class="row mt-2">
												<div class="col"></div>
												<div class="col-10">
													<label for="userBirth"><span class="small fw-semibold">생년월일 *</span></label>
													<input name="birth" type="date" class="form-control mt-2" id="userBirth">
												</div>
												<div class="col"></div>
											</div>
											<div class="row mt-2">
												<div class="col"></div>
												<div class="col-10">
													<label for="userPhone"><span class="small fw-semibold">전화번호 *</span></label>
													<input name="phone_number" type="text" placeholder="전화번호를 입력해주세요" class="form-control mt-2" id="userPhone">
												</div>
												<div class="col"></div>
											</div>
											<div class="row mt-2">
												<div class="col"></div>
												<div class="col-10">
													<label for="userEmail"><span class="small fw-semibold">이메일 *</span></label>
													<input name="email" type="email" placeholder="이메일을 입력해주세요" class="form-control mt-2" id="userEmail">
												</div>
												<div class="col"></div>
											</div>
											<div class="row mt-2">
												<div class="col"></div>
												<div class="col-10">
													<span class="small fw-semibold">프로필사진 </span>
													<input name="image" type="file" accept="image/*" class="form-control mt-2">
												</div>
												<div class="col"></div>
											</div>
											<div class="row mt-3">
												<div class="col"></div>
												<div class="col-10">
													<input class="form-check-input" type="checkbox" id="termAgree">
													<label class="form-check-label" for="termAgree"><span class="small fw-semibold"> 전체 약관 동의 </span></label>
													<div class="row mt-2 mx-1 border rounded px-1 py-3 ">
														<div class="col">
															<div class="row">
																<div class="col">
																	<input class="form-check-input importantAgree" type="checkbox" id="termAgree">
																	<label class="form-check-label" for="termAgree"><span class="small"> [필수] 만 14세 이상입니다. </span></label>
																</div>
															</div>
															<div class="row mt-2">
																<div class="col">
																	<input class="form-check-input importantAgree" type="checkbox" id="termAgree">
																	<label class="form-check-label" for="termAgree"><span class="small"> [필수] 회원가입 및 운영약관 동의</span></label>
																</div>
															</div>
															<div class="row mt-2">
																<div class="col">
																	<input class="form-check-input importantAgree" type="checkbox" id="termAgree">
																	<label class="form-check-label" for="termAgree"><span class="small"> [필수] 위치 정보 이용약관 동의</span></label>
																</div>
															</div>
															<div class="row mt-2">
																<div class="col">
																	<input class="form-check-input" type="checkbox" id="termAgree">
																	<label class="form-check-label" for="termAgree"><span class="small"> [선택] 마케팅 수신 동의</span></label>
																</div>
															</div>
														</div>													
													</div>
												</div>
												<div class="col"></div>
											</div>
											<div class="row">
												<div class="col"></div>
												<div class="col-10">
													<input type="button" value="회원가입" onclick="checkNullPoint()" class="btn btn-lg btn-block mt-3 w-100 buttonColor" 
															style="background-color: #46B8FF !important; color : white; border-radius: 5px;">
												</div>
												<div class="col"></div>
											</div>
										</form>
									</div>
								</div>

                                <div class="row my-4">
                                    <div class="col"></div>
                                    <div class="col-10">
                                    </div>
                                    <div class="col"></div>
                                </div>
                            </div>
                            <div class="col-2"></div>
                        </div>
                    </div>
                    <div class="col"></div>
                </div>
            </div>
            <div class="col-3"></div>
        </div>
    </div>
    <jsp:include page="../common/footer.jsp"></jsp:include>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

</body>
</html>