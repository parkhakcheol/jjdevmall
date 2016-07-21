<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
	div
	{	
		border: 1px solid #000000;
		width: 50%;
		margin: 1px auto;
		padding-top: 20px;
	}
</style>

<title>Insert title here</title>
</head>
<body>
	<%
		//관리자 로그인 페이지 입니다
		
		//관리자 로그인 정보를 확인
		String adminId = null;
		adminId = (String)session.getAttribute("adminId");
	
		if(adminId != null){
	%>
		<div>
			<h1>관리자 로그인 페이지</h1>
		</div>
		
		<div>
			<%=session.getAttribute("adminId") %>님환영합니다.
		</div>
		
		<div>
			<ul>
				<li><a href="<%=request.getContextPath() %>/admin/member/memberListAll.jsp">전체 회원정보 조회</a></li>
				<li><a href="<%=request.getContextPath() %>/admin/item/itemAddForm.jsp">상품 등록</a></li>
				<li><a href="<%=request.getContextPath() %>/admin/item/itemList.jsp">상품 조회</a></li>
				<li><a href="<%=request.getContextPath() %>/admin/login/adminLogout.jsp">로그아웃</a></li>
			</ul>
		</div>
	
	<%
		//로그인 정보가 없으면 로그인 페이지로 이동
		}else{
			response.sendRedirect(request.getContextPath()+"/admin/login/adminLogin.jsp");
		}
	%>
</body>
</html>