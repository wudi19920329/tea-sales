package com.tea.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import com.tea.Constants;
import com.tea.entity.User;
import com.tea.exception.ServiceException;
import com.tea.utils.MD5;

@SuppressWarnings("serial")
@WebServlet("/user")
public class UserServlet extends BaseServlet {

	public Object loadShippingAddress(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Object uri = null;

		// 跳转
		uri = request.getRequestDispatcher("/addressTemplate.jsp");

		return uri;
	}

	public void logon(HttpServletRequest request, HttpServletResponse response) {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		User user = userHandle.queryByEmail(email);
		if (user == null) {
			throw new ServiceException("用户名错误。");
		}
		if (!user.getPassword().equals(MD5.getMD5(MD5.getMD5(password)))) {
			throw new ServiceException("密码错误。");
		}
		/**
		 * Login user
		 */
		User u = userHandle.queryByEmail(email);
		request.getSession().setAttribute(Constants.TEA_CUSTOMER, u);
	}

	public void register(HttpServletRequest request, HttpServletResponse response) {
		String nickName = request.getParameter("nickName");
		String realName = request.getParameter("realName");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");

		if (!password.equals(confirmPassword)) {
			throw new ServiceException("两次输入的密码不一致");
		}
		User user = userHandle.queryByEmail(email);
		if (user != null && StringUtils.isNotBlank(user.getEmail()) && user.getEmail().trim().equals(email)) {
			throw new ServiceException("邮箱已存在，请更换邮箱注册！");
		}
		user = new User(realName, phone, address, email, password,nickName);
		userHandle.insert(user);

		/**
		 * Login user
		 */
		User u = userHandle.queryByEmail(email);
		request.getSession().setAttribute(Constants.TEA_CUSTOMER, u);
	}

}
