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


<title>餐饮管理系统</title>
<link rel="stylesheet" type="text/css" href="${ctx}/css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/css/ext/desktop.css" />
<script type="text/javascript" src="${ctx}/js/ext/ext-base.js"></script>
<script type="text/javascript" src="${ctx}/js/ext/ext-all.js"></script>

<script>
Ext.onReady(function(){
	var root=new Ext.tree.TreeNode({
		id:"root",
		text:"树的根"});
		root.appendChild(new Ext.tree.TreeNode({
		id:"c1",
		text:"子节点"
		}));
		var tree=new Ext.tree.TreePanel({
		renderTo:"hello",
		root:root,
		width:100
		});
	
	
	
	
	var i=0,mygroup;
	function newWin(){
		var win=new Ext.Window({title:"窗口"+i++,width:400,height:300,maximizable:true,manager:mygroup});win.show();
	}
	function toBack(){
		mygroup.sendToBack(mygroup.getActive());
	}
	function hideAll(){
		mygroup.hideAll();
	}
	
	mygroup = new Ext.WindowGroup();
	Ext.get("btn2").on("click",newWin);
	Ext.get("btnToBack").on("click",toBack);
	Ext.get("btnHide").on("click",hideAll);

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
/* 	
	new Ext.Viewport({
		enableTabScroll:true,
		layout:"border",
		items:[{title:"面板",
			region:"north",
			height:500,
			html:"<h1>网站后台管理系统!</h1>"
			},
		
			{title:"菜单", region:"west",width:200,collapsible:true,html:"菜单栏"},
			{xtype:"tabpanel",region:"center",
		items:[{title:"面板1"},{title:"面板2"}]}
		]
		}); */
	
	
	
	
	});

</script>
</head>
<body>


<input id="btn" type="button" value="alert框" />
<input id="btn2" type="button" name="add" value="新窗口" />
<input id="btnToBack" type="button" name="add" value="放到后台" />
<input id="btnHide" type="button" name="add" value="隐藏所有" />
<div id="hello">&nbsp;</div>
</body>
</html>