<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/ecside.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="cache-control" content="no-cache"/>
<meta http-equiv="expires" content="0"/>
<script language="javaScript" src="<c:url value='/'/>js/storage/product/card_product.js"></script>
</head>
<body>
<div class="tabcontentcur">
<div id="container-1">
<center>

<div class="blue">
<span style="color:blue"><strong>产品组装</strong></span>
</div>

<s:form action ="addProductOut_json" namespace="/admin/storage/product/json" method ="POST">
<table width="99%"  border="0" cellspacing="0" cellpadding="0" class="table_1" >
	<tr style="height: 25px"> 
		<td class="td_title" style="width: 5%"><span style="color:red">*</span>imsi</td>
		<td class="td_content" style="width: 25%">
			<input class="underline" type="text" name="simNo_from" id="simNo_from" size="25" value=""/> 
			&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;&nbsp; 
			<input class="underline" type="text" name="simNo_to" id="simNo_to" size="25" value=""/>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</td>
		<td class="td_content" style="width: 5%">排除：</td>
		<td class="td_content" style="width: 30%">
			<input class="underline" type="text" name="simNo_not_exsit" id="simNo_not_exsit" size="50" value=""/>
		</td>
	</tr>
	
	<tr>
		<td class="td_title">硬件卡</td>
		<td class="td_content">
			<input class="underline" type="text" name="snNo_from" id="snNo_from" size="25" value=""/> 
 			&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;&nbsp; 
			<input class="underline" type="text" name="snNo_to" id="snNo_to" size="25" value=""/>
		</td>
		<td class="td_content">排除：</td>
		<td class="td_content">
			<input class="underline" type="text" name="snNo_not_exsit" id="snNo_not_exsit" size="50" value=""/>
		</td>
	</tr>
	
	<tr style="height: 25px">
		<td class="td_title">盒子号</td>
		<td class="td_content">
			<input class="underline" type="text" name="boxNo_from" id="boxNo_from" size="25" value=""/> 
 			&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;&nbsp; 
			<input class="underline" type="text" name="boxNo_to" id="boxNo_to" size="25" value=""/>
		</td>
		<td class="td_content">排除：</td>
		<td class="td_content">
			<input class="underline" type="text" name="boxNo_not_exsit" id="boxNo_not_exsit" size="50" value=""/>
		</td>
	</tr>
	
	<tr>
		<td class="td_title">套餐</td>
		<td class="td_content">
			<s:select list="packageList" listKey="packageNo" listValue="packageName" headerKey="" headerValue="请选择" 
				  name="packageNo"  id="packageNo"  cssStyle="width:120px"></s:select>			  
		</td>
		<td colspan="2" class="td_content"><span style="color:red">注：多个序号之间,务必统一使用逗号","分隔</span></td>
	</tr>
	
	<tr>
		<td class="td_title">创建业务账号</td>
		<td class="td_content">
			<input type="radio" name="bussinessAccount" id="bussinessAccount1" value="1" checked="checked"/>是
			<input type="radio" name="bussinessAccount" id="bussinessAccount2" value="0" />否
		</td>
		<td colspan="2" class="td_content"><span style="color:blue">业务账号：用户在后台管理系统中对应的3G卡</span></td>
	</tr>
</table>
<div style="text-align: left">
<span><span style="color:blue;">建议一次添加不超过1000个产品</span></span>
</div>
<input type="button" class="button_1" value="增加" name="addProducts" id="addProducts"/>
</s:form>




<div class="blue" style="text-align: left">

<span style="color:blue"><strong>组装单个产品：</strong></span>
</div>
<s:form action ="addProductOut_json" namespace="/admin/storage/product/json" method ="POST">
<table width="99%"  border="0" cellspacing="0" cellpadding="0" class="table_1" >
	<tr style="height: 25px">
		<td class="td_title" style="width: 8%"><span style="color:red">*</span>imsi</td>
		<td class="td_content" >
			<input class="underline" type="text" name="simNo" id="simNo" size="25" value=""/>
		</td>
	</tr>
	
	<tr>
		<td class="td_title">硬件卡</td>
		<td class="td_content">
			<input class="underline" type="text" name="snNo" id="snNo" size="25" value=""/>
		</td>
	</tr>
	
	<tr style="height: 25px">
		<td class="td_title">盒子号</td>
		<td class="td_content">
			<input class="underline" type="text" name="boxNo" id="boxNo" size="25" value=""/>
		</td>
	</tr>
	
	<tr>
		<td class="td_title">套餐</td>
		<td class="td_content">
			<s:select list="packageList" listKey="packageNo" listValue="packageName" headerKey="" headerValue="请选择" 
				  name="packageNo"  id="packageNo2"  cssStyle="width:120px"></s:select>			  
		</td>
	</tr>
	
	<tr>
		<td class="td_title">创建业务账号</td>
		<td class="td_content">
			<input type="radio" name="bussinessAccount2" id="bussinessAccount1" value="1" checked="checked"/>是
			<input type="radio" name="bussinessAccount2" id="bussinessAccount2" value="0" />否
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<span style="color:blue">(业务账号：用户在后台管理系统中对应的3G卡)</span>
		</td>
	</tr>
</table>
<br>
<input type="button" class="button_1" value="增加" name="addOneProduct" id="addOneProduct"/>
</s:form>


</center>
</div>
</div>
<script language="javascript"	src="<c:url value='/'/>js/common/datetime.js"></script>
</body>
</html>