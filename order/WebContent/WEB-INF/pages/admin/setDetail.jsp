<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<title>套餐详细信息</title>
<style>
.td {
	border: 1px solid #000000;
	width: 10%;
}
</style>
<script type="text/javascript">
	function goSetList(){
		window.location = "list_set.action";
	}
</script>
</head>
<BODY class="mainbg">
<div class="maintop">套餐信息</div>

	<div class="div_padding">
	<div class="box_relative">	
	<fieldset style="width:800px"><legend> <font color="#000000" size="-1">基本信息</font>
	</legend>
					<table width=“780px”>
							<tr>
								<td class="tdarrow" width="10%">套餐编号：</td>
								<td  width="15%"><s:property value="pkg.packageNo"/></td>
								<td class="tdarrow"  width="10%">套餐名称：</td>
								<td  width="15%"><s:property value="pkg.packageName"/></td>
								<td  class="tdarrow" width="10%">套餐状态：</td>
								<td  width="15%"><s:if test="pkg.status==1">可用</s:if>
												<s:elseif test="pkg.status==2">不可用</s:elseif>
								</td>
							</tr>
							<tr>
								<td  class="tdarrow" width="10%">套餐类别：</td>
								<td  width="15%"><s:if test="pkg.packageType==1">流量型</s:if>
												<s:elseif test="pkg.packageType==2">时长型</s:elseif>
												<s:elseif test="pkg.packageType==3">混合型</s:elseif>
								</td>
								<td  class="tdarrow" width="15%">超出流量后资费(元/MB)：</td>
								<td  width="15%"><s:property value="pkg.feePerMbIfExceed"/></td>
								<td  class="tdarrow" width="15%">超出时长后资费(元/分钟)：</td>
								<td  width="15%"><s:property value="pkg.feePerMinuteIfExceed"/></td>
							</tr>
							<tr>
								<td  class="tdarrow" width="10%">有效期(月)：</td>
								<td  width="15%"><s:property value="pkg.validMonths"/></td>
								<td  class="tdarrow" width="10%">预存金额(元)：</td>
								<td  width="15%"><s:property value="pkg.moneyPreCharged"/></td>
								<td  class="tdarrow" width="10%">使用人数：</td>
								<td  width="15%"><s:property value="pkg.numberOfUser"/></td>
							</tr>
						</table>
					</fieldset>
			</div>
			</div>
	<div class="div_padding">
	<div class="box_relative">	
	<fieldset style="width:800px"><legend> <font color="#000000" size="-1">分级信息</font>
	</legend>
							<table width="780px">
							<tr height="10px"/>
							<tr>
								<td class="tdarrow" width="10%">套餐分级：</td>
								<td>
								<s:if test="pkg.ifMultiGrades==1">基础</s:if>
												<s:elseif test="pkg.ifMultiGrades==2">二级</s:elseif>
												<s:elseif test="pkg.ifMultiGrades==3">三级</s:elseif>
												<s:elseif test="pkg.ifMultiGrades==4">四级</s:elseif>
												<s:elseif test="pkg.ifMultiGrades==5">五级</s:elseif>
								<td colspan="5">&nbsp;</td>
							</tr>
							<tr height="10px"/>
							<tr>
								<td class="tdarrow">基础套餐</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td width="6%">&nbsp;</td>
								<td class="tdarrow" width="12%">套餐月费(元/月)：</td>
								<td width="10%"><s:property value="pkg.feeMonthly1"/></td>
								<td class="tdarrow" width="10%" >可用流量(G)：</td>
								<td width="10%"><s:property value="pkg.maxBytesGbMonthly1"/></td>
								<td class="tdarrow" width="12%" >可用时长(小时)：</td>
								<td width="10%"><s:property value="pkg.maxHoursMonthly1"/></td>
							</tr>
							<tr>
								<td class="tdarrow">套餐分级二</td>
								<td colspan="6">&nbsp;</td>
							</tr>
							<tr>
								<td width="10%">&nbsp;</td>
								<td width="10%" class="tdarrow">套餐月费(元/月)：</td>
								<td width="10%"><s:property value="pkg.feeMonthly2"/></td>
								<td width="10%"  class="tdarrow">可用流量(G)：</td>
								<td width="10%"><s:property value="pkg.maxBytesGbMonthly2"/></td>
								<td width="10%" class="tdarrow" >可用时长(小时)：</td>
								<td width="10%"><s:property value="pkg.maxHoursMonthly2"/></td>
							</tr>
							<tr>
								<td class="tdarrow">套餐分级三</td>
								<td colspan="6">&nbsp;</td>
							</tr>
							<tr>
								<td width="10%">&nbsp;</td>
								<td width="10%" class="tdarrow">套餐月费(元/月)：</td>
								<td width="10%"><s:property value="pkg.feeMonthly3"/></td>
								<td width="10%"  class="tdarrow">可用流量(G)：</td>
								<td width="10%"><s:property value="pkg.maxBytesGbMonthly3"/></td>
								<td width="10%" class="tdarrow">可用时长(小时)：</td>
								<td width="10%"><s:property value="pkg.maxHoursMonthly3"/></td>
							</tr>
							<tr>
								<td class="tdarrow">套餐分级四</td>
								<td colspan="6">&nbsp;</td>
							</tr>
							<tr>
							<td  width="10%">&nbsp;</td>
								<td width="10%" class="tdarrow">套餐月费(元/月)：</td>
								<td width="10%"><s:property value="pkg.feeMonthly4"/></td>
								<td width="10%"  class="tdarrow">可用流量(G)：</td>
								<td width="10%"><s:property value="pkg.maxBytesGbMonthly4"/></td>
								<td width="10%"  class="tdarrow">可用时长(小时)：</td>
								<td width="10%"><s:property value="pkg.maxHoursMonthly4"/></td>
							</tr>
							<tr>
								<td class="tdarrow">套餐分级五</td>
								<td colspan="6">&nbsp;</td>
							</tr>
							<tr>
								<td width="10%">&nbsp;</td>
								<td width="10%" class="tdarrow">套餐月费(元/月)：</td>
								<td width="10%"><s:property value="pkg.feeMonthly5"/></td>
								<td width="10%" class="tdarrow">可用流量(G)：</td>
								<td  width="10%"><s:property value="pkg.maxBytesGbMonthly5"/></td>
								<td width="10%"  class="tdarrow">可用时长(小时)：</td>
								<td width="10%"><s:property value="pkg.maxHoursMonthly5"/></td>
							</tr>
						</table>
					</fieldset>
					</div>
					</div>
			<div class="div_padding">
				<div class="box_relative">	
					<fieldset style="width:800px"><legend> <font color="#000000" size="-1">其他信息</font>
							</legend>
							<table width="780px">
						<table>
							<tr>
								<td width="10%" class="tdarrow">静态页面URL：</td>
								<td><s:property value="pkg.urlHtml"/></td>
							</tr>
							<tr>
								<td width="10%" class="tdarrow">套餐描述：</td>
								<td width="10%"><s:property value="pkg.description"/></td>
							</tr>
						</table>
					</fieldset>
					</div>
				</div>
				<input type="button" value="返回" class="button2_max" onclick="goSetList();"/>

	</div>
</body>
</html>