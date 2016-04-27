/**
 * @ UserDAOTest.java
 * 
 * Copyright 2016 NHN Techorus Corp. All rights Reserved. 
 * NHN Techorus PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */
package user;

import java.sql.Connection;
import java.sql.SQLException;

import static org.hamcrest.CoreMatchers.notNullValue;
import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import org.junit.Before;
import org.junit.Test;

/**
 * <pre>
 * user
 * UserDAOTest.java 
 * </pre>
 *
 * @brief	: 
 * @author	: 문재웅(jwmoon@nhn-techorus.com)
 * @Date	: 2016. 4. 14.
 */

public class UserDAOTest {

	private final String serverIp = "127.0.0.1";
	private final String serverPort = "3306";
	private final String userId = "root";
	private final String passwd = "ted0201";

	private UserDAO userDAO;
	
	@Before
	public void setUp(){
		userDAO = new UserDAO();
	}
	
	@Test
	public void getConnectionTest() throws SQLException{
		Connection conn = userDAO.getConnection(serverIp, serverPort, "springbook", userId, passwd);
		assertThat(conn, is(notNullValue()));
		conn.close();
	}
	
	@Test
	public void  sqlInjectionTest() throws Exception{
		//userDAO.getUser("'' or 1=1");
		userDAO.getUserWithSecurity("'' or 1=1");
	}
	
	
	
}
