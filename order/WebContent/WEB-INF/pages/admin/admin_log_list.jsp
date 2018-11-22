<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>后台日志查询</TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<script src="../js/ui.core.js" type="text/javascript"></script>
<script src="../js/ui.datepicker.js" type="text/javascript"></script>
<link href="../css/ui.all.css" rel="stylesheet" type="text/css">
<link href="../css/ui.datepicker.css" rel="stylesheet" type="text/css">
<script>
jQuery(function($){
	$("#stratDate, #endDate").datepicker({ 
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
	$("[name = adminLog.username]").val('');
	$("[name = adminLog.logType]").val('');
	$("[name = adminLog.cardNo]").val('');
	$("[name = query.queryCondition.startDate]").val('');
	$("[name = query.queryCondition.endDate]").val('');
}
</script>
</HEAD>

<BODY class="mainbg">
<div class="maintop">日志查询</div>

		<s:form action="admin_log_list" method="post" theme="simple">
	<div class="box_relative">
	<fieldset style="width: 380px"><legend> <font
	color="#000000" size="-1">查询条件</font> </legend>
	<div align="center">
	<table width="360px" border = 0 cellspacing = 0 cellpadding = 0>
				<tr><td height="10"></td></tr>
				<tr>
					<td align="center">
					<table>
						<tr>
							<td width="120px" class="tdarrow">操作人：</td>
							<td width="200px">
<!--								<s:textfield name="adminLog.username" />-->
								<s:select list="getTsUser()" name="adminLog.username" headerKey="" headerValue="--全部--" listKey="username" listValue="username"></s:select>	
							</td>
						</tr>
						<tr>
							<td width="120px" class="tdarrow">日志类型：</td>
							<td width="200px">
								<s:select list="getLogType()" name="adminLog.logType" headerKey="" headerValue="--全部--" listKey="value" listValue="label"></s:select>	
							</td>
						</tr>
						<tr>							
							<td width="10%" class="tdarrow">卡号：</td>
							<td width="10%"><s:textfield name="adminLog.cardNo" /></td>
						</tr>
						<tr>
							<td width="10%" class="tdarrow">操作开始日期：</td>
							<td width="10%"><s:textfield name="query.queryCondition.startDate" id="stratDate"/></td>
						</tr>
						<tr>							
							<td width="10%" class="tdarrow">操作结束日期：</td>
							<td width="10%"><s:textfield name="query.queryCondition.endDate" id="endDate"/></td>
						</tr>
					</table>
					</td>
				</tr>
				<tr><td height="10"></td></tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<s:submit value="查询" cssClass="button2"></s:submit>
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
				<h2>检索结果一览</h2>
				</li>
			</ul>
	<div class="right">				
			<display:table name="pageResult" class="list"
				id="row" style="width:100%" cellpadding="1" cellspacing="0"
				requestURI="" export="false" pagesize="10">

				<display:column headerClass="tit" paramId="id" paramProperty="id"
					title="操作人"> 
					${row.username}
				</display:column>

				<display:column headerClass="tit" paramId="id" paramProperty="id"
					title="操作时间"> 
					${row.logDate}
				</display:column>
				
				<display:column headerClass="tit" paramId="id" paramProperty="id"
					title="日志类型"> 
					${row.logTypeDesc}
				</display:column>
				
				<display:column headerClass="tit" paramId="id" paramProperty="id"
					title="卡号"> 
		        	${row.cardNo}
				</display:column>

				<display:column headerClass="tit" paramId="id" paramProperty="id"
					title="操作IP"> 
		        	${row.logIp}
				</display:column>

				<display:column headerClass="tit" paramId="id" paramProperty="id"
					title="日志详细"> 
					${row.logDesc}
				</display:column>
			</display:table>
	</div>		

</BODY>
</HTML>
