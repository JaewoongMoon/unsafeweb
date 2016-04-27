import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * @ AuthorityCheck.java
 * 
 * Copyright 2016 NHN Techorus Corp. All rights Reserved. 
 * NHN Techorus PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */

/**
 * <pre>
 * 
 * AuthorityCheck.java 
 * </pre>
 *
 * @brief	: 
 * @author	: 문재웅(jwmoon@nhn-techorus.com)
 * @Date	: 2016. 4. 22.
 */
public class AuthorityCheck {

	
	/**
	 * @Method 	: canRead
	 * @brief	: 
	 * @author	: 문재웅(jwmoon@nhn-techorus.com)
	 * @Date	: 2016. 4. 22.
	 * @param userid
	 * @param num 게시글 번호 
	 * @return
	 */
	/*
	public boolean canRead(String userid, String num){
	
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean canRead = false;
		
		
		try{
		
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/stonesoup", "root", "ted0201");
			
			String sql = "select member_level from member where userid = '" + userid + "'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

		}catch(Exception e){
			e.printStackTrace();
		}
		
		return canRead;
		
	}
	
	public boolean isAdmin(String userid){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int level = 0;
		
		try{
		
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/stonesoup", "root", "ted0201");
			
			String sql = "select member_level from member where userid = '" + userid + "'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while(rs.next()){
				level = rs.getInt(1);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}	
		
		if(level > 4 ){
			return true;
		}else{
			return false;
		}
		

	}
	
	public boolean isSecretThread(String num){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean canRead = false;
		
		
		try{
		
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/stonesoup", "root", "ted0201");
			
			String sql = "select is_secret, writer from board where num =  " + num ;
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			

		}catch(Exception e){
			e.printStackTrace();
		}finally {
			if (rs != null) rs.close();
			if (pstmt != null) pstmt.close();
			if (conn != null) conn.close();
		}
	}
	
	public boolean isAuthor(String userid, String num){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean canRead = false;
		
		
		try{
		
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/stonesoup", "root", "ted0201");
			
			String sql = "select member_level from member where userid = '" + userid + "'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

		}catch(Exception e){
			e.printStackTrace();
		}finally {
			if (rs != null) rs.close();
			if (pstmt != null) pstmt.close();
			if (conn != null) conn.close();
		}
	}
	*/
}
