package com.tea.servlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tea.entity.ShoppingCartItem;
import com.tea.utils.PageBean;

@SuppressWarnings("serial")
@WebServlet("/shoppingCart")
public class ShoppingCartServlet extends BaseServlet {

	public Object displayMiniCart(HttpServletRequest request, HttpServletResponse response) {
		Integer customerId = Integer.valueOf(request.getParameter("customerId"));
		PageBean<ShoppingCartItem> pages = new PageBean<ShoppingCartItem>();
		shoppingCartItemHandle.queryPageByCustomerId(pages, customerId);
		return pages;
	}
}
