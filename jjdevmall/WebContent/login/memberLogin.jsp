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
		$('#addBtn').click(function(){
				$('#LoginForm').submit();
		});
	});
</script>
<title>Insert title here</title>
</head>
<body>
	<form id="LoginForm" action="<%=request.getContextPath()%>/login/memberLoginAction.jsp" method="post">
		<div id="head">
			로그인
		</div>
		
		<div>
			<label>회원 ID</label>
			<input type="text" name="memberId" id="memberId"/>
			<span id="idHelper"></span>
		</div>
		
		<div>
			<label>회원 PW</label>
			<input type="password" name="memberPw" id="memberPw"/>
			<span id="pwHelper"></span>
		</div>
		<div id="btn">
			<input type="button" id="addBtn" value="로그인"/>
		</div>
		
	</form>
</body>
</html>