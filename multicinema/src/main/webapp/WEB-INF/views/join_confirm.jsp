<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>멀티시네마 가입여부 확인</title>

<style>
	html{
		text-align:center;
	}
	#container{
		height: 460px;
	}
	#contents{
		height: 460px;
	}
	.text_box {
		width: 550px;
		float: right;
		margin-left: 250px;
		text-align: left;
	}
	
	#check{
		height:400px;
		background-color:  rgb(192, 192, 192,0.1);
		width: 800px;
		margin:0 auto;
		
	}
	#contents_header{
		height:64px;
	}
	#check_member_form{
		margin-top: 60px;
		height: 180px;
	}
	#info{
		padding-top: 20px;
		height: 20%;
		line-height: 40px;
	}
	#btn_confirm_wrap{
		display: inline-block;
		margin-top: 40px;
	}
	#btn_confirm{
		text-decoration: none;
		color: black;
	}
	#btn_confirm > div{
		
		background-color: rgb(254, 228, 1);
		border-radius: 10px;
		width: 130px;
		height: 60px;
		line-height: 60px;
	}
	.error_message{
		font-size: 12px;
		color: red;
	}
</style>
<link rel="stylesheet" type="text/css" href="css/index.css">
</head>
<header class="body">
	<div class="header">
		<h1 class="mainlogo">
			<a href="mainpage.html" title="홈화면으로 가기">홈으로가기</a>
		</h1>
		<div class="myinformation">
			<a href="mainpage.html">로그인하기</a>
			<a href="signin.html">회원가입</a>
		</div>
	</div>
		
	<hr>
	<ul id="mainNavigator">
		<li id="movie"><a href="movie.html">영화</a></li>
		<li id="ticketing"><a href="timetable_select.html">예매</a></li>
		<li id="theater"><a href="theater.html">영화관</a></li>
	</ul>
	<hr>
</header>
<script>
//아이디 입력
//아이디가 조건에 맞는지(글자수 8~15글자, 영어,숫자만)
//안맞으면 member_validating에 focus가 사라진 뒤 오류메세지를 띄우게
//이메일이 조건에 맞는지
//안맞으면 member_validating에 focus가 사라진 뒤 오류메세지를 띄우게
//가입여부 확인 눌렀을 때 중복확인 + 조건확인
//통과시 회원가입 페이지로
//그 외엔 오류 메세지 띄우기
	onload=function(){
		let user_id = document.getElementById("user_id");
		let user_email = document.getElementById("user_email");
		let user_id_errMsg = document.querySelector("#user_id_errmsg");
		let user_email_errMsg = document.querySelector("#user_email_errmsg");
		let email_select = document.getElementById("email_select");
		let user_email_dir=document.getElementById("user_email_dir");
		let btn_confirm = document.getElementById("btn_confirm");
		
		let user_id_reg = /^[A-Za-z0-9]{4,12}$/;;
		let user_email_reg = /^[A-Za-z0-9]{4,12}$/;
		let user_email_dir_reg = /^[A-Za-z0-9]{1,}.(co\.kr|com|net)$/
		let email_reg =/^[A-Za-z0-9]{4,12}@[A-Za-z0-9]{1,}.(co\.kr|com|net)$/
		
		let dummy = {
			userid: "testdummy",
			email: "testdummy@naver.com"
		}
		
		//아이디, 이메일 입력 후 focus 사라지면 error 숨겨져 있던 메세지 출력
		let email = "";
		
		user_id.onblur=function(){
			
			if(user_id_reg.test(user_id.value) == false){
				user_id_errMsg.setAttribute("style","visibility: visible");
				user_id_errMsg.innerHTML = "영어, 숫자 혼합 4~12글자 아이디만 입력하실 수 있습니다";
			}else{
				user_id_errMsg.setAttribute("style","visibility: hidden");
				user_id_errMsg.innerHTML = ""
				
			}
		}
		
		user_email.onfocus = function(){
			user_email_errMsg.innerHTML = "";
		}
		
		user_email.onblur = function(){
			let flg = true;
			if(user_email_reg.test(user_email.value) == false){
				user_email_errMsg.setAttribute("style","visibility: visible");
				user_email_errMsg.innerHTML += "입력 양식이 올바르지 않습니다<br>";
				flg = false;
				
			}
			if(user_email_dir_reg.test(user_email_dir.value) == false && email_select.value=="직접입력"){
				user_email_errMsg.setAttribute("style","visibility: visible");
				user_email_errMsg.innerHTML += "도메인 입력 양식이 올바르지 않습니다<br>";
				flg = false;
			}
			if(flg){
				user_email_errMsg.setAttribute("style","visibility: hidden");
				email = user_email.value + "@" + email_select.value;
				console.log(email);
			}
		}
		
		email_select.onchange = function () {

			if (email_select.value == "직접입력") {

				user_email_dir.setAttribute("style", "visibility: visible");

				user_email_dir.onfocus = function () {
					user_email_errMsg.innerHTML = "";
				}

				user_email_dir.onblur = function () {
					let flg = true;
					if (user_email_reg.test(user_email.value) == false) {
						user_email_errMsg.setAttribute("style", "visibility: visible");
						user_email_errMsg.innerHTML += "입력 양식이 올바르지 않습니다<br>";
						flg = false;

					}
					if (user_email_dir_reg.test(user_email_dir.value) == false && email_select.value == "직접입력") {
						user_email_errMsg.setAttribute("style", "visibility: visible");
						user_email_errMsg.innerHTML += "도메인 입력 양식이 올바르지 않습니다<br>";
						flg = false;
					}
					if (flg) {
						user_email_errMsg.setAttribute("style", "visibility: hidden");
						email = user_email.value + "@" + user_email_dir.value;
						console.log(email);
					}
				}
			}
			else {
				user_email_dir.setAttribute("style", "visibility: hidden");
				user_email_dir.value = "";
				email = user_email.value + "@" + email_select.value;
				console.log(email);
			}
		
		}//email_select.onchange end
		
		btn_confirm.onclick = function(e){
			let tmp = email_select.value == "직접입력"? user_email_dir.value : email_select.value
			let email = user_email.value + "@" + tmp;
			let id = user_id.value;
			if(!email_reg.test(email) || !user_id_reg.test(id)){
				e.preventDefault();
				alert("다시 입력해주세요");
			}else if(false){
				e.preventDefault();
				alert("중복된 아이디 입니다");
				//db에서 끌고오는 걸 어떤 식으로 구현 해놓을까
			}
			else{
				btn_confirm.setAttribute("href", "member_join.html?" + "id="+id +"&em="+email);
				alert("인증되었습니다");
				
			}
		}
	}
</script>
</head>
<body>
<div id="container">
	<div id="contents">
		<div id="contents_header">
			<h1>Multi Cinema 가입여부 확인</h1>
		</div>
		<div id="check">
			<div id="info">
				<P>회원 가입 여부 확인을 위해 개인정보를 정확히 입력해주세요<br>
					입력하신 정보는 가입 여부 확인에만 사용되며 저장되지 않습니다
				</P>
			</div>
			<div id="check_member_form">
				<div class="text_box">
					아이디 <input type="text" class="text" id="user_id" placeholder="아이디를 입력해주세요.">
					<p class="error_message" id="user_id_errmsg" style="visibility: hidden"></p>
				</div>
				<div class="text_box">
					이메일 <input type="text" class="text" id="user_email" placeholder="이메일을 입력해주세요">
					@
					<select id="email_select">
						<option>naver.com</option>
						<option>google.com</option>
						<option>daum.net</option>
						<option>직접입력</option>
					</select>
					<input type="text" class="text" id="user_email_dir" placeholder="도메인을 입력해주세요" style="visibility: hidden">
					<p class="error_message" id="user_email_errmsg" style="visibility: hidden"></p>
				</div>
				
				<div id="btn_confirm_wrap">
					<a href="member_join.html" id="btn_confirm"><div>가입여부 확인</div></a>
				</div> 
			</div>
		</div>
	</div> 
</div>
</body>
</html>