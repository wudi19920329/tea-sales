package com.tea.filter;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import com.tea.Constants;

@WebFilter(urlPatterns = "/*", filterName = "encoding")
public class EncodingFilter implements Filter {

	@Override
	public void destroy() {
		System.out.println("编码过滤器销毁...");
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		request.setCharacterEncoding(Constants.UTF_8);
		response.setCharacterEncoding(Constants.UTF_8);
		HttpServletRequest req = (HttpServletRequest) request;
		if (req.getMethod().equals(Constants.GET)) {
			EncodingRequest er = new EncodingRequest(req);
			chain.doFilter(er, response);
		} else if (req.getMethod().equals(Constants.POST)) {
			chain.doFilter(request, response);
		}
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		System.out.println("编码过滤器初始化...");
	}

}

class EncodingRequest extends HttpServletRequestWrapper {

	private HttpServletRequest req;

	public EncodingRequest(HttpServletRequest request) {
		super(request);
		this.req = request;
	}

	public String getParameter(String name) {
		String value = req.getParameter(name);
		try {
			if (value != null) {
				value = new String(value.getBytes(Constants.ISO_8859_1), Constants.UTF_8);
			}
		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException(e);
		}
		return value;
	}

}
