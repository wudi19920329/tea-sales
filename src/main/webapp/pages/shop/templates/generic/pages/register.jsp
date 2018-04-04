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
<html xmlns="http://www.w3.org/1999/xhtml"> 
     <head>
       	 	<meta charset="utf-8">
       	 	<meta http-equiv="x-ua-compatible" content="ie=edge">
   			<title>Tea shop</title>
   			<meta name="viewport" content="width=device-width, initial-scale=1.0">
   			<meta name="description" content="茶叶店铺">
   			<meta name="author" content="牛占元">
			<link href="<c:url value="/resources/citydata/css/city-picker.css" />" rel="stylesheet">
			<!-- include all header js and css -->
            <jsp:include page="/pages/shop/templates/generic/sections/shopLinks.jsp" />
			<script type="text/javascript" src="<c:url value="/resources/js/jQuery.validate.js" />"></script>
			<script type="text/javascript" src="<c:url value="/resources/citydata/js/city-picker.data.js" />"></script>
			<script type="text/javascript" src="<c:url value="/resources/citydata/js/city-picker.js" />"></script>    
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
 
 		
			

			
			
			<!-- page-title-wrapper-end -->
			<!-- contuct-form-area-start -->
			<div class="login-area ptb-80">
				<div class="container">
					<div class="row">
						<div class=" col-lg-6 col-md-6 col-sm-8  col-xs-12">
							<div class="login-title">
								<h3>个人信息</h3>
							</div>
							<div class="login-form">
								<form method="post" action="#" id="registrationForm"
									class="form-signin required-validate">
									<div class="form-group login-page">
										<label for="realName">昵称 <span>*</span></label> <input
											name="nickName" id="nickName"
											class="span8 required form-control form-control-md" />
									</div>
									
									<div class="form-group login-page">
										<label for="realName">姓名 <span>*</span></label> <input
											name="realName" id="realName"
											class="span8 required form-control form-control-md" />
									</div>
									<div class="form-group login-page">
										<label for="phone">手机号 <span>*</span></label> <input name="phone"
											id="phone" class="span8 required form-control form-control-md" />
									</div>
			
									<!-- 城市信息start -->
									<div class="form-group login-page">
										<label for="address">居住地址 <span>*</span></label>
										<div style="position: relative;">
											<input id="address" name="address" class="form-control" 
												type="text" data-toggle="city-picker">
										</div><!-- readonly -->
									</div>
									<div class="form-group">
										<button class="btn btn-warning" id="reset" type="button">重置</button>
										<button class="btn btn-danger" id="destroy" type="button">确定</button>
									</div>
									<!-- 城市信息end -->
									
									<div class="form-group login-page">
										<label for="postcode">邮编 <span>*</span></label> <input name="postcode"
											id="postcode" class="span8 required form-control form-control-md" />
									</div>
			
									<div class="login-title">
										<h3>登陆信息</h3>
									</div>
									<div class="form-group login-page">
										<label for="email">邮箱地址 <span>*</span></label> <input
											name="email" id="email"
											class="span8 required email form-control form-control-md" />
									</div>
									<div class="form-group login-page">
										<label for="password">密码<span>*</span></label> <input
											type="password" name="password" id="password"
											class="span8 required password form-control form-control-md" />
									</div>
									<div class="form-group login-page">
										<label for="confirmPassword">确认密码<span>*</span></label> <input
											type="password" name="confirmPassword" id="confirmPassword"
											class="span8 required checkPassword form-control form-control-md" />
									</div>
									<button type="button" id="subBtn"
										class="btn btn-default login-btn">创建账户</button>
									<input name="method" type="hidden" id="method" value="register"/>	
								</form>
							</div>
						</div>
						<div class="col-lg-6 col-md-6 col-sm-4 hidden-xs">
							<h3 class="short_headline">
								<span>为什么注册</span>
							</h3>
							<p>简化结算流程通过你的信息,再订购一个项目从一个产品链接</p>
			
						</div>
					</div>
				</div>
			</div>
			<!-- contuct-form-area-end -->
 			
 		<script type="text/javascript">
			$(document).ready(function() {
				//城市信息
			    var $citypicker3 = $('#address');
			    $('#reset').click(function () {
			        $citypicker3.citypicker('reset');
			    });
			    $('#destroy').click(function () {
			        $citypicker3.citypicker('destroy');
			        $("#address").blur().attr("readonly",true);
			    });
			
				
				
				// 手机号码验证
			    jQuery.validator.addMethod("isPhone", function(value, element) {
			        var length = value.length;
			        return this.optional(element) || (length == 11 && /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/.test(value));
			    }, "请正确填写您的手机号码。");
				//邮箱
				jQuery.validator.addMethod("isEmail",function(value,element,params){  
			        var isEmail = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;  
			        return this.optional(element)||(isEmail.test(value));  
			    },"*请输入正确的邮箱。");  
			 
			 	// 匹配邮编
			    jQuery.validator.addMethod("isPostcode", function(value, element) {
			        var str = value;
			        return this.optional(element) || /^\d{6}$/.test(str);
			    }, "邮编为6位数字。");	
				
			    
				
			   var validate = $("#registrationForm").validate({
			        errorElement : 'span',
			        errorClass : 'help-block',
			        rules : {
			        	nickName :{
			        		required:true
			        	},
			        	realName :{
			        		required:true
			        	},
			        	phone :{
			        		required:true,
			        		isPhone:true
			        	},
			        	email : {
			                required : true,
			                isEmail:"*请输入正确的邮箱。", 
			            },
			            postcode : {
			                required : true,
			                isPostcode:"*请输入正确的邮编。", 
			            },
			            password : {
			                required : true,
			                minlength : 6
			            },
			            confirmPassword : {
			                required : true,
			                isPwd : true,
			                equalTo : "#password"
			            } 
			        },
			        messages : {
			        	nickName : {
			        		required:"请输入昵称。"
			        	},
			        	realName : {
			        		required:"请输入姓名。"
			        	},
			        	phone : {
			        		required:"请输入手机号。"
			        	},
			            email : {
			                required : "请输入Email地址。",
			                email:"*请输入正确的邮箱。"
			            },
			            postcode : {
			                required : "请输入邮编。",
			                postcode:"*请输入正确的邮编。"
			            },
			            password : {
			                required : "请输入密码。",
			                minlength : "密码不能小于6个字符。"
			            },
			            confirmPassword : {
			                required : "请输入确认密码。",
			                minlength : "确认密码不能小于5个字符。",
			                equalTo : "两次输入密码不一致不一致。"
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
		 					nickName:$("#nickName").val(),
					   		realName:$("#realName").val(),
					   		address:$("#address").val(),
					   		phone:$("#phone").val(),
					   		postcode:$("#postcode").val(),
					   		email:$("#email").val(),
					   		password:$("#password").val(),
					   		confirmPassword:$("#confirmPassword").val(),
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
				
			});
		</script>

		<jsp:include page="/pages/shop/templates/generic/sections/footer.jsp" />
		<jsp:include page="/pages/shop/templates/generic/sections/jsLinks.jsp" />

 	</body>
</html>







