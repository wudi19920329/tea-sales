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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>管理平台</title>
<link rel="Shortcut Icon" href="resources/images/favicon.ico">
<jsp:include page="/resources/inc/meta.jsp"></jsp:include>
<jsp:include page="/resources/inc/easyui.jsp"></jsp:include>

</head>
	<body id="indexLayout" class="easyui-layout" fit="true">
		<div region="north" href="<%=request.getContextPath()%>/pages/admin/layout/north.jsp"	style="height:90px;width:100%;overflow:hidden;background: url('<%=request.getContextPath()%>/resources/images/bg/top.png')"></div>
		<div region="west" href="<%=request.getContextPath()%>/pages/admin/layout/west.jsp" title="系统导航" split="true" iconCls="icon-tip"	style="width: 200px; overflow: hidden;"></div>
		<div region="center" href="<%=request.getContextPath()%>/pages/admin/layout/center.jsp" title="" style="overflow: hidden;"></div>
		<div region="south" href="<%=request.getContextPath()%>/pages/admin/layout/south.jsp" style="height: 30px; overflow: hidden;"></div>
	</body>
</html>