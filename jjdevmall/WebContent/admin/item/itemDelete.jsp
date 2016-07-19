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
	
	boolean adminLogin = false;
	if(session.getAttribute("adminLogin") != null){
		adminLogin = (boolean)session.getAttribute("adminLogin");
	}
	
	if(adminLogin){
		int sendItemNo = Integer.parseInt(request.getParameter("sendItemNo"));
	
	//확인출력
		System.out.println("itemDelete.jsp -> " + sendItemNo);
		
		
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
			String addressSql = "DELETE FROM item WHERE item_no=?";
			
			pstmt1 = conn.prepareStatement(addressSql);
			pstmt1.setInt(1, sendItemNo);
			
			int result = pstmt1.executeUpdate();
			System.out.println(pstmt1);
			
			//주소가 삭제 되었으면
			if(result != 0)
			{	
				conn.commit();
				out.print("<h1>삭제 완료!</h1>");
				response.sendRedirect(request.getContextPath()+"/admin/item/itemList.jsp");
			}else{
				out.print("<h1>입력데이터가 잘못되었습니다.</h1>");
				response.sendRedirect(request.getContextPath()+"/admin/item/itemList.jsp");
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
		response.sendRedirect(request.getContextPath()+"/admin/login/adminLogin.jsp");
	}
	

%>
</body>
</html>