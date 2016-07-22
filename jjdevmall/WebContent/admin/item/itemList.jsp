<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8"); %>
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
	
	//세션에서 로그인 데이터가 있는지 확인
	String adminId = null;
	adminId = (String)session.getAttribute("adminId");
	
	if(adminId != null){
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
					<th>수정</th>
					<th>삭제</th>
					</tr>

	<%		
			Iterator<ItemDto> iterator = itemList.iterator();
	
			//DB item테이블에 상품정보를 모두 보여주기위해 반복
			while(iterator.hasNext()){
				ItemDto itemDto = iterator.next();
	%>			
				<tr>
					<td><%=itemDto.getItme_no() %></td>	
					<td><%=itemDto.getItem_name() %></td>
					<td><%=itemDto.getItem_price() %></td>
					<td><%=itemDto.getItem_rate() %>%</td>
					<td><a href="<%=request.getContextPath()%>/admin/item/itemUpdateForm.jsp?sendItemNo=<%=itemDto.getItme_no() %>">수정</a></td>
					<td><a href="<%=request.getContextPath()%>/admin/item/itemDelete.jsp?sendItemNo=<%=itemDto.getItme_no() %>">삭제</a></td>
				</tr>
	<%
			}
	%>
				</table>
			</div>	
<% 
	}else{
		response.sendRedirect(request.getContextPath()+"/admin/login/adminLogin.jsp");
	}
%>
</body>
</html>