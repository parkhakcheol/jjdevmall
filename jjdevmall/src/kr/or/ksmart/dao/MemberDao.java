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
	
	//������ mysql����̹� �ε�, DB����
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
	
	//ȸ�� ���� �޼���(insert ó��)
	public int memberInsert(MemberDto member) throws SQLException {
		PreparedStatement memberInsertPstmt = null;
		PreparedStatement addressInsertPstmt = null;
		int result = 0;
		
		String memberSql = "INSERT INTO member(member_id, member_pw, member_name, member_gender, member_age)VALUES(?,?,?,?,?)";
		
		try {
			connection.setAutoCommit(false); //Ʈ�����
			memberInsertPstmt = connection.prepareStatement(memberSql, Statement.RETURN_GENERATED_KEYS);

			memberInsertPstmt.setString(1, member.getMember_id());
			memberInsertPstmt.setString(2, member.getMember_pw());
			memberInsertPstmt.setString(3, member.getMember_name());
			memberInsertPstmt.setString(4, member.getMember_gender());
			memberInsertPstmt.setInt(5, member.getMember_age());
			result = memberInsertPstmt.executeUpdate();
			System.out.println(memberInsertPstmt);
			
			//member table�� ���� �ԷµǾ��ٸ�.
			if(result != 0)
			{	
				
				resultSet = memberInsertPstmt.getGeneratedKeys();
				
				//������ ȸ����ȣ�� �޾ƿ�
				int key = 0;
				if(resultSet.next()){
					key = resultSet.getInt(1);
				}
				//ȸ����ȣ�� �ּҸ� �Է�
				String addressSql = "INSERT INTO address(member_no, member_address)VALUES(?,?)";
				addressInsertPstmt = connection.prepareStatement(addressSql);
				addressInsertPstmt.setInt(1, key);
				addressInsertPstmt.setString(2, member.getMember_address());
				System.out.println(addressInsertPstmt);
				result = addressInsertPstmt.executeUpdate();
				
				//���� �Է� �Ǿ��ٸ� Ŀ��
				if(result != 0){
					connection.commit();
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			connection.rollback();
		}finally {
			// ����� Statement ����
			if (memberInsertPstmt != null) try { memberInsertPstmt.close(); } catch(SQLException ex) {}
			if (addressInsertPstmt != null) try { addressInsertPstmt.close(); } catch(SQLException ex) {}
			if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
			// Ŀ�ؼ� ����
			if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		}
		return result;	
	}
	
	//member table ���� ó�� �޼ҵ�
	public int memberDeldte(int memberNo) throws SQLException{
		int result = 0;
		PreparedStatement addressDeletePstmt = null;
		PreparedStatement memberDeletePstmt = null;
		try {
			connection.setAutoCommit(false);
			//ȸ������ insert���� ����
			String addressSql = "DELETE FROM address WHERE member_no=?";
			
			addressDeletePstmt = connection.prepareStatement(addressSql);
			addressDeletePstmt.setInt(1, memberNo);
			
			result = addressDeletePstmt.executeUpdate();
			System.out.println(addressDeletePstmt);
			
			//�ּҰ� ���� �Ǿ�����
			if(result != 0)
			{	
				String memberSql = "DELETE FROM member WHERE member_no=?";
				memberDeletePstmt = connection.prepareStatement(memberSql);
				memberDeletePstmt.setInt(1, memberNo);
				System.out.println(memberDeletePstmt);
				result = memberDeletePstmt.executeUpdate();
				//����ó�� �Ǿ��ٸ� Ŀ��
				if(result != 0){
					connection.commit();
				}
			}
		} catch (SQLException e) {
			connection.rollback();
			e.printStackTrace();
		} finally {
			// ��ü ����
			if (addressDeletePstmt != null) try { addressDeletePstmt.close(); } catch(SQLException ex) {}
			if (memberDeletePstmt != null) try { memberDeletePstmt.close(); } catch(SQLException ex) {}
			if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
			
			// Ŀ�ؼ� ����
			if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		}	
		return result;
		
	}
	
	//ȸ�� ����Ʈ�� �������� �޼���
	public ArrayList<MemberDto> memberSelect(String search) throws SQLException{
		ArrayList<MemberDto> memberList = new ArrayList<MemberDto>();
		
		String listSql = null;
		PreparedStatement memberListPstmt = null;
		//��üȸ���� �����ִ� select
		if(search == null){
			listSql = "SELECT member_no, member_id, member_pw, member_name, member_gender, member_age FROM member";
			memberListPstmt = connection.prepareStatement(listSql);
		}else{
			listSql = "SELECT member_no, member_id, member_pw, member_name, member_gender, member_age FROM member WHERE member_id=?";
			memberListPstmt = connection.prepareStatement(listSql);
			memberListPstmt.setString(1, search);
		}
			
		resultSet = memberListPstmt.executeQuery();
		System.out.println(memberListPstmt);
		
		while(resultSet.next()){
			
			MemberDto memberDto = new MemberDto();
			// ������� �� ������ ����
			int  memberNo = resultSet.getInt("member_no");
			String memberId = resultSet.getString("member_id");
			String memberPw = resultSet.getString("member_pw");
			String memberName = resultSet.getString("member_name");
			String memberGender = resultSet.getString("member_gender");
			int memberAge = resultSet.getInt("member_age");
				
			//Ȯ�� ���
			System.out.println("MemberDao.java select member_no-> " + memberNo);
			System.out.println("MemberDao.java select member_id-> " + memberId);
			System.out.println("MemberDao.java select member_pw-> " + memberPw);
			System.out.println("MemberDao.java select member_name-> " + memberName);
			System.out.println("MemberDao.java select member_gender-> " + memberGender);
			System.out.println("MemberDao.java select member_age-> " + memberAge);
			
			//�Ѹ��� ȸ�������� memberDto��ü�� set
			memberDto.setMember_no(memberNo);
			memberDto.setMember_id(memberId);
			memberDto.setMember_pw(memberPw);
			memberDto.setMember_name(memberName);
			memberDto.setMember_gender(memberGender);
			memberDto.setMember_age(memberAge);
			
			// ����Ʈ�� add
			memberList.add(memberDto);
		}
		
		if (memberListPstmt != null) try { memberListPstmt.close(); } catch(SQLException ex) {}
		if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
		
		// Ŀ�ؼ� ����
		if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		
		return memberList;
		
	}
	
	// ȸ�� �ּ��� ����Ʈ �޼���
	public ArrayList<MemberAndAddressDto> addrSelect(int sendNo) throws SQLException{
		ArrayList<MemberAndAddressDto> addrList = new ArrayList<MemberAndAddressDto>();
		PreparedStatement addrListPstmt = null;
		String listSql = null;
		
		//join�� ����Ͽ� ȸ���̸��� ���� �����ݴϴ�.
		listSql = "SELECT m.member_no, m.member_id, m.member_name, addr.member_address FROM member m LEFT JOIN address addr ON m.member_no=addr.member_no WHERE m.member_no=?";
		addrListPstmt = connection.prepareStatement(listSql);
		addrListPstmt.setInt(1, sendNo);
		
		//���� ����
		resultSet = addrListPstmt.executeQuery();
		System.out.println(addrListPstmt);
		
		while(resultSet.next()){
			MemberAndAddressDto addressDto = new MemberAndAddressDto();
			// ������� �� ������ ����
			int memberNo = resultSet.getInt("member_no");
			String memberId = resultSet.getString("member_id");
			String memberName = resultSet.getString("member_name");
			String memberAddress = resultSet.getString("member_address");
			
			//Ȯ�� ���
			System.out.println("MemberDao.jsp addSelect member_no -> " + memberNo);
			System.out.println("MemberDao.jsp addSelect member_id -> " + memberId);
			System.out.println("MemberDao.jsp addSelect member_name -> " + memberName);
			System.out.println("MemberDao.jsp addSelect member_address -> " + memberAddress);
			
			//AddressDto��ü�� �Ѹ� ȸ���ּ� ���� ����
			addressDto.setMember_no(memberNo);
			addressDto.setMember_id(memberId);
			addressDto.setMember_name(memberName);
			addressDto.setMember_address(memberAddress);
			
			//����Ʈ�� add
			addrList.add(addressDto);
		}
		if (addrListPstmt != null) try { addrListPstmt.close(); } catch(SQLException ex) {}
		if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
		
		// Ŀ�ؼ� ����
		if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		
		return addrList;
	}
	
	//ȸ������ ����ȭ�� �޼���
	public MemberDto memberUpdateForm(int memberNo) throws SQLException{
		PreparedStatement memberPstmt = null;
		
		//ArrayList<MemberAndAddressDto> memberList = new ArrayList<MemberAndAddressDto>();
		MemberDto memberDto = new MemberDto();
		String memberSql = "SELECT m.member_id, m.member_pw, m.member_name, m.member_gender, m.member_age, addr.member_address FROM member m LEFT JOIN address addr ON m.member_no=addr.member_no WHERE m.member_no=?";
		memberPstmt = connection.prepareStatement(memberSql);
		memberPstmt.setInt(1, memberNo);
		System.out.println(memberPstmt);
		
		resultSet = memberPstmt.executeQuery();
		
		//ȸ�������� ����Ʈ�� ����
		if(resultSet.next()){
			//MemberAndAddressDto addressDto = new MemberAndAddressDto();
			
			String memberId = resultSet.getString("member_id");
			String memberPw = resultSet.getString("member_pw");
			String memberName = resultSet.getString("member_name");
			String memberGender = resultSet.getString("member_gender");
			int memberAge = resultSet.getInt("member_age");
			String memberAddress = resultSet.getString("member_address");
			
			//Ȯ�� ���
			System.out.println("MemberDao.jsp memberUpdateForm() member_id -> " + memberId);
			System.out.println("MemberDao.jsp memberUpdateForm() member_pw -> " + memberPw);
			System.out.println("MemberDao.jsp memberUpdateForm() member_name -> " + memberName);
			System.out.println("MemberDao.jsp memberUpdateForm() member_gender -> " + memberGender);
			System.out.println("MemberDao.jsp memberUpdateForm() member_age -> " + memberAge);
			System.out.println("MemberDao.jsp memberUpdateForm() member_address -> " + memberAddress);
			
			//��ü�� ����
			memberDto.setMember_id(memberId);
			memberDto.setMember_pw(memberPw);
			memberDto.setMember_name(memberName);
			memberDto.setMember_gender(memberGender);
			memberDto.setMember_age(memberAge);
			memberDto.setMember_address(memberAddress);
			
			//memberList.add(addressDto);
		}
		
		if (memberPstmt != null) try { memberPstmt.close(); } catch(SQLException ex) {}
		if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
		
		// Ŀ�ؼ� ����
		if (connection != null) try { connection.close(); } catch(SQLException ex) {}	
		
		return memberDto;
		
	}
	
	//ȸ������ ����ó�� �޼���
		public int memberUpdateAction(MemberDto member, String memberAfterAddr) throws SQLException{
			//������ ����� ���� ����
			int result = 0;
			PreparedStatement updatePstmt = null;
			PreparedStatement addressPstmt = null;
			
			connection.setAutoCommit(false); //Ʈ�����
		
			String updateSql = "UPDATE member SET member_id=?, member_pw=?, member_name=?, member_gender=?, member_age=? WHERE member_no=?";
			
			updatePstmt = connection.prepareStatement(updateSql);
			
			updatePstmt.setString(1, member.getMember_id());
			updatePstmt.setString(2, member.getMember_pw());
			updatePstmt.setString(3, member.getMember_name());
			updatePstmt.setString(4, member.getMember_gender());
			updatePstmt.setInt(5, member.getMember_age());
			updatePstmt.setInt(6, member.getMember_no());
			
			//Ȯ�� ���
			System.out.println("MemberDao.jsp memberUpdateAction() member_id -> " + member.getMember_id());
			System.out.println("MemberDao.jsp memberUpdateAction() member_pw -> " + member.getMember_pw());
			System.out.println("MemberDao.jsp memberUpdateAction() member_name -> " + member.getMember_name());
			System.out.println("MemberDao.jsp memberUpdateAction() member_gender -> " + member.getMember_gender());
			System.out.println("MemberDao.jsp memberUpdateAction() member_age -> " + member.getMember_age());
			System.out.println("MemberDao.jsp memberUpdateAction() member_address -> " + member.getMember_address());
				
			
			result = updatePstmt.executeUpdate();
			System.out.println(updatePstmt);
			
			if(result != 0){
				String addressSql = "UPDATE address SET member_address=? WHERE member_no=? AND member_address=?";
				addressPstmt = connection.prepareStatement(addressSql);
				
				addressPstmt.setString(1, member.getMember_address());
				addressPstmt.setInt(2, member.getMember_no());
				addressPstmt.setString(3, memberAfterAddr);
				
				result = addressPstmt.executeUpdate();
				
				if(result != 0){
					connection.commit();
				}
			}
			
			if (updatePstmt != null) try { updatePstmt.close(); } catch(SQLException ex) {}
			if (addressPstmt != null) try { addressPstmt.close(); } catch(SQLException ex) {}
			if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
			
			// Ŀ�ؼ� ����
			if (connection != null) try { connection.close(); } catch(SQLException ex) {}	
			
			return result;
			
		}
}
