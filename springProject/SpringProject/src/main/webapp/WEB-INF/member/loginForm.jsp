<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">
#loginForm  div {
	color: red;
	font-size: 8pt;
	font-weight: bold;
}
</style>

<form name="loginForm" id="loginForm" class="loginForm" >
	<table border="1" cellpadding="5" cellspacing="0">
		<tr>
			<td align="center">아이디</td>
			<td>
				<input type="text" name="id" id="id" placeholder="아이디 입력">
				
				<div id="idDiv"></div>
	   		</td>
		</tr>
		
		<tr>
			<td align="center">비밀번호</td>
			<td>
				<input type="password" name="pwd" id="pwd">
				<div id="pwdDiv"></div>
	   		</td>
		</tr>
		
		<tr>
			<td colspan ="2" align = "center">
				<input type="button" value="로그인" id="loginBtn">
				<input type="button"  value="회원가입" onclick="location.href='/SpringProject/member/writeForm'">
			</td>
		</tr>
	</table>
</form>

<div id= "loginResultDiv"></div>

<script type="text/javascript"  src = "http://code.jQuery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$('#loginBtn').click(function(){
	$('#idDiv').empty();
	$('#pwdDiv').empty(); /* 초기화 시켜줌  */
	
	//유효성 검사
	if($('#id').val()==''){
		$('#idDiv').html('아이디 입력');
		$('#idDiv').css({
			'color': 'red',
			'font-size':'8pt',
			'font-weight':'bold'
		});
	}else if($('#pwd').val()==''){
		$('#pwdDiv').html('비밀번호 입력');
		$('#pwdDiv').css('color', 'red');
		$('#pwdDiv').css('font-size','8pt');
		$('#pwdDiv').css('font-weight','bold');
	
	}else{ 
		
	//1번인 경우 - submit 하는 경우(페이지 이동)
	// $('#loginForm').submit(); 
	
	//2번인 경우
		// ajax 처리(페이지 이동하지 않음.)
      $.ajax({
         type: 'post',
         url: '/SpringProject/member/login', // 앞에 있는 /를 보고 서블릿 탄다.
         data: {'id' : $('#id').val(), 
               'pwd' : $('#pwd').val()}, //서버로 보낼 데이터, JSON
         dataType: 'text', //서버로부터 받는 데이터 형식 / 데이터 타입을 맞춰주지 않으면 들어오는 타입에 맞게 자동으로 맞춰줌
         success: function(data){
            //alert(data); 
            data = data.trim(); // 공백 제거

         if (data == 'ok'){
        	 
        	  location.href = "/SpringProject/index";
          	}
      		else if(data == 'fail') {
          		$('#loginResultDiv').text('로그인 실패');
          		$('#loginResultDiv').css({
	          		'color': 'red',
	    			'font-size':'15pt',
	    			'font-weight':'bold'
          		});
          	} 
         },
         error: function(err){
            console.log(err);
        	 }
     	});
      }// if 
 });
</script>


<!-- <script type="text/javascript">
function checkLogin(){
	document.getElementById("idDiv").innerText = "";
	document.getElementById("pwdDiv").innerText = "";
	
	if(document.loginForm.id.value == "")
		document.getElementById("idDiv").innerText = "아이디 입력";
	else if(document.loginForm.pwd.value == "")
		document.getElementById("pwdDiv").innerText = "비밀번호 입력";
	else if(document.loginForm.value == "")
		document.getElementById("idDiv").innerText = "아이디 입력";
	else 
		document.loginForm.submit();
}
</script> -->