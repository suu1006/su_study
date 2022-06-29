<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.input {
	width:352px;
	
}
#img {
	visibility : hidden;
}
</style>
</head>
<body>
<!-- 1. 단순 submit 
<form id="imageboardWriteForm" method="post" enctype="multipart/form-data" 
action="/SpringProject/imageboard/imageboardWrite"> -->
<!-- 2. 비동기 통신 Ajax 통신 -->
<form id="imageboardWriteForm">
<table border="1" style="border-collapse; width:500px;" cellpadding="5">
	<tr>
				<th style="width:25%;">상품코드</th>
				<td ><input type="text" name="imageId" id="imageId" class="input"></td>
			</tr>
			<tr>
				<th>상품명</th>
				<td><input type="text" name="imageName" id="imageName" class="input"></td>
			</tr>
			<tr>
				<th>단가</th>
				<td><input type="text" name="imagePrice" id="imagePrice" class="input"></td>
			</tr>
			<tr>
				<th>개수</th>
				<td><input type="text" name="imageQty" id="imageQty" class="input"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea cols="50" rows="15" name="imageContent" id="imageContent"></textarea></td>
			</tr>
		<tr>
			<td colspan="2">
				<img id="showImg" style="border:1px red solid; width:100px; height:100px;">
				<img src = "../image/camera.svg" id ="camera">
				<input type="file" name="img" id="img"> <!-- name명을 img로 바꿔서 dto로 넘어가지 못하게막는다. (dto에는 image라고 잡혀있어서 이름이 달라 dto로 넘어가지 않음.) -->
				</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;">
					<input type="button" name="imageBtn" id="uploadBtn" value="이미지등록">
					<input type="reset" name="resetBtn" id="resetBtn" value="다시작성">
				</td>
			</tr>
		</table>
	</form>
<script type="text/javascript"  src="http://code.jQuery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	$('#camera').click(function(){
		$('#img').trigger('click');
	});
	
	$('#img').on('change', function(){ // 45번줄에 onchange = 이렇게 작성해도 된다
		readURL(this);
	});
	
	function readURL(input) {
		if (input.files[0]){ // 파일이 여러개일수도 있기때문에
			var reader = new FileReader();  // 자바스크립트 
			reader.onload = function(event){ // 읽기 동작이 끝났으면 
				$('#showImg').attr('src', event.target.result); // result 속성에 저장해서  //  e.target >> 이벤트가 발생한 요소를 반환해준다.
			}
			
			reader.readAsDataURL(input.files[0]); // 화면에 뿌려라
		}
	}
	
	$('#uploadBtn').click(function(){
		// 1. 단순 submit
		//$('imageboardWriteForm').submit();
		
		//2. Ajax통신
		var formData = new FormData($('#imageboardWriteForm')[0]);
		$.ajax({
			type : 'post',
			url : '/SpringProject/imageboard/imageboardWrite',
			enctype: 'multipart/form-data', 
			processData: false, //변수=값&변수=값 이렇게 넘기지말고 폼 안에 있는 데이터 그대로 넘겨라!
			contentType : false, // content 타입 그대로 넘겨라!
			data : formData,
			success :  function() {
				
				alert('상품 등록 완료');
				location.href='/SpringProject/imageboard/imageboardList';
			},
			error: function(err) {
				console.log(err);
			}
		});
	});
});
</script>	
</body>	
</html>

<!-- 
FileReader 
<!-- 
FileReader?
FileReader는 type이 file인 input 태그 또는 API 요청과 같은 인터페이스를 통해 File 또는 Blob 객체를 편리하게 처리할 수 있는 방법을 제공하는 객체이다.
abort, load, error와 같은 이벤트에서 발생한 프로세스를 처리하는데 주로 사용되며, File 또는 Blob 객체를 읽어서 result 속성에 저장한다.

FileReader도 비동기로 동작한다.
>> 비동기로 동작한다. >> 동기로 읽어들인다면? 다 읽어들일때까지 모두 꼼짝마,, 이미지가 올동안 아무것도 움직이지 못하니까 비동기로 처리해야한다! --가장 중요함!

FileReader.onload()
load 이벤트의 핸들러. 이 이벤트는 읽기 동작이 성공적으로 완료되었을 때마다 발생한다.


 -->