<%
response.setCharacterEncoding("UTF-8");
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", -1);
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"> 
     <head>
       	 	<meta charset="utf-8">
       	 	<meta http-equiv="x-ua-compatible" content="ie=edge">
   			<title>Tea shop</title>
   			<meta name="viewport" content="width=device-width, initial-scale=1.0">
   			<meta name="description" content="茶叶店铺">
   			<meta name="author" content="牛占元">

			<!-- include all header js and css -->
            <jsp:include page="/pages/shop/templates/generic/sections/shopLinks.jsp" />
		    <script type="text/html" id="productBoxTemplate">
				{{#rows}}
                        <div itemscope itemtype="http://schema.org/Enumeration" class="col-md-COLUMN-SIZE col-sm-6 col-xs-12 product"  item-name="{{name}}" item-price="{{price}}" data-id="{{id}}">
								<div class="thumbnail product-img">
                                    {{#image}}
									<a href="<c:url value="/shop/product/" />{{description.friendlyUrl}}.html">
										<img src="/{{image}}" alt="" />
									</a>
									{{/image}}
								</div>
								<div class="product-content text-center">
									<a class="listing-product-name" href="<c:url value="/shop/product/" />{{description.friendlyUrl}}.html"><h3 itemprop="name">{{varieties.desc}}</h3></a>
									<h4>
										{{#discounted}}<del>￥{{price}}</del>&nbsp;<span itemprop="price" class="specialPrice">￥{{discountPrice}}</span>{{/discounted}}
										{{^discounted}}<span itemprop="price">￥{{price}}</span>{{/discounted}}
									</h4>
									<div class="store-btn">
      									<div class="store-btn-addtocart"><a class="addToCart" href="javascript:void(0)" productId="{{id}}">添加到购物车</a></div>
   									</div>
								</div>
						</div>
				{{/rows}}
    		</script>            
 	</head> 
 	
 	<body>
		<input type="hidden" id="category" value="<%=request.getParameter("category")%>"/>
 	    <!--[if lt IE 8]>
            <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->
		
		<jsp:include page="/pages/shop/templates/generic/sections/header.jsp" />
		<jsp:include page="/pages/shop/templates/generic/sections/navbar.jsp" />
		
		
		<div id="main-content" class="container clearfix row-fluid">
				<div class="span12 col-md-12 common-row">
		
					  <div class="span8 col-md-8 no-padding">
						
					<div class="checkout-box">
							<span class="box-title">
								<p class="p-title">
									订单列表
									&nbsp;
									<span class="p-title-text">
							 
								</p>
							</span>
		               <c:choose>
		                 <c:when test="${not empty customerOrders.rows}">
		                 	<div id="shop">
		
							<!-- HISTORY TABLE -->
							<table class="table table-striped">
								<!-- table head -->
								<thead>
									<tr>
										<th>id</th>
										<th>订单日期</th>
										<th>金额</th>
										<th>状态</th>
									</tr>
								</thead>
								
								<!-- /HISTORY TABLE -->
								<tbody>
								<c:forEach items="${customerOrders.rows}" var="order" varStatus="orderStatus">
									<tr><!-- item -->
										<td><a href="${customerOrder}?orderId=${order.id}">${order.id}</a></td>
										<td><fmt:formatDate type="both" value="${order.createTime}" pattern="yyyy-MM-dd" /></td>
										<td>￥${order.payableAmount}</td>
										<td>${order.orderStatus.description}</td>
									</tr>
								</c:forEach>
									
								</tbody>
							</table>
							
		
		
							
							<!-- PAGINATION -->
							<br/>
							<ul class="pagination">
								<c:forEach begin="1" end="${customerOrders.totalPage}" varStatus="paginationDataStatus">
								    <li class="${customerOrders.currentPage eq (paginationDataStatus.index) ? 'active' : ''}"><a href="/order?method=displayPastOrders&page=${paginationDataStatus.index}">${paginationDataStatus.index}</a></li>
								</c:forEach>
							</ul>
							<!-- /PAGINATION -->
						
		
						</div>
		                 </c:when>
		                 <c:otherwise>
		                 
		                 </c:otherwise>
		               
		               </c:choose>
					   </div>	
		
					 </div>
					 <div class="span4 col-md-4 no-padding">
					 	<jsp:include page="customerProfileMenu.jsp" />
					 	<jsp:include page="customerOrdersMenu.jsp" />
					 </div>
				</div>
				<!-- close row-fluid--> 
			</div>
			<!--close .container "main-content" -->
		
		<jsp:include page="/pages/shop/templates/generic/sections/footer.jsp" />
		<jsp:include page="/pages/shop/templates/generic/sections/jsLinks.jsp" />

 	</body>

</html> 
 