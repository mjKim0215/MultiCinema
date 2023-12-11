<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>멀티시네마 회원가입 페이지</title>
<link rel="stylesheet" type="text/css" href="css/index.css">
</head>
<header class="body">
	<div class="header">
		<h1 class="mainlogo">
			<a href="mainpage.html" title="홈화면으로 가기">홈으로가기</a>
		</h1>
		<div class="myinformation">
			<a href="main_signin.html">로그인하기</a>
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
<style>
	html{
		text-align:center;
	}
	#container{
		height: 600px;
	}
	#contents{
		height: 700px;
		width: 800px;
		margin:0 auto;
		
	}
	#contents_header{
		margin:50px;
	}
	
	table{
		width:700px;
		height: 500px;
		margin:0 auto;
		
	}
	table th {
		background-color: rgb(192, 192, 192,0.3);
		
	}
	
	table td{
		border-bottom: rgb(192, 192, 192 ,0.5) 1px solid;
	
		
	}
	input{
		width: 400px;
	}
	
	p{
		margin: 0px;
		color: red;
		font-size: 11px;
	}
	
	#btn_join > div{
		
		background-color: rgb(254, 228, 1);
		border-radius: 10px;
		width: 130px;
		height: 60px;
		line-height: 60px;
	}
	
	#btn_join_wrap{
		width: 130px;
		margin: 0 auto;
		margin-top: 30px;
	}
	
	#btn_join{
		text-decoration: none;
		color: black;
	}
</style>
<script>
	onload = function () {
		let user_id = document.getElementById("user_id");
		let user_email = document.getElementById("user_email");
		let user_pw = document.getElementById("user_pw");
		let user_pw_check = document.getElementById("user_pw_check");
		let user_birth = document.getElementById("user_birth");
		let user_birth_errmsg = document.getElementById("user_birth_errmsg");
		let user_pw_errmsg = document.getElementById("user_pw_errmsg");
		let user_pw_check_errmsg = document.getElementById("user_pw_check_errmsg");
		let user_name = document.getElementById("user_name");
		let user_name_errmsg = document.getElementById("user_name_errmsg");
		let user_pw_onCaps = document.getElementById("user_pw_onCaps");
		let btn_join = document.getElementById("btn_join");
		
		if(location.href.split("?")[1] == undefined){
			alert("잘못된 접근입니다");
			location.href = "join_confirm.html";
		}
		
		let receive_data = location.href.split("?")[1].split("&");
		let receive_data_form = ["id=", "em="];
		let user_data = {
			id: "",
			email: "",
			pw: "",
			name: "",
			birth: ""
		}
		for (let i = 0; i < receive_data.length; i++) {
			let idx = receive_data_form.indexOf(receive_data[i].slice(0, 3));
			switch (idx) {
				case 0: user_data.id = receive_data[i].slice(3);
				case 1: user_data.email = receive_data[i].slice(3);
			}
		}
		
		//아이디 이메일 유저 정보에 미리 넣어주기
		user_id.innerHTML = user_data.id;
		user_email.innerHTML = user_data.email;
		
		//이름 양식: 완성된 한글 + 알파벳
		let user_name_reg = /^[가-힣a-zA-z]{1,}$/g;
		
		user_name.addEventListener("change", () => { //강사님께 여쭤보기 이름 입력후 다른 text를 누르면 false가 뜨는것
			if(user_name_reg.test(user_name.value) == false){
				user_name_errmsg.style = "visibility: visible";
				user_name_errmsg.innerHTML = "올바르지 않은 이름입니다";
			}else{
				user_name_errmsg.innerHTML = "";
				user_name_errmsg.style = "visibility: collapse";
			}
		});
		
		
		
		//생년월일: 오늘 날짜 이후를 선택하면 잘못된 날짜라고 알려주기
	
		user_birth.addEventListener("change", ()=>{
			
			if(new Date(user_birth.value) - Date.now() > 0){
				user_birth_errmsg.style = "visibility: visible";
				user_birth_errmsg.innerHTML = "올바르지 않은 날짜입니다"	;
			}else{
				user_birth_errmsg.style = "visibility: hidden";
				user_birth_errmsg.innerHTML = "";
			}
			
		});
		
		//비밀번호 양식: 몇자,특수문자 반드시,캡스락
		
		let user_pw_reg = /[~!@#$%^*+=-?_]{1}/g; //이 이외의 특수문자 걸러내기
	
		user_pw.addEventListener("focus",function(){
			user_pw_errmsg.innerHTML = "";
		});
		user_pw.addEventListener("change",function(){
			
			let flg = true;
			let spcl_num = user_pw.value.match(user_pw_reg) == null ? 0 : user_pw.value.match(user_pw_reg).length;
			if(spcl_num < 2){
				user_pw_errmsg.setAttribute("style", "visibility: visible");
				user_pw_errmsg.innerHTML += "특수문자를 반드시 2글자 이상 넣어야합니다<br>";
				flg = false;
			}
			if(user_pw.value.length < 8){
				user_pw_errmsg.setAttribute("style", "visibility: visible");
				user_pw_errmsg.innerHTML += "비밀번호를 최소 8자리 입력해주세요<br>";
				flg = false;
			}
			if(flg == true){
				user_pw_errmsg.setAttribute("style", "visibility: hidden");
				user_pw_errmsg.innerHTML = "";
			}
			
		});
		
		user_pw.addEventListener("keydown",function(e){
			
  			if (e.getModifierState("CapsLock")) {
				user_pw_onCaps.innerHTML = "CAPS LOCK이 켜져있습니다";
				user_pw_onCaps.style = "visibility: visible";
  			}else {
    			user_pw_onCaps.style = "visibility: hidden";
  			}
		});
		
		//비밀번호 확인: 일치하는지
		
	
		user_pw_check.onchange=function(){
			
			
			if(user_pw_check.value != user_pw.value){
				
				user_pw_check_errmsg.setAttribute("style", "visibility: visible");
				user_pw_check_errmsg.innerHTML = "비밀번호가 일치하지 않습니다";
			}else{
				user_pw_check_errmsg.setAttribute("style", "visibility: hidden");
				user_pw_check_errmsg.innerHTML = "";
			}
		}
		
		//회원가입 클릭시
		//양식에 적혀있는 것들을 재검증한 후 통과못하면 오류메세지 + 포커스
		btn_join.addEventListener("click", event =>{
			let spcl_num = user_pw.value.match(user_pw_reg) == null ? 0 : user_pw.value.match(user_pw_reg).length;
			let go_back = (err_target, e) => {
				err_target.focus();
				e.preventDefault();
				alert("다시 입력해주세요");
			}
			console.log(user_name_reg.test(user_name.value));
			if(user_name_reg.test(user_name.value) == false){
				go_back(user_name, event);
				console.log("이름값: " + user_name.value);
				console.log("이름 확인: " +user_name_reg.test(user_name.value));
				console.log("이름 오류");
			}
			else if(new Date(user_birth.value) - Date.now() > 0 || user_birth.value == ""){
				go_back(user_birth, event);
				console.log("생년월일 오류");
			}
			else if(spcl_num < 2){
				go_back(user_pw, event);
				console.log("비번 오류1");
			}
			else if(user_pw.value.length < 8){
				go_back(user_pw, event);
				console.log("비번 오류2");
			}
			else if(user_pw_check.value != user_pw.value){
				go_back(user_pw_check, event);
				console.log("비번확인 오류");
			}
			else{
				user_data.pw = user_pw.value;
				user_data.birth = user_birth.value;
				user_data.name = user_name.value;
				
				localStorage.setItem("name", user_data.name);
			}
			
			
			
		})
		
		
	}
	
</script>
</head>
<body>
	<div id="container">
		<div id="contents">
			<div id="contents_header">
			<h1>Multi Cinema 회원가입</h1>
			</div>
			<table>
				<tr>
					<th>이름</th>
					<td>
						<input type="text" class="text" id="user_name" placeholder="성함을 입력해주세요.">
						<p style="visibility: hidden" id="user_name_errmsg"></p>
					</td>
	
				</tr>
				<tr>
					<th>생년월일</th>
					<td>
						<input type="date" id="user_birth" >
						<p style="visibility: hidden" id="user_birth_errmsg"></p>
					</td>
				</tr>
				<tr>
					<th>아이디</th>
					<td id="user_id"></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td>
						<input type="password" id="user_pw" placeholder="특수문자 2개 이상을 포함한 8~16자의 비밀번호를 입력해주세요" maxlength="16">
						<p style="color: black">사용가능한 특수문자 ~ ! @ # $ % ^ * + = - ? _</p>
						<p id="user_pw_onCaps" style="visibility: hidden"></p>
						<p style="visibility: hidden" id="user_pw_errmsg"></p>
					</td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td>
						<input type="password" id="user_pw_check">
						<p style="visibility: hidden" id="user_pw_check_errmsg"></p>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td id="user_email"></td>
				</tr>
			</table>
	
			<div id="btn_join_wrap">
				<a href="welcome.html" id="btn_join"><div>회원가입</div></a>
			</div>
		</div>
	</div>
</body>
</html>








