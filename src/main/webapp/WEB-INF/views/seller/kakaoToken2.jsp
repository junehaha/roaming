<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<title>loginPage</title>
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
function kakaoLogin2(){
	   const xhr = new XMLHttpRequest();
	   
	   xhr.onreadystatechange = function(){
	      if(xhr.readyState==4 && xhr.status ==200){
	         const response = JSON.parse(xhr.responseText);
	         kakoaLogin3(response.access_token)
	         console.log(response)
	      }
	   }
	   xhr.open("post","https://kauth.kakao.com/oauth/token");
	   xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded;charset=utf-8");
	   xhr.send("grant_type=authorization_code&client_id=9c133e8e0ca99f4e08b962a90d53f8a4&redirect_uri=http://172.30.1.80:8181/roaming/seller/kakaoToken2&code="+'${code}')
	}

function kakoaLogin3(accessToken){
const xhr = new XMLHttpRequest();
	
	xhr.onreadystatechange = function(){
		if(xhr.readyState==4 && xhr.status ==200){
			const response = JSON.parse(xhr.responseText);
			console.log(response)
			const kid=  response.id;
			const name = response.kakao_account.profile.nickname;
			loginOrSign(kid,name)
		}
	}
	xhr.open("post","https://kapi.kakao.com/v2/user/me");
	xhr.setRequestHeader("Authorization"," Bearer "+accessToken);
	xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded;charset=utf-8");
	xhr.send()
}

function loginOrSign(kid,name){
const xhr = new XMLHttpRequest();
	
	xhr.onreadystatechange = function(){
		if(xhr.readyState==4 && xhr.status ==200){
			const response = JSON.parse(xhr.responseText);
			if(response.result == "login"){
				login()
			}else{
				register()
			}
		}
	}
	xhr.open("get","./loginOrSign2?kid="+kid+"&name="+name);
	xhr.send()
}

function login(){
	window.location.href ="../sellerboard/sellerHotelListPage";
}

function register(){
	window.location.href ="./kakaoRegister2";
}
window.addEventListener("DOMContentLoaded",function(){
	kakaoLogin2();
});
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
                            	<form action="../user/loginProcess" method="post">
                                <div class="row">
                                    <div class="col mt-5 fw-bold fs-4 text-start">로그인</div>
                                </div>
                                <div class="row mt-5">
                                  <div class="col mt-6 p-3 fs-6 text-center border-top border-end" style="border-radius: 0 5px 0 0; border-bottom: 2px solid black;">
                                    	<a href="../user/loginPage" style="text-decoration: none; color: black;">회원 로그인</a>
                                    </div>
                                    <div class="col mt-6 p-3 fw-bold fs-6 text-center" style="border-radius: 5px 5px 0 0; border-top: 2px solid black; border-left: 2px solid black; border-right: 2px solid black;">파트너 로그인</div>
                                  
                                </div>
                                <div class="row mt-3">
                              		<div class="col-1"></div>
                                    <div class="col"><img  class="img-fluid" src="/roaming/resources/img/kakaonavertoss.png" onclick="kakaoLogin1()"></div>
                                   <div class="col-1"></div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col pt-2 custom-box opacity-25"></div>
                                    <div class="col-2 text-center">또는</div>
                                    <div class="col pt-2 custom-box opacity-25"></div>
                                </div>
                                <div class="row mt-5">
                                    <div class="col"></div>
                                    <div class="col-10">
                                        <input type="text" name="user_id" class="form-control" placeholder="아이디">
                                    </div>
                                    <div class="col"></div>
                                </div>
                                <div class="row mt-2">
                                    <div class="col"></div>
                                    <div class="col-10">
                                        <input type="password" name="user_pw" class="form-control" placeholder="비밀번호">
                                    </div>
                                    <div class="col"></div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-1"></div>
                                    <div class="col small"><input type="checkbox" style="width: 17px; height: 17px; padding-top: 5px;">&nbsp;아이디 저장</div>
                                    <div class="col"></div>
                                    <div class="col"></div>
                                </div>
                                <div class="row">
                                    <div class="col"></div>
                                    <div class="col-10">
                                        <button class="btn btn-dark btn-lg btn-block mt-3 w-100" style="border-radius: 5px;">로그인</button>
                                    </div>
                                    <div class="col"></div>
                                </div>
                                </form>
                                <div class="row mt-3">
                                    <div class="col small text-center"><input type="checkbox" style="width: 17px; height: 17px; padding-top: 5px;">&nbsp;로그인 상태 유지</div>
                                </div>
                                <div class="row mt-4">
                                    <div class="col"></div>
                                    <div class="col-3 text-center small opacity-75 border-end" style="cursor: pointer;">아이디 찾기</div>
                                    <div class="col-3 text-center small opacity-75 border-end" style="cursor: pointer;">비밀번호 찾기</div>
                                    <div class="col-3 text-center small opacity-75">
                                    	<a href="../user/userRegisterPage" style="text-decoration: none; color: black;">파트너 신청</a>
                                    </div>
                                    <div class="col"></div>
                                </div>
                                <div class="row my-4">
                                    <div class="col"></div>
                                    <div class="col-10">
                                        <img class="img-fluid" src="/roaming/resources/img/loginbanner.png">
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