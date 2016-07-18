<%@page import="javax.websocket.Session"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String driver = "com.mysql.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/jjdevmall?useUnicode=true&characterEncoding=utf-8";
	String dbUser = "root";
	String dbPass = "java0000";
	
	Connection conn = null;
	PreparedStatement pstmt1 = null;
	ResultSet rs = null;
	try{
		
		
		//����̹��ε�
		Class.forName(driver);
		//DB����
		conn = DriverManager.getConnection(url, dbUser, dbPass);
		
		//ȸ������ insert���� ����
		String loginSql = "SELECT member_id, member_pw FROM member WHERE member_id=? AND member_pw=?";
		pstmt1 = conn.prepareStatement(loginSql);
		pstmt1.setString(1, memberId);
		pstmt1.setString(2, memberPw);
		
		rs = pstmt1.executeQuery();
		System.out.println(pstmt1);
		
		if(rs.next()){
			session.setAttribute("memberId", rs.getString("member_id"));
			session.setAttribute("memberPw", rs.getString("member_pw"));
			response.sendRedirect(request.getContextPath()+"/admin/member/memberListAll.jsp");
		}else{
			
		}
	}finally {
		// ����� Statement ����
		if (pstmt1 != null) try { pstmt1.close(); } catch(SQLException ex) {}
		
		if (rs != null) try { rs.close(); } catch(SQLException ex) {}
		
		// Ŀ�ؼ� ����
		if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	}

	
	
	
%>

</body>
</html>