<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix= "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<%-- <c:if test= "${requestScope.id == null}">
	<jsp:include page = "../member/loginForm.jsp"/>
</c:if>	

<c:if test= "${requestScope.id != null}">
	<jsp:include page = "../member/loginOk.jsp"/>
 </c:if>	 --%>
 

<c:if test= "${sessionScope.memId == null}">
	<jsp:include page = "../member/loginForm.jsp"/> <!-- 로그인 입력하세요 -->
</c:if>	

<c:if test= "${memId != null}">
	<jsp:include page = "../member/loginOk.jsp"/> <!-- 로그인 성공 -->
 </c:if>	
