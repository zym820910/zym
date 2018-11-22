<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="../js/selectCheckBox.js"></script>
<title></title>
<script>
	function setHiddenVal(val){
		document.getElementById("roleid").value = val;
	}

	function check_hidden(){
		    var id= document.getElementById("id").value;
			window.location = "user_rolerelate.action?id="+id;
		
	}

	function check_hidden2(){
		var id = document.getElementById("id").value;	
		bindCheck('selectedArrays','selectedArray');
		var selectedArray = $("#selectedArray").val();	
		if(selectedArray==""){
			document.getElementById("chkHidden").innerHTML = "<font color='red'><s:text name='system.role.notSelect'/></font>";
		}else{
			var id = document.getElementById("id").value;			
		    window.location = "user_delete_role_relate.action?id="+id+"&selectedArray=" +$("#selectedArray").val()+"&tab=1";		
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
<s:form action="role_list.action" method="post" theme="simple">
<s:hidden name="id" id="id" />
<s:hidden name="selectedArray" id="selectedArray" />
<div class="left">   
	  <display:table name="pageResult" class="list" style="width:100%" 
	cellpadding="1" cellspacing="0" uid="aa" id="row" htmlId="idTable"
	requestURI="user_detail.action?id=${id}&tab=1" excludedParams="*">
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
         <input name="Submit" type="button" class="button2_max" onClick="check_hidden()" value="<s:text name='system.user.relateBtn'/>" />

         <!--  <input name="Submit" type="button" onclick="check_hidden1()"  class="button2_max" value="<s:text name='system.user.cancleBtn'/>" />   -->
          <input name="Submit" type="button" onclick="check_hidden2()"  class="button2_max" value="<s:text name='system.user.deleteRoleBtn'/>" />
	 <div id="chkHidden"></div>
</div>

</s:form>
</body>
</html>
