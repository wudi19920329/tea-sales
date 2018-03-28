package com.tea.servlet.json;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tea.Constants;
import com.tea.entity.User;
import com.tea.exception.ServiceException;
import com.tea.servlet.BaseServlet;

@SuppressWarnings("serial")
@WebServlet("/user/json")
public class UserJsonServlet extends BaseServlet {

	public Object accountSummary(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String realName = request.getParameter("realName");
		User user = (User) request.getSession().getAttribute(Constants.TEA_CUSTOMER);
		if (user == null || !user.getRealName().equals(realName)) {
			throw new ServiceException("Customer not authenticated");
		}
		return user;
	}
}
