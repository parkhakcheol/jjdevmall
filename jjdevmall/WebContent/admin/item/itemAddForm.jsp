<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<style>
	div
	{
		border: 1px solid #000000;
		width: 30%;
		height: 50px;
		margin: 0 auto;
		padding-top: 20px;
	}
	#btn, #head 
	{
		font-size: 25px;
		font-style: bold;
		text-align: center;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		$('#itemName').focus();
		$('#addBtn').click(function(){
			if($('#itemName').val() == ''){
				$('#nameHelper').text('등록하실 상품명을 입력하세요');
				$('#itemName').focus();
			}else if(isNaN($('#itemPrice').val()) || $('#itemPrice').val()==''){
				$('#nameHelper').text('');
				$('#priceHelper').text('상품가격은 숫자로만 또는 공백이면 안됩니다.');
				$('#itemPrice').focus();
			}else if(isNaN($('#itemRate').val()) || $('#itemRate').val()=='' || Number($('#itemRate').val()) > 1 || Number($('#itemRate').val()) < 0){
				$('#priceHelper').text('');
				$('#rateHelper').text('할인율은 숫자로만 또는 공백이면 안됩니다.');
				$('#itemRate').focus();
			}else{
				$('#rateHelper').text('');
				$('#itemForm').submit();
			}
		});
	});
</script>
<title>Insert title here</title>
</head>
<body>
<%
	boolean adminLogin = false;
	if(session.getAttribute("adminLogin") != null){
		adminLogin = (boolean)session.getAttribute("adminLogin");
	}

	if(adminLogin){
%>
	<form id="itemForm" action="<%=request.getContextPath() %>/admin/item/itemAddAction.jsp" method="post">
		
		<div id="head">
			상품등록화면
		</div>
		
		<div>
			<label>상품명</label>
			<input type="text" name="itemName" id="itemName"/>
			<span id="nameHelper"></span>
		</div>
		
		<div>
			<label>상품가격</label>
			<input type="text" name="itemPrice" id="itemPrice"/>
			<span id="priceHelper"></span>
		</div>
		
		<div>
			<label>할인율</label>
			<input type="text" name="itemRate" id="itemRate"/>
			<span id="rateHelper"></span>
		</div>
		
		<div id="btn">
			<input type="button" id="addBtn" value="상품등록"/>
		</div>
		
	</form>
<% 	
	}else{
		response.sendRedirect(request.getContextPath()+"/admin/adminIndex.jsp");
	}
	%>
</body>
</html>