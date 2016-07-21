<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%@ page import="kr.or.ksmart.dao.MemberDao" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<%
	
	String loginMemberId = null;
	loginMemberId = (String)session.getAttribute("memberId");
	//확인출력
	System.out.println("memberInfo.jsp loginMemberId-> " + loginMemberId);	
	//로그인이 되어있다면
	if(loginMemberId != null){
		int memberNo = Integer.parseInt(request.getParameter("sendNo"));
	
		MemberDao memberDao = new MemberDao();
		int result = memberDao.memberDeldte(memberNo);
		
		if(result != 0){
			System.out.println("memberDelete.jsp -> 회원탈퇴 완료");
			response.sendRedirect(request.getContextPath()+"/member/login/memberLogin.jsp");
		}else{
			System.out.println("memberDelete.jsp -> 회원탈퇴 실패");
			response.sendRedirect(request.getContextPath()+"/member/memberAddForm.jsp");
		}
			
	}else{
		response.sendRedirect(request.getContextPath()+"/member/login/memberLogin.jsp");
	}
	

%>
</body>
</html>