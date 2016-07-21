package kr.or.ksmart.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DriverDB {
	
	public Connection driverDb() throws ClassNotFoundException, SQLException{
		Connection connection = null;
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/jjdevmall?useUnicode=true&characterEncoding=utf-8";
		String dbUser = "root";
		String dbPass = "java0000";
		
		Class.forName(driver);
		//DB¿¬°á
		connection = DriverManager.getConnection(url, dbUser, dbPass);
		
		return connection;
	}

	
}
