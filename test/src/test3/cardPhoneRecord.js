$(document).ready(function(){
	
	$("#operatorStartTime").focus(function(){ setday( this ); });
	$("#operatorEndTime").focus(function(){ setday( this ); });
	
	
	$("#resetPrdtAccessory").click(function(){
         this.form.reset();
     });
	
	
	$("#bigType").change(function(){
		getCaseType("/admin/customer/cardPhoneType/json/getSmallType_TypeJson.action","smallType");
	});
	
	
	$("#queryBtn").click(function(){
      	ECSideUtil.queryECForm("ec",
    	 {
      		'cardNo':$("#cardNo").val().Trim(),
      		'imsi':$("#imsi").val().Trim(),
      		
      		bigType:$("#bigType").val(),
      		smallType:$("#smallType").val(),
      		
      		operatorStartTime:$("#operatorStartTime").val(),
      		operatorEndTime:$("#operatorEndTime").val(),
      		isClose:$("#isClose").val(),
      		
      		isRevert:$("#isRevert").val(),
      		operatorId:$("#operatorId").val(),
      		revertId:$("#revertId").val()
    	  });
      });   
	
});   

function showCard(id){
	var url = window.domainname + "admin/card/shadowCard.action";
	$(this).openJdialog(
       {width:750,height:450,caption:'详细资料',
        url:url + '?recordKey=' + id,
        destroyCallbacks:''
    });
}

function delCallBack(text){
	Dialog.alert("删除成功");
	ECSideUtil.reload("ec");
	return;
}
