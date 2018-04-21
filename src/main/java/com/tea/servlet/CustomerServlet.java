package com.tea.servlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;

import com.tea.Constants;
import com.tea.entity.Customer;
import com.tea.exception.ServiceException;
import com.tea.utils.MD5;

@SuppressWarnings("serial")
@WebServlet("/customer")
public class CustomerServlet extends BaseServlet {

	public void logon(HttpServletRequest request, HttpServletResponse response) {
		String email = request.getParameter("email").toLowerCase();
		String password = request.getParameter("password");
		Customer customer = customerHandle.queryByEmail(email);
		if (customer == null) {
			throw new ServiceException("用户名错误。");
		}
		if (!customer.getPassword().equals(MD5.getMD5(MD5.getMD5(password)))) {
			throw new ServiceException("密码错误。");
		}
		request.getSession().setAttribute(Constants.TEA_CUSTOMER, customer);
	}

	public Object logout(HttpServletRequest request, HttpServletResponse response) {
		Customer customer = CustomerServlet.getOptionalLoginSession(request);
		if (customer != null) {
			request.getSession().removeAttribute(Constants.TEA_CUSTOMER);
		}
		return "/";
	}

	public void register(HttpServletRequest request, HttpServletResponse response) {
		String nickName = request.getParameter("nickName");
		String realName = request.getParameter("realName");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		Integer postcode = Integer.valueOf(request.getParameter("postcode"));
		String email = request.getParameter("email").toLowerCase();
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");
		if (StringUtils.isBlank(address)) {
			throw new ServiceException("地址不能为空");
		}

		if (!password.equals(confirmPassword)) {
			throw new ServiceException("两次输入的密码不一致");
		}
		Customer customer = customerHandle.queryByEmail(email);
		if (customer != null && StringUtils.isNotBlank(customer.getEmail())
				&& customer.getEmail().trim().equals(email)) {
			throw new ServiceException("邮箱已存在，请更换邮箱注册！");
		}
		customer = new Customer(realName, phone, address, postcode, email, password, nickName);
		customerHandle.insert(customer);
		
		Customer u = customerHandle.queryByEmail(email);
		request.getSession().setAttribute(Constants.TEA_CUSTOMER, u);
	}

	public void changePassword(HttpServletRequest request, HttpServletResponse response) {
		Customer customer = CustomerServlet.getOptionalLoginSession(request);
		if (customer == null) {
			throw new ServiceException("请先登录！");
		}
		String password = request.getParameter("password");
		String newPassword = request.getParameter("newPassword");
		String confirmPassword = request.getParameter("confirmPassword");
		if (!MD5.getMD5(MD5.getMD5(password)).equals(customer.getPassword())) {
			throw new ServiceException("旧密码错误！");
		}
		if (!newPassword.equals(confirmPassword)) {
			throw new ServiceException("两次输入的密码不一致！");
		}
		customer.setPassword(MD5.getMD5(MD5.getMD5(newPassword)));
		customerHandle.update(customer);
	}

	/**
	 * Return LoginSession if found in HttpSession scope, else return NULL
	 * value.
	 */
	public static Customer getOptionalLoginSession(HttpServletRequest req) {
		Customer result = null;
		HttpSession session = req.getSession(false);
		if (session != null)
			result = (Customer) session.getAttribute(Constants.TEA_CUSTOMER);
		return result;
	}

}
