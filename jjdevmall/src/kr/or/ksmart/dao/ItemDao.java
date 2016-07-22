package kr.or.ksmart.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.or.ksmart.dto.ItemDto;

public class ItemDao {
	Connection connection = null;
	ResultSet resultSet = null;
		
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
		
		//상품 리스트 처리 메서드
		public ArrayList<ItemDto> itemSelect(String search) throws SQLException{
			ArrayList<ItemDto> itemList = new ArrayList<ItemDto>();
			PreparedStatement itemSelectPstmt = null;
			String listSql = null;
			
			listSql = "SELECT item_no, item_name, item_price, item_rate FROM item";
			itemSelectPstmt = connection.prepareStatement(listSql);
			
			resultSet = itemSelectPstmt.executeQuery();
			System.out.println(itemSelectPstmt);
			
			//모둔 아이템정보를 리스트에 저장하기 위해 반복
			while(resultSet.next()){
				ItemDto itemDto = new ItemDto();
			
				// 결과값을 각 변수에 대입
				int itemNo = resultSet.getInt("item_no");
				String itemName = resultSet.getString("item_name");
				int itemPrice = resultSet.getInt("item_price");
				double itemRate = resultSet.getDouble("item_rate") * 100;
				//확인 출력
				System.out.println("ItemDao.jsp itemSelect() item_no-> " + itemNo);
				System.out.println("ItemDao.jsp itemSelect() item_name-> " + itemName);
				System.out.println("ItemDao.jsp itemSelect() item_price-> " + itemPrice);
				System.out.println("ItemDao.jsp itemSelect() item_rate-> " + itemRate);
				//item정보를 넣는다
				itemDto.setItme_no(itemNo);
				itemDto.setItem_name(itemName);
				itemDto.setItem_price(itemPrice);
				itemDto.setItem_rate(itemRate);
				//하나의 아이템 정보를 리스트에 add
				itemList.add(itemDto);
			}
			//객체종료
			if (itemSelectPstmt != null) try { itemSelectPstmt.close(); } catch(SQLException ex) {}
			if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
			if (connection != null) try { connection.close(); } catch(SQLException ex) {}
			
			return itemList;
			
		}
		
	
}
