<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>流量时长查询</TITLE>
<script src="../js/ui.core.js" type="text/javascript"></script>
<script src="../js/ui.datepicker.js" type="text/javascript"></script>
<link href="../css/ui.all.css" rel="stylesheet" type="text/css">
<link href="../css/ui.datepicker.css" rel="stylesheet" type="text/css">
<script>
jQuery(function($){
	$("#startDate, #endDate").datepicker({ 
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

function submitCheck(){
	var cardNo = $("#cardNo").val();
	if(cardNo == ""){
		alert("请输入卡号！");
	}else{
		$("#frm").submit();
	}
}

function hrefCheck(yearMonth){
	var cardNo = $("#cardNo").val();
	if(cardNo == ""){
		alert("请输入卡号！");
	}else{
		window.location = "bill_usageMonthly_list.action?yearMonth="+yearMonth+"&cardNo="+cardNo;
	}
}
</script>
</HEAD>

<BODY class="mainbg">
<div class="maintop">详单查询</div>
<div class="div_padding">
<div class="right">

		<s:form action="bill_usageMonthly_list" method="post" theme="simple" id="frm">
		<div class="box_relative">
			<fieldset style="width:720px"><legend> <font color="#000000" size="-1">查询条件</font> </legend>
		<div align="center">	
			<table width="700px">
				<tr><td height="10"></td></tr>
				<tr>
					<td>
						<table>
							<tr>
								<s:iterator value="dateList">
									<td width="10%"><strong><a href="#" onclick="hrefCheck(<s:property value='value' />)"><s:property value="label" /></a></strong></td>
								</s:iterator>
							</tr>
						</table>
					</td>
				</tr>
				<tr><td height="10"></td></tr>
				<tr>
					<td align="left">
					<table>
						<tr>
							<td class="mandatoryField">卡号：</td>
							<td><s:textfield name="cardNo" id="cardNo" maxlength="11"/>(输入完整卡号)</td>
						</tr>
						<tr>
							<td class="tdarrow">开始日期：</td>
							<td ><s:textfield id="startDate" name="startDate"/></td>
							<td class="tdarrow">结束日期：</td>
							<td ><s:textfield id="endDate" name="endDate"/></td>
						</tr>
					</table>
					</td>
				</tr>
				<tr><td height="10"></td></tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="查询" class="button2" onclick="submitCheck()"/>
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
						</td>
					</tr>
					<tr><td height="10"></td></tr>
					<tr><td>
						<table width="100%">
						  <tr>
						    <td class="tdarrow" width="10%">卡号:</td>
						    <td><s:property value="cardNo"/></td>
						  </tr>
						  <tr>
						    <td class="tdarrow">计费周期:</td>
						    <td><fmt:formatDate value="${startDate}" pattern="yyyy年MM月dd日"/> 至  <fmt:formatDate value="${endDate}" pattern="yyyy年MM月dd日"/></td>
						  </tr>
						  <tr>
						    <td class="tdarrow">总流量合计:</td>
						    <td>
						    <c:if test="${total>=1024000}">${total/1024000 + 0}G</c:if>
						    <c:if test="${total<1024000}">${total/1024 + 0}MB</c:if>
						    <c:if test="${empty total}">0MB</c:if>
						    </td>
						  </tr>
						  <tr>
						    <td class="tdarrow">总时长合计:</td>
						    <td>${hours + 0}小时${minutes + 0}分</td>
						  </tr>
						</table>
						
						<p></p>
							<display:table name="pageResult" class="list" id="row" style="width:100%" cellpadding="1" cellspacing="0" requestURI="" export="false" pagesize="30">
								<display:column headerClass="tit" title="序号"> <c:out value="${row_rowNum}"/></display:column>
								<display:column headerClass="tit" title="上线时间" property="entryTime" format="{0,date,yyyy-MM-dd HH:mm:ss}"/>
								<display:column headerClass="tit" title="下线时间" property="endTime" format="{0,date,yyyy-MM-dd HH:mm:ss}"/>
								<display:column headerClass="tit" title="上行流量" property="upBytesKb" format="{0,number,.##KB}"/>
								<display:column headerClass="tit" title="下行流量" property="downBytesKb" format="{0,number,.##KB}"/>
								<display:column headerClass="tit" title="总流量" property="totalBytesKb" format="{0,number,.##KB}"/>
								<display:column  headerClass="tit"title="时长">
								<c:if test="${row.totalTimeMinutes/60>1}"><fmt:formatNumber value="${ row.totalTimeMinutes/60}" pattern="#分"/></c:if><fmt:formatNumber value="${ row.totalTimeMinutes%60}" pattern="#秒"/>
								</display:column>
							</display:table>
					</td></tr>
				</table>
</div>
</div>
</div>
</BODY>
</HTML>
