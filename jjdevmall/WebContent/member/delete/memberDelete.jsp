<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	boolean memberLogin = false;
	String loginMemberId = null;
	loginMemberId = (String)session.getAttribute("memberId");
	
	if(session.getAttribute("memberLogin") != null){
		memberLogin = (boolean)session.getAttribute("memberLogin");
	}
	//확인출력
	System.out.println("memberInfo.jsp loginMemberId-> " + loginMemberId);
	System.out.println("memberInfo.jsp memberLogin-> " + memberLogin);
	
	//로그인이 되어있다면
	if(memberLogin){
		int memberNo = Integer.parseInt(request.getParameter("sendNo"));
	
	//확인출력
		System.out.println("memberDelete.jsp -> " + memberNo);
		
		
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/jjdevmall?useUnicode=true&characterEncoding=utf-8";
		String dbUser = "root";
		String dbPass = "java0000";
		
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;
		
		try{
			//드라이버로딩
			Class.forName(driver);
			//DB연결
			conn = DriverManager.getConnection(url, dbUser, dbPass);
			conn.setAutoCommit(false); //트랜잭션
			//회원정보 insert쿼리 문장
			String addressSql = "DELETE FROM address WHERE member_no=?";
			
			pstmt1 = conn.prepareStatement(addressSql);
			pstmt1.setInt(1, memberNo);
			
			int result = pstmt1.executeUpdate();
			System.out.println(pstmt1);
			
			//주소가 삭제 되었으면
			if(result != 0)
			{	
				String memberSql = "DELETE FROM member WHERE member_no=?";
				pstmt2 = conn.prepareStatement(memberSql);
				pstmt2.setInt(1, memberNo);
				System.out.println(pstmt2);
				result = pstmt2.executeUpdate();
				//정상처리 되었다면 커밋
				if(result != 0){
					conn.commit();
					out.print("<h1>탈퇴 완료!</h1>");
					response.sendRedirect(request.getContextPath()+"/member/login/memberLogin.jsp");
				}
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
			if (pstmt2 != null) try { pstmt2.close(); } catch(SQLException ex) {}
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			
			// 커넥션 종료
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
	}else{
		response.sendRedirect(request.getContextPath()+"/member/login/memberLogin.jsp");
	}
	

%>
</body>
</html>