package com.tea.servlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tea.Constants;
import com.tea.entity.User;
import com.tea.exception.ServiceException;
import com.tea.utils.MD5;

@SuppressWarnings("serial")
@WebServlet("/user")
public class UserServlet extends BaseServlet {

	public void logon(HttpServletRequest request, HttpServletResponse response) {
		String userName = request.getParameter("userName");
		String password = request.getParameter("password");
		User user = userHandle.queryByUserName(userName);
		if (user == null) {
			throw new ServiceException("用户名错误。");
		}
		if (!user.getPassword().equals(MD5.getMD5(MD5.getMD5(password)))) {
			throw new ServiceException("密码错误。");
		}
		request.getSession().setAttribute(Constants.ADMIN_USER, user);
	}

	public Object logout(HttpServletRequest request, HttpServletResponse response) {
		User user = UserServlet.getOptionalLoginSession(request);
		if (user != null) {
			request.getSession().removeAttribute(Constants.ADMIN_USER);
		}
		return "/admin.jsp";
	}

	/**
	 * Return LoginSession if found in HttpSession scope, else return NULL value.
	 */
	public static User getOptionalLoginSession(HttpServletRequest req) {
		User result = null;
		HttpSession session = req.getSession(false);
		if (session != null)
			result = (User) session.getAttribute(Constants.ADMIN_USER);
		return result;
	}

}
