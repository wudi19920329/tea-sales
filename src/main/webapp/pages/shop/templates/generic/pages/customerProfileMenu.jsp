
<%
	response.setCharacterEncoding("UTF-8");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", -1);
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<c:set var="billing"
	value="${pageContext.request.contextPath}/shop/customer/billing.html" />
<ul class="nav nav-list">
	<li><a href="dashboard.jsp"><i
			class="fa fa-angle-right"></i> 我的账户</a></li>
	<li><a href="address.jsp"> <i class="fa fa-angle-right"></i>
			收货信息
	</a></li>
	<li><a href="<c:url value="/shop/customer/password.html"/>"><i
			class="fa fa-angle-right"></i> 更改密码</a></li>
	<li><a href="<c:url value="/shop/customer/logout"/>"><i
			class="fa fa-angle-right"></i> 登出</a></li>
</ul>