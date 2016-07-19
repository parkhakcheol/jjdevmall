<%@page import="javax.websocket.Session"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	//입력한 관리자 로그인 정보를 받는다.
	String adminId = request.getParameter("adminId");
	String adminPw = request.getParameter("adminPw");
	//로그인 처리확인 변수
	boolean adminLogin = false;
	
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
		
		//admin테이블에서 로그인정보가 있는지 확인
		String loginSql = "SELECT admin_id, admin_pw, admin_level FROM admin WHERE admin_id=? AND admin_pw=?";
		pstmt1 = conn.prepareStatement(loginSql);
		pstmt1.setString(1, adminId);
		pstmt1.setString(2, adminPw);
		
		rs = pstmt1.executeQuery();
		System.out.println(pstmt1);
		
		//관리자 정보가 있다면
		if(rs.next()){
			//로그인 처리
			adminLogin = true;
			session.setAttribute("adminId", rs.getString("admin_id"));
			session.setAttribute("adminLevel", rs.getInt("admin_level"));
			session.setAttribute("adminLogin", adminLogin);
			//처리후 페이지 이동
			response.sendRedirect(request.getContextPath()+"/admin/adminIndex.jsp");
		}else{
			//로그인 정보가 없다면 페이지이동
			response.sendRedirect(request.getContextPath()+"/admin/login/adminLogin.jsp");
		}
	}finally {
		// 사용한 Statement 종료
		if (pstmt1 != null) try { pstmt1.close(); } catch(SQLException ex) {}
		
		if (rs != null) try { rs.close(); } catch(SQLException ex) {}
		
		// 커넥션 종료
		if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	}

	
	
	
%>

</body>
</html>