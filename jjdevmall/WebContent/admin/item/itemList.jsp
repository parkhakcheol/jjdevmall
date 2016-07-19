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
		width: 50%;
		height: 50px;
		margin: 0 auto;
		padding-top: 20px;
	}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	//세션에서 로그인 데이터가 있는지 확인
	boolean adminLogin = false;
	if(session.getAttribute("adminLogin") != null){
		adminLogin = (boolean)session.getAttribute("adminLogin");
	}
	//로그인이 되어있다면
	if(adminLogin){
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
			listSql = "SELECT item_no, item_name, item_price, item_rate FROM item";
			pstmt1 = conn.prepareStatement(listSql);
			
			rs = pstmt1.executeQuery();
			System.out.println(pstmt1);
			
			//html태그 사용 상품정보를 테이블에 출력
	%>
			<div>
			<h1>상품 리스트</h1>
				<table>
					<tr>
					<th>상품번호</th>
					<th>상품이름</th>
					<th>상품가격</th>
					<th>할인율</th>
					<th>수정</th>
					<th>삭제</th>
					</tr>

	<%		
			//DB item테이블에 상품정보를 모두 보여주기위해 반복
			while(rs.next()){
				// 결과값을 각 변수에 대입
				String itemNo = rs.getString("item_no");
				String itemName = rs.getString("item_name");
				int itemPrice = rs.getInt("item_price");
				double itemRate = rs.getDouble("item_rate") * 100;
				

				//확인 출력
				System.out.println("itemList.jsp -> " + itemNo);
				System.out.println("itemList.jsp -> " + itemName);
				System.out.println("itemList.jsp -> " + itemPrice);
				System.out.println("itemList.jsp -> " + itemRate);
				// 테이블 행에 하나의 회원정보 입력
	%>			
				<tr>
					<td><%=itemNo %></td>	
					<td><%=itemName %></td>
					<td><%=itemPrice %></td>
					<td><%=itemRate %>%</td>
					<td><a href="<%=request.getContextPath()%>/admin/item/itemUpdateForm.jsp?sendItemNo=<%=itemNo %>">수정</a></td>
					<td><a href="<%=request.getContextPath()%>/admin/item/itemDelete.jsp?sendItemNo=<%=itemNo %>">삭제</a></td>
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
		response.sendRedirect(request.getContextPath()+"/admin/login/adminLogin.jsp");
	}
%>
</body>
</html>