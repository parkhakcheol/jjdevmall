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
		$('#memberId').focus();
		$('#loginBtn').click(function(){
			if($('#memberId').val() == '' || !(isNaN($('#memberId').val()))){
				$('#pwHelper').text('');
				$('#idHelper').text('아이디는 영문숫자 조합, 공백이 아니여야 합니다.');
				$('#memberId').focus();
			}else if($('#memberPw').val() == ''){
				$('#idHelper').text('');
				$('#pwHelper').text('비밀번호는 공백이 아니여야 합니다.');
				$('#memberPw').focus();
			}else{
				$('#LoginForm').submit();
			}
				
		});
	});
</script>
<title>Insert title here</title>
</head>
<body>
	<form id="LoginForm" action="<%=request.getContextPath()%>/member/login/memberLoginAction.jsp" method="post">
		<div id="head">
			회원 로그인
		</div>
		
		<div>
			<label>회원 ID : </label>
			<input type="text" name="memberId" id="memberId"/><br/>
			<span id="idHelper"></span>
		</div>
		
		<div>
			<label>회원 PW :</label>
			<input type="password" name="memberPw" id="memberPw"/><br/>
			<span id="pwHelper"></span>
		</div>
		
		<div id="btn">
			<input type="button" id="loginBtn" value="로그인"/> / 
			<a href="<%=request.getContextPath() %>/member/memberAddForm.jsp">회원가입</a> / 
			<a href="<%=request.getContextPath() %>/index.html">메인 페이지로</a>
		</div>
		
	</form>
</body>
</html>