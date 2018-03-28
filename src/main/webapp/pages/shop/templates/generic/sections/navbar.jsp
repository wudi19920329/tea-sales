
<%
	response.setCharacterEncoding("UTF-8");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", -1);
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="req" value="${request}" />
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<script type="text/javascript">
//***** Search code *****
$(document).ready(function() { 
/* 
    //post search form
   $(".searchButton").click(function(e){
			var searchQuery = $('#searchField').val();
			var q = searchQuery;
			if(q==null || q =='') {
				return;
			}
			$('#hiddenQuery').val(q);
			//log('Search string : ' + searchQuery);
			var uri = '<c:url value="/shop/search/search.html"/>?q=' + q;
            var res = encodeURI(uri);
			e.preventDefault();//action url will be overriden
	        $('#hiddenSearchForm').attr('action',res).submit();
   });

   
   
	
   var searchElements = new Bloodhound({
		datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
		queryTokenizer: Bloodhound.tokenizers.whitespace,
		prefetch: '<c:out value="${requestScope.CONFIGS['defaultSearchConfigPath'][requestScope.LANGUAGE.code]}"/>',
	    remote: {
    		url: '<c:url value="/services/public/search/${requestScope.MERCHANT_STORE.code}/${requestScope.LANGUAGE.code}/autocomplete.json"/>?q=%QUERY',
        	filter: function (parsedResponse) {
            	// parsedResponse is the array returned from your backend
            	console.log(parsedResponse);

            	// do whatever processing you need here
            	return JSON.parse(parsedResponse);
        	}
    	}
	});
   
   searchElements.initialize();


	var searchTemplate =  Hogan.compile([
				     '<p class="suggestion-text"><font color="black">{{value}}</font></p>'
	             ].join(''));
	
	
    //full view search
	$('#searchField.typeahead').typeahead({
	    hint: true,
	    highlight: true,
	    minLength: 1
	}, {
		name: 'shopizer-search',
	    displayKey: 'value',
	    source: searchElements.ttAdapter(),
	    templates: {
	    	suggestion: function (data) { return searchTemplate.render(data); }
	    }
	});
    
    //responsive
	$('#responsiveSearchField.typeahead').typeahead({
	    hint: true,
	    highlight: true,
	    minLength: 1
	}, {
		name: 'modal-shopizer-search',
	    displayKey: 'value',
	    source: searchElements.ttAdapter(),
	    templates: {
	    	suggestion: function (data) { return searchTemplate.render(data); }
	    }
	}); */

});

</script>


<!-- mainmenu-area-start -->
<div class="mainmenu-area bg-color-1" id="main_h">
	<div class="container">
		<div class="row">
			<div class="col-lg-12 col-md-12 col-sm-12 hidden-xs">
				<div class="mainmenu hidden-xs">
					<nav>
						<ul>
							<c:set var="categorys" value="<%=com.tea.enums.Category.values()%>"/>
							<c:forEach var="category" items="${categorys}">
							    <li style="width:100px"><a href="/pages/shop/templates/generic/pages/category.jsp"><c:out
											value="${category.getDescription()}" /></a></li>
							</c:forEach>
							
							
						</ul>
					</nav>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- mainmenu-area-end -->
