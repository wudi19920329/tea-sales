package com.tea.servlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tea.entity.Product;
import com.tea.enums.Category;
import com.tea.utils.PageBean;
import com.tea.utils.RandomEnums;

@SuppressWarnings("serial")
@WebServlet("/product")
public class ProductServlet extends BaseServlet {

	public Object featureds(HttpServletRequest request, HttpServletResponse response){
		PageBean<Product> pages = new PageBean<Product>();
		pages.setPageCount(4);
		productHandle.queryPageByCategory(pages, RandomEnums.random(Category.class));
		return pages;
	}
	
	public Object categorys(HttpServletRequest request, HttpServletResponse response){
		String category = request.getParameter("category");
		PageBean<Product> pages = new PageBean<Product>();
		productHandle.queryPageByCategory(pages, Category.valueOf(category));
		return pages;
	}
}
