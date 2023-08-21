<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
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
.buttonColor {
    background-color: #46B8FF	 !important;
  }
</style>
<script>
function checkValueAndSubmit(){

   const userIdBox = document.getElementById("userId");
   const idValue = userIdBox.value;

   if(idValue == ""){ // 
      alert("아이디를 입력해주세요");
      userIdBox.focus(); 
      return; 
   }

   const userPwBox = document.getElementById("userPw");
   const userPwConfirmBox = document.getElementById("userPwConfirm");
   
   if(userPwBox.value != userPwConfirmBox.value){
      alert("비밀번호 확인을 해주세요..");
   
      userPwBox.value = ""; 
      userConfirmBox.value = "";
   
      userPwBox.focus();
   
      return;
   }

   if(idChecked == false){    
      alert("중복확인을 해주세요")
      return;   
   }

   const frm = document.getElementById("frm")
   frm.submit();


}


let idChecked = false; 

function checkUserId(){
   const userIdValue = document.getElementById("userId").value;

const xhr = new XMLHttpRequest();

xhr.onreadystatechange = function(){
      if(xhr.readyState == 4 && xhr.status ==200){
         const response = JSON.parse(xhr.responseText); 
   
         const idCheckedAlert = document.getElementById("idCheckAlert")

         if(response.data == true){
            idCheckAlert.style.color = "red";
            idCheckAlert.innerText = "사용 불가능한 아이디입니다."; 
            alert("이미 존재하는 아이디입니다")
            idChecked = false;
         }else{
            idCheckAlert.style.color = "green";
            idCheckAlert.innerText = "사용 가능한 아이디입니다.";
            alert("사용 가능한 아이디 입니다.")
            idChecked = true;
      }   
   }
};

xhr.open("get", "./existsUserId?userId=" + userIdValue);
xhr.send();
}

function checkNullPoint(){
	const seller_id = document.getElementById("seller_id");
	const seller_pw = document.getElementById("seller_pw");
	const email = document.getElementById("email");
	const phone = document.getElementById("phone");
	const seller_name = document.getElementById("seller_name");
	
	const prm = document.getElementById("prm");
	
	if(seller_id.value == ""){
		alert("아이디를 입력 해주세요.")
		return;
	}else if(seller_pw.value == ""){
		alert("패스워드를 입력 해주세요.")
		return;
	}else if(email.value == ""){
		alert("이메일을 입력 해주세요.")
		return;
	}else if(phone.value == ""){
		alert("전화번호를 입력 해주세요.")
		return;
	}else if(seller_name.value == ""){
		alert("이름을 입력 해주세요.")
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
	const seller_id = document.getElementById("seller_id")
	const idConfirm = document.getElementById("idConfirm")

	xhr.onreadystatechange=function(){
		if(xhr.readyState==4 && xhr.status==200){
			const response = JSON.parse(xhr.responseText);
			if(response.result =="success"){
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
	xhr.open("get","./useAbleId?id="+seller_id.value);
	xhr.send();
}

function passwordConfirm(){
	const password = document.getElementById("seller_pw");
	const passConfirm = document.getElementById("sellerPwConfirm");
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
<body>      <jsp:include page="../common/topNavi.jsp"></jsp:include>

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
                        <div class="row ms-4 mt-5">
                           <div class="col mt-5 fw-bold fs-2">파트너 가입이 완료 되었습니다!</div>
                        </div>
                        <div class="row ms-4">
                           <div class="col mt-2 fw-bold text-secondary fs-5">숙소를 등록하여 파트너 활동을 진행하세요.
</div>

						<div class="row  mb-5">
                           <div class="col mt-3 fw-bold text-secondary"> * 숙소는 서류승인을 받은 이후에 영업 가능합니다.</div>
                        </div>
                        <div class="row  mt-2">
                           <div class="col mt-3 d-grid mb-5"><a type="button" style="background-color: #46B8FF" class="btn text-white fs-5 fw-semibold" href="./sellerLoginPage">파트너 로그인</a></div>
                        </div>
                        </div>
                       
                        
                            </div>
                            <div class="col-2"></div>
                        </div>
                                <div class="row mb-3 ms-4">
                        <div class="col"><img src="../resources/img/regiadd.jpg" class="img-fluid"></div>
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