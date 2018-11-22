<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>充值卡制作</TITLE>

<script src="../js/ui.core.js" type="text/javascript"></script>
<script src="../js/ui.datepicker.js" type="text/javascript"></script>
<link href="../css/ui.all.css" rel="stylesheet" type="text/css">
<link href="../css/ui.datepicker.css" rel="stylesheet" type="text/css">
<script>
jQuery(function($){
	$("#validDate").datepicker({ 
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
	if(confirm("确认要制作充值卡吗？")){
		var start = $("#prePaidCardNo").val();
		var end = $("#prePaidCardNoEnd").val();
		var num = 1;
		if(end != "") 
		num = (end.substr(4,16) - 0) - (start.substr(4,16) - 0) + 1;
		if(num < 0){
			alert("您在卡号From/卡号To有误，请确认。");
			$("#endNum").val("");
		}else{
			$("#endNum").val(num);
			if(start.length != 16 || end.length != 16){
				alert("请您在卡号From和卡号To中填写16位数字");
			}
			else if($("#balance").val() == ""){
				alert("请输入充值卡面额");
			}
			else if($("#validDate").val() == ""){
				alert("请输入充值卡有效期");
			}else{
				$("#frm").submit();
			}
		}
	}
}

function genEndNum(){
	var start = $("#prePaidCardNo").val();
	var end = $("#prePaidCardNoEnd").val();
	var num = 1;
	if(start != "" && end != "") 
	num = (end.substr(4,16) - 0) - (start.substr(4,16) - 0) + 1;
	$("#endNum").val(num);
}

function checktxt(){
	if((event.keyCode <48 || event.keyCode > 57) && (event.keyCode <96 || event.keyCode > 105) && event.keyCode != 8 && event.keyCode != 37 && event.keyCode != 39){
		event.returnValue = false;
	}
}
</script>
</HEAD>

<BODY  class="mainbg">
<div class="maintop">充值卡制作</div>
<s:actionmessage/>
<script type="text/javascript">
	if($("ul li span").html() != null){
		$("ul li span").html("<img class='ico' alt='提示' src='../images/iconInformation.gif'><font color='red'>"+$("ul li span").text()+"</font>");
	}
</script>
<s:form id="frm" action="prePaidCard_save" method="post" theme="simple">
	
	<div class="box_relative">
	<fieldset style="width: 380px"><legend> <font color="#000000" size="-1">充值卡信息</font> </legend>
	<div align="center">
	<table width="360px" border = 0 cellspacing = 0 cellpadding = 0>
				<tr>
					<td align="left" width="10%" class="mandatoryField">卡号From：</td>
					<td width="15%" align="left"><s:textfield size="30" maxlength="16" onblur="genEndNum()" name="perPaidCard.prePaidCardNo" id="prePaidCardNo" onkeydown="checktxt()"/></td>
				</tr>
				<tr>					
					<td align="left" width="10%" class="mandatoryField">卡号To：</td>
					<td width="15%" align="left"><s:textfield size="30" maxlength="16" onblur="genEndNum()" id="prePaidCardNoEnd" onkeydown="checktxt()"/></td>
				</tr>
				<tr>					
					<td align="left" width="10%" class="tdarrow">总共：</td>
					<td width="10%" align="left"><s:textfield name="query.queryCondition.endNum" id="endNum" readonly="true"/>份</td>
				</tr>
				<tr>
					<td align="left" width="10%" class="mandatoryField">面额：</td>
					<td align="left" width="10%"><s:textfield maxlength="5" name="perPaidCard.balance" id="balance" onkeydown="checktxt()"/></td>
				</tr>
				<tr>					
					<td align="left" width="10%" class="mandatoryField">有效期：</td>
					<td align="left" width="10%"><s:textfield name="perPaidCard.validDate" id="validDate" maxlength="10"/></td>
				</tr>
			</table>
		</div>
	</fieldset>
	</div>
	<br>
	<div align=“right">
	<span><input type="button" value="开始制作" onclick="submitCheck()" class="button4_max"/></span>
	</div>
	<br>
</s:form>
</BODY>
</HTML>
