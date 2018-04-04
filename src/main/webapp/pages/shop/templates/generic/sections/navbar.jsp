
<%
	response.setCharacterEncoding("UTF-8");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", -1);
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="req" value="${request}" />
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>


<!-- mainmenu-area-start -->
<div class="mainmenu-area bg-color-1" id="main_h">
	<div class="container">
		<div class="row">
			<div class="col-lg-12 col-md-12 col-sm-12 hidden-xs">
				<div class="mainmenu hidden-xs">
					<nav>
						<ul>
							<c:set var="categorys" value="<%=com.tea.enums.Category.values()%>"/>
							<c:forEach var="category" items="${categorys}">
							    <li style="width:100px"><a href="/pages/shop/templates/generic/pages/category.jsp?category=${category.getName()}"><c:out
											value="${category.getDescription()}" /></a></li>
							</c:forEach>
							
							
						</ul>
					</nav>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- mainmenu-area-end -->
