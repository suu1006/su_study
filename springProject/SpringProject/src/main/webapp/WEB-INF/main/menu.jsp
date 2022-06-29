<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
.mainnav {
	background-color : #ffbda4;
	list-style : none;
	color : #ffffff;
}
.mainnav li {
	display : inline-block;
	justify-content : space-between;
}

.mainnav li a {
	display : block;
	color : #ffff00;
	padding: 0 13px; /* 위/아래, 좌우 / 위아래는 0 , 좌우는 13으로 잡힘  */
	
	font : bold 16px/40px 'Nanum Gothic', sans-serif;
	/* 폰트 굵기 | 글자 크기/line-height 줄간격- 공백때문에 쉼표를 찍음  | 글꼴, 앞에 글꼴 없으면 다음 글꼴 공백없어서 쉼표는 안찍음*/
	text-transform : uppercase; 
	text-decoration : none;  /*밑줄 안나옴*/
}

.mainnav li a:hover {
	background-color : purple;
	color : white;
	}

</style>

<ul class = "mainnav">
	 <c:if test = "${memId!=null}">  <!-- 세션으로 처리해줌 --><!-- 관리자만 상품등록 할 수 있다. -->
		<li><a href = "/SpringProject/board/boardWriteForm">글쓰기</a></li> <!-- #을 쓰면 눌러도 이동안함. 주소 이따가 써주기 -->
		<li><a href = "/SpringProject/imageboard/imageboardWriteForm">상품등록</a></li> <!-- #을 쓰면 눌러도 이동안함. 주소 이따가 써주기 -->
	</c:if> 
		<li><a href = "/SpringProject/board/boardList">목록</a></li> <!--1페이지가 기본  -->
		<li><a href = "/SpringProject/imageboard/imageboardList?pg=1">상품목록</a></li> <!--1페이지가 기본  -->
</ul>
