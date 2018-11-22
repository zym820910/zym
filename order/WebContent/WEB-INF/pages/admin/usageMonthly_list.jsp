<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>运营商数据管理</TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<script>

</script>
</HEAD>

<BODY  class="mainbg">
<div class="maintop">运营商信息</div>
	<s:form action="usageMonthly_list" method="post" theme="simple">
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
							<td width="120px" class="tdarrow">年月：</td>
							<td width="200px"><s:textfield name="query.queryCondition.yearMonth" maxlength="6"  onkeyup="value=value.replace(/[^\d]/g,'')"  onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/></td>
						</tr>

						<tr>
							<td width="10%" class="tdarrow">卡号：</td>
							<td width="10%"><s:textfield name="query.queryCondition.cardNo" maxlength="11"/></td>
						</tr>
												<tr >
							<td colspan="2" align="left">
								注:如果要查询2010年5月数据，请输入201005进行查询
							</td>
						</tr>
					</table>
					</td>
				</tr>
				<tr><td height="10"></td></tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<s:submit value="查询" cssClass="button2"></s:submit>
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
					title="卡号"> 
					${row.cardNo}
				</display:column>

				<display:column headerClass="tit" paramId="id" paramProperty="id"
					title="年月"> 
					${row.yearMonth}
				</display:column>

				<display:column headerClass="tit" paramId="id" paramProperty="id"
					title="短信数量(条)"> 
					${row.message  + 0}
				</display:column>

				<display:column headerClass="tit" paramId="id" paramProperty="id"
					title="通话时间(分钟)"> 
		        	${row.phoneMinutes  + 0}
				</display:column>

				<display:column headerClass="tit" paramId="id" paramProperty="id"
					title="上行流量(MB)"> 
					${row.upBytesMB  + 0}
				</display:column>
				
				<display:column headerClass="tit" paramId="id" paramProperty="id"
					title="下行流量(MB)"> 
					${row.downBytesMB + 0}
				</display:column>

				<display:column headerClass="tit" paramId="id" paramProperty="id"
					title="总流量"> 
					${row.totalBytesMB + 0}
				</display:column>

			</display:table>
</div>

</BODY>
</HTML>
