<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>마이 페이지</title>


<link rel="stylesheet" type="text/css" href="resources/css/index.css">
<link rel="stylesheet" type="text/css" href="resources/css/mypageCSS.css">
<style>

</style>
</head>
<body >
<%@ include file="/WEB-INF/views/header/mainheader.jsp" %>
	
	<script type = "module" src ="resources/script/mypage.js"></script>
<div id = "myPage_navigater" >
	<div id="reserve_detail"> 예매내역</div><hr >
	<div id="info_change"> 회원 정보 수정</div><hr >
	<div id="my_review"> 작성 리뷰 게시글</div><hr >
</div>

<div id = "myPage_main" >
<table border="3">
<tr><th>영화 이미지</th><th>영화 이름</th><th>제목</th><th>작성일자</th></tr>
<c:forEach items="${boardlist }" var="dto">
<tr><td>${dto.movie_img_src }</td><td>${dto.movie_title }</td><td>${dto.board_title }</td><td>${dto.board_write_date }</td></tr>
</c:forEach>
</table>
<h4>페이지 번호를 선택하세요.</h4>
<%
int pagecount = (Integer)request.getAttribute("pagecount");
int totalcount = (Integer)request.getAttribute("totalcount");
int totalpage = 0;
if( totalcount % pagecount == 0)  totalpage = totalcount / pagecount;
else totalpage = totalcount / pagecount + 1;

for(int i = 1; i <=totalpage; i++){
%>	
<a href="/multicinema/reviewboardhistory?pagenum=<%=i%>"> <%=i%>페이지 </a> 
<%
}
%>
</div>




</body>
</html>