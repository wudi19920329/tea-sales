<%@page import="com.tea.entity.Product"%>
<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<style>
.basic_td{
text-align:left!important;
}
</style>

<div align="center" >
<form id="productAddForm" method="post" class="easyui-form" data-options="novalidate:true">
		 <div title="基本信息" style="padding:10px;text-align:center">
			<table class="tableForm" style="width:75%;">
				<tr>
					<th colspan="2" style="text-align:center;">
					</th>
					<td colspan="2" rowspan="6">
						<div style="border-style:solid;border-width:1px;width:300px;height:100%">
						<img id="img" src="${requestScope.product.image}" style="width:300px;height:100%"/>
						</div>
					</td>
				</tr>
				<tr>
					<th>产品名称：</th>
					<td class="basic_td">
						<input  value="${requestScope.product.name}" disabled="disabled"
						class="easyui-textbox" data-options="required:true"
						style="width: 200px;" />
					 
					</td>
				</tr>
				 
				<tr>
					<th>分类：</th>
					<td class="basic_td">
						<select disabled="disabled" class="easyui-combobox" data-options="panelHeight:'auto'"  style="width: 200px;" editable="false">
						<option value="${requestScope.product.category.name()}" >${requestScope.product.category.getDescription()}</option>			 
						</select>
					</td>
				</tr> 
				 
				
				<tr>
					<th>规格：</th>
					<td class="basic_td">
						<select disabled="disabled" class="easyui-combobox" data-options="panelHeight:'auto'"  style="width: 200px;" editable="false">
							<option value="${requestScope.product.specification.name()}" >${requestScope.product.specification.getDesc()}（${requestScope.product.specification.getWeight()}${requestScope.product.specification.getUnit()}）</option>			 
						</select>
						
					</td>
				</tr>
				
				<tr>
					<th>库存：</th>
					<td class="basic_td"><input value="${requestScope.product.inventory}" disabled="disabled"
						class="easyui-textbox" data-options="required:true"
						style="width: 200px;" />
					</td>
				</tr>
				
				<tr>
					<th>价格：</th>
					<td class="basic_td"><input value="${requestScope.product.price}" disabled="disabled"
						class="easyui-textbox" data-options="required:true,required:true"
						style="width: 200px;" />
					</td>
				</tr>
				
				<tr>
					<th>是否打折：</th>
					<td class="basic_td">
						<select  class="easyui-combobox"  style="width: 200px;"  disabled="disabled">
							<option value="${requestScope.product.discounted}">${requestScope.product.discounted?"是":"否"}</option>			
						</select>
					</td>
				</tr>
				
				<c:if test="${requestScope.product.discounted}">
					<tr>
						<th>折后价：</th>
						<td class="basic_td"><input  value="${requestScope.product.discountPrice}" disabled="disabled"
							class="easyui-textbox" 
							style="width: 200px;" />
						</td>
					</tr>
				</c:if>
				
				
				<tr>
					<th>说明：</th>
					<td class="basic_td"><input  value="${requestScope.product.content}" disabled="disabled"
						class="easyui-textbox" data-options="multiline:true,required:true"
						style="width:300px;height:100px" />
					</td>
				</tr>	
			</table>
		</div>
</form>
</div>
