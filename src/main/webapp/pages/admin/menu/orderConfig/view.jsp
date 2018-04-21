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
		 <div title="订单信息" style="padding:10px;text-align:center">
		 	<c:forEach items="${products}" var="product">
		 	<br/>
			<table class="tableForm" style="width:75%;">
				<tr>
					<th colspan="2" style="text-align:center;">
					</th>
					<td colspan="2" rowspan="6">
						<div style="border-style:solid;border-width:1px;width:300px;height:100%">
						<img id="img" src="${product.image}" style="width:300px;height:100%"/>
						</div>
					</td>
				</tr>
				<tr>
					<th>产品名称：</th>
					<td class="basic_td">
						<input  value="${product.name}" disabled="disabled"
						class="easyui-textbox" data-options="required:true"
						style="width: 200px;" />
					 
					</td>
				</tr>
				 
				<tr>
					<th>分类：</th>
					<td class="basic_td">
						<select disabled="disabled" class="easyui-combobox" data-options="panelHeight:'auto'"  style="width: 200px;" editable="false">
						<option value="${product.category.name()}" >${product.category.getDescription()}</option>			 
						</select>
					</td>
				</tr> 
				 
				
				<tr>
					<th>规格：</th>
					<td class="basic_td">
						<select disabled="disabled" class="easyui-combobox" data-options="panelHeight:'auto'"  style="width: 200px;" editable="false">
							<option value="${product.specification.name()}" >${product.specification.getDesc()}（${product.specification.getWeight()}${product.specification.getUnit()}）</option>			 
						</select>
						
					</td>
				</tr>
				
				<tr>
					<th>单价：</th>
					<td class="basic_td"><input value="${product.finalPrice}" disabled="disabled"
						class="easyui-textbox" data-options="required:true"
						style="width: 200px;" />
					</td>
				</tr>
				
				<tr>
					<th>数量：</th>
					<td class="basic_td"><input value="${product.quantity}" disabled="disabled"
						class="easyui-textbox" data-options="required:true"
						style="width: 200px;" />
					</td>
				</tr>
				
				<tr>
					<th>运费信息：</th>
					<td class="basic_td"><input value="${product.expressDeliveryMode.description}（价格：￥${product.expressDeliveryMode.cost}）" disabled="disabled"
						class="easyui-textbox" data-options="required:true"
						style="width: 200px;" />
					</td>
				</tr>
				
				<tr>
					<th>总金额：</th>
					<td class="basic_td"><input value="${product.payableAmount}" disabled="disabled"
						class="easyui-textbox" data-options="required:true,required:true"
						style="width: 200px;" />
					</td>
				</tr>
				
			 
				
				
				<tr>
					<th>产品说明：</th>
					<td class="basic_td"><input  value="${product.content}" disabled="disabled"
						class="easyui-textbox" data-options="multiline:true,required:true"
						style="width:300px;height:100px" />
					</td>
				</tr>	
			</table>
			</c:forEach>	
		</div>
</form>
</div>
