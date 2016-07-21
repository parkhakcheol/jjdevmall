<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%@ page import="kr.or.ksmart.dao.OrdersDao" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="orders" class="kr.or.ksmart.dto.OrdersDto"/>
<jsp:setProperty property="*" name="orders"/>
<%
	
//로그인 정보를 세션에서 받아온다
	String loginMemberId = null;
	loginMemberId = (String)session.getAttribute("memberId");
	//확인출력
	System.out.println("memberInfo.jsp loginMemberId-> " + loginMemberId);	
	//로그인이 되어있다면
	if(loginMemberId != null){
		
		int itemNo = Integer.parseInt(request.getParameter("itemNo"));
		int memberNo = Integer.parseInt((String)session.getAttribute("memberNo"));
		
		OrdersDao ordersDao = new OrdersDao();
		int result = ordersDao.ordersInsert(orders, itemNo, memberNo);
				
		if(result != 0 ){
			System.out.println("ordersAddAction.java -> 주문완료");
			response.sendRedirect(request.getContextPath()+"/orders/ordersList.jsp");
		}else{
			System.out.println("ordersAddAction.java -> 주문실패");
			response.sendRedirect(request.getContextPath()+"/member/memberIndex.jsp");
		}
		
	}else{
		response.sendRedirect(request.getContextPath()+"/member/login/memberLogin.jsp");
	}
	

%>
</body>
</html>