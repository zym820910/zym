<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ taglib uri="http://struts-menu.sf.net/tag-el" prefix="menu" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<link href="../../css/main.css" rel="stylesheet" type="text/css">
<link type="text/css" href="../css/ui.all.css" rel="stylesheet" />
<script type="text/javascript" src="../tree/js/jquery.js"></script>
<script type="text/javascript" src="../tree/js/jquery.tree.js"></script>
<script type="text/javascript" src="../tree/js/jquery.tree.checkbox.js"></script>
<script type="text/javascript" src="../js/ui.core.js"></script>

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
			//$("#frm").attr("action","role_resource_relate.action");
			$("#frm").submit();
	}
</script>

</head>

<body >

<div class="right" style="width: 92%;">
<h1><s:text name="system.role.edit"/></h1>

  <div class="table" style="width: 92%">
<s:form action="role_save.action" method="post" theme="simple" id="frm">
	<s:hidden name="id" id="id"></s:hidden> 
	<s:hidden name="ids" id="ids"></s:hidden> 
<table width="92%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="100" class="arrow"><s:text name="system.role.nameZh"/></td>
    <td><s:textfield maxlength="40" name="nameZh" /></td>
	</tr>
	<tr>
	    <td class="arrow"><s:text name='system.role.description'/></td>
	    <td><s:textfield maxlength="50" name="description" /></td>
    </tr>
    <tr>
	    <td class="arrow"><s:text name='system.role.editable'/></td>
	   	<td><s:checkbox name="editable" /></td>
   	
	</tr> 
  </table>
  	<div class="right" style="width: 92%;">
		<h1><s:text name="system.resource.tree" />:</h1>
		<table width="92%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td colspan="2">
				<div class="right" id="demo_1">${treeStr}</div>
				</td>
			</tr>
		</table>
	</div>
    <div class="line"></div>
  	<input type="button" onclick="checkedTree()" class="button2" value="<s:text name='system.user.enterBtn'/>" />
    <input name="Submit" type="button"  onclick="javascript:window.location='role_list.action'" class="button2" value="<s:text name='system.role.cancleBtn'/>" />

</s:form>
  </div>
</div>
</body>
</html>
