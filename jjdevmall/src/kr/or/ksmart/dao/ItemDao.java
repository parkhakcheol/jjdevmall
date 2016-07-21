package kr.or.ksmart.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import kr.or.ksmart.dto.ItemDto;

public class ItemDao {
	Connection connection = null;
		
		//생성자 재정이 mysql드라이버 로드, DB연결
		public ItemDao(){
			DriverDB driverConn = new DriverDB();
			try {
				connection = driverConn.driverDb();
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		//상품등록 처리 매서드
		public int itemInsert(ItemDto item) throws SQLException{
			int result = 0;
			PreparedStatement itemInsertPstmt = null;
			
			//회원정보 insert쿼리 문장
			String itemSql = "INSERT INTO item(item_name, item_price, item_rate)VALUES(?,?,?)";
			
			itemInsertPstmt = connection.prepareStatement(itemSql);
			itemInsertPstmt.setString(1, item.getItem_name());
			itemInsertPstmt.setInt(2, item.getItem_price());
			itemInsertPstmt.setDouble(3, item.getItem_rate());
			
			result = itemInsertPstmt.executeUpdate();
			System.out.println(itemInsertPstmt);
			
			if (itemInsertPstmt != null) try { itemInsertPstmt.close(); } catch(SQLException ex) {}
			
			// 커넥션 종료
			if (connection != null) try { connection.close(); } catch(SQLException ex) {}
			
			
			return result;
		}
		
		//상품 삭제 처리 메서드
		public int itemDelete(int sendItemNo) throws SQLException{
			int result = 0;
			PreparedStatement itemDeletePstmt = null;
			
			String addressSql = "DELETE FROM item WHERE item_no=?";
			
			itemDeletePstmt = connection.prepareStatement(addressSql);
			itemDeletePstmt.setInt(1, sendItemNo);
			
			result = itemDeletePstmt.executeUpdate();
			System.out.println(itemDeletePstmt);
			
			if (itemDeletePstmt != null) try { itemDeletePstmt.close(); } catch(SQLException ex) {}
			
			if (connection != null) try { connection.close(); } catch(SQLException ex) {}
			
			return result;
		}
		
	
}
