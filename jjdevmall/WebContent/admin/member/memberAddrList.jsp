<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%@ page import="java.util.*" %>
<%@ page import="kr.or.ksmart.dao.MemberDao" %>
<%@ page import="kr.or.ksmart.dto.MemberAndAddressDto" %>
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
		int sendNo = Integer.parseInt(request.getParameter("sendNo"));
		MemberDao memberDao = new MemberDao();
		ArrayList<MemberAndAddressDto> addrList = memberDao.addrSelect(sendNo);
			//html태그 사용 회원정보를 테이블에 출력
	%>
			<div>
			<h1>주소 리스트</h1>
				<table>
					<tr>
					<th>회원번호</th>
					<th>회원ID</th>
					<th>회원이름</th>
					<th>주소</th>
					</tr>

	<%		
			//DB member테이블에 회원정보를 모두 보여주기위해 반복
			Iterator<MemberAndAddressDto> iterator = addrList.iterator();
			while(iterator.hasNext()){
				MemberAndAddressDto addressDto = iterator.next();		
	%>			
				<tr>
					<td><%=addressDto.getMember_no() %></td>	
					<td><%=addressDto.getMember_id() %></td>
					<td><%=addressDto.getMember_name() %></td>
					<td><%=addressDto.getMember_address() %></td>
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