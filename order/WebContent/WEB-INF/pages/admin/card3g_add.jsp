<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>3G卡添加</TITLE>

<script src="../js/ui.core.js" type="text/javascript"></script>
<script src="../js/ui.datepicker.js" type="text/javascript"></script>
<link href="../css/ui.all.css" rel="stylesheet" type="text/css">
<link href="../css/ui.datepicker.css" rel="stylesheet" type="text/css">
<script>
function submitCheck(){
	var flag = true;
	var status = $("#cardStatus").val();
	//if(status == "1" ){}else 
		
	var cardNo = $("#cardNo").val();
		if(cardNo == ""){
		alert("卡号不能为空，请输入卡号");
		flag = false;
		return;
	}
		
	var imsi = $("#imsi").val();
	if(imsi == ""){
		alert("IMSI不能为空，请输入IMSI。");
		falg = false;
		return;
	}
	
	var packageNo = $("#packageNo").val();
	if(packageNo == ""){
		alert("套餐信息不能为空，请选择套餐信息。");
		flag = false;
		return;
	}

	if(status == "2" ){
		if(confirm("确定要添加新卡并同时激活吗？")){
			var packageActiveDate = $("#packageActiveDate").val();
			if(packageActiveDate == ""){
				alert("请输入激活日期，否则不能激活");
				flag = false;
				return;
			}
		}else
			return;
	}else{
		if(confirm("确定要添加新卡吗？")){
		}else
			return;
	}
	if(flag){
		//验证卡号是否重复
		$.ajax({
		    url: "cardNo_check.action?cardNo="+$("#cardNo").val()+"&imsi="+$("#imsi").val() ,
		    type: 'POST',
		    dataType: 'html',
		    success: function(val){
		    	if(val == "false")
		    	{
		    		alert("卡号已存在，请重新输入卡号");				
			    }else if(val == "imsiFail"){
			    	alert("IMSI已存在，请重新输入IMSI");
			    }
		    	else{
		    		$("#frm").submit();
		    	}
		    }
		});
	}
}

/**
$(function() {
	$("#packageActiveDate").datepicker();
	$("#packageMaturityDate").datepicker();
});
*/
jQuery(function($){
	$("#packageActiveDate, #packageMaturityDate,#firstUseDate").datepicker({ 
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

function setPackInfo(){
	var packageNo = $("#packageSel").val();
	if(packageNo != ""){
		$.ajax({
		    url: "gen_package_info.action?ajax=true&packageNo="+packageNo,
		    type: 'POST',
		    dataType: 'html',
		    success: function(val){
		    	if(val != "" && val.length > 0){
			    	var strs = val.split(',');
			    	$("#packageNo").val(strs[0]);
			    	$("#packageName").val(strs[1]);
			    	$("#feeMonthly1").val(strs[2]);
			    	$("#maxBytesGbMonthly1").val(strs[3]);
			    	$("#maxHoursMonthly1").val(strs[4]);
			    	$("#validMonths").val(strs[5]);
			    	$("#moneyPreCharged").val(strs[6]);
		    	}
		    }
		});
	}else{
		$("#packageNo").val("");
    	$("#packageName").val("");
    	$("#feeMonthly1").val("");
    	$("#maxBytesGbMonthly1").val("");
    	$("#maxHoursMonthly1").val("");
    	$("#validMonths").val("");
    	$("#moneyPreCharged").val("");
	}
}

function checktxt(){
	if((event.keyCode <48 || event.keyCode > 57) && event.keyCode != 8 && event.keyCode != 37 && event.keyCode != 39){
		event.returnValue = false;
	}
}
</script>
</HEAD>

<BODY class="mainbg">
<div class="maintop" >3G卡添加</div>
<s:form id="frm" action="card3g_save" method="post" theme="simple">
	<div class="box_relative">
	<fieldset style="width: 380px"><legend> <font
	color="#000000" size="-1">主卡信息</font> </legend>
	<div align="center">
	<table width="360px" border = 0 cellspacing = 0 cellpadding = 0>
		<tr >
			<td width="120px"class="mandatoryField" >卡号：</td>
			<td><s:textfield id="cardNo" name="card3g.cardNo" maxlength="11" /></td>
		</tr>
			<td class="tdarrow">ICCID：</td>
			<td><s:textfield name="card3g.iccid" /></td>
		</tr>
			<td class="mandatoryField">IMSI：</td>
			<td><s:textfield name="card3g.imsi" id="imsi" /></td>
		</tr>			
			<td class="mandatoryField">卡状态：</td>
			<td ><s:select list="statusList" name="card3g.status" id="cardStatus" listKey="value" listValue="label"></s:select></td>
		</tr>
		<tr>
			<td class="tdarrow">激活日期：</td>
			<td><s:textfield name="card3g.packageActiveDate" id="packageActiveDate" readonly="false" maxlength="10" /></td>
			<!--			<td class="tdarrow">有效日期：</td>-->
			<!--			<td><s:textfield name="card3g.packageMaturityDate" id="packageMaturityDate" readonly="false"/></td>-->
			<!--			<td class="tdarrow">第一次使用时间：</td>-->
			<!--			<td><s:textfield name="card3g.firstUseDate" id="firstUseDate" readonly="true"/></td>-->
			<td></td>
			<td></td>
		</tr>
	</table>
	</div>
	</fieldset>
	</div>

	<br>

	<div class="box_relative">
	<fieldset style="width: 380px"><legend> <font
		color="#000000" size="-1">套餐信息</font> </legend>
	<div align="center">
		<table border="0" width="360px">
		<tr>
			<td width="120px" class="mandatoryField">选择套餐：</td>
			<td > <s:select onchange="setPackInfo()"
				list="packageList" id="packageSel" name="query.queryCondition.packageNo" headerKey=""
				headerValue="--请选择--" listKey="packageNo" listValue="packageName" ></s:select>
			</td>
		</tr>			
		<tr>
			<td class="tdarrow">套餐编号：</td>
			<td ><s:textfield id="packageNo"
				name="card3g.packageNo" readonly="true" style="background-color:#f4fafc; border-style:none none dashed none; text-align:center; "/></td>
		</tr>
			<td  class="tdarrow">套餐名称：</td>
			<td ><s:textfield id="packageName"
				name="card3g.packageName" readonly="true" style="background-color:#f4fafc; border-style:none none dashed none; text-align:center; "/></td>
		</tr>
		<tr>
			<td class="tdarrow" >套餐月费：</td>
			<td><s:textfield id="feeMonthly1" name="pack.feeMonthly1"
				readonly="true" style="background-color:#f4fafc; border-style:none none dashed none; text-align:center; "/>元/月</td>
		</tr>			
			<td class="tdarrow" >可用流量：</td>
			<td><s:textfield id="maxBytesGbMonthly1"
				name="pack.maxBytesGbMonthly1" readonly="true" style="background-color:#f4fafc; border-style:none none dashed none;text-align:center;  "/>G</td>
		</tr>
			<td class="tdarrow" >可用时长：</td>
			<td><s:textfield id="maxHoursMonthly1"
				name="pack.maxHoursMonthly1" readonly="true" style="background-color:#f4fafc; border-style:none none dashed none; text-align:center; "/>(小时)</td>
		</tr>
		<tr>
			<td class="tdarrow">有效期：</td>
			<td><s:textfield id="validMonths" name="pack.validMonths"
				readonly="true" style="background-color:#f4fafc; border-style:none none dashed none; text-align:center; "/>月</td>
		</tr>			
			<td class="tdarrow">预存金额：</td>
			<td ><s:textfield id="moneyPreCharged"
				name="pack.moneyPreCharged" readonly="true" style="background-color:#f4fafc; border-style:none none dashed none; text-align:center; "/>元</td>
		</tr>
	</table>
	</div>
	</fieldset>
	</div>
	
	<br>

	<div class="box_relative">
	<fieldset style="width: 380px"><legend> <font
		color="#000000" size="-1">用户信息</font> </legend>
	<div align="center">		
	<table width="360px">
		<tr>
			<td width="120px" class="tdarrow">用户姓名：</td>
			<td ><s:textfield name="card3g.customerName" /></td>
		</tr>
		<tr>
			<td  class="tdarrow">性别：</td>
			<td align="left">
				<s:select name="card3g.customerSex" list="sexList" listKey="value" listValue="label"></s:select>
			</td>
		</tr>
		<tr>
			<td  class="tdarrow">联系电话：</td>
			<td ><s:textfield name="card3g.customerPhoneNo"></s:textfield>
			</td>
		</tr>
		<tr>
			<td class="tdarrow">实名审核：</td>
			<td align="left"><s:select list="appStatusList"
				name="card3g.ifIdentityVerified" listKey="key" listValue="value"></s:select>
			</td>
		</tr>
			<td class="tdarrow">证件类型：</td>
			<td><s:select list="certificateStatusList"
				name="card3g.customerCertificateName" headerKey=""
				headerValue="--请选择--" listKey="value" listValue="label"></s:select>
			</td>
		</tr>
			<td class="tdarrow">证件号码：</td>
			<td><s:textfield name="card3g.customerCertificateNo"
				maxLength="18" /></td>
		</tr>
		<tr>
			<td class="tdarrow">账单地址：</td>
			<td><s:textfield name="card3g.customerAddress" /></td>
		</tr>
			<td class="tdarrow">邮政编码：</td>
			<td><s:textfield name="card3g.customerPostCode" /></td>
		</tr>
		<tr>
			<td class="tdarrow">Email地址：</td>
			<td><s:textfield name="card3g.customerEmail" /></td>
		</tr>
	</table>
	</div>
	</fieldset>
	</div>
	<br>
	<span>
		<input type="button" value="保存" onclick="submitCheck()"
		class="button2_max" />
		</span>
	<!--	<span><input type="button" value="批量导入" onclick="" class="button4_max"/></span>-->
</s:form>
<script type="text/javascript">
	$("table tr td").attr("align","left");
</script>
</BODY>
</HTML>
