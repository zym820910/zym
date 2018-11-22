<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="itaf.framework.common.UserInfo,itaf.framework.constant.Constants" %>
<html>
<head>

</head>
<!-- <div style="height:100;width:100%;FILTER: progid:DXImageTransform.Microsoft.Gradient(startColorStr=#ffffff endColorStr=#E8E7F7, gradientType=0)"></div> -->

<div id="topbg">
	<div id="topleft"></div>
	<div id="topright">
		<ul>
			<li class="password"><a href="${ctx}/user_info.action" title="修改密码" target="mainFrame">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
			
			<li class="logout"><a href="${ctx}/user_log_out.action" title="退出系统">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>	
		</ul>
	</div>
	
	<div style="top: 10px;left: 20px;background:url(${ctx}/images/common/b2.gif) no-repeat " >
		
	</div>
</div>

<script type="text/javascript">
$("body span").replaceWith("");
</script>
</html>