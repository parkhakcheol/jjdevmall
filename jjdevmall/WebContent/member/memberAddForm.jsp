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
	span
	{
		font-size: 10px;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		$('#memberId').focus();
		$('#addBtn').click(function(){
			if($('#memberId').val() == '' || !(isNaN($('#memberId').val()))){
				$('#idHelper').text('등록하실 아이디를 입력하세요.');
				$('#memberId').focus();
			}else if($('#memberPw').val() == ''){
				$('#idHelper').text('');
				$('#pwHelper').text('비밀번호가 공백입니다.');
				$('#memberPw').focus();
			}else if($('#memberName').val() == ''|| !(isNaN($('#memberName').val()))){
				$('#pwHelper').text('');
				$('#nameHelper').text('이름을 입력하세요.');
				$('#memberName').focus();
			}else if($('.memberGender:checked').length == 0){
				$('#nameHelper').text('');
				$('#genderHelper').text('성별을 선택하세요.');
				$('.memberGender').focus();
			}else if(isNaN($('#memberAge').val()) || $('#memberAge').val()==''){
				$('#genderHelper').text('');
				$('#ageHelper').text('나이는 숫자만 또는 공백이면 안됩니다.');
				$('#memberAge').focus();
			}else if($('#memberAddr').val()=='' || !(isNaN($('#memberAddr').val()))){
				$('#ageHelper').text('');
				$('#addrHelper').text('주소를 입력하세요.');
				$('#memberAddr').focus();
			}else{
				$('#addrHelper').text('');
				$('#memberForm').submit();
			}
		});
	});
</script>
<title>Insert title here</title>
</head>
<body>
	<form id="memberForm" action="<%=request.getContextPath()%>/member/memberAddAction.jsp" method="post">
		<div id="head">
			회원등록화면
		</div>
		
		<div>
			<label>회원 ID</label>
			<input type="text" name="member_id" id="memberId"/><br/>
			<span id="idHelper"></span>
		</div>
		
		<div>
			<label>회원 PW</label>
			<input type="password" name="member_pw" id="memberPw"/><br/>
			<span id="pwHelper"></span>
		</div>
		
		<div>
			<label>회원 이름</label>
			<input type="text" name="member_name" id="memberName"/><br/>
			<span id="nameHelper"></span>
		</div>
		
		<div>
			<label>회원 성별</label>
			<input type="radio" name="member_gender" class="memberGender" value="남"/>남
			<input type="radio" name="member_gender" class="memberGender" value="여"/>여<br/>
			<span id="genderHelper"></span>		
		</div>
		
		<div>
			<label>회원 나이</label>
			<input type="text" name="member_age" id="memberAge"/><br/>
			<span id="ageHelper"></span>
		</div>
		
		<div>
			<label>회원 주소</label>
			<input type="text" name="member_address" id="memberAddr"/><br/>
			<span id="addrHelper"></span>
		</div>
		
		<div id="btn">
			<input type="button" id="addBtn" value="회원등록"/>
		</div>
		
	</form>
</body>
</html>