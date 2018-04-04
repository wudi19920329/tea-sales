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

<!DOCTYPE html>
<html>
<head>
<jsp:include page="/resources/inc/meta.jsp"></jsp:include>
<jsp:include page="/resources/inc/easyui.jsp"></jsp:include>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
</head>
<body class="easyui-layout" fit="true">
	<!-- 角色管理 查询 --> 
	<div region="north"  id="giftConfigArea" style="white-space: nowrap;padding: 5px; height: 50px;">
		<div style="margin-bottom: 5px">
			<form id="giftConfigSearchForm"  method="post">
				<table class="table_content"   border="0" >
					<tr>
						<td class="tar" >产品名称：</td>
						<td class="tal" >
							<input class="easyui-textbox" name="name" prompt="模糊查询"/>
						</td>
						<td class="tar" >类别：</td>
						<td class="tal">
							<select name="category" class="easyui-combobox"  editable="false">
								<option value="">全部</option> 
								<c:set var="categorys" value="<%=com.tea.enums.Category.values()%>"/>
								<c:forEach var="category" items="${categorys}">
									<option value="${category.getName()}" >${category.getDescription() }</option>			
								</c:forEach>
							</select>
						</td>
					    <td style="padding-left:20px">
							<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px" onclick="doSearch()">搜索</a>
							<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" style="width:80px" onclick="reset()">重置</a>
						</td> 
					</tr>
				</table>
			</form>
		</div>
	</div> 
	<div data-options="region:'center'"  border="false" style="overflow: hidden;width:85%">
    	<table id="datagrid"></table>
    </div>
</body>
<script type="text/javascript" charset="UTF-8" src="<%=request.getContextPath()%>/resources/js/aylson/mem/giftConfig.js?date=2016090903"></script>
</html>