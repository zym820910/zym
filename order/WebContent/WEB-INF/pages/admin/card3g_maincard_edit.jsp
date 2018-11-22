<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>3G卡管理-3G卡修改-主卡</TITLE>

<script src="../js/ui.core.js" type="text/javascript"></script>
<script src="../js/ui.datepicker.js" type="text/javascript"></script>
<link href="../css/ui.all.css" rel="stylesheet" type="text/css">
<link href="../css/ui.datepicker.css" rel="stylesheet" type="text/css">
<script>

jQuery(function($){
	$("#soldDate, #packageActiveDate, #packageMaturityDate, #suspendDate, #outOfServiceDate").datepicker({ 
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

function check(){
	if(confirm("确定要修改吗？")){
		$("#frm").submit();
	}
}
</script>
</HEAD>

<BODY>
<BODY  class="mainbg">
<div class="maintop">3G卡管理-3G卡修改-主卡</div>
<s:form id="frm" action="main_card_modify" method="post" theme="simple">
	<s:hidden name="card3g.packageNo"></s:hidden>
	<s:hidden name="oldStatus"></s:hidden>
	<s:hidden name="page"></s:hidden>
	<div class="box_relative">
	<fieldset style="width:380px"><legend> <font color="#000000" size="-1">主卡信息</font>
	</legend>
	<div class="center">
	<table width="360px" border="0" width="100%">
		<tr>
			<td align="left" class="tdarrow" width="120px">卡号：</td>
			<td align="left" width="200px">
			<s:property value="card3g.cardNo" />
			<s:hidden id="cardNo" name="card3g.cardNo" /></td>
		</tr>
		<tr>
			<td align="left" class="tdarrow">ICCID：</td>
			<td align="left"><s:textfield name="card3g.iccid" /></td>
		</tr>
		<tr>
			<td align="left" class="mandatoryField">IMSI：</td>
			<td align="left"><s:textfield name="card3g.imsi" /></td>
		</tr>
		<tr>
			<td align="left" class="tdarrow">卡状态：</td>
			<td align="left">
			<s:select name="card3g.status" id="cardStatus" list="statusList" listKey="value" listValue="label"></s:select>
			</td>
		</tr>
		<tr>
			<td align="left" class="tdarrow">现在余额：</td>
			<td align="left">
			<s:property value="card3g.balance"/>
			<s:hidden name="card3g.balance"/></td>
		</tr>
		<tr>
			<td align="left" class="tdarrow">添加日期：</td>
			<td align="left">
			<s:property value="card3g.appendDatetime"/>
			<s:hidden name="card3g.appendDatetime" id="appendDatetime"/></td>
		</tr>
		<tr>
			<td align="left" class="tdarrow">第一次使用时间：</td>
			<td align="left">
			<s:property value="card3g.firstUseDate"/>
			<s:hidden name="card3g.firstUseDate" id="firstUseDate"/></td>
		</tr>
		<tr>
			<td align="left" class="tdarrow">余额不足：</td>
			<td align="left">
				<s:select list="ifBalanceStatusList" name="card3g.ifBalanceUnsufficient" listKey="key" listValue="value"></s:select>
			</td>
		</tr>
		<tr>
			<td align="left" class="tdarrow">流量或时长超限：</td>
			<td align="left">
				<s:select list="ifBalanceStatusList" name="card3g.ifLimitExceed" listKey="key" listValue="value"></s:select>
			</td>
		</tr>
		<tr>
			<td align="left" class="tdarrow">销售日期：</td>
			<td align="left"><s:textfield name="card3g.soldDate" id="soldDate" readonly="false" maxlength="10"/></td>
		</tr>
		<tr>
			<td align="left" class="tdarrow">激活日期：</td>
			<td align="left"><s:textfield name="card3g.packageActiveDate" id="packageActiveDate" readonly="false" maxlength="10"/></td>
		</tr>
		<tr>
			<td align="left" class="tdarrow">有效日期：</td>
			<td align="left">
				<s:property value="card3g.packageMaturityDate"/>
<!--				<s:textfield name="card3g.packageMaturityDate" id="packageMaturityDate" readonly="false"/>-->
			</td>
		</tr>
		<tr>
			<td align="left" class="tdarrow">挂失日期：</td>
			<td align="left"><s:textfield name="card3g.suspendDate" id="suspendDate" readonly="false" maxlength="10"/></td>
		</tr>
		<tr>
			<td align="left" class="tdarrow">停机日期：</td>
			<td align="left"><s:textfield name="card3g.outOfServiceDate" id="outOfServiceDate" readonly="false" maxlength="10"/></td>
		</tr>
	</table>
	</div>
	</fieldset>
	</div>
	<br>

		<input type="button" value="修改" class="button2_max" onclick="check()"/>
		<input type="button" value="返回" onclick="window.location = 'card3g_list.action'" class="button2_max"/>

</s:form>
</BODY>
</HTML>
