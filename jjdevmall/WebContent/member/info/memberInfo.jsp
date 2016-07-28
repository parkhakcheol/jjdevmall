<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
		font-size: 20px;
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
	request.setCharacterEncoding("utf-8");
	//로그인 정보를 세션에서 받아온다
	String loginMemberId = null;
	loginMemberId = (String)session.getAttribute("memberId");
	
	//확인출력
	System.out.println("memberInfo.jsp loginMemberId-> " + loginMemberId);
	
	//로그인이 되어있다면
	if(loginMemberId != null){
		String search = loginMemberId;
		
		MemberDao memberDao = new MemberDao();
		//회원정보 select메서드 호출
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
					<th>정보수정</th>
					<th>회원탈퇴</th>
					</tr>
		<%		
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
						<td><a href="<%=request.getContextPath()%>/member/update/memberUpdateForm.jsp?sendNo=<%=memberDto.getMember_no()%>">정보수정</a></td>
						<td><a href="<%=request.getContextPath()%>/member/delete/memberDelete.jsp?sendNo=<%=memberDto.getMember_no()%>">회원탈퇴</a></td>
					</tr>
		<%
		}
		%>
				</table>
			</div>
	<% 
	
	//로그인 정보가 없을때 로그인 페이지로이동
	}else{
		response.sendRedirect(request.getContextPath()+"/member/login/memberLogin.jsp");
	}

	%>
</body>
</html>