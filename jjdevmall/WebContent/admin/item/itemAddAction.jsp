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
	//form에서 입력값 받아옵니다.
	boolean adminLogin = false;
	if(session.getAttribute("adminLogin") != null){
		adminLogin = (boolean)session.getAttribute("adminLogin");
	}
	
	if(adminLogin){
		String itemName = request.getParameter("itemName");
		int itemPrice = Integer.parseInt(request.getParameter("itemPrice"));
		double itemRate = Double.parseDouble(request.getParameter("itemRate"));
		
		//확인 출력
		System.out.println("itemAddAction.jsp itemName -> " + itemName);
		System.out.println("itemAddAction.jsp itemPrice -> " + itemPrice);
		System.out.println("itemAddAction.jsp itemRate -> " + itemRate);
		
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/jjdevmall?useUnicode=true&characterEncoding=utf-8";
		String dbUser = "root";
		String dbPass = "java0000";
		
		Connection conn = null;
		PreparedStatement pstmt1 = null;
		
		try{
			//드라이버로딩
			Class.forName(driver);
			//DB연결
			conn = DriverManager.getConnection(url, dbUser, dbPass);
			
			//회원정보 insert쿼리 문장
			String itemSql = "INSERT INTO item(item_name, item_price, item_rate)VALUES(?,?,?)";
			
			pstmt1 = conn.prepareStatement(itemSql);
			pstmt1.setString(1, itemName);
			pstmt1.setInt(2, itemPrice);
			pstmt1.setDouble(3, itemRate);
			
			int result = pstmt1.executeUpdate();
			System.out.println(pstmt1);
			
			if(result != 0 ){
				out.print("<h1>상품등록 완료</h1>");
				response.sendRedirect(request.getContextPath()+"/admin/adminIndex.jsp");
			}else{
				out.print("<h1>상품등록 실패</h1>");
			}
		}finally {
			// 사용한 Statement 종료
			if (pstmt1 != null) try { pstmt1.close(); } catch(SQLException ex) {}
			
			// 커넥션 종료
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
	}else{
		response.sendRedirect(request.getContextPath()+"/admin/adminIndex.jsp");
	}
	


	


%>
</body>
</html>