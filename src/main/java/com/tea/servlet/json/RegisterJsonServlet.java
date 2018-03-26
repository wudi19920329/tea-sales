package com.tea.servlet.json;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;

import com.tea.entity.User;
import com.tea.exception.ServiceException;
import com.tea.servlet.BaseServlet;

@SuppressWarnings("serial")
@WebServlet("/register")
public class RegisterJsonServlet extends BaseServlet {

	public void submit(HttpServletRequest request, HttpServletResponse response) {
		String realName = request.getParameter("realName");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");

		if (!password.equals(confirmPassword)) {
			throw new RuntimeException("两次输入的密码不一致");
		}
		User user = userHandle.queryByEmail(email);
		if(user!=null&&StringUtils.isNotBlank(user.getEmail())&&user.getEmail().trim().equals(email)){
			throw new ServiceException("邮箱已存在，请更换邮箱注册！");
		}
		user = new User(realName, phone, address, email, password);
		userHandle.add(user);
	}
}
