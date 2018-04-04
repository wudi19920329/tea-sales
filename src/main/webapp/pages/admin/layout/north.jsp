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
<style>
<!--
.memu_1{
	text-decoration:none;
	color:#ffffff;
}
.memu_1:hover{
	color:#000000;
}
-->
</style>
<div style="position: absolute; right: 0px; bottom: 5px;right:15px; font-weight:bolder;font-family:微软雅黑;font-size:14px; ">
	<font color="white"><c:if test="${sessionScope.ADMIN_USER!=null}"><strong>${sessionScope.ADMIN_USER.userName}</strong>，欢迎您！</c:if>|</font>
	<font color="white"><a href="/user?method=logout" class="memu_1" >注销系统</a></font>
</div>