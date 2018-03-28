package com.tea.utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.tea.Constants;

public class LoginVerify {
	public static boolean isLogin(HttpServletRequest request) {
		HttpSession session = request.getSession();
		if (session.getAttribute(Constants.TEA_CUSTOMER) != null) {
			return true;
		}
		return false;
	}
}
