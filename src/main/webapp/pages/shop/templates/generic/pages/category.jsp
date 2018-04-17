<%@page import="com.tea.enums.Category"%>
<%
response.setCharacterEncoding("UTF-8");
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", -1);
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
            <script src="<c:url value="/resources/js/jquery.easing.1.3.js" />"></script>
			<script src="<c:url value="/resources/js/jquery.quicksand.js" />"></script>
			<script src="<c:url value="/resources/js/jquery-sort-filter-plugin.js" />"></script>
			<script src="<c:url value="/resources/js/jquery.alphanumeric.pack.js" />"></script>
 
                
		    <script type="text/html" id="productBoxTemplate">
				{{#rows}}
                        <div itemscope itemtype="http://schema.org/Enumeration" class="col-md-COLUMN-SIZE col-sm-6 col-xs-12 product"  item-name="{{name}}" item-price="{{price}}" data-id="{{id}}">
								<div class="thumbnail product-img">
                                    {{#image}}
									<a href="javascript:void(0)" title="{{content}}">
										<img src="{{image}}" alt="" />
									</a>
									{{/image}}
								</div>
								<div class="product-content text-center">
									<a class="listing-product-name" href="javascript:void(0)"><h3 itemprop="name">{{name}} {{specification.desc}}（{{specification.weight}}{{specification.unit}}）</h3></a>
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
		
		<div id="mainContent" class="container">
			
					  <header class="page-header row">
					  <div class="fixed-image section dark-translucent-bg parallax-bg-3">
							<div class="container">
							<h2 class="shop-banner-title lead"><%=Category.valueOf(request.getParameter("category")).getDescription()%></h2>
							</div>
					  </div>
					  <jsp:include page="breadcrumb.jsp" />
					  </header>
		
					  
					  <div class="container">
					  	<p>
					  		<c:choose>
					  			
							     <c:when test='<%=Category.GREEN_TEA.name().equals(request.getParameter("category"))%>'>
							    	绿茶：茶是不经过发酵的茶，即将鲜叶经过摊晾后直接下到一二百度的热锅里炒制，以保持其绿色的特点。
							    </c:when>
							    <c:when test='<%=Category.BLACK_TEA.name().equals(request.getParameter("category"))%>'>
							    	红茶 ：红茶与绿茶恰恰相反，是一种全发酵茶（发酵程度大于80％）。红茶的名字得自其汤色红。
							    </c:when>
							    <c:when test='<%=Category.DARK_GREEN_TEA.name().equals(request.getParameter("category"))%>'>
							    	黑茶：黑茶原来主要销往边区，像云南的普洱茶就是其中一种。普洱茶是在已经制好的绿茶上浇上水，再经过发酵制成的。普洱茶具有降脂、减肥和降血压的功效，在东南亚和日本很普及。不过真要说减肥，效果最显著的还是乌龙茶。
							    </c:when>
							    <c:when test='<%=Category.OOLONG_TEA.name().equals(request.getParameter("category"))%>'>
							    	乌龙茶 ：乌龙茶也就是青茶，是一类介于红绿茶之间的半发酵茶。乌龙茶在六大类茶中工艺最复杂费时，泡法也最讲究，所以喝乌龙茶也被人称为喝工夫茶。
							    </c:when>
							    <c:otherwise>
							    	黄茶 ：著名的君山银针茶就属于黄茶，黄茶的制法有点像绿茶，不过中间需要闷黄三天。
							    </c:otherwise> 
							</c:choose>
					  		</p>
					  </div>
					  
		
					<div class="bedroom-all-product-area ptb-80">
					<div class="container">
						<div class="row">
							<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
								<!-- category-products-area-start -->
								<div class="caregory-products-area">
									<div class="row">
										<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
											<div class="product-option">
												<div class="porduct-option-left floatleft">
													<div class="sort-by">
														<label>排序</label>
		
														<select id="filter" class="cust-select">
															<option value="item-order">默认</option>
															<option value="item-name">名称</option>
															<option value="item-price">价格</option>
														</select>
													</div>
												</div>
												<div class="product-option-right floatright">
													&nbsp;
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="tab-content category-products">
										<div class="tab-pane active" id="viewed">
											<div class="row">
											<section class="products-grid">
											    <!-- Products here -->
											    <div id="productsContainer" class="list-unstyled"></div>
												<span id="end_nav" style="display:none;">没有更多商品显示</span>
		          								<!-- end block -->
												<!-- hidden -->
												<div id="hiddenProductsContainer" style="display:none;"></div>
											</section>
											</div>
										</div>
								</div>
							</div>
							<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
									<c:if test="${parent!=null}">
		              					<h3><c:out value="${parent.description.name}" /></h3>
		             				</c:if>
									<ul class="nav nav-list">
										<c:forEach items="${subCategories}" var="subCategory">
											<c:if test="${subCategory.visible}">
			              					<li>
			              					<a href="javascript:void(0)"><i class="fa fa-angle-right"></i> <c:out value="${subCategory.description.name}" />
			              						<c:if test="${subCategory.productCount>0}">&nbsp;<span class="countItems">(<c:out value="${subCategory.productCount}" />)</span></c:if></a>
			              					</li>
			              					</c:if>
			              				</c:forEach>
									</ul>
									 
									 
							</div>
						</div>
					</div>
				</div>
		</div>		
		
		
		
		 <!-- don't change that script except max_oroducts -->
		 <script>
			 var START_COUNT_PRODUCTS = 0;
			 var MAX_PRODUCTS = 30;
			 var filter = null;
			 var filterValue = null;
			
			 $(function(){
				
				/** specific to this template ***/
				var tpl = $('#productBoxTemplate').text();
				tpl = tpl.replace("COLUMN-SIZE", "4");//size of the div
				$('#productBoxTemplate').text(tpl);
				/*** ***/
				 
			    //price minimum/maximum
				$('.numeric').numeric();
			    
			    
				$('#filter').on('change', function() {
					visualize();
				});
				
				$('#priceFilterMinimum').on('blur', function() {
					visualize();
				});
				
				$('#priceFilterMaximum').on('blur', function() {
					visualize()	
				});
				
				 
				loadCategoryProducts();
			
			 });
			 
			 
			 	function visualize() {
			 		var orderBy = $("#filter").val();
					var minimumPrice = $('#priceFilterMinimum').val();
					var maximumPrice = $('#priceFilterMaximum').val();
					orderProducts(orderBy, minimumPrice, maximumPrice);
			 	}
			 
				/** used for ordering and filtering **/
				//function orderProducts(attribute, minimum, maximum) {
				function orderProducts(attribute, minimumPrice, maximumPrice) {
					
					  if(minimumPrice==undefined) {
						  minimumPrice = '';
					  }
					  
					  if(maximumPrice==undefined) {
						  maximumPrice = ''; 
					  }
					
					  //log('Attribute ' + attribute + ' Minimum price ' + minimumPrice + ' Maximum price ' + maximumPrice);
					
					  if(minimumPrice == '' && maximumPrice == '') {
					  
						  if(attribute=='item-order') {	  
							  return;
						  }
					  }
					
					  // get the first collection
					  var $prods = $('#productsContainer');
					  
			
					  // clone applications to get a second collection
					  data = $('#hiddenProductsContainer').clone();
					  
					  //console.log('Data');
					  //console.log(data);
					  
					  
					  listedData = data.find('.product');
					  
					  //console.log('Listed Data');
					  //console.log(listedData);
			
					  filteredData = listedData;
					  var $sortedData = null;
				      
					  if(minimumPrice != '' || maximumPrice != '') {
						  //filter filteredData
						  if(minimumPrice == '') {
							  minimumPrice = '0';
						  }
						  filteredData = listedData.filter(function() {
							 
							   //log('Item price ' + $(this).attr('item-price'));
						  
							   var price = parseFloat($(this).attr('item-price'));
							   if(maximumPrice != '') {
								   return price >= parseFloat(minimumPrice) && price <= parseFloat(maximumPrice); 
							   } else {
								   return price >= parseFloat(minimumPrice);
							   }
							   
						  }); 
					  } 
					  
					  //console.log('After filtered Data');
					  //console.log(filteredData);
			
					  
					  if(attribute!='item-order') {	
					  
					  	$sortedData = filteredData.sorted({
					        by: function(v) {
					        	if(attribute=='item-price') {
					        		return parseFloat($(v).attr(attribute));
					        	} else {
					        		return $(v).attr(attribute);
					        	}
					        }
					 	 });
					  
					  } else {
						  $sortedData =  filteredData; 
					  }
			
					  // finally, call quicksand
					  $prods.quicksand($sortedData, {
					      duration: 800,
					      easing: 'easeInOutQuad'
					  });
					
					
				}
			 
			 	function loadCategoryProducts() {
			 		var url = '/product?category='+$("#category").val()+'&&method=categorys';
			 		loadProducts(url,'#productsContainer');
			 	}
			 	
			 	
			 	function filterCategory(filterType,filterVal) {
				 		//reset product section
				 		$('#productsContainer').html('');
				 		$('#hiddenProductsContainer').html('');
				 		START_COUNT_PRODUCTS = 0;
				 		filter = filterType;
				 		filterValue = filterVal;
				 		loadCategoryProducts();
			 	}
			 	
			 	function buildProductsList(productList, divProductsContainer) {
			 		log('Products-> ' + productList.rows.length);
					var productsTemplate = Hogan.compile(document.getElementById("productBoxTemplate").innerHTML);
					var productsRendred = productsTemplate.render(productList);
					$('#productsContainer').append(productsRendred);
					$('#hiddenProductsContainer').append(productsRendred);
					initBindings();
			 	}
			 
				function callBackLoadProducts(productList) {
						totalCount = productList.productCount;
						START_COUNT_PRODUCTS = START_COUNT_PRODUCTS + MAX_PRODUCTS;
						if(START_COUNT_PRODUCTS < totalCount && START_COUNT_PRODUCTS <= productList.productCount) {
								$("#button_nav").show();
						} else {
								$("#button_nav").hide();
						}
						hideSMLoading('#productsContainer');
						visualize();
						
						var productQty = productList.productCount + ' 找不到商品';
						$('#products-qty').html(productQty);
			
			
				}
		</script>	
		<jsp:include page="/pages/shop/templates/generic/sections/footer.jsp" />
		<jsp:include page="/pages/shop/templates/generic/sections/jsLinks.jsp" />

 	</body>

</html> 
 





