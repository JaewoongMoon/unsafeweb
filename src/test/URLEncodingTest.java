/**
 * @ URLEncodingTest.java
 * 
 * Copyright 2016 NHN Techorus Corp. All rights Reserved. 
 * NHN Techorus PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */
package test;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

/**
 * <pre>
 * test
 * URLEncodingTest.java 
 * </pre>
 *
 * @brief	: 
 * @author	: 문재웅(jwmoon@nhn-techorus.com)
 * @Date	: 2016. 4. 18.
 */
public class URLEncodingTest {

	public static void main(String[] args) throws UnsupportedEncodingException {
		
		String name = URLEncoder.encode("문재웅", "UTF-8");
		System.out.println(name);
		
//		String decoded_name = new String(name.getBytes(), "UTF-8");
		String decoded_name = URLDecoder.decode(name, "UTF-8");
		System.out.println(decoded_name);
	}
}
