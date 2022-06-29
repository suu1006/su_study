<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <!-- 태그 라이브러리 선언 (java에서 import 선언하듯 jsp에서도 jstl 확장 태그를 사용하면 
 taglib 지시자로 라이브러리를 선언해야함.)
 c: out >> 출력문을 만드는 태그
 c: set >> 변수를 다룰 때 사용 >> jsp 로컬 변수가 아니라 서블릿 보관소(jspContext, ServletRequest, HttpSession, ServletContext)에 저장됨
 c: remove :보관소에 저장된 값을 제거
  -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type = "text/css">
body {
margin : 0; /* <!--바깥쪽 여백--> */
padding : 0; /* <!--안쪽 여백--> */
height : 100%;/* 높이 지정  */
width : auto; /* <!--브라우저의 가운데로 와라 (크기에 맞게 같이 움직여라)--> */

}

#header {/*id 속성을 사용할때는 # 사용  */

margin: 0 auto; /* 자동정렬 */
/* margin-left : 30px; <!--여백 -->
margin-right : 30px; */
width : 1700px;
height : 1500%; 
background-color: #f6f6ee;
text-align : center; <!-- 정렬 -->

}

#container { /* id 속성을 쓸 때는 # 써주기 */
	/*margin : auto;*/
	margin: 0 auto;
	width : 1700px;
	/* margin-left : 30px;
	margin-right : 30px; */
	height : 500px;
	background-color: #f8d8cf;
}

#container:after { /* <!--after : 뒤에 배치  --> */
/* 	margin : auto; */
	content : '나는 container:after / clear:both해주었기 떄문에 아래에 붙지!';
	 display : block; /* 한 칸 띄워주기 */
	  clear : both; /*float를 해제해줌 /  오른쪽 왼쪽  둘다 취소 >> both */
	/* margin-left : 30px;
	margin-right : 30px; */
	float : none; /* float를 해제하지 않으면 float상태 유지 (계속 옆으로 붙음) / 해제 > 아래로 붙어  */
	background-color : #da9da0;
}
/* container:after 
content 안에 아무 글자가 없으면 영역이 잡히지 않는다. 
clear를 해주기위해 after를 써주는것 
clear를 해주지 않으면 오른쪽 옆 영역에 붙음 */

#nav {
	 margin-left : 10px;
	/*width : 400px */
	width : 28%;
	height : 100%;
	float : left;
	
}
#section {
margin-left : 10px;
width : 70%;
height : 100%;
float : left;
}

#footer {

width : 1700px;
height : 10%;
background: #9a6976;
margin: 0 auto;
text-align : center;
}

</style>
</head>

<body>
<div id = "header">
	<h1>
	<img src = "${pageContext.request.contextPath}/image/rabbit2.gif" width = "50" height = "50"
	 alt = "망상토끼" onclick = "location.href='${pageContext.request.contextPath}/index'" style = "cusor : pointer"> MVC를 이용한 미니 프로젝트
	</h1>
	<br>    <!--src 에 절대번지를 사용하면 망상토끼 안없어짐 상대번지면 주소가 바뀔때마다 바뀜 -->
	  <jsp:include page = "${menu}"/> 
	
	</div>
	
	<!-- <div> 레이아웃을 만들때 주로 사용 / 블록을 알맞게 배치하고, css활용해서 스타일 적용 -->
	<!-- <div> 와 <p>태그는 한 줄을 모두 영역으로 잡음 / span 태그는 글자길이만큼 영역을 잡기떄문에 div와 p태그를 품을 수 없다. -->
<div id = "container">
	<div id = "nav">
		 <jsp:include page = "${nav}"/>
	</div>
		
	<div id = "section">
			<c:if test = "${empty display}">
				<h1>
					여기는 container.<br>
					Have a nice day!!<br>
					<img src = "/SpringProject/image/rabbit2.gif" alt = "망상토끼"> <!-- alt : 해당 이미지가 없거나 엑박뜰때 대체할 이미지 -->
				</h1>
			</c:if>
		
		  <c:if test="${not empty display}"> 
		 	<jsp:include page="${requestScope.display}"/> 
		  </c:if>  
		  
	  </div>
</div>

<div id = "footer">
	<p>여기는 footer</p>
	<!-- <p> 하위에는 span, a, strong 인라인 요소만 올 수 있다!!!! -->
</div>

</body>
</html>