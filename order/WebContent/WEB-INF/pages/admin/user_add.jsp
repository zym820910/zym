<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<link href="../../css/main.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../js/calendar.js"></script>
<script type="text/javascript">
function check(){
	if(confirm("确定要新增吗？")){
		if(trim($("#newPwd").val())==''){
			alert("请输入密码！");
			return false;
		}
		if(trim($("#rePwd").val())==''){
			alert("请再次输入密码！");
			return false;
		}
		if($("#newPwd").val()!= $("#rePwd").val()){
			alert("两次输入的密码不一致，请重新输入");
			return false;
		}else{
			$("#frm").submit();
		}
	}
}
function  trim(str){
    for(var  i  =  0  ;  i<str.length  &&  str.charAt(i)==" ";  i++  )  ;
    for(var  j  =str.length;  j>0  &&  str.charAt(j-1)==" ";  j--)  ;
    if(i>j)  return  "";  
    return  str.substring(i,j);  
}
</script>
</head>

<BODY class="mainbg">
<div class="maintop">密码修改</div>
<s:form id="frm" action="user_save.action" method="post" theme="simple">
<div class="right" style="width: 92%;">
  <h1><s:text name="system.user.add"/></h1>
  <div class="table">
      
<table width="100%"  border="0" cellspacing="0" cellpadding="0">

	<tr>
	    <td  class="mandatoryField"><s:text name='system.user.username'/></td>
	    <td><s:textfield maxlength="15" name="ttsUser.username" value=""/></td>
	    <td></td>
	    <td></td> 
	</tr>
	<tr>		
	    <td class="arrow"><s:text name='system.role.enable'/></td>
	   	<td><s:checkbox name="ttsUser.enabled" /></td>      
	    <td class="arrow"><s:text name='system.role.editable'/></td>
	   	<td><s:checkbox name="ttsUser.editable" /></td>      
     </tr>	
	<tr>		
	    <td  class="mandatoryField"><s:text name='system.user.password'/></td>
	   	<td><s:password maxlength="8" id="newPwd" name="ttsUser.password" value=""/></td>      
	    <td  class="mandatoryField"><s:text name='system.user.repassword'/></td>
	   	<td><s:password id="rePwd" maxlength="8" name="ttsUser.rePassword" /></td>      
     </tr>	
     <tr>		
	    <td class="arrow"><s:text name='system.user.relateroles'/></td>
	   	<td><s:select list="roleList" listKey="id" name="roleSel" listValue="nameZh" headerKey="" headerValue="请选择一个角色" /> </td>      
	    <td></td>
	   	<td></td>      
     </tr>	
  </table>

      <div class="line"></div>
   	  <br/>
    <input name="Submit" type="button" onclick="check()"  class="button2" value="<s:text name='system.user.enterBtn'/>" /> 
    <input name="Submit" type="button" onclick="javascript:window.location='user_list.action'"  class="button2" value="<s:text name='system.user.cancleBtn'/>" /> 

  </div>
</div>
</s:form>
</body>
</html>
