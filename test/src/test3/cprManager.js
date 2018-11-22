$(document).ready(function(){
	$("#operator_time").focus(function(){ setday( this ); });
	$("#revert_time").focus(function(){ setday( this ); });
	
	if($("#is_revert").val()=="1"){
		$("#revert_div1").show();
		$("#revert_div2").show();
		$("#revert_div3").show();
	}
	
	$("#isRevert").change(function(){
		if($("select[name=isRevert] option[selected]").val()==1){
			$("#revert_div1").show();
			$("#revert_div2").show();
			$("#revert_div3").show();
		}else{
			$("#revert_div1").hide();
			$("#revert_div2").hide();
			$("#revert_div3").hide();
		}
	});

	$("#bigType").change(function(){
		getCaseType("/admin/customer/cardPhoneType/json/getSmallType_TypeJson.action","smallType");
	});
	
	
	$("#find_card").click(function(){
		findCard();
	});

	$("#add_type").click(function(){
		addType();
	});
	
	$("#add_remark").click(function(){
		if(!checkAddRemark())return false;
		var url = window.domainname + "/admin/customer/cardPhoneRecord/json/addCPR_RecordJson.action";
		var data = {
			'cpr.cardNo':$("#cardNo").val().Trim(),
			'cpr.customer_name':$("#customer_name").val().Trim(),
			'cpr.customer_phone':$("#customer_phone").val().Trim(),
			'cpr.customer_address':$("#customer_address").val(),
			'cpr.operatorId':$("#operatorId").val(),
			'cpr.operatorName':$("#operatorId").find("option:selected").text(),
			'cpr.bigType':$("#bigType").val(),
			'cpr.bigTypeName':$("#bigType").find("option:selected").text(),
			'cpr.smallType':$("#smallType").val(),
			'cpr.smallTypeName':$("#smallType").find("option:selected").text(),
			'cpr.detail':$("#detail").val().Trim(),
			'cpr.resolvent':$("#resolvent").val().Trim(),
			'cpr.remark':$("#remark").val().Trim(),
			'cpr.reverted':$("#isRevert").val(),
			'cpr.revertId':$("#revertId").val(),
			'cpr.revertName':$("#revertId").find("option:selected").text(),
			'cpr.revertResult':$("#revert_result").val().Trim(),
			'cpr.closed':$("#is_closed").attr("checked")==true? "1":"0",
			
			'operatorTime':$("#operator_time").val(),
			'revertTime':$("#revert_time").val()
		};
		$.post(url, data, function (rs) {
			if (rs.message && rs.message == "success") {
				Dialog.alert("添加成功");
				setTimeout(closeWin,1000);
			}else if(rs.data){
				Dialog.alert(rs.data);
			}
		}, "json");
	});
 
	$("#update_remark").click(function(){
	 	if(!checkAddRemark())return false;
	 	var url = window.domainname + "/admin/customer/cardPhoneRecord/json/editCPR_RecordJson.action";
	 	var data = {
	 			'cpr.id':$("#cprId").val(),
	 			'cpr.cardNo':$("#cardNo").val().Trim(),
				'cpr.customer_name':$("#customer_name").val().Trim(),
				'cpr.customer_phone':$("#customer_phone").val().Trim(),
				'cpr.customer_address':$("#customer_address").val(),
				'cpr.operatorId':$("#operatorId").val(),
				'cpr.operatorName':$("#operatorId").find("option:selected").text(),
				'cpr.bigType':$("#bigType").val(),
				'cpr.bigTypeName':$("#bigType").find("option:selected").text(),
				'cpr.smallType':$("#smallType").val(),
				'cpr.smallTypeName':$("#smallType").find("option:selected").text(),
				'cpr.detail':$("#detail").val().Trim(),
				'cpr.resolvent':$("#resolvent").val().Trim(),
				'cpr.remark':$("#remark").val().Trim(),
				'cpr.reverted':$("#isRevert").val(),
				'cpr.revertId':$("#revertId").val(),
				'cpr.revertName':$("#revertId").find("option:selected").text(),
				'cpr.revertResult':$("#revert_result").val().Trim(),
				'cpr.closed':$("#is_closed").attr("checked")==true? "1":"0",
				
				'operatorTime':$("#operator_time").val(),
				'revertTime':$("#revert_time").val()
	 	};		
		$.post(url, data, function (rs) {
			if (rs.message && rs.message == "success") {
				Dialog.alert("修改成功");
				setTimeout(closeWin,1000);
			}else if(rs.data){
				Dialog.alert(rs.data);
			}
		}, "json");
	  }); 

});

function findCard(){
	var url = window.domainname + "admin/card/findCardPage.action";
	window.open(url,"_blank", "menubar=no,location=no,toolbar=no, width=750,height=450,resizeable=no");
}

function addType(){
	var url = window.domainname + "admin/customer/cardPhoneType/view.action?win_flag=1";
	window.open(url,"_blank", "menubar=no,toolbar=no, width=650,height=550,resizeable=no");
}

function refreshType(){
	var url = "/admin/customer/cardPhoneType/json/getBigType_TypeJson.action";
	$.ajax({
        type: "POST",
        url: window.domainname+ url +'?date='+new Date(),
        dataType: "json",
        success: function(json){
			createOption(json,"bigType");
			var url2 = "/admin/customer/cardPhoneType/json/getSmallType_TypeJson.action";
			$.ajax({
		        type: "POST",
		        url: window.domainname+ url2 +'?date='+new Date()+"&selectedId=" + $("#bigType").val(),
		        dataType: "json",
		        success: function(json){
					createOption(json,"smallType");
				}
			});
		}
	});
}


function checkAddRemark(){
	if($("#cardNo").val().Trim()==""){Dialog.alert("请输入卡号");$("#cardNo").focus();return false;}
	if($("select[name=operatorId] option[selected]").val()==""){Dialog.alert("请选择操作人");$("#operatorId").focus();return false;}
	if($("select[name=bigType] option[selected]").val()==""){Dialog.alert("请选择操作类型");$("#bigType").focus();return false;}
	if($("#operator_time").val()==""){Dialog.alert("请输入操作日期");$("#operator_time").focus();return false;}
	if($("#detail").val().Trim()==""){Dialog.alert("请输入详细信息");$("#detail").focus();return false;}
	
	/*if($("select[name=isRevert] option[selected]").val()==1){
		if($("select[name=revertId] option[selected]").val()==""){Dialog.alert("请选择回复人");$("#revertId").focus();return false;}
		if($("#revert_result").val().Trim()==""){Dialog.alert("请输入回复内容");$("#revert_result").focus();return false;}
		if($("#revert_time").val()==""){Dialog.alert("请输入回复时间");$("#revert_time").focus();return false;}
	}*/
	if($("#detail").val() != "" && $("#detail").val().length >200){Dialog.alert("详情字数太长");$("#detail").focus();return false;}
	if($("#resolvent").val() != "" && $("#resolvent").val().length >200){Dialog.alert("解决方案字数太长");$("#resolvent").focus();return false;}
	if($("#remark").val() != "" && $("#remark").val().length >1000){Dialog.alert("备注太长");$("#remark").focus();return false;}
	if($("#revert_result").val() != "" && $("#revert_result").val().length >200){Dialog.alert("回复内容字数太长");$("#revert_result").focus();return false;}
	return true;
}
