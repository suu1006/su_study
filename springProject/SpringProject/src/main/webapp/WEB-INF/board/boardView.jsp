<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form name = "boardViewForm" >
<input type = "hidden" name = "seq" value= "${seq}"> <!-- 입력상자 -->
<input type = "hidden" name = "pg" value= "${pg}">
<table border = "1" width = "450" cellspacing = "0" cellpadding = "5" frame = "hsides" rules = "rows"> <!-- cellspaing : 셀 간격 cellpadding : 셀과 글자간격  -->
	<tr>
		<td colspan = "3"> <!-- 합칠 열의 개수 -->
		<h2><span id = "subjectSpan"></h2>
		</td>
	</tr>
	
	
	<tr>
		<td width = "150" align = "center"> 글번호 : <span id = "seqSpan"></td> <!-- span태그 안잡으면 글번호 글씨가 안보임 -->
		<td width = "150" align = "center"> 작성자 :<span id = "idSpan"></td>
		<td width = "150" align = "center"> 조회수 : <span id = "hitSpan"></td>
	</tr>
	
	
	<tr>
      <td colspan="3" height="300" valign="top">
         <div style="width: 100%; height: 100%; overflow: auto;">
             <pre style="white-space: pre-line; word-break; break-all;" > <!-- pre태그 안에서는 개행의 효과를 낼 수 있음. / white space:pre-line : 공백을 여러개 넣어도 1개만 표시 / 자동줄바꿈 -->
            <!-- word-break : 텍스트 줄바꿈속성  break-all : 문자단위로 줄바꿈-->
            <span id = "contentSpan">
             </pre>
         </div>
      </td>
   </tr>
	
	</table>
	
	<input type = "button" value = "목록" 
		style = "margin : 5px;" 
		onclick = "location.href = '/SpringProject/board/boardList?pg=${pg}'">
		
	<%--  <c:if test = "${sessionScope.memId==boardDTO.id}"> --%>
	
	<!-- 글삭제와 글수정은 본인의 글일때만 뜨게한다 다른사람이 로그인하면 할 수 없지! mode는 강사님이 그냥 이름지은거 / 기능을 나눌때 이렇게 mode형식으로 나눠서 사용할 수 있쮜!-->
	<span id = "boardViewSpan">
	<input type = "button" value = "글수정" onclick = "mode(1)"> 
	<input type = "button" value = "글삭제" id = "boardDeleteBtn">
	</span>
	 <%--  </c:if>  --%>
	<!-- 글을 삭제하면 seq 들고가고, 글삭제하면 무조건 1페이지로 온다. submit을 이용 -->
	<input type = "button" value = "답글" onclick = "mode(3)">  
	<onclick="window.location.reload()">
</form>

<script type="text/javascript"  src="http://code.jQuery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	/* boardView 할때  */
	$.ajax({
		type : 'post',
		url : '/SpringProject/board/getBoardView', /* 한 사람의 글을 가져와라 */
		data : 'seq=' + $('input[name="seq"]').val(), /* seq가 name속성으로 잡혀있네 */
		dataType : 'json',
		success : function(data){
			/* alert(JSON.stringify(data)), */
			
			$('#subjectSpan').text(data.boardDTO.subject);
			$('#seqSpan').text(data.boardDTO.seq);
			$('#idSpan').text(data.boardDTO.id);
			$('#hitSpan').text(data.boardDTO.hit);
			$('#contentSpan').text(data.boardDTO.content);
			
			if (data.memId == data.boardDTO.id)
				$('#boardViewSpan').show(); /* 글수정, 글삭제 버튼을 아이디가 작성자의 아이디이면 보여주고 아니면 보여주지않는다. */
			else 
				$('#boardViewSpan').hide();
		},
		error:function(e){ 
			console.log(e);
		} 
	});
});
//글삭제버튼
$('#boardDeleteBtn').click(function(){
			if (confirm("정말로 삭제하시겠습니까?")) 
		$.ajax({
				type: 'post',
				url :'/miniProject/board/boardDelete.do',
				data : 'seq=${seq}',
				success : function(){
				alert("선택한 글 삭제했습니다.");
				location.href = 'boardList.do?pg=1';
			},
				error:function(e){ 
				console.log(e);
			
		}
	});
});
</script>

<script type="text/javascript">
function mode(num) { // submit을 각자 돌리고 싶어할 때
	if (num ==1) { // 글수정 , seq, pg submit하면 form안에 있는 데이터 다가지고 감
		
		document.boardViewForm.method = "post";
		document.boardViewForm.action = "/miniProject/board/boardUpdateForm.do";
		document.boardViewForm.submit(); // form 영역안에 있는 입력 데이터를 들고 페이지를 이동하러감 >> 회원가입 데이터같은거에 쓰면 좋다! name속성에 있는 애들을 들고가고, id속성은 안들고감 무조건 name속성이 있어야함
		
	} else if (num == 2) { // 글삭제 - 나중에 프로젝트할때는 비밀번호 물어보고 삭제하자! / seq만 가져가면 됨
		
		if (confirm("정말로 삭제하시겠습니까?")) {
			document.boardViewForm.method = "post";
			document.boardViewForm.action = "/miniProject/board/boardDelete.do";
			document.boardViewForm.submit();
		}
	} else if (num == 3) { // 답글

		document.boardViewForm.method = "post";
		document.boardViewForm.action = "/miniProject/board/boardReplyForm.do";
		document.boardViewForm.submit();
		
	} 
}
</script>
</body>
</html>