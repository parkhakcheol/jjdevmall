package kr.or.ksmart.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import kr.or.ksmart.dto.MemberDto;

public class MemberDao {
	Connection connection = null;
	ResultSet resultSet = null;
	
	//������ ������ mysql����̹� �ε�, DB����
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
	
	//member table ���� ó��
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
			
			if(result != 0)
			{	
				//������ ȸ����ȣ�� �޾ƿ�
				resultSet = memberInsertPstmt.getGeneratedKeys();
				
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
			if (addressDeletePstmt != null) try { addressDeletePstmt.close(); } catch(SQLException ex) {}
			if (memberDeletePstmt != null) try { memberDeletePstmt.close(); } catch(SQLException ex) {}
			if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
			
			// Ŀ�ؼ� ����
			if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		}	
		return result;
		
	}
}
