
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


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
				{{#pageData}}
                        <div itemscope itemtype="http://schema.org/Enumeration" class="col-md-COLUMN-SIZE col-sm-6 col-xs-12 product"  item-name="{{name}}" item-price="{{price}}" data-id="{{id}}">
								<div class="thumbnail product-img">
                                    {{#image}}
									<a href="<c:url value="/shop/product/" />{{description.friendlyUrl}}.html">
										<img src="{{image}}" alt="" />
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
				{{/pageData}}
    		</script>
 

</head>
<body>
	<!--[if lt IE 8]>
           <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
       <![endif]-->
	<jsp:include page="/pages/shop/templates/generic/sections/header.jsp" />
	<jsp:include page="/pages/shop/templates/generic/sections/navbar.jsp" />
	
	<div id="main-content" class="container clearfix no-padding-left">
		<h1>订单已完成</h1>
		<div class="row-fluid">
			<div class="span12">  
          <p class="lead">谢谢你订购茶叶</p>
          <p class="lead">您的订单号<%=request.getParameter("orderNumber") %></p>
          <p>请留意你的过去的订单</p>
          <p class="muted">如果您对订单有疑问，请联系我们！9999-9999-9999</p>
            </div>
          </div>
      </div>



	<jsp:include page="/pages/shop/templates/generic/sections/footer.jsp" />
	<jsp:include page="/pages/shop/templates/generic/sections/jsLinks.jsp" />
</body>
</html>
	
	