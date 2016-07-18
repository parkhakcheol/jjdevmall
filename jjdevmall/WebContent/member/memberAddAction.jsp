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
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String memberName = request.getParameter("memberName");
	String memberGender = request.getParameter("memberGender");
	int memberAge = Integer.parseInt(request.getParameter("memberAge"));
	String memberAddr = request.getParameter("memberAddr");
	System.out.println(memberAddr);
	
	String driver = "com.mysql.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/jjdevmall?" +
			"useUnicode=true&characterEncoding=utf-8";
	String dbUser = "root";
	String dbPass = "java0000";
	
	Connection conn = null;
	
	//드라이버로딩
	try{
		Class.forName(driver);
		//DB연결
		conn = DriverManager.getConnection(url, dbUser, dbPass);
		conn.setAutoCommit(false); //트랜잭션
		
		String memberSql = "INSERT INTO member(member_id, member_pw, member_name, member_gender, member_age)VALUES(?,?,?,?,?)";
		PreparedStatement pstmt1 = conn.prepareStatement(memberSql, Statement.RETURN_GENERATED_KEYS);
		pstmt1.setString(1, memberId);
		pstmt1.setString(2, memberPw);
		pstmt1.setString(3, memberName);
		pstmt1.setString(4, memberGender);
		pstmt1.setInt(5, memberAge);
		
		int result = pstmt1.executeUpdate();
		System.out.println(pstmt1);
		
		
		if(result != 0)
		{	
			ResultSet rs = pstmt1.getGeneratedKeys();
			
			int key = 0;
			if(rs.next()){
				key = rs.getInt(1);
			}
			String addressSql = "INSERT INTO address(member_no, member_address)VALUES(?,?)";
			PreparedStatement pstmt2 = conn.prepareStatement(addressSql);
			//pstmt2.setInt(1, key);
			pstmt2.setString(2, memberAddr);
			System.out.println(pstmt2);
			result = pstmt2.executeUpdate();
			
			if(result != 0){
				conn.commit();
				out.print("<h1>회원등록 완료!</h1>");
			}
			else{
				out.print("<h1>입력데이터가 잘못되었습니다.</h1>");
			}
		}else{
			out.print("<h1>입력데이터가 잘못되었습니다.</h1>");
		}
		
	}catch(Exception e){
		conn.rollback();
		e.printStackTrace();
	}
	

%>
</body>
</html>