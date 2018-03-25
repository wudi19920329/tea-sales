package com.tea.servlet.form;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tea.entity.User;
import com.tea.servlet.BaseServlet;

@SuppressWarnings("serial")
@WebServlet("/register")
public class RegisterServlet extends BaseServlet {

	public Object preloadRegister(HttpServletRequest request, HttpServletResponse response) {
		// 跳转
		return request.getRequestDispatcher("/registerTemplate.jsp");
	}

	public Object submit(HttpServletRequest request, HttpServletResponse response) {
		String realName = request.getParameter("realName");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");
		if (!password.equals(confirmPassword)) {
			throw new RuntimeException("两次输入的密码不一致");
		}
		User user = new User(realName, phone, address, email, password);
		userHandle.add(user);
		// 跳转
		return request.getRequestDispatcher("/index.jsp");
	}

}
