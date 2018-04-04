package com.tea.servlet;

import java.io.UnsupportedEncodingException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import com.tea.entity.Product;
import com.tea.entity.User;
import com.tea.enums.Category;
import com.tea.enums.Status;
import com.tea.exception.ServiceException;
import com.tea.utils.PageBean;
import com.tea.utils.RandomEnums;

@SuppressWarnings("serial")
@WebServlet("/product")
public class ProductServlet extends BaseServlet {

	public Object featureds(HttpServletRequest request, HttpServletResponse response) {
		PageBean<Product> pages = new PageBean<Product>();
		pages.setPageCount(4);
		productHandle.queryPageByCategory(pages, RandomEnums.random(Category.class), null, Status.FAYE_FLY);
		return pages;
	}

	public Object categorys(HttpServletRequest request, HttpServletResponse response)
			throws UnsupportedEncodingException {
		String category = request.getParameter("category");
		String name = request.getParameter("name");
		Integer pageCount = Integer.valueOf(
				StringUtils.isBlank(request.getParameter("pageCount")) ? "10" : request.getParameter("pageCount"));
		Integer currentPage = Integer.valueOf(
				StringUtils.isBlank(request.getParameter("currentPage")) ? "1" : request.getParameter("currentPage"));
		PageBean<Product> pages = new PageBean<Product>();
		pages.setPageCount(pageCount);
		pages.setCurrentPage(currentPage);
		productHandle.queryPageByCategory(pages, StringUtils.isBlank(category) ? null : Category.valueOf(category),
				name, Status.FAYE_FLY);
		return pages;
	}

	public Object adminCreateProductPrepared(HttpServletRequest request, HttpServletResponse response)
			throws UnsupportedEncodingException {
		User user = UserServlet.getOptionalLoginSession(request);
		if (user == null) {
			throw new ServiceException("请先登录");
		}
		return request.getRequestDispatcher("/pages/admin/layout/menu/productConfig/add.jsp");
	}

}
