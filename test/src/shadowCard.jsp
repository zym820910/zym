<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="/common/ecside.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="cache-control" content="no-cache"/>
<meta http-equiv="expires" content="0"/>


<div class="blue">
	主卡信息
</div>

<table width="90%" border="0" cellspacing="0" cellpadding="0"   class="ictable">
	<tr>
		<th style="text-align:right;width: 10%">3G卡号:</th>
		<td style="text-align:left; width: 20%">
			<c:out value='${card.cardNo}'/>
	 	</td>
	 	
	 	<th style="text-align:right;width: 10%">imsi:</th>
		<td style="text-align:left; width: 20%"> 
			<c:out value='${card.imsi}'/>
	 	</td>
	 	
	 	<th style="text-align:right; width: 10%">iccid:</th>
		<td style="text-align:left; width: 20%">
			<c:out value='${card.iccid}'/>
	 	</td>
	</tr>
	
	<tr>
		<th width="15%" style="text-align:right;">卡状态:</th>
		<td width="35%" style="text-align:left;">
			<c:choose>
				<c:when test="${card.status ==1}">空卡</c:when>
				<c:when test="${card.status ==2}">激活</c:when>
				<c:when test="${card.status ==3}">欠费停机</c:when>
				<c:when test="${card.status ==4}">到期停机</c:when>
				<c:otherwise></c:otherwise>
			</c:choose>
	 	</td>
		<th style="text-align:right;">激活日期:</th>
		<td style="text-align:left;">
			<fmt:formatDate  pattern="yyyy-MM-dd" value='${card.packageActiveDate}'/>
	 	</td>
	 	<th style="text-align:right;">有效期:</th>
		<td style="text-align:left;">
			<fmt:formatDate  pattern="yyyy-MM-dd" value='${card.packageMaturityDate}'/>
	 	</td>
	</tr>
	
	<tr>
		<th width="15%" style="text-align:right;">帐户余额:</th>
		<td width="35%" style="text-align:left;">
			<c:out value='${card.balance}'/>
	 	</td>
	 	
		<th width="15%" style="text-align:right;">登陆IP:</th>
		<td width="35%" style="text-align:left;">
			<c:out value='${card.loginIp}'/>
	 	</td>
		
	 	<th style="text-align:right;">第一次使用时间:</th>
		<td style="text-align:left;"> 
			<fmt:formatDate  pattern="yyyy-MM-dd hh:mm:ss" value='${card.firstUseDate}'/>
	 	</td>
	</tr>
	
	
	
	
	
	<tr>
		<th style="text-align:right;">挂失日期:</th>
		<td style="text-align:left;">
			<fmt:formatDate  pattern="yyyy-MM-dd" value='${card.suspendDate}'/>
	 	</td>
	 	<th style="text-align:right;">添加日期:</th>
		<td style="text-align:left;">
			<fmt:formatDate  pattern="yyyy-MM-dd hh:mm:ss" value='${card.appendDatetime}'/>
	 	</td>
	 	
	 	<th style="text-align:right;">删除时间:</th>
		<td style="text-align:left;">
			<fmt:formatDate  pattern="yyyy-MM-dd hh:mm:ss" value='${card.deleteDate}'/>
	 	</td>
	</tr>
	
	<tr>
		<th style="text-align:right;">3G卡销售日期:</th>
		<td style="text-align:left;">
			<fmt:formatDate  pattern="yyyy-MM-dd" value='${card.soldDate}'/>
	 	</td>
	 	<th style="text-align:right;">第一次使用时间:</th>
		<td style="text-align:left;">
			<fmt:formatDate  pattern="yyyy-MM-dd" value='${card.firstUseDate}'/>
	 	</td>
	 	
	 	<th style="text-align:right;">是否余额不足:</th>
		<td style="text-align:left;">
			<c:if test="${card.ifBalanceUnsufficient == true}">不足</c:if>
			<c:if test="${card.ifBalanceUnsufficient == false}">足</c:if>
	 	</td>
	</tr>
	
	<tr>
		<th style="text-align:right;">停机日期:</th>
		<td style="text-align:left;">
			<fmt:formatDate  pattern="yyyy-MM-dd" value='${card.outOfServiceDate}'/>
	 	</td>
	 	
	 	<td colspan="4">&nbsp;</td>
	</tr>
</table>	
	
<br></br>	

<div class="blue">
	套餐信息
</div>	

<table width="90%" border="0" cellspacing="0" cellpadding="0"  class="ictable">	
	<tr>
		<th style="text-align:right;">套餐编号:</th>
		<td style="text-align:left;">
			<c:out value='${card.packageNo}'/>
	 	</td>
	 	<th style="text-align:right;">套餐名字:</th>
		<td style="text-align:left;">
			<c:out value='${card.packageName}'/>
	 	</td>
	 	<th style="text-align:right;">预存金额:</th>
		<td style="text-align:left;">
			<c:out value='${card.moneyPreCharged}'/>
	 	</td>
	</tr>
</table>


<div class="blue">
	用户信息
</div>
<table width="90%" border="0" cellspacing="0" cellpadding="0" class="ictable">	
	<tr>
		<th style="text-align:right;">用户姓名:</th>
		<td style="text-align:left;">
			<c:out value='${card.customerName}'/>
	 	</td>
	 	<th style="text-align:right;">联系电话:</th>
		<td style="text-align:left;">
			<c:out value='${card.customerPhoneNo}'/>
	 	</td>
	 	<th style="text-align:right;">性别:</th>
		<td style="text-align:left;">
			<c:if test="${card.customerSex==1}">男</c:if>
			<c:if test="${card.customerSex==2}">女</c:if>
	 	</td>
	 	
	</tr>
	
	
	<tr>
		<th style="text-align:right;">证件类型:</th>
		<td style="text-align:left;">
			<c:choose>
				<c:when test="${card.customerCertificateName ==1}">身份证</c:when>
				<c:when test="${card.customerCertificateName ==2}">护照</c:when>
				<c:when test="${card.customerCertificateName ==3}">军官证</c:when>
				<c:when test="${card.customerCertificateName ==4}">驾驶证</c:when>
				<c:when test="${card.customerCertificateName ==5}">其他（回乡证，台胞证）</c:when>
			</c:choose>
	 	</td>
	 	<th style="text-align:right;">证件号码:</th>
		<td style="text-align:left;">
			<c:out value='${card.customerCertificateNo}'/>
	 	</td>
	
	</tr>
	
	<tr>
		
	 	<th style="text-align:right;">email:</th>
		<td style="text-align:left;">
			<c:out value='${card.customerEmail}'/>
	 	</td>
	 	
	 	<th style="text-align:right;">实名审核状态:</th>
		<td style="text-align:left;">
			<c:if test="${card.ifIdentityVerified == true}">通过</c:if>
			<c:if test="${card.ifIdentityVerified == false}">不通过</c:if>
	 	</td>
	</tr>
	
	
	<tr>
		<th style="text-align:right;">联系地址:</th>
		<td style="text-align:left;" colspan="3">
			<c:out value='${card.customerAddress}'/>
	 	</td>
	</tr>


</table>



