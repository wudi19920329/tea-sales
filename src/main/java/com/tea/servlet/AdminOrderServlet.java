package com.tea.servlet;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import com.tea.entity.Customer;
import com.tea.entity.Order;
import com.tea.entity.Product;
import com.tea.entity.ShoppingCartItem;
import com.tea.enums.OrderStatus;
import com.tea.utils.PageBean;

@SuppressWarnings("serial")
@WebServlet("/admin/order")
public class AdminOrderServlet extends BaseServlet {

	public Object orders(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		PageBean<Order> pages = new PageBean<Order>();
		Integer pageCount = Integer.valueOf(
				StringUtils.isBlank(request.getParameter("pageCount")) ? "20" : request.getParameter("pageCount"));
		Integer currentPage = Integer.valueOf(
				StringUtils.isBlank(request.getParameter("currentPage")) ? "1" : request.getParameter("currentPage"));
		pages.setPageCount(pageCount);
		pages.setCurrentPage(currentPage);

		String nickName = request.getParameter("customerName");
		Integer customerId = null;
		if (StringUtils.isNoneBlank(nickName)) {
			Customer customer = customerHandle.queryByName(nickName);
			if (customer == null) {
				pages.setRows(Arrays.asList());
				return pages;
			}
			customerId = customer.getId();
		}
		orderHandle.queryPageByCustomerId(pages, customerId);
		return pages;
	}

	public Object queryProduct(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Integer productId = Integer.valueOf(request.getParameter("productId"));
		Product product = productHandle.queryById(productId);
		request.setAttribute("product", product);
		// 跳转
		return request.getRequestDispatcher("/pages/admin/menu/productConfig/view.jsp");
	}

	public void deliver(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Integer orderId = Integer.valueOf(request.getParameter("orderId"));
		Order order = orderHandle.queryById(orderId);
		order.setOrderStatus(OrderStatus.DELIVERED);
		orderHandle.update(order);
		Integer customerId = order.getCustomer().getId();
		PageBean<ShoppingCartItem> pb = new PageBean<ShoppingCartItem>();
		pb.setCurrentPage(1);
		pb.setPageCount(99999);
		PageBean<ShoppingCartItem> pages = shoppingCartItemHandle.queryPageByCustomerId(pb, customerId);
		pages.getRows().forEach(page -> {
			Integer productId = page.getProduct().getId();
			Product product = productHandle.queryById(productId);
			productHandle.update(product);// 批量更新库存
		});
	}

}
