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
		
		//������ ������ mysql����̹� �ε�, DB����
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
		
		//��ǰ��� ó�� �ż���
		public int itemInsert(ItemDto item) throws SQLException{
			int result = 0;
			PreparedStatement itemInsertPstmt = null;
			
			//ȸ������ insert���� ����
			String itemSql = "INSERT INTO item(item_name, item_price, item_rate)VALUES(?,?,?)";
			
			itemInsertPstmt = connection.prepareStatement(itemSql);
			itemInsertPstmt.setString(1, item.getItem_name());
			itemInsertPstmt.setInt(2, item.getItem_price());
			itemInsertPstmt.setDouble(3, item.getItem_rate());
			
			result = itemInsertPstmt.executeUpdate();
			System.out.println(itemInsertPstmt);
			
			if (itemInsertPstmt != null) try { itemInsertPstmt.close(); } catch(SQLException ex) {}
			
			// Ŀ�ؼ� ����
			if (connection != null) try { connection.close(); } catch(SQLException ex) {}
			
			
			return result;
		}
		
		//��ǰ ���� ó�� �޼���
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
		
		//��ǰ ����Ʈ ó�� �޼���
		public ArrayList<ItemDto> itemSelect(String search) throws SQLException{
			ArrayList<ItemDto> itemList = new ArrayList<ItemDto>();
			PreparedStatement itemSelectPstmt = null;
			String listSql = null;
			
			listSql = "SELECT item_no, item_name, item_price, item_rate FROM item";
			itemSelectPstmt = connection.prepareStatement(listSql);
			
			resultSet = itemSelectPstmt.executeQuery();
			System.out.println(itemSelectPstmt);
			
			//��� ������������ ����Ʈ�� �����ϱ� ���� �ݺ�
			while(resultSet.next()){
				ItemDto itemDto = new ItemDto();
			
				// ������� �� ������ ����
				int itemNo = resultSet.getInt("item_no");
				String itemName = resultSet.getString("item_name");
				int itemPrice = resultSet.getInt("item_price");
				double itemRate = resultSet.getDouble("item_rate") * 100;
				//Ȯ�� ���
				System.out.println("ItemDao.jsp itemSelect() item_no-> " + itemNo);
				System.out.println("ItemDao.jsp itemSelect() item_name-> " + itemName);
				System.out.println("ItemDao.jsp itemSelect() item_price-> " + itemPrice);
				System.out.println("ItemDao.jsp itemSelect() item_rate-> " + itemRate);
				//item������ �ִ´�
				itemDto.setItme_no(itemNo);
				itemDto.setItem_name(itemName);
				itemDto.setItem_price(itemPrice);
				itemDto.setItem_rate(itemRate);
				//�ϳ��� ������ ������ ����Ʈ�� add
				itemList.add(itemDto);
			}
			//��ü����
			if (itemSelectPstmt != null) try { itemSelectPstmt.close(); } catch(SQLException ex) {}
			if (resultSet != null) try { resultSet.close(); } catch(SQLException ex) {}
			if (connection != null) try { connection.close(); } catch(SQLException ex) {}
			
			return itemList;
			
		}
		
	
}
