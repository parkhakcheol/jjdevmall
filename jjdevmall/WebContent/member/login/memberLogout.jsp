<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
	//세션 종료
	session.invalidate();

	//adminIndex.jsp 페이지로 이동
	response.sendRedirect(request.getContextPath()+"/main.jsp");
%>
</body>
</html>