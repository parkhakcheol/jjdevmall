<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html class="no-js" lang="ko">
<div id="head">
	<jsp:include page="/module/head.jsp"/>
</div>
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
<div class="insert">
	<form id="memberForm" action="<%=request.getContextPath()%>/member/memberAddAction.jsp" method="post">
		<div id="head">
			회원가입
		</div>
		
		<div>
			<label>회원 ID : </label>
			<input type="text" name="member_id" id="memberId" class="text"/><br/>
			<span id="idHelper"></span>
		</div>
		
		<div>
			<label>회원 PW : </label>
			<input type="password" name="member_pw" id="memberPw" class="text"/><br/>
			<span id="pwHelper"></span>
		</div>
		
		<div>
			<label>회원 이름 : </label>
			<input type="text" name="member_name" id="memberName" class="text"/><br/>
			<span id="nameHelper"></span>
		</div>
		
		<div>
			<label>회원 성별 </label>
			<input type="radio" name="member_gender" class="memberGender" value="남"/>남
			<input type="radio" name="member_gender" class="memberGender" value="여"/>여<br/>
			<span id="genderHelper"></span>		
		</div>
		
		<div>
			<label>회원 나이 : </label>
			<input type="text" name="member_age" id="memberAge"/><br/>
			<span id="ageHelper"></span>
		</div>
		
		<div>
			<label>회원 주소 : </label>
			<input type="text" name="member_address" id="memberAddr"/><br/>
			<span id="addrHelper"></span>
		</div>
		
		<div>
			<!-- <input type="button" id="addBtn" value="회원등록"/> -->
			<a id="addBtn" class="btn">회원등록</a>
		</div>
		
	</form>
</div>
<%@ include file="/module/footer.jsp" %>	
</body>
</html>