<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<%@ include file="/common/meta.jsp"%>
<title><decorator:title /> | <fmt:message key="webapp.name" /></title>
<script language="javascript">
	var mainFrame = parent.frames.mainFrame;
	if (!mainFrame) {
		var hrf = location.href;
		var ctx = "${ctx}";
		var index = hrf.indexOf(ctx);
		var dest = hrf.substring(index+ctx.length);
		if(dest == '/j_logout'){
			self.location.replace("${ctx}/login/login.action");	
		}else{
			self.location.replace("${ctx}/index.action");
		}
	}

	function check_key_code(obj){
		var str = obj.value ;
		var filter_list = ["!" , "@" , "#" , "$" , "%" , "^" , "&" , "*" , "(" , ")"];
		for(index in filter_list){
			if(	str.indexOf(filter_list[index]) > -1 ){
				obj.value = str.substring(0 , str.length - 1) ;
				break ;
			}
		}
	}
	
	function goto_page(e, txtfield){

		var flag = window.event ;
		var k = (flag ? e.keyCode : e.which) ;
		var pageValue = txtfield.value;
		if   ((k < 48 || k > 57 )&& (k != 8 && k != 37 && k!= 38 && k!= 39 && k!= 40) ){   
			if(flag) e.returnValue = false;
			else e.preventDefault();  
		}

		if(k == 13){
			var maxPage = document.getElementById("max_page").value ;
			maxPage = maxPage.replace(/,/g , "");
			pageValue = pageValue.replace(/,/g , "");
		
			if(parseInt(pageValue) == 0) pageValue =1 ;
			else if(parseInt(pageValue) > parseInt(maxPage) ) pageValue = maxPage ;

			var str = document.getElementById("sign").href ;
			var k = str.indexOf("?page=");
			var x = str.indexOf("&page=") ;
			var first = 0 ;
			var str1 ;
			if(k == -1){
				str1 = str.substring(0 , x) ;
			}else{
				str1 = str.substring(0 , k) ;
				x = k ;
				first = 1 ;
			}
			var str2 = str.substring(x + 6);
			var str3 = "" ;
			var y = str2.indexOf("&");
			if(y > -1) str3 = str2.substring(y);
			var z = str.indexOf("')");
			str2 = (first == 0 ? "&" : "?") + "page=" + pageValue ;
			str = str1 + str2 + str3 ;
			if(z > -1 && str3 == "") str += "')" ;
			window.location = str ;
		}
		
	}

	var preLoadHtml = "<font color='red'>运行中...</font>" ;
</script>
<link rel="stylesheet" type="text/css" href="<c:url value = '../css/redmond/jquery-ui-1.7.2.custom.css'/>"/>
<!--<script type="text/javascript" src="<c:url value = '../js/jquery-1.3.2.js'/>"></script>-->
<decorator:head />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/main.css'/>" />
</head>
<body
	<decorator:getProperty property="body.id" writeEntireProperty="true"/>
	<decorator:getProperty property="body.class" writeEntireProperty="true"/>>
<span class="right">
</span>
<%@ include file="/common/messages.jsp"%>  
<decorator:body />
</body>
</html>
