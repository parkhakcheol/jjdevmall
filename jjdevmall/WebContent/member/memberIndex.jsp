<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	
	div
	{	
		border: 1px solid #000000;
		width: 50%;
		margin: 0 auto;
		padding-top: 20px;
	}
</style>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		//회원로그인 페이지입니다.
		
		//로그인 정보를 세션에서 받아와
		boolean memberLogin = false;
		if(session.getAttribute("memberLogin") != null){
			memberLogin = (boolean)session.getAttribute("memberLogin");
		}
		//로그인이 되어있다면 페이지 출력
		if(memberLogin){
	%>
		<div>
			<h1>회원 로그인 페이지</h1>
		</div>
		
		<div>
			<%=session.getAttribute("memberId") %>님환영합니다.
		</div>
		
		<div>
			<ul>
				<li><a href="<%=request.getContextPath() %>/member/info/memberInfo.jsp">회원정보 조회</a></li>
				<li><a href="<%=request.getContextPath() %>/member/memberAddAddressForm.jsp">배송지 추가</a></li>
				<li><a href="<%=request.getContextPath() %>/member/item/itemList.jsp">상품목록</a></li>
				<li><a href="<%=request.getContextPath() %>/order/orderList.jsp">주문조회</a></li>
				<li><a href="<%=request.getContextPath() %>/member/login/memberLogout.jsp">로그아웃</a></li>
			</ul>
		</div>
	
	<%
		//로그인이 되어있지않으면 로그인 페이지로 이동
		}else{
			response.sendRedirect(request.getContextPath()+"/member/login/memberLogin.jsp");
		}
	%>
</body>
</html>