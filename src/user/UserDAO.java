
package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.log4j.Logger;


public class UserDAO{
	
	private static final Logger log = Logger.getLogger(UserDAO.class);
	
	private Connection conn;
	
	public UserDAO (){
		conn = getConnection("127.0.0.1", "3306", "stonesoup", "root", "ted0201");
	}

	public Connection getConnection(String strIP, String strPort, String strDBName, String strUser, String strPass) {
		
		Connection conn = null;

		String strURL = "jdbc:mysql://" + strIP + ":" + strPort + "/" + strDBName
				+ "?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull";
		String strClassName = "com.mysql.jdbc.Driver";
		
		try {
			Class.forName(strClassName).newInstance();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		}

		try {
			conn = DriverManager.getConnection(strURL, strUser, strPass);
		} catch (SQLException e) {
			log.error("getConnection fail : \n" + "IP : " + strIP + "\n" + "Port : " + strPort + "\n" + "DB : " + strDBName + "\n");
			e.printStackTrace();
		}

		return conn;
	}
	
	
	public void getUser(String userKey) throws SQLException{
		
		String sql = "select * from member where seq = " + userKey;
		System.out.println("SQL : " + sql);
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		
//		User user;
		
		while(rs.next()){
			String seq = rs.getString(1);
			System.out.println(seq);
			String userid = rs.getString(2);
			System.out.println(userid);
			String username = rs.getString(3);
			System.out.println(username);
			String level = rs.getString(4);
			System.out.println(level);
		}
		rs.close();
		stmt.close();
	}

	public void getUserWithSecurity(String userKey) throws SQLException{
		String sql = "select * from member where seq = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, userKey);
//		System.out.println("SQL : " + sql);
		
		ResultSet rs = stmt.executeQuery();
		
//		User user;
		
		while(rs.next()){
			String seq = rs.getString(1);
			System.out.println(seq);
			String userid = rs.getString(2);
			System.out.println(userid);
			String username = rs.getString(3);
			System.out.println(username);
			String level = rs.getString(4);
			System.out.println(level);
		}
		rs.close();
		stmt.close();
	}
}