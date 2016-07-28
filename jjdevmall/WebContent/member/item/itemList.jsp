<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.util.*" %>
<%@page import="kr.or.ksmart.dto.ItemDto" %>
<%@page import="kr.or.ksmart.dao.ItemDao" %>
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
	String loginMemberId = null;
	loginMemberId = (String)session.getAttribute("memberId");
	
	//로그인이 되어있다면
	if(loginMemberId != null){
		String search = null;
		ItemDao itemDao = new ItemDao();
		ArrayList<ItemDto> itemList = itemDao.itemSelect(search);
			
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
					<th>주문</th>
					</tr>

	<%		
			//DB item테이블에 상품정보를 모두 보여주기위해 반복
			Iterator<ItemDto> iterator = itemList.iterator();
	
			//DB item테이블에 상품정보를 모두 보여주기위해 반복
			while(iterator.hasNext()){
				ItemDto itemDto = iterator.next();
				// 결과값을 각 변수에 대입
				int itemNo = itemDto.getItme_no();
				String itemName = itemDto.getItem_name();
				int itemPrice = itemDto.getItem_price();
				double itemRate = itemDto.getItem_rate();
				

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
					<td><%=itemRate %></td>
					<td><a href="<%=request.getContextPath()%>/orders/ordersAddForm.jsp?sendItemNo=<%=itemNo %>&sendItemName=<%=itemName %>&sendItemPrice=<%=itemPrice %>&sendItemRate=<%=itemRate %>">주문</a></td>
				</tr>
	<%
			}
	%>
				</table>
			</div>
	<% 
	//로그인 정보가없으면 로그인페이지로 이동
	}else{
		response.sendRedirect(request.getContextPath()+"/member/login/memberLogin.jsp");
	}
%>
</body>
</html>