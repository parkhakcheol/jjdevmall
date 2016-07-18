<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	
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
		
		//회원정보 insert쿼리 문장
		String listSql = "SELECT member_no, member_id, member_pw, member_name, member_gender, member_age FROM member";
		
		pstmt1 = conn.prepareStatement(listSql);
		
		
		rs = pstmt1.executeQuery();
		System.out.println(pstmt1);
		
		//html태그 사용 회원정보를 테이블에 출력
		out.print("<table border=1>");
		out.print("<tr>");
		out.print("<th>회원번호</th>");
		out.print("<th>회원ID</th>");
		out.print("<th>회원PW</th>");
		out.print("<th>회원이름</th>");
		out.print("<th>회원성별</th>");
		out.print("<th>회원나이</th>");
		out.print("<th>주소등록</th>");
		out.print("</tr>");
		//DB member테이블에 회원정보를 모두 보여주기위해 반복
		while(rs.next()){
			// 결과값을 각 변수에 대입
			String memberNo = rs.getString("member_no");
			String memberId = rs.getString("member_id");
			String memberPw = rs.getString("member_pw");
			String memberName = rs.getString("member_name");
			String memberGender = rs.getString("member_gender");
			String memberAge = rs.getString("member_age");
			
			//확인 출력
			System.out.println("ListAll.jsp -> " + memberNo);
			System.out.println("ListAll.jsp -> " + memberId);
			System.out.println("ListAll.jsp -> " + memberPw);
			System.out.println("ListAll.jsp -> " + memberName);
			System.out.println("ListAll.jsp -> " + memberGender);
			System.out.println("ListAll.jsp -> " + memberAge);
			
			// 테이블 행에 하나의 회원정보 입력
			out.print("<tr>");
			out.print("<td>"+memberNo+"</td>");
			out.print("<td>"+memberId+"</td>");
			out.print("<td>"+memberPw+"</td>");
			out.print("<td>"+memberName+"</td>");
			out.print("<td>"+memberGender+"</td>");
			out.print("<td>"+memberAge+"</td>");
			out.print("<td><a href=>주소등록</a></td>");
			out.print("</tr>");
		}
		out.print("</table>");
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