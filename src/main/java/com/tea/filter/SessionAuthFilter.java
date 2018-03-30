/*package com.tea.filter;

import java.io.IOException;
import java.nio.charset.Charset;
import java.text.MessageFormat;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tea.Constants;
import com.tea.entity.Customer;
import com.tea.exception.ExceptionInfo;
import com.tea.servlet.CustomerServlet;

//@WebFilter(urlPatterns = { "/shoppingCart" }, filterName = "auth")
public class SessionAuthFilter implements Filter {
	protected static final ObjectMapper MAPPER = new ObjectMapper();

	@Override
	public void destroy() {
		System.out.println("session认证过滤器销毁...");
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		if (request instanceof HttpServletRequest) {
			HttpServletRequest req = (HttpServletRequest) request;
			System.out.println(MessageFormat.format("Checking LoginSession token for uri={0}", req.getRequestURI()));
			Customer customerSession = CustomerServlet.getOptionalLoginSession(req);
			if (customerSession == null) {
				System.out.println("No LoginSession token found; forwarding request to login page.");
				// We need to save the old URI so we can auto redirect after
				response.setContentType(Constants.AJAX_CONTENT_TYPE);
				response.getOutputStream()
						.write(MAPPER
								.writeValueAsString(
										new ExceptionInfo(String.valueOf(401), "未登陆"))
								.getBytes(Charset.defaultCharset()));
				((HttpServletResponse) response).setStatus(510);
				response.getOutputStream().flush();
				return;
			} else {
				System.out.println(
						MessageFormat.format("Request allowed using LoginSession token={0}", customerSession.getId()));
			}
		}
		chain.doFilter(request,(HttpServletResponse)response);
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		System.out.println("session认证过滤器初始化...");
	}

}
*/