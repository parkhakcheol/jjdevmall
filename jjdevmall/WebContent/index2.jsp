<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<style>
	div
	{
		border: 1px solid #000000;
		width: 50%;
		margin: 0 auto;
	}
</style>
<title>Insert title here</title>
</head>
<body>
<%
	session.invalidate();
%>
	<div>
		<h1>메인페이지 입니다.</h1>
	</div>
	
	<div>
		<ul>
			<li><a href="<%=request.getContextPath() %>/admin/login/adminLogin.jsp">관리자 로그인</a></li>
			<li><a href="<%=request.getContextPath() %>/member/login/memberLogin.jsp">회원 로그인</a></li>
		</ul>
	</div>
	

</body>
</html>