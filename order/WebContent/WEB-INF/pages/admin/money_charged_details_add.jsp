<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>3G卡管理-3G卡修改-费用操作</TITLE>
</HEAD>

<BODY  class="mainbg">
<div id="errorMsg"></div>

<div class="maintop">3G卡管理-3G卡修改-费用操作</div>
<s:form id="frm" action="money_charged_details_save" method="post" theme="simple">
	<s:hidden name="page"></s:hidden>
	<div class="box_relative">
	<fieldset style="width: 380px"><legend> <font
		color="#000000" size="-1">费用操作</font> </legend>
	<table border="0" width="360px">
		<tr>
			<td class="tdarrow" width="120px">卡号：</td>
			<td width=“200px”><s:property value="cardNo"/><s:hidden name="cardNo" /></td>
		</tr>
		<tr>
			<td class="tdarrow">操作方式：</td>
			<td>
				<input type="radio" name="dotype" value="1" checked="checked" onclick="changeChargeMethod()"/>增加
				<input type="radio" name="dotype" value="2" onclick="changeChargeMethod()"/>扣除
			</td>
		</tr>
		<tr>
			<td class="mandatoryField">操作项目：</td>
			<td><select name="moneyChargedDetails.chargeMethod" id="chargeMethod">
				  <option value=''>--请选择--</option>
				  <option value='3'>客服人工充值</option>
				  <option value='5'>优惠活动充值</option>
				  <option value='9'>(其他)充值</option>
				  <option value='14'>返还半月套餐</option>
				  <option value='15'>返还全月套餐</option>
			</select></td>
		</tr>
		<tr>
			<td class="mandatoryField">操作金额：</td>
			<td><s:textfield name="balance" maxlength="15"/></td>
		</tr>
		<tr>
			<td class="mandatoryField" valign="top">备注：</td>
			<td align="left">
				<s:textarea rows="5" cols="20" name="moneyChargedDetails.detailMethod"></s:textarea>
			</td>
		</tr>
	</table>
	</fieldset>
	</div>
	<br>
	<span>
		<input type="button" value="保存" class="button2_max" onclick="validateSave()"/>
		<input type="button" value="返回" onclick="back()" class="button2_max" />
	</span>
</s:form>
<script type="text/javascript">
function changeChargeMethod(){
	var dotype = $("input[name = dotype][value = 1]").attr("checked");
	if(dotype){
		var str = "<option value=''>--请选择--</option>"+
				  "<option value='3'>客服人工充值</option>"+
				  "<option value='5'>优惠活动充值</option>"+
				  "<option value='9'>(其他)充值</option>"+
				  "<option value='14'>返还半月套餐</option>"+
				  "<option value='15'>返还全月套餐</option>";
		$("#chargeMethod").html(str);
	}else{
		var str = "<option value=''>--请选择--</option>"+
				  "<option value='7'>补卡手续扣费</option>"+
				  "<option value='8'>代扣代缴扣费</option>"+
				  "<option value='10'>(其他)扣费</option>"+
				  "<option value='13'>短信费用</option>"+
				  "<option value='16'>补扣半月套餐费</option>"+
				  "<option value='17'>补扣全月套餐费</option>";
		$("#chargeMethod").html(str);
	}
}
function back(){
	window.location='card3g_list.action';
}

function validateSave(){
	$.ajax({
	    url: 'save_validate.action?ajax=true',
	    type: 'post',
	    data: $("#frm").serialize(),
	    dataType: 'html',
	    success: function(val){
	        if(val != ""){
		        $("#errorMsg").html(val);
	        }else{
				$("#frm").submit();
		    }
	    }
	});
}
</script>
</BODY>
</HTML>
