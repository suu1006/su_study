<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<!-- <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title> -->  <!-- 글 목록을 보여주는곳 -->
<style type = "text/css">
.subjectA:link {color : black; text-decoration : none;} /*링크를 올렸을때 바로 나오는 색*/
.subjectA:visited {color : black; text-decoration : none;} /*클릭한 뒤*/
.subjectA:hover {color : green; text-decoration : underline;} /*마우스만 올라갔을때*/
.subjectA:active {color : black; text-decoration : none;} /*마우스를 꾹 눌렀을때*/

#currentPaging {
	color : red;
	text-deciration : underline;
	cursor : pointer;
}

#paging {
	color : black;
	text-decoration : none;
	 cursor : pointer; 
}
</style>
</head>

<body>
<!-- jsp (최종목적지)로 request가 배달이 왔고 이제 이걸 풀어서 보여주면된다.  -->
<input type = "text" id ="pg" value="${requestScope.pg}">
<table id="boardListTable" border="1" cellspacing="0" cellpadding="5" frame="hsides" rules="rows">
	<tr>
		<th width="100">글번호</th>
		<th width="300">제목</th>
		<th width="100">작성자</th>
		<th width="100">작성일</th>
		<th width="100">조회수</th>
	</tr>
	
	
	
</table>
<div style = "float : left; width : 700px; text-align : center;">
<input type = "button"  value = "글쓰기" style = "margin : 5px; float :left;" onclick = "location.href = '/SpringProject/board/boardWriteForm'">

<div id = "boardPagingDiv"></div> <!-- 페이징 하는 부분 ${boardPaging.pagingHTML} -->
		
	 </div>
	 <br><br>
	 
	 <!-- 글 검색 -->
	 <form id = "boardSearchForm"> 
		 <input type="hidden" name="pg" id ="searchPg" value="1"><!--검색결과:  나는 무조건 1페이지에 뿌려줘야해 !  -->
		 <div style= "margin-left:200px; text-align:left;">
		 <select name = "searchOption">
		 	<option value="subject">제목</option>
		 	<option value="id">작성자</option>
		 	</select>
		 	<input type="search" name="keyword" id="keyword" value="${keyword}">
		 	<input type="button" value="검색" id="boardSearchBtn">
		 </div>
	</form>
	
	
	
<script type="text/javascript"  src="http://code.jQuery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="../js/boardList.js"></script>
<script type="text/javascript">
function boardPaging(pg2) {  
	var keyword = $('#keyword').val();
	if (keyword == '') {
		location.href = "boardList?pg=" + pg2; // 페이징처리할때 쓴 pg2

	} else {
		/* location.href = "/miniProject/board/boardSearch.do?pg=" + pg2 
				+ "&searchOption=${searchOption}&keyword=" + keyword;/* 자바스크립트에서 한글처리해달라고 하는것 */ 
			$('#searchPg').val(pg2); //searchPg가 1로 고정되어있기 때문에 다시 검색할땐 페이지값이 1로 바뀌어야한다. 그래야 찾을 수 있다 .
					//강제 이벤트 발생
			$('#boardSearchBtn').trigger('click'); // 강제로 이벤트를 발생시킨다.
			
			//다시 검색버튼을 누르면 searchPg를 1로 바꾸어야한다. 
			$('#searchPg').val(1);
	}		
}
	
</script>
