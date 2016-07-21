<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<style>
	table, td, th
	{
		border: 1px solid #000000;
		font-size: 10px;
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
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/jjdevmall?useUnicode=true&characterEncoding=utf-8";
		String dbUser = "root";
		String dbPass = "java0000";
		
		
		Connection conn = null;
		PreparedStatement pstmt1 = null;
		ResultSet rs = null;
	
	
		try{
			
			//드라이버로딩
			Class.forName(driver);
			//DB연결
			conn = DriverManager.getConnection(url, dbUser, dbPass);
			String listSql = null;
			//회원정보 select 문장
			
				listSql = "SELECT member_no, member_id, member_pw, member_name, member_gender, member_age FROM member WHERE member_id=?";
				pstmt1 = conn.prepareStatement(listSql);
				pstmt1.setString(1, loginMemberId);
				rs = pstmt1.executeQuery();
				System.out.println(pstmt1);
				
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
						//DB member테이블에 회원정보를 모두 보여주기위해 반복
						if(rs.next()){
							// 결과값을 각 변수에 대입
							String memberNo = rs.getString("member_no");
							String memberId = rs.getString("member_id");
							String memberPw = rs.getString("member_pw");
							String memberName = rs.getString("member_name");
							String memberGender = rs.getString("member_gender");
							String memberAge = rs.getString("member_age");
							
							//확인 출력
							System.out.println("memberInfo.jsp memberNo -> " + memberNo);
							System.out.println("memberInfo.jsp memberId -> " + memberId);
							System.out.println("memberInfo.jsp memberPw -> " + memberPw);
							System.out.println("memberInfo.jsp memberName -> " + memberName);
							System.out.println("memberInfo.jsp memberGender -> " + memberGender);
							System.out.println("memberInfo.jsp memberAge -> " + memberAge);
							// 테이블 행에 하나의 회원정보 입력
				%>			
							<tr>
								<td><%=memberNo %></td>
								<td><%=memberId %></td>
								<td><%=memberPw %></td>
								<td><%=memberName %></td>
								<td><%=memberGender %></td>
								<td><%=memberAge %></td>
								<td><a href="<%=request.getContextPath()%>/member/update/memberUpdateForm.jsp?sendId=<%=memberId%>">정보수정</a></td>
								<td><a href="<%=request.getContextPath()%>/member/delete/memberDelete.jsp?sendNo=<%=memberNo%>">회원탈퇴</a></td>
							</tr>
				<%
						}
				%>
							</table>
						</div>
		<% 
			
			
	
		}finally {
			// 사용한 Statement 종료
			if (pstmt1 != null) try { pstmt1.close(); } catch(SQLException ex) {}
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			
			// 커넥션 종료
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
	//로그인 정보가 없을때 로그인 페이지로이동
	}else{
		response.sendRedirect(request.getContextPath()+"/member/login/memberLogin.jsp");
	}

	%>
</body>
</html>