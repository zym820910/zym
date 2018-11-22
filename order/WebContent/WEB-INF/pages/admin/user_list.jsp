<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<script type="text/javascript" src="../js/ui.core.js"></script>
<script type="text/javascript" src="../js/ui.dialog.js"></script>
<script type="text/javascript" src="../js/ui.draggable.js"></script>
<script type="text/javascript" src="../js/ui.resizable.js"></script>
<script type="text/javascript" src="../js/jquery.bgiframe.js"></script>
<title></title>


<script>
var path ;
	function setHiddenVal(val){
		
		document.getElementById("id").value = val;
	}

	function check_hidden(){
		alrtt(123);
		var hiddenVal = document.getElementById("id").value;		
		if(hiddenVal == ""){
			document.getElementById("chkHidden").innerHTML = "<font color='red'><s:text name='User.interior.select.one.item'/></font>";
		}else{
			window.location = "user_edit.action?id="+hiddenVal;
		}
	}
	function check_hidden1(){
		var hiddenVal = document.getElementById("id").value;		
		if(hiddenVal == ""){
			document.getElementById("chkHidden").innerHTML = "<font color='red'><s:text name='User.interior.select.one.item'/></font>";
		}else{
			window.location = "user_delete.action?id="+hiddenVal;
		}
	}

	function chooseDep(){
		window.location = "select_department_tree.action";
		
	}

	$(function() {
		$("#dialog").dialog({
			bgiframe: true,
			resizable: false,
			height:400,
			width:280,
			autoOpen: false,
			modal: true,
			overlay: {
				backgroundColor: '#000',
				opacity: 0.5
			}
		});
	});		


	function selectDepClick()
	{
		
		path = "select_department_tree.action?"+"ajax=true";
		$("#dialog").load(path);
		$("#dialog").dialog('open');
	}
</script>


</head>

<body >

<s:form action="user_list.action" method="post" theme="simple">
<s:hidden name="id" id="id" />
<!-- 
<div id="dialog" title="<s:text name='system.user.selectDep'/>"></div>
<div class="right">
   <div class="myPlace"><span><a href="user_list.action"><s:text name="system.user.title"/></a><s:text name="system.title"/></span></div>
   <h1><s:text name="system.user.title"/></h1>
  <div class="table">
 -->
   <table width="100%"  border="0" cellspacing="0" cellpadding="0">
     <tr>
       <td class="arrow"><s:text name="system.user.username"/></td>
       <td><s:textfield name="tsUser.username" /></td>
       <td class="arrow"><s:text name='system.user.realname'/></td>
	   <td><s:textfield name="tsUser.realnameZh" /></td>
     </tr>
     <tr>
       <td class="arrow"><s:text name='system.user.departname'/></td>
       <td><s:textfield id="selectDep" name="deptNo" id="depTree"/>
       <img src="../images/p_04.gif" width="26" height="20" border="0" name="pdSelect" id="pdSelect" onclick="selectDepClick()" style="cursor:pointer;" /></td>
       <td class="arrow"><s:text name='system.user.telephone'/></td>
       <td><s:textfield name="tsUser.telephone" /></td>
       <td class="arrow"><s:text name='system.user.email'/></td>
       <td><s:textfield name="tsUser.email" /></td>
     </tr>
   </table>
   
    <div class="line"></div>
    <s:submit cssClass="button2" value="%{getText('system.user.queryBtn')}" />
  
   <ul class="list4">
     <li> <h2><s:text name='system.user.list.title'/></h2>
     </li>
	 <li class="down">
	  <input name="Submit" type="button" class="button2_w" onClick="window.location='user_add.action'" value="<s:text name='system.user.addBtn' />" />
      <input name="Submit" type="button" class="button2_w" onClick="check_hidden()" value="<s:text name='system.user.editBtn' />" />
      <input name="Submit" type="button" class="button2_w" onClick="check_hidden1()" value="<s:text name='system.user.deleteBtn' />" />
	 </li>
   </ul>  
    <table width="100%" id="tablecolor1"  class="list"  border="0" cellspacing="1" cellpadding="0">
      <tr>
        <td width="10" align="center"  class="tit">&nbsp;</td>
        <td align="center"  class="tit"><strong><s:text name="system.user.username"/></strong></td>
        <td align="center"  class="tit"><strong><s:text name="system.user.description"/></strong></td>       
        <td align="center"  class="tit"><strong><s:text name="system.user.editable"/></strong></td>
      </tr>
        <s:iterator value="tsUserList" status="item">
	      	<tr>
	        <td align="center">
	      	  <input type="radio" name="radiobutton"  class="check" value="<s:property value='id'/>"  onclick="setHiddenVal(this.value)"/>
	        </td>
	        <td> <a href="user_detail.action?id=<s:property value='id'/>"><s:property value="username" /> </a></td>
	        <td><s:property value="description" /></td>
            <td>
            	<s:if test="editable">
            	<s:text name="User.show.is"/>
            	</s:if>
            	<s:if test="!editable">
            	<s:text name="User.show.not"/>
            	</s:if>
            </td>
	      </tr> 
	      </s:iterator>
	      
	      
	  <tr>
	    <td colspan="8" class="line2"></td>
	  </tr>
    </table>
      
<!--      <div class="number">-->
<!--   <a href="#"><img src="../../images/i_arrw1.gif" width="12" style="padding: 0px 2px 0px 2px; " height="14" border="0" align="absmiddle"></a><a href="#"><img src="../../images/i_arrw3.gif" width="12" height="14" style="padding: 0px 2px 0px 2px; " border="0" align="absmiddle"></a>　Page-->
<!--         <input name="textfield" type="text" value="17" size="4">           -->
<!--         of 67　<a href="#"><img src="../../images/i_arrw5.gif" style="padding: 0px 2px 0px 2px; " width="12" height="14" border="0" align="absmiddle"></a><a href="#"><img src="../../images/i_arrw7.gif" width="12" height="14" style="padding: 0px 2px 0px 2px; " border="0" align="absmiddle"></a>　|　<img src="../../images/loading.gif" width="16" height="16" align="absmiddle">　当前显示 1-25条订单,共 1669条订单-->
<!--     </div>-->
         <input name="Submit" type="button" class="button2_max" onClick="window.location='user_add.action'" value="<s:text name='system.user.addBtn'/>" />
         <input name="Submit" type="button" class="button2_max" onClick="check_hidden()" value="<s:text name='system.user.editBtn'/>" />
          <input name="Submit" type="button" class="button2_max" onClick="check_hidden1()" value="<s:text name='system.user.deleteBtn'/>" />
         
	 <div id="chkHidden"></div>
</div>
</div>
</s:form>
</body>
</html>
