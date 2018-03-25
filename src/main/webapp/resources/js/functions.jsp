<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page session="false"%>

<script>

function getContextPath() {
   return "${pageContext.request.contextPath}";
}

function getMerchantStore() {
   return "${requestScope.MERCHANT_STORE.id}";
}

function getMerchantStoreCode() {
   return "${requestScope.MERCHANT_STORE.code}";
}

function getLanguageCode() {
   return "${requestScope.LANGUAGE.code}";
}

function supportsCustomerLogin() {
	return true;
}

function getItemLabel(quantity) {
	var labelItem = '商品';
	if (quantity > 1) {
		labelItem = '商品列表';
	}
	return labelItem;
}

//assign rating on a list of products
function setProductRating(productList) {
	jQuery.each( productList, function( i, val ) {
		var pId = '#productRating_' + val.id; 
	    $(pId).raty({ 
			readOnly: true,
			half: true,
			path : '<c:url value="/resources/img/stars/"/>',
			score: val.ratingCount
		});
	 });
}

function getLoginErrorLabel() {
	return 'ç»éå¤±è´¥ï¼ç¨æ·åæå¯ç éè¯¯ï¼';
}

function getEmptyCartLabel() {
	return 'æ¨çè´­ç©è½¦æ¯ç©ºçï¼';
}


function getInvalidEmailMessage() {
	return 'æ æé®ç®±å°å';
}

function getInvalidUserNameMessage() {
	return 'ç¨æ·åé¿åº¦æå°å¿é¡»6ä½';
}


function getInvalidPasswordMessage() {
	return 'å¯ç é¿åº¦æå°å¿é¡»6ä½"/>';
}

function getInvalidCheckPasswordMessage() {
	return 'ä¸¤æ¬¡è¾å¥çå¯ç ä¸ä¸è´';
}

function cartInfoLabel(cart){
	 var labelItem = getItemLabel(cart.quantity);
	 //A configuration is required to display quantity and price 
	 <c:choose>
	 <c:when test="${requestScope.CONFIGS['displayFullMiniCartInfo'] == true}">
	 $("#cartinfo").html('<span id="cartqty">(' + cart.quantity + ' ' + labelItem + ')</span>&nbsp;<span id="cartprice">' + cart.total + '</span>');
	 </c:when>
	 <c:otherwise>
	 $("#cartinfo").html('<span id="cartqty">(' + cart.quantity + ' ' + labelItem + ')</span>');
	 </c:otherwise>
	 </c:choose>
}

function cartSubTotal(cart) {
	return '<div class="pull-right"><font class="total-box-label">å±è®¡: <font class="total-box-price"><strong><span id="checkout-total">' + cart.subTotal + '</span></strong></font></font></div>';
}


function getOrderValidationMessage(messageKey) {
	
	//stripe messages
	var invalid_number 	= '<s:message code="messages.error.creditcard.number" text="invalid_number"/>';
	var error_creditcard 	= '<s:message code="messages.error.creditcard" text="messages.error.creditcard"/>';
	var invalid_expiry_month = '<s:message code="messages.error.creditcard.dateformat" text="invalid_expiry_month"/>';
	var invalid_expiry_year = '<s:message code="messages.error.creditcard.dateformat" text="invalid_expiry_year"/>';
	var invalid_cvc 	= '<s:message code="messages.error.creditcard.cvc" text="invalid_cvc"/>';
	var incorrect_number = '<s:message code="messages.error.creditcard.number" text="invalid_expiry_month"/>';
	var expired_card 	= '<s:message code="message.payment.declined" text="expired_card"/>';
	var incorrect_cvc 	= '<s:message code="messages.error.creditcard.cvc" text="incorrect_cvc"/>';
	var card_declined 	= '<s:message code="message.payment.declined" text="card_declined"/>';
	var processing_error = '<s:message code="message.payment.error" text="processing_error"/>';
	var rate_limit = '<s:message code="message.payment.error" text="rate_limit"/>';
	
	var map = new Object(); // or var map = {};
	map['invalid_number'] = invalid_number;
	map['error_creditcard'] = error_creditcard;
	map['invalid_expiry_month'] = invalid_expiry_month;
	map['invalid_expiry_year'] = invalid_expiry_year;
	map['invalid_cvc'] = invalid_cvc;
	map['incorrect_number'] = incorrect_number;
	map['expired_card'] = expired_card;
	map['incorrect_cvc'] = incorrect_cvc;
	map['card_declined'] = card_declined;
	map['processing_error'] = processing_error;
	map['rate_limit'] = rate_limit;
	
	//log('Got message key ' + messageKey);
	
	var message = map[messageKey];
	
	if(message==null) {
		message = messageKey;
	}
	
	return message;

	
}




</script>