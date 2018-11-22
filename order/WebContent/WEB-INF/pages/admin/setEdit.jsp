<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<title>套餐修改</title>
<style>
.td {
	border: 1px solid #000000;
}
</style>
<script type="text/javascript">
	function goSetList(){
		window.location = "list_set.action";
	}
	function saveSet(){
		if(confirm("确定要修改套餐吗？")){
			if(chechNumLen()){
				$('#form1').submit();
			}	
		}
	}
	function countPreSaveAmount(){
		var validMonths = $('#validMonths').val();
		var feeMonthly1 = $('#feeMonthly1').val();
		if(!isNaN(validMonths)&&!isNaN(feeMonthly1)){
			$('#moneyPreCharged').val(validMonths * feeMonthly1);
		}
	}


    function chechNumLen(){
		var feeMinute = $('#feeMinute').val();
		var feeMb = $('#feeMb').val();
		if(check(feeMinute,'超出时长资费','2')&&
		check(feeMb,'超出流量资费','1')){
			return true;
		}
		return false;
    }

	function check(val,msg,position){
		var ind = val.indexOf('.');
		if(ind<0){
			if(val.length>3){
				alert(msg + '超出最大范围，请输入小于1000的值');
				if(position == '1'){
					document.getElementById("feeMb").focus();
				}else{
					document.getElementById("feeMinute").focus();
				}
				return false;
			}
			return true;
		}else{
			var str = val.substring(0,ind);
			if(str.length>3){
				alert(msg + '超出最大范围，请输入小于1000的值');
				if(position == '1'){
					document.getElementById("feeMb").focus();
				}else{
					document.getElementById("feeMinute").focus();
				}
				return false;
			}
			return true;
		}
	}
</script>
</head>
<BODY  class="mainbg">
<div class="maintop">套餐管理-套餐修改</div>
		<s:form id="form1" action="set_save" method="post" theme="simple">

	<div class="div_padding">
	<div class="box_relative">	
	<fieldset style="width:800px"><legend> <font color="#000000" size="-1">基本信息</font>
	</legend>
							<table width=“780px”>
								<tr>
									<td class="mandatoryField">套餐编号：</td>
									<td><s:textfield maxlength="5" size="10" readonly="true" name="pkg.packageNo" /></td>
									<td class="mandatoryField">套餐名称：</td>
									<td><s:textfield maxlength="20" size="20" name="pkg.packageName" /></td>
									<td class="tdarrow">套餐状态：</td>
									<td><s:radio id="status" name="pkg.status" list="statusRadioList" listKey="value" listValue="label" theme="simple"></s:radio></td>
								</tr>
								<tr>
									<td class="mandatoryField">套餐类别：</td>
									<td><s:select id="packageType" name="pkg.packageType" list="typeList" listKey="value" listValue="label" headerKey="" headerValue="" style="width:93px"/></td>
									<td class="tdarrow">超出流量后资费(元/MB)：</td>
									<td><s:textfield maxlength="6" size="6" id="feeMb"
										onpaste="return !clipboardData.getData('text').match(/[^w-]/)"  
										ondragenter="return false" style="ime-mode:disabled" 
										onkeyup = "this.value=/^\d+\.?\d{0,2}$/.test(this.value) ? this.value : ''"
										name="pkg.feePerMbIfExceed"  onblur="check(this.value,'超出流量后资费','1')" />元/MB
									</td>
									<td class="tdarrow">超出时长后资费：</td>
									<td><s:textfield maxlength="6" size="6" id="feeMinute"
										onpaste="return !clipboardData.getData('text').match(/[^w-]/)"  
										ondragenter="return false" style="ime-mode:disabled" 
										onkeyup = "this.value=/^\d+\.?\d{0,2}$/.test(this.value) ? this.value : ''"
									 	name="pkg.feePerMinuteIfExceed" onblur="check(this.value,'超出时长资费','2')"/>元/分钟</td>
								</tr>
								<tr>
									<td class="mandatoryField">有效期：</td>
									<td><s:textfield maxlength="2" size="10" id="validMonths"
										onkeyup="value=value.replace(/[^\d]/g,'')"
										onpaste="return   !clipboardData.getData('text').match(/[^w-]/)"  
									    ondragenter="return false" style="ime-mode:disabled"   
										onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"
									 	name="pkg.validMonths"  onblur="countPreSaveAmount();"/>月
									 </td>
									<td class="tdarrow">预存金额：</td>
									<td><s:textfield maxlength="11" size="10" 
										onkeyup="value=value.replace(/[^\d]/g,'')" id="moneyPreCharged"
										onpaste="return   !clipboardData.getData('text').match(/[^w-]/)"  
									    ondragenter="return false" style="ime-mode:disabled; background-color:#f4fafc; border-style:none none dashed none;text-align:center;"   
										onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"
										name="pkg.moneyPreCharged" />元
									</td>
									<td colspan="2">&nbsp;</td>
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
									<td class="mandatoryField">套餐分级：</td>
									<td><s:select id="pkg.ifMultiGrades" name="pkg.ifMultiGrades" list="setGradesList" listKey="value" listValue="label" style="width:100px"/></td>
									<td colspan="5">&nbsp;</td>
								</tr>
								<tr height="10px"/>
								<tr>
										<td class="tdarrow">基础套餐</td>
										<td colspan="6">&nbsp;</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
										<td class="tdarrow">套餐月费(元/月)：</td>
										<td><s:textfield maxlength="11" size="11" id="feeMonthly1"
											onkeyup="value=value.replace(/[^\d]/g,'')"
											onpaste="return !clipboardData.getData('text').match(/[^w-]/)"  
										    ondragenter="return false" style="ime-mode:disabled"   
											onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"
											name="pkg.feeMonthly1" onblur="countPreSaveAmount();" />
										</td>
										<td class="tdarrow">可用流量(G)：</td>
										<td><s:textfield maxlength="11" size="11"
											onpaste="return !clipboardData.getData('text').match(/[^w-]/)"  
											ondragenter="return false" style="ime-mode:disabled" 
											onkeyup = "this.value=/^\d+\.?\d{0,2}$/.test(this.value) ? this.value : ''"
											name="pkg.maxBytesGbMonthly1" /></td>
										<td class="tdarrow">可用时长(小时)：</td>
										<td><s:textfield maxlength="11" size="11"
											onkeyup="value=value.replace(/[^\d]/g,'')"
											onpaste="return   !clipboardData.getData('text').match(/[^w-]/)"  
										    ondragenter="return false" style="ime-mode:disabled"   
											onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" 
											name="pkg.maxHoursMonthly1" /></td>
									</tr>
									<tr>
										<td class="tdarrow">套餐分级二</td>
										<td colspan="6">&nbsp;</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
										<td class="tdarrow">套餐月费(元/月)：</td>
										<td><s:textfield maxlength="11" size="11"
											onkeyup="value=value.replace(/[^\d]/g,'')"
											onpaste="return   !clipboardData.getData('text').match(/[^w-]/)"  
										    ondragenter="return false" style="ime-mode:disabled"   
											onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" 
											name="pkg.feeMonthly2" /></td>
										<td class="tdarrow">可用流量(G)：</td>
										<td><s:textfield maxlength="11" size="11"
											onpaste="return !clipboardData.getData('text').match(/[^w-]/)"  
											ondragenter="return false" style="ime-mode:disabled" 
											onkeyup = "this.value=/^\d+\.?\d{0,2}$/.test(this.value) ? this.value : ''"
											name="pkg.maxBytesGbMonthly2" /></td>
										<td class="tdarrow">可用时长(小时)：</td>
										<td><s:textfield maxlength="11" size="11"
											onkeyup="value=value.replace(/[^\d]/g,'')"
											onpaste="return   !clipboardData.getData('text').match(/[^w-]/)"  
										    ondragenter="return false" style="ime-mode:disabled"   
											onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" 
											name="pkg.maxHoursMonthly2" /></td>
									</tr>
									<tr>
										<td class="tdarrow">套餐分级三</td>
										<td colspan="6">&nbsp;</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
										<td class="tdarrow">套餐月费(元/月)：</td>
										<td><s:textfield maxlength="11" size="11"
											onkeyup="value=value.replace(/[^\d]/g,'')"
											onpaste="return   !clipboardData.getData('text').match(/[^w-]/)"  
										    ondragenter="return false" style="ime-mode:disabled"   
											onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" 
											name="pkg.feeMonthly3" /></td>
										<td class="tdarrow">可用流量(G)：</td>
										<td><s:textfield maxlength="11" size="11"
											onpaste="return !clipboardData.getData('text').match(/[^w-]/)"  
											ondragenter="return false" style="ime-mode:disabled" 
											onkeyup = "this.value=/^\d+\.?\d{0,2}$/.test(this.value) ? this.value : ''"
											name="pkg.maxBytesGbMonthly3" /></td>
										<td class="tdarrow">可用时长(小时)：</td>
										<td><s:textfield maxlength="11" size="11"
											onkeyup="value=value.replace(/[^\d]/g,'')"
											onpaste="return   !clipboardData.getData('text').match(/[^w-]/)"  
										    ondragenter="return false" style="ime-mode:disabled"   
											onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" 
											name="pkg.maxHoursMonthly3" /></td>
									</tr>
									<tr>
										<td class="tdarrow">套餐分级四</td>
										<td colspan="6">&nbsp;</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
										<td class="tdarrow">套餐月费(元/月)：</td>
										<td><s:textfield maxlength="11" size="11"
											onkeyup="value=value.replace(/[^\d]/g,'')"
											onpaste="return   !clipboardData.getData('text').match(/[^w-]/)"  
										    ondragenter="return false" style="ime-mode:disabled"   
											onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" 
											name="pkg.feeMonthly4" /></td>
										<td class="tdarrow">可用流量(G)：</td>
										<td><s:textfield maxlength="11" size="11"
											onpaste="return !clipboardData.getData('text').match(/[^w-]/)"  
											ondragenter="return false" style="ime-mode:disabled" 
											onkeyup = "this.value=/^\d+\.?\d{0,2}$/.test(this.value) ? this.value : ''"
											name="pkg.maxBytesGbMonthly4" /></td>
										<td class="tdarrow">可用时长(小时)：</td>
										<td><s:textfield maxlength="11" size="11"
											onkeyup="value=value.replace(/[^\d]/g,'')"
											onpaste="return   !clipboardData.getData('text').match(/[^w-]/)"  
										    ondragenter="return false" style="ime-mode:disabled"   
											onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" 
											name="pkg.maxHoursMonthly4" /></td>
									</tr>
									</tr>
									<tr>
										<td class="tdarrow">套餐分级五</td>
										<td colspan="6">&nbsp;</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
										<td class="tdarrow">套餐月费(元/月)：</td>
										<td><s:textfield maxlength="11" size="11"
											onkeyup="value=value.replace(/[^\d]/g,'')"
											onpaste="return   !clipboardData.getData('text').match(/[^w-]/)"  
										    ondragenter="return false" style="ime-mode:disabled"   
											onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" 
											name="pkg.feeMonthly5" /></td>
										<td class="tdarrow">可用流量(G)：</td>
										<td><s:textfield maxlength="11" size="11"
											onpaste="return !clipboardData.getData('text').match(/[^w-]/)"  
											ondragenter="return false" style="ime-mode:disabled" 
											onkeyup = "this.value=/^\d+\.?\d{0,2}$/.test(this.value) ? this.value : ''" 
											name="pkg.maxBytesGbMonthly5" /></td>
										<td class="tdarrow">可用时长(小时)：</td>
										<td><s:textfield maxlength="11" size="11"
											onkeyup="value=value.replace(/[^\d]/g,'')"
											onpaste="return   !clipboardData.getData('text').match(/[^w-]/)"  
										    ondragenter="return false" style="ime-mode:disabled"   
											onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" 
											name="pkg.maxHoursMonthly5" /></td>
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
								<tr height="10px"/>
								<tr>
									<td class="tdarrow">静态页面URL：</td>
									<td><s:textfield name="pkg.urlHtml" size="95" maxlength="60" /></td>
								</tr>
								<tr height="10px"/>
								<tr>
									<td class="tdarrow">套餐描述：</td>
									<td><s:textarea name="pkg.description" cols="80" rows="3"/></td>
								</tr>
							</table>
						</fieldset>
					</div>
				</div>
			<input type="button" value="修改" class="button2_max" onclick="saveSet();"/>&nbsp;<input type="button" value="返回" class="button2_max" onclick="goSetList();"/>
		</s:form>
	</div>
</body>
</html>