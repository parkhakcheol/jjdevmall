<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%@ page import="java.util.*" %>
<%@ page import="kr.or.ksmart.dao.MemberDao" %>
<%@ page import="kr.or.ksmart.dto.MemberDto" %>
<!DOCTYPE html>
<html>
<head>
<style>
	table, td, th
	{
		border: 1px solid #000000;
	}
	div
	{
		width: 50%;
		height: 50px;
		margin: 0 auto;
		padding-top: 20px;
	}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<%
	
	//세션에서 로그인 데이터가 있는지 확인
	String adminId = null;
	adminId = (String)session.getAttribute("adminId");
	
	if(adminId != null){
		String search = null;
		MemberDao memberDao = new MemberDao();
		ArrayList<MemberDto> memberList = memberDao.memberSelect(search);
			//html태그 사용 회원정보를 테이블에 출력
%>
	<div>
		<h1>회원 리스트</h1>
			<table>
				<tr>
					<th>회원번호</th>
					<th>회원ID</th>
					<th>회원PW</th>
					<th>회원이름</th>
					<th>회원성별</th>
					<th>회원나이</th>
					<th>주소</th>
				</tr>

	<%		
			//DB member테이블에 회원정보를 모두 보여주기위해 반복
			Iterator<MemberDto> iterator = memberList.iterator();
			while(iterator.hasNext()){
				MemberDto memberDto = iterator.next();
	%>			
				<tr>
					<td><%=memberDto.getMember_no() %></td>	
					<td><%=memberDto.getMember_id() %></td>
					<td><%=memberDto.getMember_pw() %></td>
					<td><%=memberDto.getMember_name() %></td>
					<td><%=memberDto.getMember_gender() %></td>
					<td><%=memberDto.getMember_age() %></td>
					<td><a href="<%=request.getContextPath()%>/admin/member/memberAddrList.jsp?sendNo=<%=memberDto.getMember_no() %>">주소보기</a></td>
				</tr>
	<%
			}
	%>
				</table>
			</div>
	<% 
	//로그인 정보가없으면 로그인페이지로 이동
	}else{
		response.sendRedirect(request.getContextPath()+"/admin/login/adminLogin.jsp");
	}
	

%>
</body>
</html>