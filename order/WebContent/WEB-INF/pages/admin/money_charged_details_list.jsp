<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>3G卡管理-3G费用查询</TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<script src="../js/ui.core.js" type="text/javascript"></script>
<script src="../js/ui.datepicker.js" type="text/javascript"></script>
<link href="../css/ui.all.css" rel="stylesheet" type="text/css">
<link href="../css/ui.datepicker.css" rel="stylesheet" type="text/css">
<script>
	function deleteCard(cardNo, status){
		if(confirm("确定要删除吗？")){
			if(status == 2){
				alert("无法删除激活卡！");
				return;
			}
		window.location = 'card3g_delete.action?cardNo='+cardNo;
		}
	}

	jQuery(function($){
		$("#startTime, #endTime").datepicker({ 
			changeMonth: true,
			changeYear: true,
			dateFormat: 'yy-mm-dd', 
			clearText:'清除',
			closeText:'关闭',
			prevText:'前一月',
			nextText:'后一月',
			currentText:' ',
			monthNames:['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],
			beforeShow: '', 
			showOn: "button", 
			buttonImage: "${ctx}/images/calendar.gif", 
			buttonImageOnly: true 
			});
	});

function resetVal()
{
	$("[name = moneyChargedDetails.cardNo]").val('');
	$("[name = moneyChargedDetails.chargeMethod]").val('');
	$("[name = moneyChargedDetails.operator]").val('');
	$("[name = query.queryCondition.startTime]").val('');
	$("[name = query.queryCondition.endTime]").val('');
}
</script>
</HEAD>

<BODY class="mainbg">
<div class="maintop">费用查询</div>

<s:actionmessage/>
<script type="text/javascript">
	if($("ul li span").html() != null){
		$("ul li span").html("<img class='ico' alt='提示' src='../images/iconInformation.gif'><font color='red'>"+$("ul li span").text()+"</font>");
	}
</script>
	<s:form action="money_charged_details_list" method="post" theme="simple">
	<s:hidden name="nameOfSubmit" value = "newSearch"> </s:hidden > 
	<div class="box_relative">
		<fieldset style="width: 380px"><legend> <font color="#000000" size="-1">查询条件</font> </legend>
			<div align="center">
				<table width="360px">
					<tr>
						<td width="120px" class="tdarrow">卡号：</td>
						<td ><s:textfield name="moneyChargedDetails.cardNo" /></td>
					</tr>
					<tr>
						<td  class="tdarrow">操作方式：</td>
						<td >
							<s:select list="chargeMethodList" name="moneyChargedDetails.chargeMethod" headerKey="" headerValue="全部" listKey="value" listValue="label"></s:select>
						</td>
					</tr>
					<tr>
						<td class="tdarrow">操作人员：</td>
						<td>
<!--							<s:textfield name="moneyChargedDetails.operator" />-->
							<s:select list="getTsUser()" name="moneyChargedDetails.operator" headerKey="" headerValue="--全部--" listKey="username" listValue="username"></s:select>
						</td>
					</tr>
					<tr>
						<td class="tdarrow">操作时间 From：</td>
						<td><s:textfield name="query.queryCondition.startTime" id="startTime" readonly="false"/></td>
					</tr>
					<tr>						
						<td class="tdarrow">操作时间To：</td>
						<td><s:textfield name="query.queryCondition.endTime" id="endTime" readonly="false"/></td>
					</tr>
					<tr>						
						<td class="tdarrow"></td>
						<td>
							<s:submit value="查询" cssClass="button2"></s:submit>
							<input type="button" value="重置" class="button2" onclick="resetVal()"/>
						</td>
					</tr>
				</table>
			</div>		
		</fieldset>
	</div>	
			</s:form>
			<ul class="list4">
				<li>
				<h2>卡费用信息列表</h2>
				</li>
			</ul>
	<div class="right">		
			<display:table name="pageResult" class="list"
				id="row" style="width:100%" cellpadding="1" cellspacing="0"
				requestURI="" export="false" pagesize="10">

				<display:column headerClass="tit" paramId="id" paramProperty="id"
					title="卡号"> 
					${row.cardNo}
				</display:column>

				<display:column headerClass="tit" paramId="id" paramProperty="id"
					title="操作时间"> 
					${row.chargeTime}
				</display:column>

				<display:column headerClass="tit" paramId="id" paramProperty="id"
					title="操作方式"> 
		        	${row.chargeMethodDesc}
				</display:column>

				<display:column headerClass="tit" paramId="id" paramProperty="id"
					title="操作金额"> 
					${row.moneyCharged}
				</display:column>

				<display:column headerClass="tit" paramId="id" paramProperty="id"
					title="操作前金额"> 
					${row.balanceBeforeCharge}
				</display:column>

				<display:column headerClass="tit" paramId="id" paramProperty="id"
					title="操作后金额"> 
					${row.balanceAfterCharge}
				</display:column>

				<display:column headerClass="tit" paramId="id" paramProperty="id"
					title="操作详细信息"> 
					${row.detailMethod}
				</display:column>
				
				<display:column headerClass="tit" paramId="id" paramProperty="id"
					title="操作人员"> 
					${row.operator}
				</display:column>
			</display:table>
	</div>
</BODY>
</HTML>
