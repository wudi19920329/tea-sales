package com.tea.servlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;

import com.tea.Constants;
import com.tea.entity.Customer;
import com.tea.entity.ShoppingCart;
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
		// 创建购物车
		ShoppingCart shoppingCart = new ShoppingCart(u);
		shoppingCartHandle.insert(shoppingCart);

		request.getSession().setAttribute(Constants.TEA_CUSTOMER, u);
	}

	/**
	 * Return LoginSession if found in HttpSession scope, else return NULL
	 * value.
	 */
	public static User getOptionalLoginSession(HttpServletRequest req) {
		User result = null;
		HttpSession session = req.getSession(false);
		if (session != null)
			result = (User) session.getAttribute(Constants.ADMIN_USER);
		return result;
	}

}
