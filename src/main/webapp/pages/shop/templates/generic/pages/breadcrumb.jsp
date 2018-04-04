<%@page import="com.tea.enums.Category"%>
<%
response.setCharacterEncoding("UTF-8");
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", -1);
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
	<div class="page-intro" style="margin-top: 0px;">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<ol class="breadcrumb">
						  <li class="active">
							  <i class="fa fa-home pr-10"></i>
							  <a href="/">主页</a>
						  </li>
						  <li>
						    <a href="#"><%=Category.valueOf(request.getParameter("category")).getDescription()%></a>
						  </li>
					</ol>
				</div>
			</div>
		</div>
	</div>



