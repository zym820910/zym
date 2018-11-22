<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<script type="text/javascript" src="../js/selectCheckBox.js"></script>
<script>


	function check_hidden(){

		bindCheck('selectedArrays','selectedArray');
		var id = document.getElementById("id").value;
		var selectedArray = $("#selectedArray").val();
		if(selectedArray==""){
			document.getElementById("chkHidden").innerHTML = "<font color='red'><s:text name='system.role.notSelect'/></font>";
		}else if(selectedArray.length > 0){
				window.location ="user_rolerelatedo.action?id="+id+"&selectedArray="+$("#selectedArray").val()+"&tab=1";
		}
	}
	function check_hidden2(){
		
		var id = document.getElementById("id").value;		
		window.location = "user_detail.action?id="+id+"&tab=1";
	}

	var errorMsg = "<s:property value='resData'/>" ;
	if(errorMsg != ""){
		alert("<s:text name='system.user.roleRepeat' />");	
	}
	// 多选框开始
	function jqSelectAll( id )
	{
	   $( "#idTable" + " :checkbox").attr('checked', $('#' + id).is(':checked'));
	}
</script>
</head>

<body >

<div class="right">
   <h1><s:text name="system.role.title"/></h1>
  <div class="table">
  <s:form action="role_list.action" id="form" method="post" theme="simple">
	<s:hidden name="id" id="id" />
	<s:hidden name="selectedArray" id="selectedArray" />
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
  	<s:reset cssClass="button2" value="%{getText('system.user.resetBtn')}"></s:reset>
  	</s:form>
   <ul class="list4">
     <li> <h2><s:text name='system.role.list.title'/></h2>
     </li>
	 <li class="down">
	  <input name="Submit" type="button" class="button2_w" onClick="check_hidden()" value="<s:text name='system.user.relateBtn' />" />
	 
	  <input name="Submit" type="button"  onclick="check_hidden2()" class="button2_w" value="<s:text name='system.user.cancleBtn'/>" />
	 </li>
   </ul>
    <display:table name="pageResult" class="list" style="width:100%" 
	cellpadding="1" cellspacing="0" uid="aa" id="row" htmlId="idTable"
	requestURI="">
    <display:column title="<input type='checkbox' id='selectAll' onclick='jqSelectAll(this.id);'/>" 
		headerClass="tit" style="width:2%;" >
		<input type="checkbox" name="selectedArrays" value="${row.id}" ></input>
	</display:column> 
     <display:column property="nameZh"  titleKey="system.role.nameZh" headerClass="tit"/>
     <display:column property="nameEn"  titleKey="system.role.nameEn" headerClass="tit"/>
     <display:column property="description" titleKey="system.role.description" headerClass="tit"/>
     </display:table>
   

      
      <div class="number">
     </div>    	   
     	    <input name="Submit" type="button" class="button2" onClick="check_hidden()" value="<s:text name='system.user.relateBtn' />" />
            <input name="Submit" type="button"  onclick="check_hidden2()" class="button2" value="<s:text name='system.user.cancleBtn'/>" />
	 <div id="chkHidden"></div>
</div>
</div>

</body>
</html>
