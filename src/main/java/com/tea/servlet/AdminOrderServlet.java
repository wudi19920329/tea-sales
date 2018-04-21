package com.tea.servlet;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.tuple.Pair;

import com.tea.dto.ProductInfo;
import com.tea.entity.Customer;
import com.tea.entity.Order;
import com.tea.entity.Product;
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
		@SuppressWarnings("unused")
		OrderStatus orderStatus = null;
		if(StringUtils.isNoneBlank(request.getParameter("orderStatus"))) {
			orderStatus = OrderStatus.valueOf(request.getParameter("orderStatus"));
		}
		
		Integer customerId = null;
		if (StringUtils.isNoneBlank(nickName)) {
			Customer customer = customerHandle.queryByName(nickName);
			if (customer == null) {
				pages.setRows(Arrays.asList());
				return pages;
			}
			customerId = customer.getId();
		}
		orderHandle.queryPageBy(pages, customerId , orderStatus);
		return pages;
	}
	
	public Object queryProductsBy(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Integer orderId = Integer.valueOf(request.getParameter("orderId"));
		List<ProductInfo> infos = productHandle.queryProductInfosBy(orderId);
		request.setAttribute("products", infos);
		// 跳转
		return request.getRequestDispatcher("/pages/admin/menu/orderConfig/view.jsp");
	}

	public void deliver(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		Integer orderId = Integer.valueOf(request.getParameter("orderId"));
		Order order = orderHandle.queryById(orderId);
		

		// 更新产品库存
		List<Pair<Integer, Integer>> pairs = orderHandle.queryWithProductInfos(orderId);
		pairs.forEach(productInfo -> {
			Product product = productHandle.queryById(productInfo.getLeft());
			product.setInventory(product.getInventory() - productInfo.getRight());
			productHandle.update(product);
		});
		// 更新订单状态
		order.setOrderStatus(OrderStatus.DELIVERED);
		orderHandle.update(order);
	}

}
