<%@ page language="java" errorPage="/common/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>餐饮管理系统</title>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="cache-control" content="no-cache"/>
<meta http-equiv="expires" content="0"/>

<link rel="stylesheet" type="text/css" href="${ctx}/css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/css/ext/desktop.css" />
<script type="text/javascript" src="${ctx}/js/ext/ext-base.js"></script>
<script type="text/javascript" src="${ctx}/js/ext/ext-all.js"></script>
<!-- DESKTOP -->
<script type="text/javascript" src="${ctx}/js/ext/StartMenu.js"></script>
<script type="text/javascript" src="${ctx}/js/ext/TaskBar.js"></script>
<script type="text/javascript" src="${ctx}/js/ext/Desktop.js"></script>
<script type="text/javascript" src="${ctx}/js/ext/App.js"></script>
<script type="text/javascript" src="${ctx}/js/ext/Module.js"></script>
<script type="text/javascript" src="${ctx}/js/ext/sample.js"></script>
    
</head>
<body scroll="no">

<div id="x-desktop">
    <!-- <a href="http://menhu.com" target="_blank" style="margin:5px; float:right;"><img src="${ctx}/images/ext/powered.gif" /></a> -->

    <dl id="x-shortcuts">
        <dt id="grid-win-shortcut">
            <a href="#"><img src="${ctx}/images/ext/s.gif" />
            <div>表格</div></a>
        </dt>
        <dt id="acc-win-shortcut">
            <a href="#"><img src="${ctx}/images/ext/s.gif" />
            <div>聊天</div></a>
        </dt>
    </dl>
</div>

<div id="ux-taskbar">
	<div id="ux-taskbar-start"></div>
	<div id="ux-taskbuttons-panel"></div>
	<div class="x-clear"></div>
</div>

</body>
</html>
