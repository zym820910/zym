<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>3G卡管理-3G卡修改-套餐</TITLE>

<script>
function check(obj,val){
	if(confirm("确定要变更套餐吗？")){
		var status = $("#status").val();
		if(status == 3 || status == 4){
			alert("该卡号处于停机状态，无法修改套餐。");
		}else{
			$("#packageNo").val(obj);
			$("#packageName").val(val);
			$("#packageAfterChanges").val(val);
			$("#packageNoAfterChanges").val(obj);
			$("#frm").submit();
		}
	}
}
</script>
</HEAD>

<BODY  class="mainbg">
<div class="maintop">3G卡管理-3G卡修改-套餐</div>
<s:form id="frm" action="package_info_modify" method="post" theme="simple">
<s:hidden name="page"></s:hidden>
<s:hidden name="card3g.packageNo" id="packageNo"/>
<s:hidden name="card3g.packageName" id="packageName"/>
<s:hidden name="packageAfterChange" id="packageAfterChanges"></s:hidden>
<s:hidden name="packageNoAfterChange" id="packageNoAfterChanges"></s:hidden>
	<div class="box_relative">
	<fieldset style="width:380px"><legend> <font color="#000000" size="-1">现有信息</font>
	</legend>
	<table border="0" width="360px">
		<tr>
			<td width="120px" class="tdarrow">卡号：</td>
			<td width="200px"  align="left">
				<s:hidden id="cardNo" name="card3g.cardNo"/>
				<s:property value="card3g.cardNo"/>
			</td>
		</tr>
		<tr>			
			<td class="tdarrow">卡状态:</td>
			<td>
				<s:hidden name="card3g.status" id="status"/>
				<s:property value="card3g.statusName"/>
			</td>
		</tr>
		<tr>
			<td class="tdarrow">现有套餐:</td>
			<td>
				<s:property value="card3g.packageName"/>
			</td>
		</tr>
	</table>
	</fieldset>
	</div>
	<div class="div_padding">
	<div class="right">
	<ul class="list4">
		<li>
		<h2>更改套餐</h2>
		</li>
	</ul>
	<div class="box_relative">
	<fieldset style="width:380px"><legend> <font color="#000000" size="-1">套餐列表</font>
	</legend>
	<display:table name="packageList" class="list" id="row" style="width:100%" cellpadding="1" cellspacing="0" requestURI="" export="false" pagesize="10">
		<display:column headerClass="tit" paramId="id" paramProperty="id" style="width:30px"
			title="序号"> 
			${row.packageNo}
		</display:column>

		<display:column headerClass="tit" paramId="id" paramProperty="id" style="width:300px"
			title="可用套餐"> 
        	${row.packageName}
		</display:column>
		
		<display:column headerClass="tit" paramId="id" paramProperty="id" title="操作" style="width:50px"> 
			<a title="点击变更" class="a" href="#" onclick="check('${row.packageNo}','${row.packageName}')"><b>变更</b></a>
		</display:column>
	</display:table>
	</fieldset>
	</div>
	<ul class="list4">
		<li>
		<h2>变更记录</h2>
		</li>
	</ul>
	<display:table name="packageChangeList" class="list" id="row" style="width:100%" cellpadding="1" cellspacing="0" requestURI="" export="false" pagesize="10">
		<display:column headerClass="tit" paramId="id" paramProperty="id" style="width:7%"
			title="卡号"> 
			${row.cardNo}
		</display:column>

		<display:column headerClass="tit" paramId="id" paramProperty="id" style="width:27%"
			title="原有套餐"> 
        	${row.packageBeforeChange}
		</display:column>
		
		<display:column headerClass="tit" paramId="id" paramProperty="id" style="width:27%"
			title="变更后套餐"> 
        	${row.packageAfterChange}
		</display:column>
		
		<display:column headerClass="tit" paramId="id" paramProperty="id" style="width:14%"
			title="变更方式"> 
        	${row.changeTypeName}
		</display:column>

		<display:column headerClass="tit" paramId="id" paramProperty="id" style="width:10%"
			title="状态"> 
        	${row.statusName}
		</display:column>
		
		<display:column headerClass="tit" paramId="id" paramProperty="id" style="width:14%"
			title="变更时间"> 
        	${row.changeValidDate}
		</display:column>
		
		
	</display:table>
	<div style="height:10px"></div>
	<span>
		<input type="button" value="返回" onclick="window.location = 'card3g_list.action'" class="button2_max"/>
	</span>
	</div>
	</div>
	<br>

</s:form>
</BODY>
</HTML>
