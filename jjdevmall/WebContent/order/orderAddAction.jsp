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
//로그인 정보를 세션에서 받아온다
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
		int itemNo = Integer.parseInt(request.getParameter("itemNo"));
		int memberNo = Integer.parseInt((String)session.getAttribute("memberNo"));
		int ordersQuantity = Integer.parseInt(request.getParameter("quantity"));
		double itemRate = Double.parseDouble(request.getParameter("itemRate"));
		int itemPrice = Integer.parseInt(request.getParameter("itemPrice"));
		
		//확인 출력
		
		System.out.println("orderAddAction.jsp itemPrice -> " + itemNo);
		System.out.println("orderAddAction.jsp itemPrice -> " + memberNo);
		System.out.println("orderAddAction.jsp itemPrice -> " + ordersQuantity);
		System.out.println("orderAddAction.jsp itemPrice -> " + itemRate);
		System.out.println("orderAddAction.jsp itemPrice -> " + itemPrice);
		
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
			
			//주문 데이터 저장
			String orderSql = "INSERT INTO orders(item_no, member_no, orders_quantity, orders_date, orders_rate, orders_price)VALUES(?,?,?,SYSDATE(),?,?)";
			pstmt1 = conn.prepareStatement(orderSql);
			pstmt1.setInt(1, itemNo);
			pstmt1.setInt(2, memberNo);
			pstmt1.setInt(3, ordersQuantity);
			pstmt1.setDouble(4, itemRate);
			pstmt1.setInt(5, itemPrice);
			
			int result = pstmt1.executeUpdate();
			System.out.println(pstmt1);
			
			if(result != 0 ){
				out.print("<h1>주문등록 완료</h1>");
				response.sendRedirect(request.getContextPath()+"/order/orderList.jsp");
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
		response.sendRedirect(request.getContextPath()+"/member/login/memberLogin.jsp");
	}
	

%>
</body>
</html>