<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>3G卡管理-3G卡修改-用户信息</TITLE>

<script>
function check(){
	if(confirm("确定要修改吗？")){
		if($("#password1").val() != $("#password2").val()){
			alert("两次输入的新密码不一致，请重新输入");
		}else{
			$("#frm").submit();
		}
	}
}
</script>
</HEAD>

<BODY  class="mainbg">
<div class="maintop">3G卡管理-3G卡修改-用户信息</div>
<s:form id="frm" action="user_info_modify" method="post" theme="simple">
<s:hidden name="card3g.cardNo" value="%{cardNo}"></s:hidden>
<s:hidden name="page"></s:hidden>
	<div class="div_padding">
	<div class="box_relative">	
	<fieldset style="width:380px"><legend> <font color="#000000" size="-1">用户信息</font>
	</legend>
	<table border="0" width="360px">
		<tr>
			<td width="120" class="tdarrow">用户姓名：</td>
			<td width="200px" align="left"><s:textfield id="cardNo" name="card3g.customerName"/></td>
		</tr>
		<tr>
			<td class="tdarrow">性别：</td>
			<td align="left">
				<s:select list="sexList" name="card3g.customerSex" listKey="value" listValue="label"></s:select>
			</td>
		</tr>
		<tr>
			<td class="tdarrow">联系电话：</td>
			<td align="left"><s:textfield name="card3g.customerPhoneNo"/></td>
		</tr>
		<tr>
			<td class="tdarrow">实名审核：</td>
			<td align="left">
				<s:select list="appStatusList" name="card3g.ifIdentityVerified" listKey="key" listValue="value"></s:select>
			</td>
		</tr>
		<tr>
			<td class="tdarrow">证件类型：</td>
			<td align="left">
				<s:select list="certificateStatusList"  name="card3g.customerCertificateName" headerKey="" headerValue="--请选择--" listKey="value" listValue="label"></s:select>
			</td>
		</tr>
		<tr>
			<td class="tdarrow">证件号码：</td>
			<td align="left"><s:textfield name="card3g.customerCertificateNo" /></td>
		</tr>
		<tr>
			<td class="tdarrow">账单地址：</td>
			<td align="left"><s:textfield name="card3g.customerAddress"/></td>
		</tr>
		<tr>
			<td class="tdarrow">邮政编码：</td>
			<td align="left"><s:textfield name="card3g.customerPostCode"/></td>
		</tr>
		<tr>
			<td class="tdarrow">Email地址：</td>
			<td align="left"><s:textfield name="card3g.customerEmail"/></td>
		</tr>
		</table>
			</fieldset>
		</div>
	</div>
	
	<div class="box_relative">	
	<fieldset style="width:380px"><legend> <font color="#000000" size="-1">修改密码</font>
	</legend>
	<table border="0" width="360px">			<tr>
			<td class="tdarrow">请输入密码：</td>
			<td align="left"><s:password id="password1"/></td>
		</tr>
		<tr>
			<td class="tdarrow">再次输入密码：</td>
			<td align="left"><s:password id="password2" name="card3g.password"/></td>
		</tr>
	</table>
	</fieldset>
		</div>

	
	<br>

	<span>
		<input type="button" value="修改" onclick="check()" class="button2_max"/>
		<input type="button" value="返回" onclick="window.location = 'card3g_list.action'" class="button2_max"/>
	</span>

</s:form>
</BODY>
</HTML>
