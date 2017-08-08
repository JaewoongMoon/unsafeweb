/**
 * @ XssFilter.java
 * 
 * Copyright 2016 NHN Techorus Corp. All rights Reserved. 
 * NHN Techorus PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */
package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.swing.plaf.synth.SynthSeparatorUI;

import com.nhncorp.lucy.security.xss.XssFilter;

/**
 * <pre>
 * filter
 * XssFilter.java 
 * </pre>
 *
 * @brief	: 
 * @author	: 문재웅(jwmoon@nhn-techorus.com)
 * @Date	: 2016. 5. 18.
 */
public class LucyFilter {
	
	public static final XssFilter lucyFilter = XssFilter.getInstance("lucy-xss-superset.xml");
	
	
	public static void main(String[] args) {
		System.out.println(lucyFilter.doFilter("<script>alert('1'); </script>"));
	}
}
