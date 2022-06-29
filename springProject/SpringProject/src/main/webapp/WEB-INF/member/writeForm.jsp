<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style type="text/css">
#writeForm div {
	color: red;
	font-size: 8pt;
	font-weight:bold;
}
</style>
</head>
<body>
<h3>회원가입</h3>
<form name="writeForm" id = "writeForm">
	<table border="1" cellspacing="0" cellpadding="5">
		<tr>
			<td width="50" align="center">이름</td>
			<td>
				<input type="text" name="name" id="name" placeholder="이름 입력">
				<div id="nameDiv"></div>
			</td>
		</tr>
		
		<tr>
         <td width="50" align="center">아이디</td>
         <td>
            <input type="text" name="id" id="id_write" placeholder="아이디 입력">
            <input type="hidden" name="check" value="">
            <div id="idDiv_write"></div>
         </td>
      <tr>
         <td width="100" align="center">비밀번호</td>
         <td>
            <input type="password" name="pwd" id="pwd_write">
            <div id="pwdDiv_write"></div>
         </td>
      <tr>
		
		
		<tr>
			<td width="50" align="center">재확인</td>
			<td>
				<input type="password" name="repwd" id="repwd">
				<div id="repwdDiv"></div>
			</td>
		</tr>
		
		<tr>
			<td align="center">성별</td>
			<td>
				<label><input type="radio" name="gender" id="gender1" value="0" checked="checked">남</label>
				<label><input type="radio" name="gender" id="gender2" value="1">여</label>
			</td>
		</tr>
		
		<tr>
			<td align="center">이메일</td>
			<td>
				<input type="text" name="email1"> 
				
				<input type="email" list="email2" name="email2" placeholder="직접입력" >
				<datalist id="email2">
					<option value="gmail.com">
					<option value="daum.net">
					<option value="naver.com">
				</datalist>
			</td>
		</tr>
		
		<tr>
			<td align="center">핸드폰</td>
			<td>
				<select name="tel1" style="width: 70px;">
					<option value="010">010</option>
					<option value="011">011</option>
					<option value="019">019</option>
				</select>
				
				<input type="text" name="tel2" id="tel2" size="5">
				
				<input type="text" name="tel3" id="tel3" size="5">
			</td>
		</tr>
		
		<tr>
			<td width="50" align="center">주소</td>
			<td>
				<input type="text" name="zipcode" id="zipcode" readonly>
				<input type="button" value="우편번호검색" onclick = "checkPost()"><br>
				<input type="text" name="addr1" id="addr1" placeholder="주소" size="50" readonly><br>
				<input type="text" name="addr2" id="addr2" placeholder="상세주소" size="50"><br>
			</td>
		</tr>
		
		<tr>
		<td colspan="2" align="center">
				<!-- <input type = "button" value="회원가입" onclick="check()"> -->
				<input type = "button" value="회원가입" id="writeBtn"> <!-- 버튼에서 발생한 클릭버튼이다해서 Btn이라고 많이 사용함. -->
				<input type = "reset" value="다시작성">
			</td>
		</tr>
		
	</table>
</form>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> <!-- 우편번호 -->
<script type="text/javascript"  src = "http://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- 
Javascript 
<script type = "text/javascript" src = "../script/member.js"></script> -->
<!-- jQuery -->
<script type = "text/javascript" src = "../js/member_jQuery.js"></script>

</body>
</html>
