
 

	$(function(){
		initBindings();
		initMiniCart();

	});
	
	function initMiniCart() {
			//display empty cart
			/*var emptyCart = emptyCartObject();
			miniCartSummary(emptyCart);//mini cart summary empty
			fullCart(emptyCart);//mini cart empty dropdown
			return;*/
		miniCart();
		
		
	}

	
	function initBindings() {
		/** add to cart **/
		$(".addToCart").click(function(){
			addToCart($(this).attr("productId"));
	    });
	}
	
	/**
	 * Function used for adding a product to the Shopping Cart
	 */
	function addToCart(sku) {
		showSMLoading('#pageContainer');
		var qty = '#qty-productId-'+ sku;
		var quantity = $(qty).val();
		if(!quantity || quantity==null || quantity==0) {
			quantity = 1;
		}

		var formId = '#input-' + sku;
		//var $inputs = $(formId); 
		var $inputs = $(formId).find(':input');
		
		var values = new Array();
		if($inputs.length>0) {//check for attributes
			i = 0;
			$inputs.each(function() { //attributes
				if($(this).hasClass('attribute')) {
				    //if($(this).hasClass('required') && !$(this).is(':checked')) {
					//   		$(this).parent().css('border', '1px solid red'); 
				    //}
			        if($(this).is(':checkbox')) {
			        	var checkboxSelected = $(this).is(':checked');
			        	if(checkboxSelected==true) {
							values[i] = $(this).val();
							//console.log('checkbox ' + values[i]);
							i++;
						}
			        	
					} else if ($(this).is(':radio')) {
						var radioChecked = $(this).is(':checked');
						if(radioChecked==true) {
							values[i] = $(this).val(); 
							//console.log('radio ' + values[i]);
							i++;
						}
					} else {
					   if($(this).val()) {
					       values[i] = $(this).val(); 
					       //console.log('select ' + values[i]);
					       i++;
				       }
					}
				}
			});
		}
		
		/**
		 * shopping cart code identifier is <cart>_<storeId>
		 * need to check if the cookie is for the appropriate store
		 */
		//cart item
		var prefix = "{";
		var suffix = "}";
		var shoppingCartItem = '';
		var shoppingCartItem = shoppingCartItem + '"quantity":' + quantity + ',';
		var shoppingCartItem = shoppingCartItem + '"productId":' + sku;
		
		var attributes = null;
		//cart attributes
		if(values.length>0) {
			attributes = '[';
			for (var i = 0; i < values.length; i++) {
				var shoppingAttribute= prefix + '"attributeId":' + values[i] + suffix ;
				if(values.length>1 && i < values.length-1){
					shoppingAttribute = shoppingAttribute + ',';
				}
				attributes = attributes + shoppingAttribute;
			}
			attributes = attributes + ']';
		}
		
		if(attributes!=null) {
			shoppingCartItem = shoppingCartItem + ',"shoppingCartAttributes":' + attributes;
		}
		var scItem = prefix + shoppingCartItem + suffix;

		/** debug add to cart **/
		scItem = JSON.parse(scItem);
		scItem.method = "addShoppingCartItem";
		
		$.ajax({  
			 type: 'POST',  
			 url:  '/shoppingCart',  
			 data: scItem, 
			 dataType: 'json', 
			 cache:false,
			 error: function(jqXHR, textStatus, errorThrown) { 
				hideSMLoading('#pageContainer');
				alert(jqXHR.responseJSON.message);
			 },
			 success: function(cart) {
			     cleanupMiniCart();
			     miniCartSummary(cart);
			     fullCart(cart);
				 hideSMLoading('#pageContainer');
			 } 
		});
		
	}
	
function removeLineItem(lineItemId){
	$( "#shoppingCartRemoveLineitem_"+lineItemId).submit();		
}

//update full cart
function updateCart(cartDiv) {
	$('.alert-error').hide();
	$('.quantity').removeClass('required');
	//$('#mainCartTable').showLoading();
	hideSMLoading('#mainCartTable');
	var inputs = $(cartDiv).find('.quantity');
	if(inputs !=null) {
		var items = new Array();
		for(var i = 0; i< inputs.length; i++) {
			var item = new Object();
			var qty = inputs[i].value;
			if(qty =='' || qty<1) {
				$('#' + inputs[i].id).addClass('required');
				$('#mainCartTable').hideLoading();
				return;
			}
			var id = inputs[i].id;
			item.id = id;
			item.quantity = qty;
			items[i] = item;
		}
		//update cart
		json_data = JSON.stringify(items);
		var params = {
			method : "updateShoppingCartItem",
			items:json_data
				
		}
		 
		$.ajax({  
			 type: 'POST',  
			 url: '/shoppingCart',
			 data: params,
			 dataType: 'json', 
			 cache:false,
			 error: function(e) { 
				 console.log('error ' + e);
				 //$('#mainCartTable').hideLoading();
				 hideSMLoading('#mainCartTable');
			 },
			 success: function(response) {
				 //$('#mainCartTable').hideLoading();
				 hideSMLoading('#mainCartTable');
				 location.href='/shoppingCart?method=displayShoppingCart';
			} 
		});
		
	}	
}

function miniCart(){
	log('Display cart content');

	$.ajax({  
		 type: 'GET',  
		 url:  '/shoppingCart?method=displayMiniCart',  
		 cache:false,
		 error: function(jqXHR, textStatus, errorThrown) { 
			//console.log(jqXHR.responseJSON.message);
			//window.location.href = "/pages/shop/templates/generic/pages/logon.jsp";
		 },
		 success: function(miniCart) {
		    cleanupMiniCart();
		 	miniCartSummary(miniCart);
		 	fullCart(miniCart);
		} 
	});
}



 /**
  * JS function responsible for removing give line item from
  * the Cart.
  * For more details see MiniCartController.
  * 
  * Controller will return JSON as response and it will be parsed to update
  * mini-cart section.
  * @param lineItemId
  */
function removeItemFromMinicart(lineItemId){
	log('Removing ' + lineItemId);
	$.ajax({  
		 type: 'GET',
		 cache:false,
		 url: getContextPath() + '/shoppingCart?method=removeMiniShoppingCartItem&&lineItemId='+lineItemId,  
		 error: function(e) { 
			 console.log('error ' + e);
		 },
		 success: function(miniCart) {
		    log('Success remove item ' + miniCart);
		 	miniCartSummary(miniCart);
		    fullCart(miniCart);
		} 
	});
}

function removeItemFromCart(lineItemId){
	log('Removing ' + lineItemId);
	$.ajax({  
		 type: 'GET',
		 cache:false,
		 url: getContextPath() + '/shoppingCart?method=removeMiniShoppingCartItem&&lineItemId='+lineItemId,  
		 error: function(e) { 
			 console.log('error ' + e);
		 },
		 success: function(miniCart) {
			 hideSMLoading('#mainCartTable');
			 location.href='/shoppingCart?method=displayShoppingCart';
		} 
	});
}

function cleanupMiniCart() {
	 $('#miniCartDetails').html('');
}

function miniCartSummary(cart) {
	var miniCartSummaryTemplate = Hogan.compile(document.getElementById("miniCartSummaryTemplate").innerHTML);
    var miniCartSummaryRendered = miniCartSummaryTemplate.render(cart);
    $('#miniCartSummary').html(miniCartSummaryRendered);
		
}

function fullCart(cart) {
    var miniCartTemplate = Hogan.compile(document.getElementById("miniCartTemplate").innerHTML);
    var miniCartRendered = miniCartTemplate.render(cart);
    //log(miniCartRendered);
    $('#miniCartDetails').html(miniCartRendered);
}



function emptyCartObject() {
	var miniCart = new Object();
	return miniCart
}



