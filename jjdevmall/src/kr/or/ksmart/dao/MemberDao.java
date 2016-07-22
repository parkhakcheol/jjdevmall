package kr.or.ksmart.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import kr.or.ksmart.dto.MemberAndAddressDto;
import kr.or.ksmart.dto.MemberDto;

public class MemberDao {
	Connection connection = null;
	ResultSet resultSet = null;
	
	//생성자 mysql드라이버 로드, DB연결
	public MemberDao(){
		DriverDB driverConn = new DriverDB();
		try {
			connection = driverConn.driverDb();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//회원 가입 메서드(insert 처리)
	public int memberInsert(MemberDto member) throws SQLException {
		PreparedStatement memberInsertPstmt = null;
		PreparedStatement addressInsertPstmt = null;
		int result = 0;
		
		String memberSql = "INSERT INTO member(member_id, member_pw, member_name, member_gender, member_age)VALUES(?,?,?,?,?)";
		
		try {
			connection.setAutoCommit(false); //트랜잭션
			memberInsertPstmt = connection.prepareStatement(memberSql, Statement.RETURN_GENERATED_KEYS);

			memberInsertPstmt.setString(1, member.getMember_id());
			memberInsertPstmt.setString(2, member.getMember_pw());
			memberInsertPstmt.setString(3, member.getMember_name());
			memberInsertPstmt.setString(4, member.getMember_gender());
			memberInsertPstmt.setInt(5, member.getMember_age());
			result = memberInsertPstmt.executeUpdate();
			System.out.println(memberInsertPstmt);
			
			//member table에 정상 입력되었다면.
			if(result != 0)
			{	
				
				resultSet = memberInsertPstmt.getGeneratedKeys();
				
				//마지막 회원번호를 받아와
				int key = 0;
				if(resultSet.next()){
					key = resultSet.getInt(1);
				}
				//회원번호와 주소를 입력
				String addressSql = "INSERT INTO address(member_no, member_address)VALUES(?,?)";
				addressInsertPstmt = connection.prepareStatement(addressSql);
				addressInsertPstmt.setInt(1, key);
				addressInsertPstmt.setString(2, member.getMember_address());
				System.out.println(addressInsertPstmt);
				result = addressInsertPstmt.executeUpdate();
				
				//정상 입력 되었다면 커밋
				if(result != 0){
					connection.commit();
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			connection.rollback();
		}finally {
			// 사용한 Statement 종료
			if (memberInsertPstmt != null) try { memberInsertPstmt.close(); } catch(SQLException ex) {}
			if (addressInsertPstmt != null) try { addressInsertPstmt.close(); } catch(SQLException ex) {}
			if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
			// 커넥션 종료
			if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		}
		return result;	
	}
	
	//member table 삭제 처리 메소드
	public int memberDeldte(int memberNo) throws SQLException{
		int result = 0;
		PreparedStatement addressDeletePstmt = null;
		PreparedStatement memberDeletePstmt = null;
		try {
			connection.setAutoCommit(false);
			//회원정보 insert쿼리 문장
			String addressSql = "DELETE FROM address WHERE member_no=?";
			
			addressDeletePstmt = connection.prepareStatement(addressSql);
			addressDeletePstmt.setInt(1, memberNo);
			
			result = addressDeletePstmt.executeUpdate();
			System.out.println(addressDeletePstmt);
			
			//주소가 삭제 되었으면
			if(result != 0)
			{	
				String memberSql = "DELETE FROM member WHERE member_no=?";
				memberDeletePstmt = connection.prepareStatement(memberSql);
				memberDeletePstmt.setInt(1, memberNo);
				System.out.println(memberDeletePstmt);
				result = memberDeletePstmt.executeUpdate();
				//정상처리 되었다면 커밋
				if(result != 0){
					connection.commit();
				}
			}
		} catch (SQLException e) {
			connection.rollback();
			e.printStackTrace();
		} finally {
			// 객체 종료
			if (addressDeletePstmt != null) try { addressDeletePstmt.close(); } catch(SQLException ex) {}
			if (memberDeletePstmt != null) try { memberDeletePstmt.close(); } catch(SQLException ex) {}
			if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
			
			// 커넥션 종료
			if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		}	
		return result;
		
	}
	
	//회원 리스트를 가져오는 메서드
	public ArrayList<MemberDto> memberSelect(String search) throws SQLException{
		ArrayList<MemberDto> memberList = new ArrayList<MemberDto>();
		
		String listSql = null;
		PreparedStatement memberListPstmt = null;
		//전체회원을 보여주는 select 
		listSql = "SELECT member_no, member_id, member_pw, member_name, member_gender, member_age FROM member";
		memberListPstmt = connection.prepareStatement(listSql);
		
		resultSet = memberListPstmt.executeQuery();
		System.out.println(memberListPstmt);
		
		while(resultSet.next()){
			
			MemberDto memberDto = new MemberDto();
			// 결과값을 각 변수에 대입
			int  memberNo = resultSet.getInt("member_no");
			String memberId = resultSet.getString("member_id");
			String memberPw = resultSet.getString("member_pw");
			String memberName = resultSet.getString("member_name");
			String memberGender = resultSet.getString("member_gender");
			int memberAge = resultSet.getInt("member_age");
				
			//확인 출력
			System.out.println("MemberDao.java select member_no-> " + memberNo);
			System.out.println("MemberDao.java select member_id-> " + memberId);
			System.out.println("MemberDao.java select member_pw-> " + memberPw);
			System.out.println("MemberDao.java select member_name-> " + memberName);
			System.out.println("MemberDao.java select member_gender-> " + memberGender);
			System.out.println("MemberDao.java select member_age-> " + memberAge);
			
			//한명의 회원정보를 memberDto객체에 set
			memberDto.setMember_no(memberNo);
			memberDto.setMember_id(memberId);
			memberDto.setMember_pw(memberPw);
			memberDto.setMember_name(memberName);
			memberDto.setMember_gender(memberGender);
			memberDto.setMember_age(memberAge);
			
			// 리스트에 add
			memberList.add(memberDto);
		}
		
		if (memberListPstmt != null) try { memberListPstmt.close(); } catch(SQLException ex) {}
		if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
		
		// 커넥션 종료
		if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		
		return memberList;
		
	}
	
	// 회원 주소의 리스트 메서드
	public ArrayList<MemberAndAddressDto> addrSelect(int sendNo) throws SQLException{
		ArrayList<MemberAndAddressDto> addrList = new ArrayList<MemberAndAddressDto>();
		PreparedStatement addrListPstmt = null;
		String listSql = null;
		
		//join을 사용하여 회원이름과 같이 보여줍니다.
		listSql = "SELECT m.member_no, m.member_id, m.member_name, addr.member_address FROM member m LEFT JOIN address addr ON m.member_no=addr.member_no WHERE m.member_no=?";
		addrListPstmt = connection.prepareStatement(listSql);
		addrListPstmt.setInt(1, sendNo);
		
		//쿼리 실행
		resultSet = addrListPstmt.executeQuery();
		System.out.println(addrListPstmt);
		
		while(resultSet.next()){
			MemberAndAddressDto addressDto = new MemberAndAddressDto();
			// 결과값을 각 변수에 대입
			int memberNo = resultSet.getInt("member_no");
			String memberId = resultSet.getString("member_id");
			String memberName = resultSet.getString("member_name");
			String memberAddress = resultSet.getString("member_address");
			
			//확인 출력
			System.out.println("MemberDao.jsp addSelect member_no -> " + memberNo);
			System.out.println("MemberDao.jsp addSelect member_id -> " + memberId);
			System.out.println("MemberDao.jsp addSelect member_name -> " + memberName);
			System.out.println("MemberDao.jsp addSelect member_address -> " + memberAddress);
			
			//AddressDto객체에 한명 회원주소 정보 저장
			addressDto.setMember_no(memberNo);
			addressDto.setMember_id(memberId);
			addressDto.setMember_name(memberName);
			addressDto.setMember_address(memberAddress);
			
			//리스트에 add
			addrList.add(addressDto);
		}
		if (addrListPstmt != null) try { addrListPstmt.close(); } catch(SQLException ex) {}
		if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
		
		// 커넥션 종료
		if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		
		return addrList;
	}
	
	//회원정보 수정처리 메서드
	public int memberUpdate(MemberDto memberDto){
		int result = 0;
		
		
		return result;
		
	}
}
