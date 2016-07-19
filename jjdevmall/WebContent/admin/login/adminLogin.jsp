<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style>
	div
	{
		border: 1px solid #000000;
		width: 30%;
		height: 50px;
		margin: 10px auto;
		padding-top: 20px;
	}
	#head 
	{
		font-size: 25px;
		font-style: bold;
		text-align: center;
	}
	#btn
	{
		text-align: center;
	}
	span
	{
		font-size: 10px;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		$('#adminId').focus();
		$('#loginBtn').click(function(){
			if($('#adminId').val() == '' || !(isNaN($('#adminId').val()))){
				$('#pwHelper').text('');
				$('#idHelper').text('아이디는 영문숫자 조합, 공백이 아니여야 합니다.');
				$('#adminId').focus();
			}else if($('#adminPw').val() == ''){
				$('#idHelper').text('');
				$('#pwHelper').text('비밀번호는 공백이 아니여야 합니다.');
				$('#adminPw').focus();
			}else{
				$('#LoginForm').submit();
			}
				
		});
	});
</script>
<title>Insert title here</title>
</head>
<body>
	<form id="LoginForm" action="<%=request.getContextPath()%>/admin/login/adminLoginAction.jsp" method="post">
		<div id="head">
			관리자 로그인
		</div>
		
		<div>
			<label>관리자 ID : </label>
			<input type="text" name="adminId" id="adminId"/><br/>
			<span id="idHelper"></span>
		</div>
		
		<div>
			<label>관리자 PW :</label>
			<input type="password" name="adminPw" id="adminPw"/><br/>
			<span id="pwHelper"></span>
		</div>
		
		<div id="btn">
			<input type="button" id="loginBtn" value="로그인"/> / 
			<a href="<%=request.getContextPath() %>/index.jsp">메인 페이지로</a>
		</div>
		
	</form>
</body>
</html>