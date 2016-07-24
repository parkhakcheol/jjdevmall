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
<jsp:useBean id="item" class="kr.or.ksmart.dto.ItemDto"/>
<jsp:setProperty property="*" name="item"/>
<%
	//로그인이 되어있는지 확인
	String adminId = null;
	adminId = (String)session.getAttribute("adminId");
	
	//로그인이 되어있다면
	if(adminId != null){
		//상품등록
		ItemDao itemDao = new ItemDao();
		int result = itemDao.itemInsert(item);
			
		if(result != 0 ){
			System.out.println("itemAddAction.jsp -> 상품등록완료");
			response.sendRedirect(request.getContextPath()+"/admin/item/itemList.jsp");
		}else{
			System.out.println("itemAddAction.jsp -> 상품등록실패");
			response.sendRedirect(request.getContextPath()+"/admin/adminIndex.jsp");
		}
	//로그인이 안되 있다면 관리자 페이지 이동
	}else{
		response.sendRedirect(request.getContextPath()+"/admin/adminIndex.jsp");
	}
	


	


%>
</body>
</html>