<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<link href="../../css/main.css" rel="stylesheet" type="text/css">
<script src="../../js/table_color.js" type="text/javascript"></script>
<script>
	function setHiddenVal(val){
		document.getElementById("id").value = val;
	}

	function check_hidden(){
		var hiddenVal = document.getElementById("id").value;
		if(hiddenVal == ""){
			document.getElementById("chkHidden").innerHTML = "<font color='red'><s:text name='role.interior.select.one.item'/></font>";
		}else{
			window.location = "role_edit.action?id="+hiddenVal;
		}
	}
	function check_hidden1(){
		var hiddenVal = document.getElementById("id").value;
		if(hiddenVal == ""){
			document.getElementById("chkHidden").innerHTML = "<font color='red'><s:text name='role.interior.select.one.item'/></font>";
		}else{
			window.location = "role_delete.action?id="+hiddenVal;
		}
	}
</script>
</head>

<body >
<s:form action="role_list.action" method="post" theme="simple">
<s:hidden name="id" id="id" />
<div class="right" style="width: 92%;">
<!--   <div class="myPlace"><span><a href="role_list.action"><s:text name="system.role.title"/></a><s:text name="system.title"/></span></div>-->
   <h1><s:text name="system.role.title"/></h1>
  <div class="table">
  
   <table width="100%"  border="0" cellspacing="0" cellpadding="0">
     <tr>
       <td class="arrow"><s:text name="system.role.nameZh"/></td>
       <td><s:textfield name="tsSysRole.nameZh" /></td>
       <td class="arrow"><s:text name='system.role.nameEn'/></td> 
	   <td><s:textfield name="tsSysRole.nameEn" /></td>	  
	 </tr>      	
     <tr>
       <td class="arrow"><s:text name='system.role.description'/></td>
       <td><s:textfield name="tsSysRole.description" /></td>
       <td ></td>
       <td></td>
       
     </tr>
   </table>
   
    <div class="line"></div>
    <s:submit cssClass="button2" value="%{getText('system.role.queryBtn')}" />
  
   <ul class="list4">
     <li> <h2><s:text name='system.role.list.title'/></h2>
     </li>
	 <li class="down">
	  <input name="Submit" type="button" class="button2_w" onClick="window.location='role_add.action'" value="<s:text name='system.role.addBtn' />" />
      <input name="Submit" type="button" class="button2_w" onClick="check_hidden()" value="<s:text name='system.role.editBtn' />" />
	   <input name="Submit" type="button" class="button2_w" onClick="check_hidden1()" value="<s:text name='system.role.deleteBtn'/>" />
	 </li>
   </ul>
   
    <table width="100%" id="tablecolor1"  class="list"  border="0" cellspacing="1" cellpadding="0">
      <tr>
        <td width="10" align="center"  class="tit">&nbsp;</td>
        <td align="center"  class="tit"><strong><s:text name="system.role.nameZh"/></strong></td>
        <td align="center"  class="tit"><strong><s:text name="system.role.nameEn"/></strong></td>
        <td align="center"  class="tit"><strong><s:text name="system.role.description"/></strong></td>             
      </tr>
        <s:iterator value="tsSysRoleList" status="item">
	      	<tr>
	        <td align="center">
	        <input type="radio" name="radiobutton"  class="check" value="<s:property value='id'/>" onclick="setHiddenVal(this.value)"/>
	        </td>
	        <td> <a href="role_detail.action?id=<s:property value='id'/>"><s:property value='nameZh' /></a></td>
	        <td><s:property value="nameEn" /></td>
	        <td><s:property value="description" /></td> 	        
	      
	      </s:iterator>
	  <tr>
	    <td colspan="3" class="line2"></td>
	  </tr>
    </table>
   
	
      
      <div class="number">
   <a href="#"><img src="../../images/i_arrw1.gif" width="12" style="padding: 0px 2px 0px 2px; " height="14" border="0" align="absmiddle"></a><a href="#"><img src="../../images/i_arrw3.gif" width="12" height="14" style="padding: 0px 2px 0px 2px; " border="0" align="absmiddle"></a>　Page
         <input name="textfield" type="text" value="17" size="4">           
         of 67　<a href="#"><img src="../../images/i_arrw5.gif" style="padding: 0px 2px 0px 2px; " width="12" height="14" border="0" align="absmiddle"></a><a href="#"><img src="../../images/i_arrw7.gif" width="12" height="14" style="padding: 0px 2px 0px 2px; " border="0" align="absmiddle"></a>　|　<img src="../../images/loading.gif" width="16" height="16" align="absmiddle">　当前显示 1-25条订单,共 1669条订单
     </div>
         <input name="Submit" type="button" class="button2_max" onClick="window.location='role_add.action'" value="<s:text name='system.role.addBtn'/>" />
         <input name="Submit" type="button" class="button2_max" onClick="check_hidden()" value="<s:text name='system.role.editBtn'/>" />
         <input name="Submit" type="button" class="button2_max" onClick="check_hidden1()" value="<s:text name='system.role.deleteBtn'/>" />
	 <div id="chkHidden"></div>
</div>
</div>
</s:form>
</body>
</html>
