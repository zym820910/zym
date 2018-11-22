<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>3G卡管理</TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<script src="../js/ui.core.js" type="text/javascript"></script>
<script src="../js/ui.datepicker.js" type="text/javascript"></script>
<link href="../css/ui.all.css" rel="stylesheet" type="text/css">
<link href="../css/ui.datepicker.css" rel="stylesheet" type="text/css">
<script>
	function deleteCard(cardNo, status ,page){
		if(confirm("确定要删除吗？")){
			if(status == 2){
				alert("无法删除激活卡！");
				return;
			}
		window.location = 'card3g_delete.action?cardNo='+cardNo+'&page='+page;
		}
	}

jQuery(function($){
	$("#packageActiveStartDate, #packageActiveEndDate,#soldStartDate,#soldEndDate,#packageMaturityStartDate, #packageMaturityEndDate,#suspendStartDate,#suspendEndDate,#outOfServiceStartDate,#outOfServiceEndDate").datepicker({ 
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

function resetVal(){
	$("[name = card3g.cardNo]").val('');
	$("[name = card3g.iccid]").val('');
	$("[name = card3g.imsi]").val('');
	$("[name = card3g.status]").val('');
	$("[name = query.queryCondition.packageActiveStartDate]").val('');
	$("[name = query.queryCondition.packageActiveEndDate]").val('');
	$("[name = query.queryCondition.soldStartDate]").val('');
	$("[name = query.queryCondition.soldEndDate]").val('');
	$("[name = query.queryCondition.packageMaturityStartDate]").val('');
	$("[name = query.queryCondition.packageMaturityEndDate]").val('');
	$("[name = query.queryCondition.suspendStartDate]").val('');
	$("[name = query.queryCondition.suspendEndDate]").val('');
	$("[name = query.queryCondition.outOfServiceStartDate]").val('');
	$("[name = query.queryCondition.outOfServiceEndDate]").val('');
	$("[name = card3g.customerName]").val('');
	$("[name = card3g.customerCertificateNo]").val('');
	$("[name = card3g.customerPhoneNo]").val('');
	$("[name = query.queryCondition.ifIdentityVerified]").val('');
	$("[name = card3g.packageNo]").val('');
	$("[name = query.queryCondition.ifBalanceUnsufficient]").val('');
	$("[name = query.queryCondition.ifLimitExceed]").val('');
	$("[name = query.queryCondition.checkVal]").val('');
}
</script>
</HEAD>

<BODY class="mainbg">
<div class="maintop">3G卡管理</div>


		<s:form action="card3g_list" method="post" theme="simple">
		<s:hidden name="nameOfSubmit" value = "newSearch"> </s:hidden > 

				<div class="box_relative">
					<fieldset style="width:660px"><legend> <font color="#000000"
						size="-1">主卡信息</font> </legend>
					<div align="center">	
					<table>
						<tr>
							<td width="120px" class="tdarrow">卡号：</td>
							<td width="200px"><s:textfield name="card3g.cardNo" /></td>
							<td width="120px" class="tdarrow">ICCCID：</td>
							<td width="200px"><s:textfield name="card3g.iccid" /></td>
						</tr><tr>	
							<td  class="tdarrow">IMSI:</td>
							<td ><s:textfield name="card3g.imsi" /></td>
							<td  class="tdarrow">卡状态：</td>
							<td >
								<s:select name="card3g.status" list="statusList" headerKey="" headerValue="全部" listKey="value" listValue="label"></s:select>
							</td>
						</tr>
						<tr>
							<td class="tdarrow">激活日期开始：</td>
							<td ><s:textfield name="query.queryCondition.packageActiveStartDate" id="packageActiveStartDate" readonly="false" maxlength="10" /></td>
							<td class="tdarrow">结束：</td>
							<td ><s:textfield name="query.queryCondition.packageActiveEndDate" id="packageActiveEndDate" readonly="false" maxlength="10" /></td>
							</tr><tr>
							<td class="tdarrow">销售日期开始:</td>
							<td><s:textfield name="query.queryCondition.soldStartDate" id="soldStartDate" readonly="false" maxlength="10" /></td>
							<td class="tdarrow">结束：</td>
							<td><s:textfield name="query.queryCondition.soldEndDate" id="soldEndDate" readonly="false" maxlength="10" /></td>
						</tr>
						<tr>
							<td class="tdarrow">有效期日期开始：</td>
							<td><s:textfield name="query.queryCondition.packageMaturityStartDate" id="packageMaturityStartDate" readonly="false" maxlength="10" /></td>
							<td class="tdarrow">结束：</td>
							<td><s:textfield name="query.queryCondition.packageMaturityEndDate" id="packageMaturityEndDate" readonly="false" maxlength="10" /></td>
							</tr><tr>
							<td class="tdarrow">挂失日期开始:</td>
							<td><s:textfield name="query.queryCondition.suspendStartDate" id="suspendStartDate" readonly="false" maxlength="10" /></td>
							<td class="tdarrow">结束：</td>
							<td><s:textfield name="query.queryCondition.suspendEndDate" id="suspendEndDate" readonly="false" maxlength="10" /></td>
						</tr>
						<tr>
							<td class="tdarrow">停机日期开始：</td>
							<td><s:textfield name="query.queryCondition.outOfServiceStartDate" id="outOfServiceStartDate" readonly="false" maxlength="10" /></td>
							<td class="tdarrow">结束：</td>
							<td><s:textfield name="query.queryCondition.outOfServiceEndDate" id="outOfServiceEndDate" readonly="false" maxlength="10" /></td>
						</tr>
					</table>
					</div>
					</fieldset>
				</div>

				<div class="box_relative">					
					<fieldset style="width : 660px"><legend> <font color="#000000" size="-1">用户信息</font> </legend>
					<div align="center">					
					<table>
						<tr>
							<td width="120px" class="tdarrow">用户姓名：</td>
							<td width="200px"><s:textfield name="card3g.customerName" /></td>
							<td width="120px" class="tdarrow">证件号码：</td>
							<td width="200px"><s:textfield name="card3g.customerCertificateNo" /></td>
						</tr>
						<tr>
							<td width="120px" class="tdarrow">联系电话：</td>
							<td width="200px"><s:textfield name="card3g.customerPhoneNo" /></td>
							<td width="120px" class="tdarrow">实名审核：</td>
							<td width="200px">
								<s:select list="appStatusList" name="query.queryCondition.ifIdentityVerified" headerKey="" headerValue="全部" listKey="key" listValue="value"></s:select>
							</td>
						</tr>
					</table>
					</div>
					</fieldset>
				</div>

				<div class="box_relative">					
					<fieldset style = "width:660px"><legend> <font color="#000000"
						size="-1">套餐信息</font> </legend>
					<div class="center">
					<table>
						<tr>
							<td width="120px" class="tdarrow">套餐名称：</td>
							<td width="200px"><s:select list="packageList" id="packageNo"
								name="card3g.packageNo" headerKey="" headerValue="全部"
								listKey="packageNo" listValue="packageName"></s:select></td>
							<td width="120px" class="tdarrow">余额不足：</td>
							<td width="200px">
								<s:select list="getSelStatusList()" name="query.queryCondition.ifBalanceUnsufficient" headerKey="" headerValue="全部" listKey="key" listValue="value"></s:select>
							</td>
						</tr>
						<tr>
							<td width="120px" class="tdarrow">流量或时长超限：</td>
							<td width="200px">
								<s:select list="getSelStatusList()" name="query.queryCondition.ifLimitExceed" headerKey="" headerValue="全部" listKey="key" listValue="value"></s:select>
							</td>
<!--							<s:checkbox name="card3g.ifBalanceUnsufficient" fieldValue="true">余额不足 </s:checkbox>-->
<!--							<s:checkbox name="card3g.ifLimitExceed" fieldValue="true">流量或时长超限 </s:checkbox>-->
							<td width="120px" class="tdarrow">卡使用情况：</td>
							<td width="120px" >
							<s:select list="checkList" name="query.queryCondition.checkVal" headerKey="" headerValue="全部" listKey="value" listValue="label" />
							</td>
						</tr>
						<tr>
							<td height="5"></td>
						</tr>
					</table>
					</div>
					</fieldset>
				</div>
		<br>
		<div class="button_relative"><s:submit value="查询" cssClass="button2"></s:submit>
		<input type="button" class="button2" value="重置" onclick="resetVal();" />
		</div>
		<br>
		

		</s:form>
		
<table width=100% border = 0 cellspacing = 0 cellpadding = 0>
		<tr>
			<td class="td">
			<ul class="list4">
				<li>
				<h2>卡信息列表</h2>
				</li>
			</ul>
	<div class="div_padding">
	<div class="right">
			<display:table name="pageResult" class="list"
				id="row" style="width:100%" cellpadding="1" cellspacing="0"
				requestURI="" export="false" pagesize="10">

				<display:column headerClass="tit" paramId="id" paramProperty="id"
					title="卡号"> 
					<a title="查看明细" class="a" href="card3g_item_info.action?cardNo=${row.cardNo }">
						<c:if test="${row.ifLimitExceed == false && row.ifBalanceUnsufficient == true}">
							<strong><font color="#FFAF03">${row.cardNo}</font></strong>
						</c:if>
						<c:if test="${row.ifLimitExceed == true && row.ifBalanceUnsufficient == false}">
							<strong><font color="#1BFE03">${row.cardNo}</font></strong>
						</c:if>
						<c:if test="${row.ifLimitExceed == true && row.ifBalanceUnsufficient == true}">
							<strong><font color="red">${row.cardNo}</font></strong>
						</c:if>
						<c:if test="${row.ifLimitExceed == false && row.ifBalanceUnsufficient == false}">
							${row.cardNo}
						</c:if>
					</a>
				</display:column>

				<display:column headerClass="tit" paramId="id" paramProperty="id"
					title="卡状态"> 
					${row.statusName}
				</display:column>

				<display:column headerClass="tit" paramId="id" paramProperty="id"
					title="套餐名称"> 
		        	${row.pkg.packageName}
				</display:column>

				<display:column headerClass="tit" paramId="id" paramProperty="id"
					title="预存金额(元)"> 
					${row.moneyPreCharged}
				</display:column>

				<display:column headerClass="tit" paramId="id" paramProperty="id"
					title="账户余额(元)"> 
					${row.balance}
				</display:column>

				<display:column headerClass="tit" paramId="id" paramProperty="id"
					title="套餐到期日"> 
					${row.packageMaturityDate}
				</display:column>
				
				<display:column headerClass="tit" paramId="id" paramProperty="id"
					title="用户姓名"> 
					${row.customerName}
				</display:column>

				<display:column headerClass="tit" paramId="id" paramProperty="id"
					title="联系电话"> 
					${row.customerPhoneNo}
				</display:column>
				
				<display:column headerClass="tit" paramId="id" paramProperty="id" title="操作">
					<s:if test="map.mainCardSet"> 
					<a href="main_card_edit.action?cardNo=${row.cardNo }&page=${page }"><b>主卡</b></a>&nbsp;
					</s:if>
					<s:if test="map.packageSet"> 
					<a href="package_info_edit.action?cardNo=${row.cardNo }&page=${page }"><b>套餐</b></a>&nbsp;
					</s:if>
					<s:if test="map.moneySet">
					<a href="money_charged_details_add.action?cardNo=${row.cardNo }&page=${page }"><b>费用</b></a><br>
					</s:if>
					<s:if test="map.userSet">
					<a href="user_info_edit.action?cardNo=${row.cardNo }&page=${page }"><b>用户</b></a>&nbsp;
					</s:if>
					<s:if test="map.deleteSet">
					<a href="#" onclick="deleteCard('${row.cardNo }','${row.status }','${page }')"><b>删除</b></a>
					</s:if>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</display:column>
			</display:table>
		</div>
		</div>
			</td>

		</tr>

</table>

<!--<input type="button" class="button2_max" value="添加" onclick="javascript:window.location='card3g_add.action'" /> -->
<!--<input type="button" class="button2_max" value="导入" />-->

<script type="text/javascript">
	$("table tr td").attr("align","left");
</script>
</BODY>
</HTML>
