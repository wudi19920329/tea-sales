package com.tea.servlet;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.tea.dto.ShoppingCartItemVo;
import com.tea.entity.Customer;
import com.tea.entity.Product;
import com.tea.entity.ShoppingCart;
import com.tea.entity.ShoppingCartItem;
import com.tea.exception.ServiceException;
import com.tea.utils.PageBean;

@SuppressWarnings("serial")
@WebServlet("/shoppingCart")
public class ShoppingCartServlet extends BaseServlet {

	public Object displayMiniCart(HttpServletRequest request, HttpServletResponse response) {
		Customer customer = CustomerServlet.getOptionalLoginSession(request);
		if (customer == null) {
			return null;
		}
		return getShoppingCartItem(customer.getId());
	}

	public Object displayShoppingCart(HttpServletRequest request, HttpServletResponse response) {
		Customer customer = CustomerServlet.getOptionalLoginSession(request);
		if (customer == null) {
			return null;
		}
		PageBean<ShoppingCartItem> carts = getShoppingCartItem(customer.getId());
		request.getSession().setAttribute("cart", carts);
		Object uri = "/pages/shop/templates/generic/pages/cart.jsp";
		return uri;
	}

	public Object addShoppingCartItem(HttpServletRequest request, HttpServletResponse response) {
		Customer customer = CustomerServlet.getOptionalLoginSession(request);
		if (customer == null) {
			return null;
		}
		Integer productId = Integer.valueOf(request.getParameter("productId"));
		Integer quantity = Integer.valueOf(request.getParameter("quantity"));
		Product product = productHandle.queryById(productId);
		ShoppingCart shoppingCart = shoppingCartHandle.queryByCustomerId(Integer.valueOf(customer.getId()));
		if (shoppingCart == null) {
			throw new ServiceException("用户购物车信息异常");
		}
		// 购物车中没有该产品，则创建新的购物车商品
		ShoppingCartItem shoppingCartItem = shoppingCartItemHandle.queryBy(productId, shoppingCart.getId());
		if (shoppingCartItem != null) {
			shoppingCartItem.addQuantity(quantity);
			shoppingCartItemHandle.updateQuantity(shoppingCartItem);
		} else {
			shoppingCartItem = new ShoppingCartItem(product, shoppingCart, quantity);
			shoppingCartItemHandle.insert(shoppingCartItem);
		}
		return getShoppingCartItem(customer.getId());
	}

	public Object removeMiniShoppingCartItem(HttpServletRequest request, HttpServletResponse response) {
		Customer customer = CustomerServlet.getOptionalLoginSession(request);
		if (customer == null) {
			return null;
		}
		Integer lineItemId = Integer.valueOf(request.getParameter("lineItemId"));
		ShoppingCartItem shoppingCartItem = shoppingCartItemHandle.queryById(lineItemId);
		if (shoppingCartItem != null) {
			shoppingCartItemHandle.delete(shoppingCartItem.getId());
		}
		return getShoppingCartItem(customer.getId());
	}

	public Object updateShoppingCartItem(HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {
		Customer customer = CustomerServlet.getOptionalLoginSession(request);
		if (customer == null) {
			return null;
		}
		List<ShoppingCartItemVo> vos = MAPPER.readValue(request.getParameter("items"),
				new TypeReference<List<ShoppingCartItemVo>>() {
				});
		vos.forEach(vo -> {
			ShoppingCartItem shoppingCartItem = new ShoppingCartItem();
			shoppingCartItem.setId(vo.getId());
			shoppingCartItem.setQuantity(vo.getQuantity());
			shoppingCartItemHandle.updateQuantity(shoppingCartItem);
		});
		return getShoppingCartItem(customer.getId());
	}

	private PageBean<ShoppingCartItem> getShoppingCartItem(Integer customerId) {
		PageBean<ShoppingCartItem> pages = new PageBean<ShoppingCartItem>();
		shoppingCartItemHandle.queryPageByCustomerId(pages, Integer.valueOf(customerId));
		if (pages.getPageData() != null && pages.getPageData().size() > 0) {
			pages.setSubTotalPrice(pages.getPageData().stream().map(item -> {
				return item.getProduct().getPrice().multiply(new BigDecimal(item.getQuantity()));
			}).reduce(BigDecimal.ZERO, BigDecimal::add));

			pages.setSubTotalCount(pages.getPageData().stream().map(item -> {
				return item.getQuantity();
			}).reduce(0, Integer::sum));

		}
		return pages;
	}

}
