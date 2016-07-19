<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String memberId = (String)session.getAttribute("memberId");
	if(memberId == null){
		response.sendRedirect(request.getContextPath()+"/member/login/memberLogin.jsp");
	}else{
		String memberNo = (String)session.getAttribute("memberNo");
		int itemNo = Integer.parseInt(request.getParameter("sendItemNo"));
		String itemName = request.getParameter("sendItemName");
		int itemPrice = Integer.parseInt(request.getParameter("sendItemPrice"));
		double itemRate = Double.parseDouble(request.getParameter("sendItemRate"));
		
%>
	<script>
		
		$(document).ready(function(){
			$('#checkBtn').click(function(){
				var quantity = Number($('#quantity').val());
				var result = (<%=itemPrice%> * quantity) * (1-<%=itemRate%>);
				
				//consol.log(quantity);
				var lnnerTag = '<label>최종금액 : </label><input type="text" id="itemPrice" name="itemPrice" value="'+result+'"/>';
				//var resultBtn = ' <input type="button" id="resultBtn" value="최종주문"/>';
				$('#resultCheck').append(lnnerTag);
				//$('#resultCheck').append(resultBtn);
			});
			
			$('#resultBtn').click(function(){
				$('#orderAddForm').submit();
			});
		});
	</script>
		<form id="orderAddForm" action="<%=request.getContextPath() %>/order/orderAddAction.jsp">
			
			<div>
				<label>상품번호 : </label>
				<input type="text" id="itemNo" name="itemNo" value="<%=itemNo %>" readonly="readonly"/>
			</div>
			
			<div>
				<label>상품이름 : </label>
				<input type="text" id="itemName" name="itemName" value="<%=itemName %>" readonly="readonly"/>
			</div>
			
			<div>
				<label>주문수량 : </label>
				<select id="quantity" name="quantity">
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
				</select>
			</div>
			
			<div>
				<label>할인율 : </label>
				<input type="text" id="itemRate" name="itemRate" value="<%=itemRate%>"/>
			</div>
			
			<div>
				<input type="button" id="checkBtn" value="주문확인">
			</div>
			
			<div id="resultCheck">
				
			</div>
			
			<div>
				<input type="button" id="resultBtn" value="최종주문"/>
			</div>
		</form>
<%
	}
%>
</body>
</html>