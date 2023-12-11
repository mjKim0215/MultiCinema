<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>환영합니다</title>
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
	#main_page_btn{
		text-decoration: none;
		color: black;
		width: 180px;
		height: 50px;
		background-color: rgb(254, 228, 1);
		border: 10px solid rgb(254, 228, 1);
		display: block;
		margin:0 auto;
		line-height: 50px;
		
		border-radius: 3px;
	}
</style>
<script>
	onload=()=>{
		let name = localStorage.getItem("name");
		let welcome_greetings = document.getElementById("welcome_greetings");
/*		if(name == null){
			alert("잘못된 접근입니다");
			location.href = "mainpage.html";
		}
*/		welcome_greetings.innerHTML = name + "님<br><br> MultiCinema의 회원이 되신걸 진심으로 환영합니다";
		localStorage.clear();
	}
	
	
</script>
<body>
	<h1 id="welcome_greetings"></h1>
	<a id = "main_page_btn" href="mainpage.html">메인 화면으로 돌아가기</a>
</body>
</html>