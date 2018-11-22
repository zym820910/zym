<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<link href="../../css/main.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/ui.core.js"></script>
<script src="../../js/table_color.js" type="text/javascript"></script>
<!--<script type="text/javascript" src="${ctx}/js/ui.datepicker.js"></script>-->
<script type="text/javascript" src="../js/selectCheckBox.js"></script>
<script>
	function setHiddenVal(val){
		document.getElementById("id").value = val;
	}

	function check_hidden(){
		bindCheck('selectedArrays','selectedArray');
		var selectedArray = $("#selectedArray").val();
		var count = 0 ;
		var checkboxList = document.getElementsByName('selectedArrays') ;
		for(var cbxIndex = 0 ; cbxIndex < checkboxList.length ; cbxIndex++){
			if(checkboxList[cbxIndex].checked) {				
				count++ ;
			}
		}		
		if(count== 1){
			 window.location = "role_edit.action?id="+$("#selectedArray").val();
		}else{
			document.getElementById("chkHidden").innerHTML = "<font color='red'><s:text name='system.role.notSelect'/></font>";
		}
	}
	function check_hidden1(){
		if(confirm('确认删除吗?')){
			bindCheck('selectedArrays','selectedArray');
			var selectedArray = $("#selectedArray").val();
			if(selectedArray==""){
				document.getElementById("chkHidden").innerHTML = "<font color='red'><s:text name='system.role.notSelect'/></font>";
			}else if(selectedArray.length > 0){
					window.location = "role_delete.action?selectedArray="+$("#selectedArray").val();
			}
		}
	}
	// 多选框开始
	function jqSelectAll( id )
	{
	   $( "#idTable" + " :checkbox").attr('checked', $('#' + id).is(':checked'));
	}

	function resetCondition(){
		$('#nameZh').val('');
		$('#description').val('');
	}
</script>
</head>

<body>
<s:hidden name="id" id="id" />
<s:hidden name="selectedArray" id="selectedArray" />
<div class="right" style="width: 92%;">
   <s:actionmessage/>
   <h1><s:text name="system.role.title"/></h1>
  <div class="table" style="width: 92%">
  <s:form action="role-search.action" method="post" theme="simple">
   <table width="92%"  border="0" cellspacing="0" cellpadding="0">
     <tr>
       <td class="arrow"><s:text name="system.role.nameZh"/></td>
       <td><s:textfield id="nameZh" name="query.queryCondition.nameZh" /></td>
<!--       <td class="arrow"><s:text name='system.role.nameEn'/></td> -->
<!--	   <td><s:textfield name="query.queryCondition.nameEn" /></td>	  -->
	 </tr>      	
     <tr>
       <td class="arrow"><s:text name='system.role.description'/></td>
       <td><s:textfield id="description" name="query.queryCondition.description" /></td>
       <td ></td>
       <td></td>
       
     </tr>
   </table>
   
    <div class="line" style="width: 92%"></div>
    <s:submit cssClass="button2" value="%{getText('system.role.queryBtn')}" />
    <input type="button" class="button2" value="<s:text name='system.user.resetBtn'/>" onclick="resetCondition();"/>
  </s:form>
   <ul class="list4" style="width: 92%">
     <li> <h2><s:text name='system.role.list.title'/></h2>
     </li>
	 <li class="down">
	  <input name="Submit" type="button" class="button2_w" onClick="window.location='role_add.action'" value="<s:text name='system.role.addBtn' />" />
      <input name="Submit" type="button" class="button2_w" onClick="check_hidden()" value="<s:text name='system.role.editBtn' />" />
	 <input name="Submit" type="button" class="button2_w" onClick="check_hidden1()" value="<s:text name='system.role.deleteBtn'/>" />
	 </li>
   </ul>
   <display:table name="pageResult" class="list" style="width:92%" 
	cellpadding="1" cellspacing="0" uid="aa" id="row" htmlId="idTable"
	requestURI="">
	<display:column title="<input type='checkbox' id='selectAll' onclick='jqSelectAll(this.id);'/>" 
		headerClass="tit" style="width:2%;" >
		<input type="checkbox" name="selectedArrays" value="${row.id}" ></input>
	</display:column>
	
    <display:column property="nameZh" titleKey="system.role.nameZh" headerClass="tit"
    	href="role_detail.action" paramId="id" paramProperty="id" style="width:100px"/>
     <display:column property="description" titleKey="system.role.description" headerClass="tit"/>
     <display:column property="userCount" titleKey="system.role.users.count" headerClass="tit"/>
</display:table>
      <div class="number">
     </div>
<!--         <input name="Submit" type="button" class="button2_max" onClick="window.location='role_add.action'" value="<s:text name='system.role.addBtn'/>" />-->
<!--         <input name="Submit" type="button" class="button2_max" onClick="check_hidden()" value="<s:text name='system.role.editBtn'/>" />-->
<!--         <input name="Submit" type="button" class="button2_max" onClick="check_hidden1()" value="<s:text name='system.role.deleteBtn'/>" />-->
	 <div id="chkHidden"></div>
</div>
</div>

</body>
</html>
