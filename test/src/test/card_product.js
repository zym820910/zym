$(document).ready(function(){
	try{
		$('#container-1 > ul').tabs();
	}catch(e){}
	
	
	$("#start_entryTime").focus(function(){ setday( this ); });
	$("#end_entryTime").focus(function(){ setday( this ); });
	$("#entryDate").focus(function(){ setday( this ); });
	$("#resetPrdtAccessory").click(function(){
         this.form.reset();
     });
	
     $("#queryBtn").click(function(){
    	 var agent_name = "";
    	 var provider_name = "";
    	 
    	 if($("#agent_no").val() != 0){agent_name = $("#agent_no option:selected").text();}
    	 if($("#provider_no").val() != 0){provider_name = $("#provider_no option:selected").text();}
    	 
      	ECSideUtil.queryECForm("ec",
    	 {
      		p_no:$("#p_no").val(),
      		p_no_from:$("#p_no_from").val(),
      		p_no_to:$("#p_no_to").val(),
      		
      		card_no:$("#card_no").val(),
      		card_no_from:$("#card_no_from").val(),
      		card_no_to:$("#card_no_to").val(),
      		
      		sn_no:$("#sn_no").val(),
      		sn_no_from:$("#sn_no_from").val(),
      		sn_no_to:$("#sn_no_to").val(),
      		
      		box_no:$("#box_no").val(),
      		box_no_from:$("#box_no_from").val(),
      		box_no_to:$("#box_no_to").val(),
      		
      		p_type:$("#p_type").val(),
       	 	p_status:$("#p_status").val(),
       	 
       	 	agent_name:strencode(agent_name),
       		provider_name:strencode(provider_name),
       		
      		start_entryTime:$("#start_entryTime").val(),
      		end_entryTime:$("#end_entryTime").val()
    	  });
      });   
     
     
     
     $("#preAddProductOut").click(function(){
    	 var productList = "";
    	 var p_num = 0;
    	 if($("input[@type=checkbox]:checked","#ec_main_content").size()==0){
    		Dialog.alert("请选择产品");
 			return;
 		 }
 		 $("input[@type=checkbox]:checked","#ec_main_content").each(function(){
 			productList = productList + this.value + ";";
 			p_num ++ ;
 		 });
 		 if(confirm("您确认出库这 "+p_num+" 个产品吗？")){
 			if($("input[@type=checkbox]:checked","#ec_main_content").size()!=0){
 	 			$(this).openJdialog(
 	               {width:550,height:350,caption:"新增出库单",
 	 		       url:window.domainname+'/admin/storage/preAddProductOut_product.action?productList='+productList,
 	 		       destroyCallbacks:[function(){ECSideUtil.reload('ec');}]
 	 		    });
 	 		 }
 		 }
     });
     
     $("#addProductOut").click(function(){
    	 if(!add_wi_check())return false;
    	 var param = "entryDate="+$("#entryDate").val()+
			"&wi.productPrice="+$("#productPrice").val()+
			"&wi.cardSimPrice="+$("#cardSimPrice").val()+
			"&wi.cardSnPrice="+$("#cardSnPrice").val()+
			"&wi.cardBoxPrice="+$("#cardBoxPrice").val()+
			"&wi.agentNo=" + $("#agentNo").val()+
			"&wi.agentName=" + strencode($("#agentNo option:selected").text())+
			"&productList=" + $("#productList").val();
    	 ajax_to_action("/admin/storage/product/json/addProductOut_json",param,addProductOutCallBack);
     });
});   

function refresh(){
	var p = arguments[0];
	switch (p) {
	case 2:
		$("#inFrame").attr("src",window.domainname+"/admin/storage/card_product/preCrateCardProduct.action");
		break;
	case 3:
		$("#outFrame").attr("src",window.domainname+"/admin/storage/viewOut_wi.action");
	break;
	default:
		break;
	}
	$("#fragment-"+p).attr("style","visibility:visible ");
}

function addProductOutCallBack(data){
	if(data!="") Dialog.alert(data);
}

function disabledFromAndTo(filed){
	if($("#"+filed).val()!= ""){
		$("#"+filed + "_from").val("");
		$("#"+filed + "_to").val("");
	}
}

function disabledField(filed){
	if($("#"+filed + "_from").val() != "" || $("#"+filed + "_to").val() != ""){
		$("#"+filed).val("");
	}
}

var product_id = 0 ;

function show_oprate(pid,event){
	document.getElementById("show_oprate").style.pixelLeft=event.x+10;
	document.getElementById("show_oprate").style.pixelTop=event.y - 15 -163;
	document.getElementById("show_oprate").style.display="";
 	event.cancelBubble = true;
}

function hide_oprate(){
 	document.getElementById("show_oprate").style.display = 'none';
 	event.cancelBubble = true;
}


function add_wi_check(){
	 if($("#entryDate").val()==""){Dialog.alert("请填写入库日期"); return false;}
	 if($("#agentNo").val()=="0"){Dialog.alert("请选择供应商"); return false;}
	 var productPrice = $("#productPrice").val();
	 var cardSimPrice = $("#cardSimPrice").val();
	 var cardSnPrice  = $("#cardSnPrice").val();
	 var cardBoxPrice = $("#cardBoxPrice").val();
	 if(""!= productPrice && !verify_double(productPrice) && !isNumber(productPrice)){Dialog.alert("请输入正确的单价");$("#productPrice").focus();return false;}	
	 if(""!= cardSimPrice && !verify_double(cardSimPrice) && !isNumber(cardSimPrice)){Dialog.alert("请输入正确的单价");$("#cardSimPrice").focus();return false;}
	 if(""!= cardSnPrice && !verify_double(cardSnPrice) && !isNumber(cardSnPrice)){Dialog.alert("请输入正确的单价");$("#cardSnPrice").focus();return false;}
	 if(""!= cardBoxPrice && !verify_double(cardBoxPrice) && !isNumber(cardBoxPrice)){Dialog.alert("请输入正确的单价");$("#cardBoxPrice").focus();return false;}
	 return true;
}