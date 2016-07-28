<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%@ page import="kr.or.ksmart.dao.MemberDao" %>
<%@ page import="kr.or.ksmart.dto.MemberDto" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<%

	String loginMemberId = null;
	loginMemberId = (String)session.getAttribute("memberId");
	//로그인이 되어있다면 페이지 출력
	if(loginMemberId != null){

		int memberNo = Integer.parseInt(request.getParameter("member_no"));
		String memberId = request.getParameter("member_id");
		String memberPw = request.getParameter("member_pw");
		String memberName = request.getParameter("member_name");
		String memberGender = request.getParameter("member_gender");
		int memberAge = Integer.parseInt(request.getParameter("member_age"));
		String memberAfterAddr = request.getParameter("member_afteraddr");
		String memberAddress = request.getParameter("member_address");
		
		MemberDao memberDao = new MemberDao();
		MemberDto memberDto = new MemberDto();
		//확인출력
		System.out.println("memberAddAction.jsp -> " + memberId);
		System.out.println("memberAddAction.jsp -> " + memberPw);
		System.out.println("memberAddAction.jsp -> " + memberName);
		System.out.println("memberAddAction.jsp -> " + memberGender);
		System.out.println("memberAddAction.jsp -> " + memberAge);
		
		//객체에 셋팅
		memberDto.setMember_no(memberNo);
		memberDto.setMember_id(memberId);
		memberDto.setMember_pw(memberPw);
		memberDto.setMember_name(memberName);
		memberDto.setMember_gender(memberGender);
		memberDto.setMember_age(memberAge);
		memberDto.setMember_address(memberAddress);
		
		//업데이트 처리 메서드 호출
		int result = memberDao.memberUpdateAction(memberDto, memberAfterAddr);
		System.out.println(result);
		if(result != 0){
			response.sendRedirect(request.getContextPath()+"/member/info/memberInfo.jsp");
		}
	
	}else{
		response.sendRedirect(request.getContextPath()+"/login/memberLogin.jsp");
	}
	
%>
</body>
</html>