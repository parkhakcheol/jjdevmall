<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
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
			if($('#memberPw').val() == ''){
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
				$('#memberForm').submit();
			}
		});
	});
</script>
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	boolean memberLogin = false;
	String loginMemberId = null;
	loginMemberId = (String)session.getAttribute("memberId");
	
	if(session.getAttribute("memberLogin") != null){
		memberLogin = (boolean)session.getAttribute("memberLogin");
	}
	//확인출력
	System.out.println("memberInfo.jsp loginMemberId-> " + loginMemberId);
	System.out.println("memberInfo.jsp memberLogin-> " + memberLogin);
	
	//로그인이 되어있다면
	if(memberLogin){
		String sendId = request.getParameter("sendId");
	
	//확인출력
		System.out.println("memberDelete.jsp -> " + sendId);
		
		
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/jjdevmall?useUnicode=true&characterEncoding=utf-8";
		String dbUser = "root";
		String dbPass = "java0000";
		
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement pstmt1 = null;
		
		String memberId = null;
		String memberPw = null;
		String memberName = null;
		String memberGender = null;
		int memberAge = 0;
		
		
		try{
			//드라이버로딩
			Class.forName(driver);
			//DB연결
			conn = DriverManager.getConnection(url, dbUser, dbPass);
			//회원정보 select문장
			String addressSql = "SELECT member_id, member_pw, member_name, member_gender, member_age FROM member WHERE member_id=?";
			
			pstmt1 = conn.prepareStatement(addressSql);
			pstmt1.setString(1, sendId);
			
			rs = pstmt1.executeQuery();
			System.out.println(pstmt1);
			
			//회원정보가 있다면
			if(rs.next())
			{	
				memberId = rs.getString("member_id");
				memberPw = rs.getString("member_pw");
				memberName = rs.getString("member_name");
				memberGender = rs.getString("member_gender");
				memberAge = rs.getInt("member_age");
			}else{
				out.print("<h1>입력데이터가 잘못되었습니다.</h1>");
				response.sendRedirect(request.getContextPath()+"/member/memberAddForm.jsp");
			}
			
		}catch(Exception e){
			conn.rollback();
			e.printStackTrace();
		}finally {
			// 사용한 Statement 종료
			if (pstmt1 != null) try { pstmt1.close(); } catch(SQLException ex) {}
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			
			// 커넥션 종료
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		%>
		<form id="memberUpdateForm" action="<%=request.getContextPath()%>/member/update/memberUpdateAction.jsp" method="post">
			<div id="head">
				회원정보수정화면
			</div>
			
			<div>
				<label>회원 ID</label>
				<input type="text" name="memberId" id="memberId" readonly="readonly" value="<%=memberId %>"/><br/>
				<span id="idHelper"></span>
			</div>
			
			<div>
				<label>회원 PW</label>
				<input type="password" name="memberPw" id="memberPw" value="<%=memberPw %>"/><br/>
				<span id="pwHelper"></span>
			</div>
			
			<div>
				<label>회원 이름</label>
				<input type="text" name="memberName" id="memberName" value="<%=memberName %>"/><br/>
				<span id="nameHelper"></span>
			</div>
			
			<div>
				<label>회원 성별</label>
				<%
					if(memberGender.equals("남")){
				%>
						<input type="radio" name="memberGender" class="memberGender" value="남" checked="checked"/>남
						<input type="radio" name="memberGender" class="memberGender" value="여"/>여<br/>
				<% 
					}else{
				%>
						<input type="radio" name="memberGender" class="memberGender" value="남"/>남
						<input type="radio" name="memberGender" class="memberGender" value="여" checked="checked"/>여<br/>
				<% 	
					}	
				%>
				<span id="genderHelper"></span>		
			</div>
			
			<div>
				<label>회원 나이</label>
				<input type="text" name="memberAge" id="memberAge" value="<%=memberAge %>"/><br/>
				<span id="ageHelper"></span>
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