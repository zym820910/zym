<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<!--<link href="../css/main.css" rel="stylesheet" type="text/css">-->

<!--<script src="../js/tabbed_pages.js" type="text/javascript"></script>-->
<!--<script src="../js/table_color.js" type="text/javascript"></script>-->
<script type="text/javascript" src="../js/ui.core.js"></script>

<script language="JavaScript" type="text/JavaScript">
</script>
</head>

<body >

<s:hidden name="tsUser.id" id="id"></s:hidden>
<div class="right" style="width: 92%;">
	 	<h1><s:text name="system.user.detaile"/></h1>  
	   <div class="table">
	    <s:hidden name="id" id="id"></s:hidden>
		   <table width="100%"  border="0" cellspacing="0" cellpadding="0">
				<tr>
				    <td class="arrow"><s:text name='system.user.username'/></td>
				    <td><s:label name="ttsUser.username" /></td>
				    <td></td>
				    <td></td> 
				</tr>
				<tr>		
				    <td class="arrow"><s:text name='system.role.enable'/></td>
				   	<td><s:checkbox name="ttsUser.enabled" disabled="true"/></td>      
				    <td class="arrow"><s:text name='system.role.editable'/></td>
				   	<td><s:checkbox name="ttsUser.editable" disabled="true" /></td>      
			     </tr>
			     <tr>		
				    <td class="arrow"><s:text name='system.user.relateroles'/></td>
				   	<td><s:label name="roleName" /></td>      
				    <td></td>
				   	<td></td>      
			     </tr>			 
		   </table> 	 
		  <input name="Submit" type="button" onclick="javascript:window.location='user_list.action'" class="button2_max" value="<s:text name='user.outeruser.back'/>" />
	  </div>  
<!--	  <div class="line"></div>-->
<!--	  <div id="tabs">-->
<!--	  	<ul>-->
<!--			<li><a href="user_role_list.action?page=${page}&tab=0&id=<s:property value='tsUser.id'/>&ajax=true"><s:text name="system.user.relateroles"/></a></li>	-->
<!--			<li><a href="creat_tree_for_user.action?tab=1&id=<s:property value='tsUser.id'/>&sign=inneruser&ajax=true"><s:text name="system.user.resources"/></a></li>			-->
<!--		</ul>	-->
<!--	 </div>-->
  </div>

</body>
</html>
