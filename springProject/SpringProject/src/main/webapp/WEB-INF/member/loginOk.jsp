<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%
 
 // 쿠키
/*
 Cookie ar[] = request.getCookies();	//쿠키 - 특정 쿠키를 얻을 수 없으므로 모든 쿠키를 다 가져와야한다. 
 
 if (ar!=null) {
	 
	 for(int i=0; i<ar.length; i++) {
		 String cookieName = ar[i].getName();
		 String cookieValue = ar[i].getValue();
		 System.out.println("쿠키명 = " + cookieName);
		 System.out.println("쿠키값 = " + cookieValue);
	 }//for
 }//if
 */ %>   
<!-- 
 
 <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body> -->
<h3>${sessionScope.memName }님 로그인</h3>
<!-- <input type = "button" value= "로그아웃" onclick = "location.href='/miniProject/member/logout.do'"> -->
<input type = "button" value= "로그아웃" id = "logoutBtn">
<!--  <input type = "button" value= "회원정보수정" onclick = "location.href='/miniProject/member/updateForm.do'"> -->
<input type = "button" value= "회원정보수정" onclick = "location.href='/SpringProject/member/updateForm'">

<script type="text/javascript"  src = "http://code.jQuery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	$('#logoutBtn').click(function(){
		$.ajax({
			type : 'post',
			url : '/SpringProject/member/logout',
			success : function() {
				alert("로그아웃");
				location.href = "/SpringProject/index";
			},
			error : function(err) {
				console.log(err);
			}
		});
	});
});
</script>
</body>
</html>
