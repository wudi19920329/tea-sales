package com.tea.servlet;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.nio.charset.Charset;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.tea.Constants;
import com.tea.dbHandle.ProductHandle;
import com.tea.dbHandle.ShoppingCartHandle;
import com.tea.dbHandle.ShoppingCartItemHandle;
import com.tea.dbHandle.CustomerHandle;
import com.tea.dbHandle.OrderHandle;
import com.tea.exception.ExceptionInfo;
import com.tea.factory.BeanFactory;
import com.tea.utils.WebUtils;

@SuppressWarnings("serial")
public abstract class BaseServlet extends HttpServlet {
	protected static final ObjectMapper MAPPER = new ObjectMapper();
	protected ProductHandle productHandle = BeanFactory.getInstance("productHandle");
	protected CustomerHandle customerHandle = BeanFactory.getInstance("customerHandle");
	protected ShoppingCartHandle shoppingCartHandle = BeanFactory.getInstance("shoppingCartHandle");
	protected ShoppingCartItemHandle shoppingCartItemHandle = BeanFactory.getInstance("shoppingCartItemHandle");
	protected OrderHandle orderHandle = BeanFactory.getInstance("orderHandle");
	

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 用于保存跳转资源
		Object returnValue = null;
		// 操作类型的值,对应servlet中的方法名称
		final String methodName = request.getParameter("method");
		String xRequestedWith = request.getHeader(Constants.AJAX_HEADER);
		boolean isAjax = StringUtils.isNotEmpty(xRequestedWith);
		try {
			// 获取当前运行类的字节码
			Class<?> clazz = this.getClass();
			// 获取当前执行的方法的Method类型
			Method method = clazz.getDeclaredMethod(methodName, HttpServletRequest.class, HttpServletResponse.class);
			// 执行
			returnValue = method.invoke(this, request, response);
		} catch (InvocationTargetException e) {
			e.printStackTrace();
			// agetShoppingCartItem(customer.getId())jax请求
			if (isAjax) {
				response.setContentType(Constants.AJAX_CONTENT_TYPE);
				response.getOutputStream()
						.write(MAPPER
								.writeValueAsString(
										new ExceptionInfo(String.valueOf(400), e.getTargetException().getMessage()))
								.getBytes(Charset.defaultCharset()));
				response.setStatus(510);
				response.getOutputStream().flush();
				return;
			}
			// 跳转到错误页面
			returnValue = "/error.jsp";
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (isAjax) {
			response.setContentType(Constants.AJAX_CONTENT_TYPE);
			MAPPER.setSerializationInclusion(Include.NON_NULL);
			MAPPER.writeValue(response.getOutputStream(), returnValue);
			return;
		}
		// 跳转
		WebUtils.goTo(request, response, returnValue);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doGet(request, response);
	}

}
