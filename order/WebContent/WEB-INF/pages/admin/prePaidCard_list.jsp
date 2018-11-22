<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>充值卡管理</TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<script src="../js/ui.core.js" type="text/javascript"></script>
<script src="../js/ui.datepicker.js" type="text/javascript"></script>
<link href="../css/ui.all.css" rel="stylesheet" type="text/css">
<link href="../css/ui.datepicker.css" rel="stylesheet" type="text/css">
<script>
//去左空格; 
function ltrim(s){ 
 return s.replace( /^\s*/, ""); 
} 
//去右空格; 
function rtrim(s){ 
 return s.replace( /\s*$/, ""); 
} 
//去左右空格; 
function trim(s){ 
 return rtrim(ltrim(s)); 
}

jQuery(function($){
	$("#startValidDate,#endValidDate").datepicker({ 
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

function deleteCard(prePaidCardNo,nowPage){
	if(confirm("确认执行充值卡作废操作吗？")){
		$.ajax({
		    url: "check_status.action?ajax=true&prePaidCardNo="+prePaidCardNo,
		    type: 'POST',
		    dataType: 'html',
		    success: function(val){
		    	if(val == "2"){
			    	alert("该充值卡已经完成充值，无法作废");
		    	}else{
			    	window.location = "prePaidCard_delete.action?prePaidCardNo="+prePaidCardNo + "&page=" + nowPage;
		    	}
			}
		});
	}
}

function checkCard(prePaidCardNo,nowPage){
	if(confirm("确认执行充值卡验证操作吗？")){
		$.ajax({
		    url: "check_status.action?ajax=true&prePaidCardNo="+prePaidCardNo,
		    type: 'POST',
		    dataType: 'html',
		    success: function(val){
		    	if(val != "0"){
			    	alert("该充值卡不是初始状态，无法验证");
		    	}else{
		    		window.location = "prePaidCard_check.action?prePaidCardNo="+prePaidCardNo + "&page=" + nowPage;
		    	}
			}
		});
	}
}

function resetVal()
{
	$("[name = perPaidCard.prePaidCardNo]").val('');
	$("[name = perPaidCard.status]").val('');
	$("[name = query.queryCondition.startValidDate]").val('');
	$("[name = query.queryCondition.endValidDate]").val('');
	$("[name = perPaidCard.balance]").val('');
}
</script>
</HEAD>

<BODY  class="mainbg">
<div class="maintop">充值卡管理</div>
		<s:form action="prePaidCard_list" method="post" theme="simple">
	<div class="box_relative">
	<fieldset style="width: 380px"><legend> <font color="#000000" size="-1">查询条件</font> </legend>
	<div align="center">
	<table width="360px" border = 0 cellspacing = 0 cellpadding = 0>
						<tr>
							<td align="left" width="120px" class="tdarrow">充值卡号：</td>
							<td width="200px"><s:textfield name="perPaidCard.prePaidCardNo" /></td>
						</tr>
						<tr>	
							<td align="left" class="tdarrow">充值卡状态：</td>
							<td >
								<s:select list="statusList"  name="perPaidCard.status" headerKey="" headerValue="--全部--" listKey="value" listValue="label"></s:select>
							</td>
						</tr>
						<tr>
							<td align="left" class="tdarrow">有效期From：</td>
							<td><s:textfield name="query.queryCondition.startValidDate" id="startValidDate"/></td>
						</tr>
						<tr>
							<td align="left" class="tdarrow">有效期To：</td>
							<td><s:textfield name="query.queryCondition.endValidDate" id="endValidDate"/></td>
						</tr>
						<tr>
							<td align="left" class="tdarrow">面额：</td>
							<td ><s:textfield name="perPaidCard.balance" onkeyup="value=value.replace(/[^\d]/g,'')"  onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/></td>
						</tr>
					</table>
				</div>
				</fieldset>
			</div>
		<table>
			<tr>
				<td align="right"><s:submit value="查询" cssClass="button2" ></s:submit>
				<input type="button" value="重置" class="button2" onclick="resetVal()"/></td>
			</tr>
		</table>	
			

			<s:hidden name="nameOfSubmit" value = "newSearch"> </s:hidden > 
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
					title="序号"> 
					${row.id}
				</display:column>

				<display:column headerClass="tit" paramId="id" paramProperty="id"
					title="充值卡号"> 
					${row.prePaidCardNo}
				</display:column>

				<display:column headerClass="tit" paramId="id" paramProperty="id"
					title="充值卡状态"> 
					${row.statusName}
				</display:column>

				<display:column headerClass="tit" paramId="id" paramProperty="id"
					title="面额"> 
		        	${row.balance}
				</display:column>

				<display:column headerClass="tit" paramId="id" paramProperty="id"
					title="有效期"> 
					${row.validDate}
				</display:column>

				<display:column headerClass="tit" paramId="id" paramProperty="id"
					title="制作日期"> 
					${row.createTime}
				</display:column>

				<display:column headerClass="tit" paramId="id" paramProperty="id" title="操作">
					<s:if test="map.checkSet">  
					<a href="#" onclick="deleteCard('${row.prePaidCardNo}','${page}')"><b>作废</b></a>&nbsp;
					</s:if>
					<s:if test="map.deleteSet"> 
					<a href="#" onclick="checkCard('${row.prePaidCardNo}','${page}')"><b>验证</b></a><br>
					</s:if>
				</display:column>
			</display:table>
	</div>
<!--<input type="button" class="button2_max" value="添加" onclick="javascript:window.location='prePaidCard_add.action'" /> -->
</div>
</BODY>
</HTML>
