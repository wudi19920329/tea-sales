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
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-large-picture',size:'large',iconAlign:'top'"onclick="uploadImg('img','imgUrl','dc-gift')" id="uploadImg" style="margin-bottom:10px;">添加标题图片</a>
					</th>
					<td colspan="2" rowspan="6">
						<div style="border-style:solid;border-width:1px;width:300px;height:100%">
						<img id="img" src="${requestScope.product.image}" style="width:300px;height:100%"/>
						<input id="imgUrl" name="imgUrl" value="${requestScope.product.image}"  type="hidden"/>
						</div>
					</td>
				</tr>
				<tr>
					<th>产品名称：</th>
					<td class="basic_td">
						<input name="name"  value="${requestScope.product.name}"
						class="easyui-textbox" data-options="required:true"
						style="width: 200px;" />
						<c:choose>
							<c:when test="${requestScope.product!=null}">
									<input name="method" id="method" value="updateProduct" type="hidden"/>
							</c:when>	
							<c:otherwise>
									<input name="method" id="method" value="createProduct" type="hidden"/>
							</c:otherwise>
						</c:choose>
					
						<input name="productId" id="productId" value="${requestScope.product.id}" type="hidden"/>
					</td>
				</tr>
				 
				<tr>
					<th>分类：</th>
					<td class="basic_td">
						<select id="category" name="category" class="easyui-combobox" data-options="panelHeight:'auto'"  style="width: 200px;" editable="false" >
							<c:set var="categorys" value="<%=com.tea.enums.Category.values()%>"/>
							<c:forEach var="category" items="${categorys}">
								<c:choose>
								<c:when test="${requestScope.product.category.name()==category.name()}">
									<option value="${category.name()}" selected="selected">${category.getDescription()}</option>
								</c:when>	
								<c:otherwise>
									<option value="${category.name()}" >${category.getDescription()}</option>
								</c:otherwise>
								</c:choose>
											
							</c:forEach>
						</select>
					</td>
				</tr> 
				 
				
				<tr>
					<th>规格：</th>
					<td class="basic_td">
						<select id="specification" name="specification" class="easyui-combobox" data-options="panelHeight:'auto'"  style="width: 200px;" editable="false">
							<c:set var="specifications" value="<%=com.tea.enums.Specification.values()%>"/>
							<c:forEach var="specification" items="${specifications}">
								<c:choose>
								<c:when test="${requestScope.product.specification.name()==specification.name()}">
									<option value="${specification.name()}" selected="selected">${specification.getDesc()}（${specification.getWeight()}${specification.getUnit()}）</option>		
								</c:when>	
								<c:otherwise>
									<option value="${specification.name()}" >${specification.getDesc()}（${specification.getWeight()}${specification.getUnit()}）</option>		
								</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</td>
				</tr>
				
				<tr>
					<th>库存：</th>
					<td class="basic_td"><input name="inventory" value="${requestScope.product.inventory}"
						class="easyui-textbox" data-options="required:true"
						style="width: 200px;" />
					</td>
				</tr>
				
				<tr>
					<th>价格：</th>
					<td class="basic_td"><input name="price" value="${requestScope.product.price}"
						class="easyui-textbox" data-options="required:true,required:true"
						style="width: 200px;" />
					</td>
				</tr>
				
				<tr>
					<th>是否打折：</th>
					<td class="basic_td">
						<select id="discounted" name="discounted"  class="easyui-combobox"  style="width: 200px;" editable="false"
						data-options="panelHeight:'auto',onSelect:function(record){
								if(record.value == 1){
									$('#discountPriceTr').show();
								}else{
									$('#discountPriceTr').hide();
								}
							}"
						>
							<c:choose>
								<c:when test="${requestScope.product.discounted}">
									<option value="1" selected="selected">是</option>	
									<option value="0" >否</option>				
								</c:when>	
								<c:otherwise>
									<option value="1" >是</option>	
									<option value="0" selected="selected">否</option>				
								</c:otherwise>
							</c:choose>
							
							
						</select>
					</td>
				</tr>
				
				<c:if test="${requestScope.product.discounted}">
					<tr id="discountPriceTr" >
						<th>折后价：</th>
						<td class="basic_td"><input name="discountPrice"  value="${requestScope.product.discountPrice}"
							class="easyui-textbox" 
							style="width: 200px;" />
						</td>
					</tr>
				</c:if>
				
				<tr>
					<th>说明：</th>
					<td class="basic_td"><input name="content"   value="${requestScope.product.content}"
						class="easyui-textbox" data-options="multiline:true,required:true"
						style="width:300px;height:100px" />
					</td>
				</tr>	
			</table>
		</div>
</form>
</div>
