<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%@ page import="java.sql.*" %>
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
		//로그인이 되어있다면 페이지 출력
if(loginMemberId != null){

	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String memberName = request.getParameter("memberName");
	String memberGender = request.getParameter("memberGender");
	int memberAge = Integer.parseInt(request.getParameter("memberAge"));
	
	//확인출력
	System.out.println("memberAddAction.jsp -> " + memberId);
	System.out.println("memberAddAction.jsp -> " + memberPw);
	System.out.println("memberAddAction.jsp -> " + memberName);
	System.out.println("memberAddAction.jsp -> " + memberGender);
	System.out.println("memberAddAction.jsp -> " + memberAge);
	
	String driver = "com.mysql.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/jjdevmall?useUnicode=true&characterEncoding=utf-8";
	String dbUser = "root";
	String dbPass = "java0000";
	
	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement pstmt1 = null;
	
	try{
		//드라이버로딩
		Class.forName(driver);
		//DB연결
		conn = DriverManager.getConnection(url, dbUser, dbPass);
		conn.setAutoCommit(false); //트랜잭션
		//회원정보 insert쿼리 문장
		String memberSql = "UPDATE member SET member_pw=?, member_name=?, member_gender=?, member_age=? WHERE member_id=?";
		
		pstmt1 = conn.prepareStatement(memberSql, Statement.RETURN_GENERATED_KEYS);
		
		pstmt1.setString(1, memberPw);
		pstmt1.setString(2, memberName);
		pstmt1.setString(3, memberGender);
		pstmt1.setInt(4, memberAge);
		pstmt1.setString(5, memberId);
		
		int result = pstmt1.executeUpdate();
		System.out.println(pstmt1);
		
		//회원정보가 잘입력되었다면
		if(result != 0){	
			conn.commit();
			out.print("<h1>회원수정 완료!</h1>");
			response.sendRedirect(request.getContextPath()+"/member/memberIndex.jsp");
		}else{
			out.print("<h1>입력데이터가 잘못되었습니다.</h1>");
			response.sendRedirect(request.getContextPath()+"/member/memberAddForm.jsp");
		}
		
	}catch(Exception e){
		conn.rollback();
		e.printStackTrace();
	}finally {
		// 사용한 Statement 종료
		if (pstmt1 != null) try { pstmt1.close(); } catch(SQLException ex) {}
		if (rs != null) try { rs.close(); } catch(SQLException ex) {}
		
		// 커넥션 종료
		if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	}
}else{
	
}
	
%>
</body>
</html>