
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

<ul class="nav nav-list">
	<li><a href="/order?method=displayPastOrders"><i class="fa fa-angle-right"></i> 过去的订单</a></li>
</ul>