<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>3G卡详细显示</TITLE>
</HEAD>

<BODY  class="mainbg">
<div class="maintop">3G卡管理-3G卡修改-主卡</div>
<s:form id="frm" action="card3g_save" method="post" theme="simple">
<!--	<div class="title">3G卡明细</div>-->
<!--	<br>-->
	<div align="center">
	<fieldset style="width:95%"><legend> <font color="#000000" size="-1">主卡信息</font>
	</legend>
	<table border="0" width="100%">
		<tr>
			<td width="10%" class="tdarrow">卡号：</td>
			<td width="10%"><s:property value="card3g.cardNo" /></td>
			<td width="10%" class="tdarrow">ICCCID：</td>
			<td width="10%"><s:property value="card3g.iccid" /></td>
			<td width="10%" class="tdarrow">IMSI：</td>
			<td width="10%"><s:property value="card3g.imsi" /></td>
			<td width="10%" class="tdarrow">卡状态：</td>
			<td width="10%"><s:property value="card3g.statusName" /></td>
		</tr>
		<tr>
			<td class="tdarrow">现在余额：</td>
			<td><s:property value="card3g.balance" /></td>
			<td class="tdarrow">余额不足：</td>
			<td><s:property value="card3g.ifBalanceUnsufficientDesc" /></td>
			<td class="tdarrow">流量或时长超限：</td>
			<td><s:property value="card3g.ifLimitExceedDesc" /></td>
		</tr>
		<tr>
			<td class="tdarrow">激活日期：</td>
			<td><s:property value="card3g.packageActiveDate"/></td>
			<td class="tdarrow">有效日期：</td>
			<td><s:property value="card3g.packageMaturityDate"/></td>
			<td class="tdarrow">添加日期：</td>
			<td><s:property value="card3g.appendDatetime"/></td>
			<td class="tdarrow">停机日期：</td>
			<td><s:property value="card3g.outOfServiceDate"/></td>
		</tr>
		<tr>
			<td class="tdarrow">销售日期：</td>
			<td><s:property value="card3g.soldDate"/></td>
			<td class="tdarrow">挂失日期：</td>
			<td><s:property value="card3g.suspendDate"/></td>
			<td class="tdarrow">第一次使用时间：</td>
			<td><s:property value="card3g.firstUseDate"/></td>
			<td></td>
			<td></td>
		</tr>
	</table>
	</fieldset>
	</div>
	<br>

	<div align="center">
	<fieldset style="width:95%"><legend> <font color="#000000" size="-1">套餐信息</font>
	</legend>
	<table border="0" width="100%">
		<tr>
			<td align="left" width="10%" class="tdarrow">套餐编号：</td>
			<td width="10%"><s:property value="card3g.packageNo" /></td>
			<td width="10%" class="tdarrow">套餐名称：</td>
			<td width="10%"><s:property value="pack.packageName" /></td>
			<td width="10%" class="tdarrow">预存金额：</td>
			<td width="10%"><s:property value="pack.moneyPreCharged" /></td>
			<td width="10%"></td>
			<td width="10%"></td>
		</tr>
		<tr>
			<td class="tdarrow">套餐月费(元/月)：</td>
			<td><s:property value="pack.feeMonthly1" /></td>
			<td class="tdarrow">可用流量(G)：</td>
			<td><s:property value="pack.maxBytesGbMonthly1" /></td>
			<td class="tdarrow">可用时长(小时)：</td>
			<td><s:property value="pack.maxHoursMonthly1" /></td>
			<td></td>
			<td></td>
		</tr>
	</table>
	</fieldset>
	</div>
	<br>

	<div align="center">
	<fieldset style="width:95%"><legend> <font color="#000000" size="-1">用户信息</font>
	</legend>
	<table width="100%">
		<tr>
			<td width="10%" class="tdarrow">用户姓名：</td>
			<td width="10%"><s:property value="card3g.customerName" /></td>
			<td width="10%" class="tdarrow">性别：</td>
			<td width="10%"><s:property value="card3g.customerSexDesc" /></td>
			<td width="10%" class="tdarrow">联系电话：</td>
			<td width="10%"><s:property value="card3g.customerPhoneNo"/></td>
			<td width="10%"></td>
			<td width="10%"></td>
		</tr>
		<tr>
			<td class="tdarrow">实名审核：</td>
			<td><s:property value="card3g.ifIdentityVerifiedDesc" /></td>
			<td class="tdarrow">证件类型：</td>
			<td><s:property value="card3g.customerCertificateNameDesc" /></td>
			<td class="tdarrow">证件号码：</td>
			<td><s:property value="card3g.customerCertificateNo" /></td>
		</tr>
		<tr>
			<td class="tdarrow">账单地址：</td>
			<td><s:property value="card3g.customerAddress"/></td>
			<td class="tdarrow">邮政编码：</td>
			<td><s:property value="card3g.customerPostCode"/></td>
		</tr>
		<tr>
			<td class="tdarrow">Email地址：</td>
			<td><s:property value="card3g.customerEmail"/></td>
		</tr>
		<tr>
			<td class="tdarrow">登录IP：</td>
			<td>
			<s:property value="card3g.loginIP" /></td>
			<td class="tdarrow">登录时间：</td>
			<td>
			<s:property value="card3g.loginTime" /></td>
		</tr>
	</table>
	</fieldset>
	</div>
	<br>
	<span><input type="button" value="返回" onclick="javascript:window.location = 'card3g_list.action'" class="button2_max"/></span>
</s:form>

<script type="text/javascript">
	$("table tr td").attr("align","left");
</script>
</BODY>
</HTML>
