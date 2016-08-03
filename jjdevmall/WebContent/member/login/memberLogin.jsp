<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="no-js" lang="ko">
<%@ include file="/module/head.jsp"  %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		$('#memberId').focus();
		$('#insertBtn').click(function(){
			location.href = "<%=request.getContextPath() %>/member/memberAddForm.jsp";
		});
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

<div class="login">
	<form id="LoginForm" action="<%=request.getContextPath()%>/member/login/memberLoginAction.jsp" method="post">	
		<div>
			<input type="text" name="memberId" id="memberId" class="text" placeholder="ID"/><br/>
			<span id="idHelper"></span>
		</div>
		
		<div>
			<input type="password" name="memberPw" id="memberPw" class="text" placeholder="Password"/><br/>
			<span id="pwHelper"></span>
		</div>
		
		<div>
			<!-- <input type="button" id="loginBtn" class="btn" value="로그인"/> -->
			<a id="loginBtn" class="btn">로그인</a>
			<a class="btn" href="<%=request.getContextPath() %>/member/memberAddForm.jsp">회원가입</a>
			<!-- <input type="button" id="insertBtn" class="btn" value="회원가입"/> -->
		</div>
		
	</form>
</div>
<%@ include file="/module/footer.jsp" %>
</body>
</html>