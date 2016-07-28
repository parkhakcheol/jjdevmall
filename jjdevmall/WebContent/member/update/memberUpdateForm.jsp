<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%@ page import="java.util.*" %>
<%@ page import="kr.or.ksmart.dao.MemberDao" %>
<%@ page import="kr.or.ksmart.dto.MemberDto" %>
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
				
			if($('#memberId').val() == ''){
				$('#idHelper').text('아이디는 공백을할 수 없습니다.');
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
			}else{
				$('#memberUpdateForm').submit();
			}
		});
	});
</script>
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String loginMemberId = null;
	loginMemberId = (String)session.getAttribute("memberId");
	
	//확인출력
	System.out.println("memberInfo.jsp loginMemberId-> " + loginMemberId);
	
	//로그인이 되어있다면
	if(loginMemberId != null){
		int sendNo = Integer.parseInt(request.getParameter("sendNo"));
		System.out.println("memberDelete.jsp -> " + sendNo);
		
		MemberDao memberDao = new MemberDao();
		//ArrayList<MemberAndAddressDto> memberList = new ArrayList<MemberAndAddressDto>();
		MemberDto memberDto = new MemberDto();
		memberDto = memberDao.memberUpdateForm(sendNo);

		%>
		<form id="memberUpdateForm" action="<%=request.getContextPath()%>/member/update/memberUpdateAction.jsp" method="post">
			<div id="head">
				회원정보수정화면
				<input type="hidden" name="member_no" id="memberNo" value="<%=sendNo %>"/>
			</div>
			
			<div>
				<label>회원 ID</label>
				<input type="text" name="member_id" id="memberId" value="<%=memberDto.getMember_id() %>"/><br/>
				<span id="idHelper"></span>
			</div>
			
			<div>
				<label>회원 PW</label>
				<input type="password" name="member_pw" id="memberPw" value="<%=memberDto.getMember_pw() %>"/><br/>
				<span id="pwHelper"></span>
			</div>
			
			<div>
				<label>회원 이름</label>
				<input type="text" name="member_name" id="memberName" value="<%=memberDto.getMember_name() %>"/><br/>
				<span id="nameHelper"></span>
			</div>
			
			<div>
				<label>회원 성별</label>
				<%
					if(memberDto.getMember_gender().equals("남")){
				%>
						<input type="radio" name="member_gender" class="memberGender" value="남" checked="checked"/>남
						<input type="radio" name="member_gender" class="memberGender" value="여"/>여<br/>
				<% 
					}else{
				%>
						<input type="radio" name="member_gender" class="memberGender" value="남"/>남
						<input type="radio" name="member_gender" class="memberGender" value="여" checked="checked"/>여<br/>
				<% 	
					}	
				%>
				<span id="genderHelper"></span>		
			</div>
			
			<div>
				<label>회원 나이</label>
				<input type="text" name="member_age" id="memberAge" value="<%=memberDto.getMember_age() %>"/><br/>
				<span id="ageHelper"></span>
			</div>
			
			<div>
				<label>회원 주소</label><br/>
				<input type="hidden" name="member_afteraddr" id="member_afteraddr" value="<%=memberDto.getMember_address() %>"/>
				<input type="text" name="member_address" class="memberAddress" value="<%=memberDto.getMember_address() %>"/><br/>
				<span id="addressHelper"></span>
			</div>
			
			<div id="btn">
				<input type="button" id="addBtn" value="정보수정"/>
			</div>
			
		</form>
<% 
	}else{
		response.sendRedirect(request.getContextPath()+"/member/login/memberLogin.jsp");
	}
%>
</body>
</html>