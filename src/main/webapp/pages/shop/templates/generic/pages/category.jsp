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
				{{#goods}}
                        <div itemscope itemtype="http://schema.org/Enumeration" class="col-md-COLUMN-SIZE col-sm-6 col-xs-12 product"  item-name="{{name}}" item-price="{{price}}" data-id="{{id}}">
								<div class="thumbnail product-img">
                                    {{#image}}
									<a href="<c:url value="/shop/product/" />{{description.friendlyUrl}}.html">
										<img src="{{image}}" alt="" />
									</a>
									{{/image}}
								</div>
								<div class="product-content text-center">
									<a class="listing-product-name" href="<c:url value="/shop/product/" />{{description.friendlyUrl}}.html"><h3 itemprop="name">{{name}}</h3></a>
									<h4>
										{{#discounted}}<del>{{priceStr}}</del>&nbsp;<span itemprop="price" class="specialPrice">{{discountPriceStr}}</span>{{/discounted}}
										{{^discounted}}<span itemprop="price">{{priceStr}}</span>{{/discounted}}
									</h4>
									<div class="store-btn">
      									<div class="store-btn-addtocart"><a class="addToCart" href="javascript:void(0)" productId="{{id}}">添加到购物车</a></div>
   									</div>
								</div>
						</div>
				{{/goods}}
    		</script>            
                
 	</head> 

	<body>
 	    <!--[if lt IE 8]>
            <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->
		
		<jsp:include page="/pages/shop/templates/generic/sections/header.jsp" />
		<jsp:include page="/pages/shop/templates/generic/sections/navbar.jsp" />
		
		<div id="mainContent" class="container">
			
					  <header class="page-header row">
					  <c:if test="${category.description.name!=null}">
					  <div class="fixed-image section dark-translucent-bg parallax-bg-3">
							<div class="container">
							<h2 class="shop-banner-title lead"><c:out value="${category.description.name}"/></h2>
							</div>
					  </div>
					  </c:if>
					  <jsp:include page="breadcrumb.jsp" />
					  </header>
		
					  
					  <c:if test="${category.description.description!=null}">
					  <div class="container">
					  	<p><c:out value="${category.description.description}" escapeXml="false"/></p>
					  </div>
					  </c:if>
					  
		
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
		              					<a href="<c:url value="/shop/category/${subCategory.description.friendlyUrl}.html"/>"><i class="fa fa-angle-right"></i> <c:out value="${subCategory.description.name}" />
		              						<c:if test="${subCategory.productCount>0}">&nbsp;<span class="countItems">(<c:out value="${subCategory.productCount}" />)</span></c:if></a>
		              					</li>
		              					</c:if>
		              				</c:forEach>
									</ul>
									<br/>
									<c:if test="${fn:length(manufacturers) > 0}">
							          	<h3>制造商列表</h3>
							            <ul class="nav nav-list">
							              <li class="nav-header"></li>
							              <c:forEach items="${manufacturers}" var="manufacturer">
							              	<li>
							              		<a href="javascript:filterCategory('BRAND','${manufacturer.id}')"><i class="fa fa-angle-right"></i>&nbsp;<c:out value="${manufacturer.description.name}" /></a></li>
							              </c:forEach>
							            </ul>
							          </div>          
		          					</c:if>
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
			 		var url = '<%=request.getContextPath()%>/services/public/products/page/' + START_COUNT_PRODUCTS + '/' + MAX_PRODUCTS + '/<c:out value="${requestScope.MERCHANT_STORE.code}"/>/<c:out value="${requestScope.LANGUAGE.code}"/>/<c:out value="${category.description.friendlyUrl}"/>';
				 	
			 		if(filter!=null) {
			 			url = url + '/filter=' + filter + '/filter-value=' + filterValue +'';
			 		}
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
			 		log('Products-> ' + productList.products.length);
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
 




