package com.tea.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.tea.dbHandle.UserHandle;
import com.tea.entity.User;
import com.tea.tools.LoginVerify;

@WebFilter(urlPatterns = "/*", filterName = "autoLoginFilter")
public class AutoLoginFilter implements Filter {
	public void destroy() {
		System.out.println("自动登陆过滤器销毁...");
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpSession ses = req.getSession();

		if (LoginVerify.isLogin(req)) {
			chain.doFilter(request, response);
			return;
		}

		Cookie[] cookies = req.getCookies();
		UserHandle userHandle = new UserHandle();
		String emailCookie = null;
		/*
		 * **重要**：//日后修复标记：这里仅用了email作为cookie并用于验证，极不安全
		 */
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if ("LOGIN_EMAIL".equals(cookie.getName())) {
					emailCookie = cookie.getValue();
					try {
						if (userHandle.queryByEmail(emailCookie) != null) {
							User user = userHandle.queryByEmail(emailCookie);
							if (user != null) {
								ses.setAttribute("loginUser", user);
								ses.setAttribute("isLogined", true);
							} else {
								// 未检测到cookie，不做任何事
							}
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}
		//userHandle.close();
		chain.doFilter(request, response);
	}

	public void init(FilterConfig fConfig) throws ServletException {
		System.out.println("自动登陆过滤器初始化...");
	}
}
