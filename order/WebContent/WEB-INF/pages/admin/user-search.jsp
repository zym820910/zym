<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<script type="text/javascript" src="../js/ui.core.js"></script>
<script type="text/javascript" src="../js/ui.dialog.js"></script>
<script type="text/javascript" src="../js/ui.draggable.js"></script>
<script type="text/javascript" src="../js/ui.resizable.js"></script>
<script type="text/javascript" src="../js/jquery.bgiframe.js"></script>
<script type="text/javascript" src="../js/ui.core.js"></script>
<script type="text/javascript" src="../js/ui.datepicker.js"></script>
<script type="text/javascript" src="../js/selectCheckBox.js"></script>
<title></title>
<script type="text/javascript">
	function reset(){
		$('#urname').val('');
	}
	var path ;

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
			 window.location = "user_edit.action?id="+$("#selectedArray").val();
		}else{
			document.getElementById("chkHidden").innerHTML = "<font color='red'><s:text name='user.interior.select.one.item'/></font>";
		}
	}
	function check_hidden2(){
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
			 window.location = "admin_change_user_pwd.action?id="+$("#selectedArray").val();
		}else{
			document.getElementById("chkHidden").innerHTML = "<font color='red'><s:text name='user.interior.select.one.item'/></font>";
		}
	}
	function check_hidden1(){
		if(confirm('确认删除吗?')){
			bindCheck('selectedArrays','selectedArray');
			var selectedArray = $("#selectedArray").val();
			if(selectedArray==""){
				document.getElementById("chkHidden").innerHTML = "<font color='red'><s:text name='user.interior.select.one.item'/></font>";
			}else if(selectedArray.length > 0){
					window.location = "user_delete.action?selectedArray="+$("#selectedArray").val();
			}
		}
	}

	// 多选框开始
	function jqSelectAll( id )
	{
	   $( "#idTable" + " :checkbox").attr('checked', $('#' + id).is(':checked'));
	}
</script>
</head>

<body >
<s:hidden name="selectedArray" id="selectedArray" />
<div class="right" style="width: 92%;">
	<s:actionmessage/>
<!--   <div class="myPlace"><span><a href="user_list.action"><s:text name="system.user.title"/></a><s:text name="system.title"/></span></div>-->
   <h1><s:text name="system.user.title"/></h1>
  <div class="table"  style="width: 92%;">
  <s:form action="user-search.action" method="post" theme="simple">
   <table width="100%"  border="0" cellspacing="0" cellpadding="0">
     <tr>
       <td class="arrow"><s:text name="system.user.username"/></td>
       <td><s:textfield id="urname" name="query.queryCondition.username" /></td>
     </tr>

   </table>
 
    <div class="line" style="width: 92%"></div>
    <s:submit cssClass="button2" value="%{getText('system.user.queryBtn')}" />
    <input type="button" class="button2" value="<s:text name="system.user.resetBtn"/>" onclick="reset();"/>
  </s:form>  
   <ul class="list4" style="width: 92%">
     <li> <h2><s:text name='system.user.list.title'/></h2>
     </li>
	 <li class="down">
	  <input name="Submit" type="button" class="button2_w" onClick="window.location='user_add.action'" value="<s:text name='system.user.addBtn' />" />
      <input name="Submit" type="button" class="button2_w" onClick="check_hidden()" value="<s:text name='system.user.editBtn' />" />
      <input name="Submit" type="button" class="button4_w" onClick="check_hidden2()" value="<s:text name='system.user.modifypassword' />" />
      <input name="Submit" type="button" class="button2_w" onClick="check_hidden1()" value="<s:text name='system.user.deleteBtn' />" />
	 </li>
   </ul>  
    <display:table name="pageResult" class="list" style="width:92%" cellpadding="1" cellspacing="0" uid="aa" id="row" htmlId="idTable"	requestURI="">
	<display:column title="<input type='checkbox' id='selectAll' onclick='jqSelectAll(this.id);'/>" headerClass="tit" style="width:10%;" >
		<input type="checkbox" name="selectedArrays" value="${row.id}" ></input>
	</display:column>	
    <display:column property="username" titleKey="system.user.username"  headerClass="tit"
    	href="user_detail.action" paramId="id" paramProperty="id"/>
    <display:column property="rolename" titleKey="system.user.relateroles"  headerClass="tit"
    	paramId="id" paramProperty="id"/>
    </display:table>  
      <div class="number">
     </div>
<!--         <input name="Submit" type="button" class="button2_max" onClick="window.location='user_add.action'" value="<s:text name='system.user.addBtn'/>" />-->
<!--         <input name="Submit" type="button" class="button2_max" onClick="check_hidden()" value="<s:text name='system.user.editBtn'/>" />-->
<!--         <input name="Submit" type="button" class="button4_max" onClick="check_hidden2()" value="<s:text name='system.user.modifypassword' />" />-->
<!--         <input name="Submit" type="button" class="button2_max" onClick="check_hidden1()" value="<s:text name='system.user.deleteBtn'/>" />-->
         
	 <div id="chkHidden"></div>
</div>
</div>

</body>
</html>
