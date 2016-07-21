package kr.or.ksmart.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import kr.or.ksmart.dto.OrdersDto;

public class OrdersDao {
	
	Connection connection = null;
	
	//������ ������ mysql����̹� �ε�, DB����
	public OrdersDao(){
		DriverDB driverConn = new DriverDB();
		try {
			connection = driverConn.driverDb();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//��ǰ�ֹ� insert ó�� �޼���
	public int ordersInsert(OrdersDto orders, int itemNo, int memberNo) throws SQLException{
		int result = 0;
		PreparedStatement ordersInsertPstmt = null;
		
		String ordersSql = "INSERT INTO orders(item_no, member_no, orders_quantity, orders_date, orders_rate, orders_price)VALUES(?,?,?,SYSDATE(),?,?)";
		ordersInsertPstmt = connection.prepareStatement(ordersSql);
		
		ordersInsertPstmt.setInt(1, itemNo);
		ordersInsertPstmt.setInt(2, memberNo);
		ordersInsertPstmt.setInt(3, orders.getOrders_quantity());
		ordersInsertPstmt.setDouble(4, orders.getOrders_rate());
		ordersInsertPstmt.setInt(5, orders.getOrders_price());
		
		result = ordersInsertPstmt.executeUpdate();
		System.out.println(ordersInsertPstmt);
		
		if (ordersInsertPstmt != null) try { ordersInsertPstmt.close(); } catch(SQLException ex) {}
		
		// Ŀ�ؼ� ����
		if (connection != null) try { connection.close(); } catch(SQLException ex) {}
		
		return result;
		
	}
}
