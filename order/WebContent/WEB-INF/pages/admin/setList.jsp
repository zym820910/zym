<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<title>套餐查询</title>
<style>
.td {
	border: 1px solid #000000;
}
</style>
<script type="text/javascript">
	function goSetDetail(packageNo){
		var path = "set_detail.action?pkg.packageNo="+packageNo;
		window.location=path;
		
	}
	
	function goSetAdd(){
		var path = "set_add.action";
		window.location=path;
		
	}
	
	function goSetEdit(packageNo){
		var path = "set_edit.action?pkg.packageNo="+packageNo;
		window.location=path;
	}	
	
	function setDelete(packageNo){
		if(confirm("确定要删除套餐信息吗?")){
			$.ajax({
			    url: "set_check.action?pkgNo="+packageNo,
			    type: 'POST',
			    dataType: 'html',
			    success: function(val){
			    	if(val == "false")
			    	{
			    		alert("套餐正在使用中，不能删除！");		
				    }
			    	else{
						var path = "set_delete.action?pkg.packageNo="+packageNo;
						window.location=path;
			    	}
			    }
			});
		}
		
	}	
</script>
</head>
<BODY class="mainbg">
<div class="maintop">套餐管理</div>

<s:actionmessage />
		<s:form action="list_set" method="post" theme="simple">
		<div class="box_relative">
			<fieldset style="width:380px"><legend> <font color="#000000" size="-1">查询条件</font> </legend>
		<div align="center">	
			<table width="360px">
				<tr>
					<td width="120px" class="tdarrow">套餐编号：</td>
					<td ><s:textfield name="pkg.packageNo" /></td>
				</tr>
				<tr>	
					<td class="tdarrow">套餐名称：</td>
					<td ><s:textfield name="pkg.packageName" /></td>
				</tr>
				<tr>
					<td class="tdarrow">套餐状态：</td>
					<td ><s:radio id="status" name="pkg.status"
						list="statusRadioList" listKey="value" listValue="label"
						theme="simple"></s:radio></td>
				</tr>
				<tr>
					<td class="tdarrow">套餐类别：</td>
					<td ><s:select id="packageType"
						name="pkg.packageType" list="typeList" listKey="value"
						listValue="label" headerKey="" headerValue="" /></td>
				</tr>
				<tr>
					<td class="tdarrow">套餐分级：</td>
					<td ><s:radio id="ifMultiGrades"
						name="pkg.ifMultiGrades" list="gradeRadioList" listKey="value"
						listValue="label" theme="simple"></s:radio></td>
				</tr>
				<tr>
					<td >&nbsp;</td>
					<td ><s:submit cssClass="button2" value="查询" /></td>
				</tr>
			</table>
		</div>
			</fieldset>
		</div>
		</s:form>



		<ul class="list4">
			<li>
			<h2>套餐信息列表</h2>
			</li>
		</ul>
<div class="right">		
		<display:table name="pageResult" class="list" id="row"
			style="width:100%" cellpadding="1" cellspacing="0" requestURI=""
			export="false" pagesize="10">
			<display:column headerClass="tit" paramId="id" paramProperty="id"
				title="套餐编号">
				<a href="javaScript:goSetDetail('${row.packageNo}')"><font
					color="blue"><b>${row.packageNo}</b></font></a>
			</display:column>
			<display:column headerClass="tit" paramId="id" paramProperty="id"
				title="套餐状态">
				<c:if test="${row.status=='1'}">可用</c:if>
				<c:if test="${row.status=='2'}">不可用</c:if>
			</display:column>
			<display:column headerClass="tit" paramId="id" paramProperty="id"
				title="套餐名称">
				<a href="javaScript:goSetDetail('${row.packageNo}')"><font
					color="blue"><b>${row.packageName}</b></font></a>
			</display:column>
			<display:column headerClass="tit" paramId="id" paramProperty="id"
				title="预存金额（元）">${row.moneyPreCharged}</display:column>
			<display:column headerClass="tit" paramId="id" paramProperty="id"
				title="套餐分级">
				<c:if test="${row.ifMultiGrades==1}">基础</c:if>
				<c:if test="${row.ifMultiGrades==2}">二级</c:if>
				<c:if test="${row.ifMultiGrades==3}">三级</c:if>
				<c:if test="${row.ifMultiGrades==4}">四级</c:if>
				<c:if test="${row.ifMultiGrades==5}">五级</c:if>
			</display:column>
			<display:column headerClass="tit" paramId="id" paramProperty="id"
				title="有效期（月）">${row.validMonths}</display:column>
			<display:column headerClass="tit" paramId="id" paramProperty="id"
				title="套餐月费(元/月)">${row.feeMonthly1}</display:column>
			<display:column headerClass="tit" paramId="id" paramProperty="id"
				title="可用流量(G)">${row.maxBytesGbMonthly1}</display:column>
			<display:column headerClass="tit" paramId="id" paramProperty="id"
				title="可用时长(小时)">${row.maxHoursMonthly1}</display:column>
			<display:column headerClass="tit" paramId="id" paramProperty="id"
				title="使用人数">${row.numberOfUser}</display:column>
			<s:if test="map.updateSet or map.deleteSet">
				<display:column headerClass="tit" paramId="id" paramProperty="id" title="操作">
					<s:if test="map.updateSet">
						<input type="button" value="修改" onclick="goSetEdit('${row.packageNo}')" />&nbsp;
					</s:if>
					<s:if test="map.deleteSet">
						<input type="button" value="删除" onclick="setDelete('${row.packageNo}')" />
					</s:if>
				</display:column>
			</s:if>
		</display:table>
</div>

<!--	<tr>-->
<!--		<td><input type="button" class="button2_max" value="添加"-->
<!--			onclick="goSetAdd();" /></td>-->
<!--	</tr>-->



</body>
</html>