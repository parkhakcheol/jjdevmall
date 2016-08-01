<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="no-js" lang="ko">
<%@ include file="./module/head.jsp"  %>
<!-- <style>
	div
	{
		border: 1px solid #000000;
		width: 50%;
		margin: 0 auto;
	}
</style>
<title>Insert title here</title>
</head>
<body> -->

<%
	session.invalidate();
%>
	<div>
		<h1>메인페이지 입니다.</h1>
	</div>
	
	<div>
		<ul>
			<li><a href="<%=request.getContextPath() %>/admin/login/adminLogin.jsp">관리자 로그인</a></li>
			<li><a href ="<%=request.getContextPath() %>/member/login/memberLogin.jsp">회원 로그인</a></li>
		</ul>
	</div>
	
<%@ include file="./module/footer.jsp" %>

</body>
</html>