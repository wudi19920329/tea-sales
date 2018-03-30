package com.tea.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;

import com.tea.Constants;
import com.tea.entity.Customer;
import com.tea.entity.ShoppingCart;
import com.tea.exception.ServiceException;
import com.tea.utils.MD5;

@SuppressWarnings("serial")
@WebServlet("/customer")
public class CustomerServlet extends BaseServlet {

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
		Customer user = customerHandle.queryByEmail(email);
		if (user == null) {
			throw new ServiceException("用户名错误。");
		}
		if (!user.getPassword().equals(MD5.getMD5(MD5.getMD5(password)))) {
			throw new ServiceException("密码错误。");
		}
		/**
		 * Login user
		 */
		Customer u = customerHandle.queryByEmail(email);
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
		Customer customer = customerHandle.queryByEmail(email);
		if (customer != null && StringUtils.isNotBlank(customer.getEmail())
				&& customer.getEmail().trim().equals(email)) {
			throw new ServiceException("邮箱已存在，请更换邮箱注册！");
		}
		customer = new Customer(realName, phone, address, email, password, nickName);
		customerHandle.insert(customer);

		Customer u = customerHandle.queryByEmail(email);
		// 创建购物车
		ShoppingCart shoppingCart = new ShoppingCart(u);
		shoppingCartHandle.insert(shoppingCart);

		request.getSession().setAttribute(Constants.TEA_CUSTOMER, u);
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
