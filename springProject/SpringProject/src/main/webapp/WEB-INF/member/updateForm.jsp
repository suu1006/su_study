<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 

<meta charset="UTF-8">
<title>회원정보수정</title>
<style type="text/css">
#updateForm div {
	color: red;
	font-size: 8pt;
	font-weight: bold;
}
</style>

<h3>회원정보수정</h3>
<form name="updateForm" id="updateForm">
	<table border="1" cellpadding="5" cellspacing="0">
		<tr>
			<td align="center" width="100">이름</td>
   			<td>
    			<input type="text" name="name" id="name">
    			<div id="nameDiv"></div>
   			</td>
  		</tr>
  		
  		<tr>
			<td align="center">아이디</td>
			<td>
				<input type="text" name="id" id="id" readonly>
				
	   		</td>
		</tr>
		
		<tr>
			<td align="center">비밀번호</td>
			<td>
				<input type="password" name="pwd" id="pwd">
				<div id="pwdDiv_write"></div>
	   		</td>
		</tr>
		
		<tr>
			<td align="center">재확인</td>
			<td>
				<input type="password" name="repwd" id="repwd">
				<div id="repwdDiv"></div>
	   		</td>
		</tr>
		
		<tr>
			<td align="center">성별</td>
			<td>
				<input type="radio" name="gender" value="0">남
				<input type="radio" name="gender" value="1">여
			</td>
		</tr>
		
		<tr>
			<td align="center">이메일</td>
			<td>
				<input type="text" name="email1" >
				@
				<input type="email" list="email2" name="email2" value = "">
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
				-
				<input type="text" name="tel2" size="5" >
				-
				<input type="text" name="tel3" size="5" >
			</td>
		</tr>
		
		<tr>
			<td align="center">주소</td>
			<td>
				<input type="text" name="zipcode" id="zipcode" readonly>
				<input type="button" value="우편번호검색" onclick="checkPost()"><br>
				<input type="text" name="addr1" id="addr1" size="50" readonly><br>
				<input type="text" name="addr2" id="addr2" size="50">
			</td>
		</tr>
		
		<tr>
			<td colspan ="2" align = "center">
				<input type="button" value="회원정보수정" id="updateBtn">
				<input type="reset"  value="다시작성" onclick= "location.reload()">
			</td>
		</tr>
	</table>
</form>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript"  src = "http://code.jQuery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="../js/member_jQuery.js"></script>
<script type="text/javascript">

$(function(){ // 데이터를 받아서
	   $.ajax({
	      type: 'post',
	      url: '/SpringProject/member/getMember', 
	      dataType: 'json',
	      success: function(data){
	         //alert( JSON.stringify(data)); $('') - jQuery   // 중괄호있는거 - EL  자바스크립트 - 제이쿼리 
	         
	         $('input[name="name"]').val(data.name);
	         $('input[name="id"]').val(data.id);
	         $('input[name="gender"]:eq(' + data.gender + ')').attr("checked", true); /* data.gender 가 불러오는구나 >> 분리작업 해야 안헷갈리징! */
	         $('input[name="email1"]').val(data.email1);
	         $('input[name="email2"]').val(data.email2); 
	         $('select[name="tel1"]').val(data.tel1); /* select 주의! */
	         $('input[name="tel2"]').val(data.tel2);
	         $('input[name="tel3"]').val(data.tel3);
	         $('input[name="zipcode"]').val(data.zipcode);
	         $('input[name="addr1"]').val(data.addr1);
	         $('input[name="addr2"]').val(data.addr2); 
	      },
	      error: function(err){
	         console.log(err);
	      } 
	   });
	});
/* window.onload=function(){ /* onload = 실행할때 처음, 딱 한번 읽어드림 >> 다시 작성하면 안 읽어들임 
	document.updateForm.gender['${memberDTO.gender}'].checked = true;
	document.updateForm.email2.value = '${memberDTO.email2}';
	document.updateForm.tel1.value = '${memberDTO.tel1}'; */

	//회원정보수정     
$('#updateBtn').click(function(){
	 $('#nameDiv').empty();
	 $('#pwdDiv_write').empty();
	 
	 if($('#name').val() == ''){
	      $('#nameDiv').html('이름을 입력하세요');
	      $('#nameDiv').css('color', 'red');
	      $('#nameDiv').css('font-size', '8pt');
	      $('#nameDiv').css('font-weight', 'bold');
	   
	 }else if($('#pwd').val() == ''){
	      $('#pwdDiv_write').html('비밀번호를 입력하세요');
	      $('#pwdDiv_write').css('color', 'red');
	      $('#pwdDiv_write').css('font-size', '8pt');
	      $('#pwdDiv_write').css('font-weight', 'bold');
	   
	 }else if($('#repwd').val() != $('#pwd').val()){
	      $('#repwdDiv').html('비밀번호가 맞지 않습니다');
	      $('#repwdDiv').css('color', 'red');
	      $('#repwdDiv').css('font-size', '8pt');
	      $('#repwdDiv').css('font-weight', 'bold');

	 } else {   // 수정하였습니다 출력
		      //$('#updateForm').submit(); submit하면 name 속성에 있는거 다 가져감
		      
		     // alert($('#updateForm').serialize();
		       $.ajax({
		    	  type :'post',
		    	  url : '/SpringProject/member/update',
		    	  data : $('#updateForm').serialize(), /* 문자열로 받음 / '변수=값&변수=값&변수=값~~'이런식으로 출력됨 */
		   		  success : function() {
		   			  alert('회원의 정보를 수정하였습니다.');
		   			  location.href = '/SpringProject/index';
		   		  },
		   		 error: function(err){
			         console.log(err);
			 } 
		}); 
 	}
});
</script>
