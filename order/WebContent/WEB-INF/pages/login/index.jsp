<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<html>
<head>

<title><s:text name="system.name"/></title>
<script type="text/javascript">
if(parent!=this){ parent.parent.location.href = '${ctx}/main/index.action';}
</script>
<script language="javaScript" src="<c:url value='/'/>js/common/Dialog.js"></script>
</head>
<body>

<div width="100%"  height="100%">
	<iframe src="<s:url value="menu/top.action" includeParams='none'/>" name="header" width="100%" height="185px" scrolling="no" frameborder="0"></iframe>
</div>
<div width="100%"  height="100%">
	<iframe src="<s:url value="menu/main.action" includeParams='none'/>" name="mainFrame"  width="100%" height="100%" frameborder="0" scrolling="yes" style="overflow:visible;"></iframe>
</div>

</body>
</html>