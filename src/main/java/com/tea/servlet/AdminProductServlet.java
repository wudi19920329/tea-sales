package com.tea.servlet;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import com.tea.entity.Product;
import com.tea.enums.Category;
import com.tea.enums.Specification;
import com.tea.enums.Status;
import com.tea.utils.PageBean;

@SuppressWarnings("serial")
@WebServlet("/admin/product")
public class AdminProductServlet extends BaseServlet {

	public Object categorys(HttpServletRequest request, HttpServletResponse response)
			throws UnsupportedEncodingException {
		String category = request.getParameter("category");
		String name = request.getParameter("name");
		Integer pageCount = Integer.valueOf(
				StringUtils.isBlank(request.getParameter("pageCount")) ? "20" : request.getParameter("pageCount"));
		Integer currentPage = Integer.valueOf(
				StringUtils.isBlank(request.getParameter("currentPage")) ? "1" : request.getParameter("currentPage"));
		PageBean<Product> pages = new PageBean<Product>();
		pages.setPageCount(pageCount);
		pages.setCurrentPage(currentPage);
		productHandle.queryPageByCategory(pages, StringUtils.isBlank(category) ? null : Category.valueOf(category),
				name,null);
		return pages;
	}

	public void createProduct(HttpServletRequest request, HttpServletResponse response)
			throws UnsupportedEncodingException {

		String image = request.getParameter("imgUrl");
		Category category = Category.valueOf(request.getParameter("category"));
		String name = request.getParameter("name");
		Long inventory = Long.valueOf(request.getParameter("inventory"));
		Specification specification = Specification.valueOf(request.getParameter("specification"));
		BigDecimal price = new BigDecimal(request.getParameter("price"));
		BigDecimal discountPrice = new BigDecimal(StringUtils.isBlank(request.getParameter("discountPrice")) ? "0.00"
				: request.getParameter("discountPrice"));
		Boolean discounted = Boolean.valueOf(request.getParameter("discounted"));
		String content = request.getParameter("content");
		Product product = new Product(image, category, name, inventory, specification, price, content, discountPrice,
				discounted);
		productHandle.insert(product);
	}

	public Object queryProduct(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Integer productId = Integer.valueOf(request.getParameter("productId"));
		Product product = productHandle.queryById(productId);
		request.setAttribute("product", product);
		// 跳转
		return request.getRequestDispatcher("/pages/admin/menu/productConfig/view.jsp");
	}

	public void updateProductStatus(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Integer productId = Integer.valueOf(request.getParameter("productId"));
		Status status = Status.valueOf(request.getParameter("status"));
		Product product = productHandle.queryById(productId);
		product.setStatus(status);
		productHandle.update(product);
	}

	public void deleteProduct(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Integer productId = Integer.valueOf(request.getParameter("productId"));
		productHandle.delete(productId);
	}
	
	public Object updateProductPrepare(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Integer productId = Integer.valueOf(request.getParameter("productId"));
		Product product = productHandle.queryById(productId);
		request.setAttribute("product", product);
		// 跳转
		return request.getRequestDispatcher("/pages/admin/menu/productConfig/add.jsp");
	}
	
	
	public void updateProduct(HttpServletRequest request, HttpServletResponse response){
		Integer productId = Integer.valueOf(request.getParameter("productId"));
		String image = request.getParameter("imgUrl");
		Category category = Category.valueOf(request.getParameter("category"));
		String name = request.getParameter("name");
		Long inventory = Long.valueOf(request.getParameter("inventory"));
		Specification specification = Specification.valueOf(request.getParameter("specification"));
		BigDecimal price = new BigDecimal(request.getParameter("price"));
		BigDecimal discountPrice = BigDecimal.ZERO;
		Boolean discounted = Boolean.FALSE;
		if("1".equals(request.getParameter("discounted"))){
			discounted = Boolean.TRUE;
			discountPrice = new BigDecimal(StringUtils.isBlank(request.getParameter("discountPrice")) ? "0.00"
					: request.getParameter("discountPrice"));
		}
		String content = request.getParameter("content");
		Product product = productHandle.queryById(productId);
		product.setImage(image);
		product.setCategory(category);
		product.setName(name);
		product.setInventory(inventory);
		product.setSpecification(specification);
		product.setPrice(price);
		product.setDiscountPrice(discountPrice);
		product.setDiscounted(discounted);
		product.setContent(content);
		productHandle.update(product);
	}

}
