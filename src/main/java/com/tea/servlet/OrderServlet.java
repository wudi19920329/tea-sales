package com.tea.servlet;

import java.math.BigDecimal;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tea.entity.Customer;
import com.tea.entity.Order;
import com.tea.entity.ShoppingCart;
import com.tea.entity.ShoppingCartItem;
import com.tea.enums.ExpressDeliveryMode;
import com.tea.enums.ShoppingCartItemStatus;
import com.tea.enums.ShoppingCartStatus;
import com.tea.utils.PageBean;

@SuppressWarnings("serial")
@WebServlet("/order")
public class OrderServlet extends BaseServlet {

	@SuppressWarnings("unchecked")
	public Object submit(HttpServletRequest request, HttpServletResponse response) {
		Customer customer = CustomerServlet.getOptionalLoginSession(request);
		if (customer == null) {
			return null;
		}
		String description = request.getParameter("description");
		ExpressDeliveryMode expressDeliveryMode = ExpressDeliveryMode
				.valueOf(request.getParameter("expressDeliveryMode"));
		BigDecimal payableAmount = new BigDecimal(request.getParameter("payableAmount"));

		ShoppingCart shoppingCart = shoppingCartHandle.queryNoSettlementByCustomerId(customer.getId());
		// 更新购物车商品的状态
		PageBean<ShoppingCartItem> carts = (PageBean<ShoppingCartItem>) request.getSession().getAttribute("cart");
		carts.getRows().forEach(cartItem -> {
			cartItem.setStatus(ShoppingCartItemStatus.PAYMENT_HAS_BEEN);
			shoppingCartItemHandle.updateStatus(cartItem);
		});
		Order order = new Order(customer, payableAmount, shoppingCart, expressDeliveryMode, description);
		orderHandle.insert(order);
		shoppingCart.setStatus(ShoppingCartStatus.HAVE_ALREADY_SETTLED);
		shoppingCartHandle.update(shoppingCart);
		return order.getOrderNumber();
	}

	public Object displayPastOrders(HttpServletRequest request, HttpServletResponse response) {
		Customer customer = CustomerServlet.getOptionalLoginSession(request);
		if (customer == null) {
			return null;
		}
		String page = request.getParameter("page") == null ? "1" : request.getParameter("page");
		PageBean<Order> pages = new PageBean<Order>();
		pages.setCurrentPage(Integer.valueOf(page));
		orderHandle.queryPageBy(pages, Integer.valueOf(customer.getId()),null);
		request.setAttribute("customerOrders", pages);
		Object uri = request.getRequestDispatcher("/pages/shop/templates/generic/pages/orders.jsp");
		return uri;
	}
}
