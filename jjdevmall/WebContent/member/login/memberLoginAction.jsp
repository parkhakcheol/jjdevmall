<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="kr.or.ksmart.dao.*" %>
<%@ page import="kr.or.ksmart.dto.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	//로그인 하기위해 입력받은 회원 아이디와 패스워드를 받아옵니다.
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	
	MemberDao memberDao = new MemberDao();
	String loginResult = null;
	MemberDto memberDto = new MemberDto();
	
	loginResult = memberDao.memberLoginCheck(memberId, memberPw);
	
		// 맞는 회원이있으면 로그인처리
	if(loginResult.equals("로그인성공")){
		memberDto = memberDao.memberLogin(memberId);
		session.setAttribute("memberName", memberDto.getMember_name());
		session.setAttribute("memberNo", memberDto.getMember_no());
		//페이지 이동
		response.sendRedirect(request.getContextPath()+"/main.jsp");
	}else if(loginResult.equals("아이디불일치")){
	%>
	<script>
		alert("아이디 불일치");
	</script>
	<% 
		response.sendRedirect(request.getContextPath()+"/member/login/memberLogin.jsp");
	}else if(loginResult.equals("비밀번호불일치")){
	%>
	<script>
		alert("비밀번호 불일치");
	</script>
	<% 
		response.sendRedirect(request.getContextPath()+"/member/login/memberLogin.jsp");	
	}	
	
%>

</body>
</html>