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
	//로그인 하기위해 입력받은 회원 아이디와 패스워드를 받아옵니다.
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	boolean memberLogin = false;
	
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
		
		//회원정보를 select하여 id와 pw를 비교하여 
		String loginSql = "SELECT member_no, member_id, member_pw FROM member WHERE member_id=? AND member_pw=?";
		pstmt1 = conn.prepareStatement(loginSql);
		pstmt1.setString(1, memberId);
		pstmt1.setString(2, memberPw);
		
		rs = pstmt1.executeQuery();
		System.out.println(pstmt1);
		
		// 맞는 회원이있으면 로그인처리
		if(rs.next()){
			//세션에 로그인 정보 저장
			memberLogin = true;
			session.setAttribute("memberId", rs.getString("member_id"));
			session.setAttribute("memberNo", rs.getString("member_no"));
			//페이지 이동
			response.sendRedirect(request.getContextPath()+"/member/memberIndex.jsp");
		}else{
			//로그인이 잘안되었다면 회원등록페이지로 이동
			response.sendRedirect(request.getContextPath()+"/member/memberAddForm.jsp");
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