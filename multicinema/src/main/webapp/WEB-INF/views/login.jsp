<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/index.css">
<style>
	#contents{
		width: 800px;
		margin: 0 auto;	
		height: 443px;
	}
	#contents_header > h1{
		text-align: left;
	}
	#login_box{
		height: 132px;
		padding-top: 153px;
		padding-bottom: 153px;
		background-color: rgb(192, 192, 192,0.1);
		text-align: left;
		
	}
	#login_box input{
		width: 350px;
		height: 45px;
	}
	.user_login_wrap{
		width: 509px;
		display: inline-block;
		text-align: right;
	}
	#login_btn_wrap{
		height: 102px;
		width: 140px;
		border: 1px solid rgb(0,0,0,0.3);
		border-radius: 8px;
		background-color: rgb(254, 228, 1);
		text-align: center;
		position: relative;
		top: -102px;
		left: 511px;
		
	}
	#login_btn{
		text-decoration: none;
		color: rgb(0, 0, 0, 0.6);
		font-size: 20px;
		font-weight: 1000;
		line-height: 102px;
	}
	#sign_in_btn_wrap{
		position: relative;
		display: inline-block;
		top: -92px;
		left: 151px;
	}
	#sign_in_btn{
		text-decoration: none;
		color: rgb(0, 0, 0, 0.6);
		
	}
</style>
</head>
<body>
<div id="headerInput"></div>
<!-- body start -->

<div id="container">
	<div id="contents">
		<div id="contents_header">
		</div>
		<div id="login_box">
			<div class="user_login_wrap">
				<input id="user_login_id" type="text" placeholder="아이디를 입력해주세요">
			</div>
			<div class="user_login_wrap">
				<input id="user_login_pw" type="password" placeholder="비밀번호를 입력해주세요">
			</div>
			<div id="login_btn_wrap">
				<a id="login_btn" href="mainpage.html">
					<div>로그인</div>
				</a>
			</div>
			<div id="sign_in_btn_wrap">
				<a id="sign_in_btn" href="join_confirm.html"><span>회원가입</span></a>
			</div>
		</div>
	</div>
</div>

<!-- body end -->
<div id="footerInput"></div>
</body>
<script>
	onload = function() {
		fetch('signinheader.html')
		.then(response => response.text())
		.then(data => {
			document.getElementById('headerInput').innerHTML = data;
		}).catch(error => {
			console.error('Header could not be loaded', error);
		});		
	}
</script>
</html>