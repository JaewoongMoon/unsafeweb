/**
 * @ JayEncodingFilter.java
 * 
 * Copyright 2016 NHN Techorus Corp. All rights Reserved. 
 * NHN Techorus PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */
package filter;

import java.io.IOException;
import java.util.Enumeration;
import java.util.Iterator;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;



/**
 * <pre>
 * filter
 * JayEncodingFilter.java 
 * </pre>
 *
 * @brief	: 
 * @author	: 문재웅(jwmoon@nhn-techorus.com)
 * @Date	: 2016. 4. 18.
 */
public class JayEncodingFilter implements Filter{

	/* (non-Javadoc)
	 * @see javax.servlet.Filter#doFilter(javax.servlet.ServletRequest, javax.servlet.ServletResponse, javax.servlet.FilterChain)
	 */
	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
//		System.out.println("인코딩 필터 작동...");
		
		HttpServletRequest request =  (HttpServletRequest) req;
		request.setCharacterEncoding("UTF-8");
		req.setCharacterEncoding("UTF-8");
		
		/*
		Enumeration params = request.getParameterNames();
		
		while(params.hasMoreElements()){
			String paramName = (String)params.nextElement();
			
		}
		*/
		chain.doFilter(request, res);
	}
	
	/* (non-Javadoc)
	 * @see javax.servlet.Filter#destroy()
	 */
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}
	
	/* (non-Javadoc)
	 * @see javax.servlet.Filter#init(javax.servlet.FilterConfig)
	 */
	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}
}
