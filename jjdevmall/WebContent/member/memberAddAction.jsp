<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="kr.or.ksmart.dao.MemberDao" %>
<%request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="member" class="kr.or.ksmart.dto.MemberDto"/>
<<jsp:setProperty property="*" name="member"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<%
	MemberDao memberDao = new MemberDao();
	int result = memberDao.memberInsert(member);
	
	//확인출력
	if(result != 0){
		System.out.println("memberAddAction.jsp -> 회원가입완료");
		response.sendRedirect(request.getContextPath()+"/member/login/memberLogin.jsp");
	}else{
		System.out.println("memberAddAction.jsp -> 회원가입실패");
		response.sendRedirect(request.getContextPath()+"/member/memberAddForm.jsp");
	}
		
%>
</body>
</html>