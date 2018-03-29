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
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta charset="utf-8">
	<meta http-equiv="x-ua-compatible" content="ie=edge">
	<title>Tea shop</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="茶叶店铺">
	<meta name="author" content="牛占元">
	<link href="<c:url value="/resources/css/assets/bootstrap-social.css" />" rel="stylesheet">
	<!-- include all header js and css -->
	<jsp:include page="/pages/shop/templates/generic/sections/shopLinks.jsp" />
	<!-- requires functions.jsp -->
	<script type="text/javascript"
		src="<c:url value="/resources/js/jQuery.validate.js" />"></script>
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


	<div class="login-area ptb-80">
		<div class="container">
			<div class="row">
				<div class=" col-lg-6 col-md-6 col-sm-6 col-xs-12">
					<div class="login-title">
						<h3>已注册用户</h3>
						<span>如果你有一个账户，登陆你的邮箱。</span>
					</div>
					<div id="login-form" class="login-form">
						<form action="#" id="logonForm">
							<div class="form-group login-page">
								<label for="inputEmail">邮箱地址 <span>*</span></label> <input
									type="text" class="form-control" id="email"
									name="email"/>
							</div>
							<div class="form-group login-page">
								<label for="password">密码<span>*</span></label><input type="password" class="form-control" id="password" name="password"/>
							</div>
							<input type="hidden" 
								name="method" id="method"
								value="logon" />
							<button type="button" id="subBtn"
								class="btn btn-default login-btn">登陆</button>
						</form>

					</div>
					<!-- 
							<a href="#" class="back">Forgot Your Password?</a>
							 -->
					<!-- 
							<br/>
							<div class="login-title">
								
								<span><s:message code="label.customer.signin.social" arguments="Facebook" text="Make it easier and sign in with your Facebook account!" /></span>
							</div>

								  <ass="btn btn-block btn-social btn-lg btn-facebook">
    								<span class="fa fa-facebook"></span> <s:message code="label.customer.signin.social.system" arguments="Facebook" text="Sign in with Facebook" />
  								  </a>
  								  -->
				</div>
				<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
					<div class="login-title">
						<h3>新用户</h3>
						<span>创建一个账户有很多好处:查看更快,让多个地址,跟踪订单和更多</span>
					</div>
					<a class="btn btn-default login-btn" href="register.jsp">注册 </a>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/pages/shop/templates/generic/sections/footer.jsp" />
	<jsp:include page="/pages/shop/templates/generic/sections/jsLinks.jsp" />
	<script type="text/javascript">
		$(document).ready(function() {
			//邮箱
			jQuery.validator.addMethod("isEmail",function(value,element,params){  
		        var isEmail = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;  
		        return this.optional(element)||(isEmail.test(value));  
		    },"*请输入正确的邮箱。"); 
			// 匹配密码，以字母开头，长度在6-12之间，必须包含数字和特殊字符。
		    jQuery.validator.addMethod("isPwd", function(value, element) {
		        var str = value;
		        return this.optional(element) || /^\d{6}$/.test(str);
		    }, "6位数字。");	
			var validate = $("#logonForm").validate({
			        errorElement : 'span',
			        errorClass : 'help-block',
			        rules : {
			        	email : {
			                required : true,
			                isEmail:"*请输入正确的邮箱。", 
			            },
			            password : {
			                required : true,
			                isPwd : true
			            }
			        },
			        messages : {
			            email : {
			                required : "请输入Email地址。",
			                email:"*请输入正确的邮箱。"
			            },
			            password : {
			                required : "请输入密码。",
			                minlength : jQuery.format("密码不能小于6个字符。")
			            }
			        },
			        //自定义错误消息放到哪里
			        errorPlacement : function(error, element) {
			            element.removeClass("valid");
			            element.closest('.form-group').append(error);//显示错误消息提示
			        },
			        //给未通过验证的元素进行处理
			        highlight : function(element) {
			            $(element).closest('.form-group').addClass('has-error has-feedback');
			        },
			        //验证通过的处理
			        success : function(label) {
			            label.closest('.form-group').removeClass('has-error').addClass("has-feedback has-success");
			            label.remove();
			        },
			 
			    });
			
			 $("#subBtn").click(function(){
		 		if(validate.form()){
		 			var params = {
					   		email:$("#email").val(),
					   		password:$("#password").val(),
					   		method:$("#method").val()
					   }
				   $.ajax({
					   	data:params,
						type : 'POST',
						dataType : "json",
						url : '/customer',
						success : function(productList) {
							window.location.href = "dashboard.jsp";
						},
						error : function(jqXHR, textStatus, errorThrown) {
							alert(jqXHR.responseJSON.message);
						}
					});
		 		}
		   })
		})
	
	
	</script>
</body>
</html>