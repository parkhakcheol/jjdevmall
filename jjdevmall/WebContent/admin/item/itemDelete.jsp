<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%@ page import="kr.or.ksmart.dao.ItemDao" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<%
	String adminId = null;
	adminId = (String)session.getAttribute("adminId");
	
	if(adminId != null){
		int sendItemNo = Integer.parseInt(request.getParameter("sendItemNo"));
		
		ItemDao itemDao = new ItemDao();
		int result = itemDao.itemDelete(sendItemNo);
			
			
		if(result != 0){	
			System.out.println("ItemDelete.java -> 상품삭제완료");
			response.sendRedirect(request.getContextPath()+"/admin/item/itemList.jsp");
		}else{
			System.out.println("ItemDelete.java -> 상품삭제실패");
			response.sendRedirect(request.getContextPath()+"/admin/item/itemList.jsp");
		}
			
	}else{
		response.sendRedirect(request.getContextPath()+"/admin/login/adminLogin.jsp");
	}
	

%>
</body>
</html>