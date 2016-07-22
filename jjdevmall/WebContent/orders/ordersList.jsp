<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<style>
	table, td, th
	{
		border: 1px solid #000000;
	}
	div
	{
		width: 100%;
		height: 50px;
		margin: 0 auto;
		padding-top: 20px;
	}
	table{width:100%;}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String loginMemberId = null;
	loginMemberId = (String)session.getAttribute("memberId");
	//확인출력
	System.out.println("memberInfo.jsp loginMemberId-> " + loginMemberId);	
	//로그인이 되어있다면
	if(loginMemberId != null){
		String loginMemberNo = null;
		loginMemberNo = (String)session.getAttribute("memberNo");
		
		int memberNumber = Integer.parseInt(loginMemberNo);
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
			String listSql = null;
			//전체회원을 보여주는 select 
			listSql = "SELECT * FROM orders WHERE member_no=?";
			pstmt1 = conn.prepareStatement(listSql);
			pstmt1.setInt(1, memberNumber);
			
			rs = pstmt1.executeQuery();
			System.out.println(pstmt1);
			
			//html태그 사용 상품정보를 테이블에 출력
	%>
			<div>
			<h1>주문 리스트</h1>
				
				<table>
					<tr>
					<th>주문번호</th>
					<th>상품번호</th>
					<th>회원번호</th>
					<th>주문수량</th>
					<th>날짜</th>
					<th>할인율</th>
					<th>최종가격</th>
					<th>상태</th>
					</tr>

	<%		
			//DB item테이블에 상품정보를 모두 보여주기위해 반복
			while(rs.next()){
				// 결과값을 각 변수에 대입
				int ordersNo = rs.getInt("orders_no");
				int itemNo = rs.getInt("item_no");
				int memberNo = rs.getInt("member_no");
				int ordersQuantity = rs.getInt("orders_quantity");
				String orderDate = rs.getString("orders_date");
				double ordersRate = rs.getDouble("orders_rate");
				int ordersPrice = rs.getInt("orders_price");
				String ordersState = rs.getString("orders_state");
				
				

				//확인 출력
				System.out.println("ordersList.jsp -> " + ordersNo);
				System.out.println("ordersList.jsp -> " + itemNo);
				System.out.println("ordersList.jsp -> " + memberNo);
				System.out.println("ordersList.jsp -> " + ordersQuantity);
				System.out.println("ordersList.jsp -> " + orderDate);
				System.out.println("ordersList.jsp -> " + ordersRate);
				System.out.println("ordersList.jsp -> " + ordersPrice);
				System.out.println("ordersList.jsp -> " + ordersState);
				// 테이블 행에 하나의 회원정보 입력
	%>			
				<tr>
					<td><%=ordersNo %></td>	
					<td><%=itemNo %></td>
					<td><%=memberNo %></td>
					<td><%=ordersQuantity %></td>
					<td><%=orderDate %></td>
					<td><%=ordersRate %></td>
					<td><%=ordersPrice %></td>
					<td><%=ordersState %></td>
				</tr>
	<%
			}
	%>
				</table>
			</div>
	<% 
		}finally {
			// 사용한 Statement 종료
			if (pstmt1 != null) try { pstmt1.close(); } catch(SQLException ex) {}
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			
			// 커넥션 종료
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
	//로그인 정보가없으면 로그인페이지로 이동
	}else{
		response.sendRedirect(request.getContextPath()+"/member/login/memberLogin.jsp");
	}
%>

</body>
</html>