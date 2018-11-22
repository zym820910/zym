<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<link href="../css/main.css" rel="stylesheet" type="text/css">

<script language="JavaScript" type="text/JavaScript">

</script>
</head>

<BODY  class="mainbg">
<div class="maintop">修改密码</div>

	    <s:hidden name="id" id="id"></s:hidden>
	<div class="box_relative">
	<fieldset style="width: 380px"><legend> <font
	color="#000000" size="-1"><s:text name="system.user.detaile"/></font> </legend>
	<div align="center">
	<table width="360px" border = 0 cellspacing = 0 cellpadding = 0>
				<tr>
				    <td class="arrow"><s:text name='system.user.username'/></td>
				    <td><s:label name="ttsUser.username" /></td>
				    <td></td>
				    <td></td> 
				</tr>
<!--				<tr>		-->
<!--				    <td class="arrow"><s:text name='system.role.enable'/></td>-->
<!--				   	<td><s:checkbox name="ttsUser.enabled" /></td>      -->
<!--				    <td class="arrow"><s:text name='system.role.editable'/></td>-->
<!--				   	<td><s:checkbox name="ttsUser.editable" /></td>      -->
<!--			     </tr>-->
			     <tr>		
				    <td class="arrow"><s:text name='system.user.relateroles'/></td>
				   	<td><s:label name="ttsUser.roleName" /></td>      
				    <td></td>
				   	<td></td>      
			     </tr>
			     <tr height="15"></tr>
			     <tr>
			     	<td colspan="4">
					  <input type="button" class="button2" onClick="window.location='change_password.action'" value="<s:text name='system.user.modifypassword' />" />
			     	</td>
			     </tr>
		   </table>
	</div>
	</fieldset>
	</div>		   


</body>
</html>
