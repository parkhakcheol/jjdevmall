<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
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
	request.setCharacterEncoding("utf-8");
	//세션에서 로그인 데이터가 있는지 확인
	boolean adminLogin = false;
	if(session.getAttribute("adminLogin") != null){
		adminLogin = (boolean)session.getAttribute("adminLogin");
	}
	//로그인이 되어있다면
	if(adminLogin){
		int sendNo = Integer.parseInt(request.getParameter("sendNo"));
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
			//전체회원을 보여주는 select 
			listSql = "SELECT m.member_no, m.member_id, m.member_name, addr.member_address FROM member m LEFT JOIN address addr ON m.member_no=addr.member_no WHERE m.member_no=?";
			pstmt1 = conn.prepareStatement(listSql);
			pstmt1.setInt(1, sendNo);
			
			rs = pstmt1.executeQuery();
			System.out.println(pstmt1);
			
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
			while(rs.next()){
				// 결과값을 각 변수에 대입
				String memberNo = rs.getString("member_no");
				String memberId = rs.getString("member_id");
				String memberName = rs.getString("member_name");
				String memberAddress = rs.getString("member_address");
				
				//확인 출력
				System.out.println("ListAll.jsp -> " + memberNo);
				System.out.println("ListAll.jsp -> " + memberId);
				System.out.println("ListAll.jsp -> " + memberName);
				// 테이블 행에 하나의 회원정보 입력
	%>			
				<tr>
					<td><%=memberNo %></td>	
					<td><%=memberId %></td>
					<td><%=memberName %></td>
					<td><%=memberAddress %></td>
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
	//로그인 정보가없으면 로그인페이지로 이동
	}else{
		response.sendRedirect(request.getContextPath()+"/admin/login/adminLogin.jsp");
	}
	

%>
</body>
</html>