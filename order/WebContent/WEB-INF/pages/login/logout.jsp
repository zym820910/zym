<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>

<head>
    <title><fmt:message key="logout.title"/></title>
    <meta name="heading" content="<fmt:message key='login.heading'/>"/>
    <meta name="menu" content="Login"/>
    <link href="${ctx}/css/main.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
	body {
		background: url(${ctx}/images/login/bg_login.gif) top #72b7fd repeat-x;
	}
	.transportBg{ width:544px; margin:0 auto; }	
	.transportBg {background-image:url(${ctx}/images/login/bg_login1.png)!important;background-image:url();
FILTER: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${ctx}/images/login/bg_login1.png');
WIDTH: 544px;height:466px;}

	.transportBgEn{ width:544px; margin:0 auto; }	
	.transportBgEn {background-image:url(${ctx}/images/login/bg_login1_en.png)!important;background-image:url();
FILTER: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${ctx}/images/login/bg_login1_en.png');
WIDTH: 544px;height:466px;}

-->
</style>
    
<script language="javascript">
	var mainFrame = parent.frames.mainFrame;
	if (mainFrame) {
		var hrf = location.href;
		var ctx = "${pageContext.request.contextPath}";
		var index = hrf.indexOf(ctx);
		var dest = hrf.substring(index+ctx.length);
		parent.location.replace(ctx+"/login/login.action");
	}

	function login(){
		loginForm.submit();
	}

	function login2(){
		if(event.keyCode == 13) login();
	}
</script>
    
</head>


<body id="Logout"/>
<div style="background:url(${ctx}/images/login/logo_volks.gif) top left no-repeat;" align="center">
<s:if test="locale.toString() == 'zh_CN'">
	<div class="transportBg" style="width:544px; margin:0 auto;" >	
</s:if>
<s:if test="locale.toString() == 'en_US'">
	<div class="transportBgEn" style="width:544px; margin:0 auto;" >
</s:if>

<table width="544" height="100%" align="center"  cellpadding="0" cellspacing="0"  >
   <tr>
	  <td align="center" valign="middle">
	   	<div class="loginBox">
         <div class="loginInput" >
		   <table border="0" cellspacing="3" cellpadding="0">
			 <tr>
				<td>您已经成功登出!</td>
		     </tr>
			</table>
			 <div class="copyright">Copyright ©<fmt:message key='system.copyright'/></div>
		  </div>
		  </div>
	  
	  </td>
   </tr>
</table>
</div>	
 </form> 
</body>


