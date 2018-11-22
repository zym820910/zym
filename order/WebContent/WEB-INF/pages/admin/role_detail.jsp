<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://struts-menu.sf.net/tag-el" prefix="menu"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator"
	prefix="decorator"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>

<!--<link href="../css/main.css" rel="stylesheet" type="text/css">-->

<!--<script src="../js/tabbed_pages.js" type="text/javascript"></script>-->
<script src="../js/table_color.js" type="text/javascript"></script>

<link type="text/css" href="../css/ui.all.css" rel="stylesheet" />
<script type="text/javascript" src="../tree/js/jquery.js"></script>
<script type="text/javascript" src="../tree/js/jquery.tree.js"></script>
<script type="text/javascript" src="../tree/js/jquery.tree.checkbox.js"></script>
<script type="text/javascript" src="../js/ui.core.js"></script>
<script type="text/javascript" src="../js/ui.tabs.js"></script>
<script type="text/javascript" src="../js/selectCheckBox.js"></script>
<link type="text/css" href="../css/demos.css" rel="stylesheet" />

<script language="JavaScript" type="text/JavaScript">
$(function() {
	$("#demo_1").tree({
		ui : {
			theme_name : "checkbox"
		},
		plugins : { 
			checkbox : { }
		}
	});});

function checkedTree()
{
	var t = $.tree.focused();
	var obj = t.container.find("a.checked").parent();

	var obj1 = t.container.find("a.undetermined").parent();
	
	var id = document.getElementById("id").value;
	var idsString="";
	
		for(var i=0;i<obj.length;i++)
		{
			idsString=idsString+obj[i].id+",";
		}

		for(var i=0;i<obj1.length;i++)
		{
			idsString=idsString+obj1[i].id+",";
		}
		
		$("#ids").val(idsString);
		$("#id").val(id);
		$("#frm").attr("action","role_resource_relate.action");
		$("#frm").submit();
}
// 多选框开始
function jqSelectAll( id )
{
   $( "#idTable" + " :checkbox").attr('checked', $('#' + id).is(':checked'));
}
function check_hidden1(){
	if(confirm('确认删除吗?')){
		bindCheck('selectedArrays','selectedArray');
		var selectedArray = $("#selectedArray").val();
		if(selectedArray==""){
			document.getElementById("chkHidden").innerHTML = "<font color='red'><s:text name='user.interior.select.one.item'/></font>";
		}else if(selectedArray.length > 0){
				window.location = "user_delete_by_role.action?selectedArray="+$("#selectedArray").val();
		}
	}
}
</script>
</head>

<body>
<s:hidden name="id" id="id"></s:hidden>
<s:hidden name="tsSysRole.id"></s:hidden>
<div class="right" style="width: 92%;">
<h1><s:text name="system.role.detaile" /></h1>
<div class="table">
<table width="100%" border="0" cellspacing="0" cellpadding="0">

	<tr>
		<td width="100" class="arrow"><s:text name="system.role.nameZh" /></td>
		<td><s:textfield name="tsSysRole.nameZh" /></td>
	</tr>
	<tr>
		<td class="arrow"><s:text name='system.role.description' /></td>
		<td><s:textfield name="tsSysRole.description" /></td>
	</tr>
	<tr>
		<td class="arrow"><s:text name='system.role.editable' /></td>
		<td><s:checkbox name="tsSysRole.editable" theme="simple" /></td>

	</tr>
</table>
<div class="line"></div>
<form action="role_detail.action?id=<s:property value='tsSysRole.id'/>" id="frm">
	<s:hidden name="id" id="id"></s:hidden> 
	<s:hidden name="ids" id="ids"></s:hidden>
<s:hidden name="selectedArray" id="selectedArray" />
<div class="right">
<h1><a
	href="role_detail.action?id=<s:property value='tsSysRole.id'/>"> <s:text
	name="system.resource.tree" />:</a></h1>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td colspan="2">
		<div class="right" id="demo_1">${treeStr}</div>
		</td>
	</tr>
</table>
<div class="line"></div>
    <display:table name="tsSysRole.tsUsers" class="list" style="width:100%" cellpadding="1" cellspacing="0" uid="aa" id="row" htmlId="idTable"	requestURI="">
	<display:column title="<input type='checkbox' id='selectAll' onclick='jqSelectAll(this.id);'/>" headerClass="tit" style="width:10%;" >
		<input type="checkbox" name="selectedArrays" value="${row.id}" ></input>
	</display:column>	
    <display:column property="username" titleKey="system.user.username"  headerClass="tit"
    	href="user_detai_by_role.action?roleid=${id}" paramId="id" paramProperty="id" />
    </display:table>  
      <div class="number">
     </div>
         <input name="Submit" type="button" class="button2_max" onClick="check_hidden1()" value="<s:text name='system.user.deleteBtn'/>" />
         <input name="Submit" type="button" onclick="javascript:window.location='role_list.action'" class="button2_max" value="<s:text name='user.outeruser.back'/>" />
   </div>
</form>
</div>
<div id="chkHidden"></div>
<div class="demo-description"></div>

</div>
</body>
</html>
