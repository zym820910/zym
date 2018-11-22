
//判断数字
function isNumber( s ){   
	var regu = "^[0-9]+$";
	var re = new RegExp(regu);
	if (s.search(re) != -1) {
	   return true;
	} else {
	   return false;
	}
}

//判断double
function verify_double(node){
	var patrn=/^\d+(\.\d+)?$/;  
	if(!patrn.exec(node))
		return false;
	return true;
}

//只能输入整数
function onlyInteger(opts) {
	var curVal=opts.val();
	if((curVal+'').length > 1) {
		opts.val(opts.val().replace(/[^\d]/g,'').replace(/^0\d{0,4}$/g,''));
	} else {
		opts.val(opts.val().replace(/\D/g,''));
	}
}

function deleteSpan(sourceSpan){
	if(sourceSpan=="")
		return "";
	var span_index = sourceSpan.indexOf("</SPAN>");
	if(-1 != span_index){
		return sourceSpan.substring(span_index+7).Trim();
	}
	return sourceSpan;
}

function closeWin(){
	window.close();
}

/**
 *   AJAX到ACTION方法
 *   update_flag  可选参数 true 或者 回调函数,
 */
 function ajax_to_action(url, param, update_flag){
 	$.ajax({
	        type: "POST",
	        url: window.domainname + url +".action?date="+new Date(),
	        data:param,
	        dataType: "html",
	        success: function(data){
	        	if(update_flag == true){
	        		if(data=='success'){
						Dialog.alert("操作成功！");
					}else if (data =='0'){
						Dialog.alert("操作失败！");
					}else{
						Dialog.alert(data);
					}
	        	}else{
	        		try{
	        			update_flag(data);
	        		}catch(e){};
	        	}
			}
	});		
 } 
 
 //显示正确提示信息
 function showRight(id, message) {
 	clear(id);
 	$('#'+id+'Info').addClass('right_validator_text');
 	$('#'+id+'Info').html("<span style='vertical-align:10%;padding-left:10px'>"+ message +"</span>");					
 }

 //显示错误提示信息
 function showError(id, message) {
 	clear(id);
 	$('#'+id+'Info').addClass('error_validator_text');
 	$('#'+id+'Info').html("<span style='vertical-align:10%;padding-left:10px'>"+ message +"</span>");
 }

 //显示输入提示信息
 function showNormal(id, message) {
 	clear(id);
 	$('#'+id+'Info').html("<span style='vertical-align:10%'>"+ message +"</span>");
 }

 //清除样式
 function clear(id) {
 	$('#'+id+'Info').removeClass('right_validator_text');
 	$('#'+id+'Info').removeClass('error_validator_text');
 	$('#'+id+'Info').removeClass('focus_validator_text');
 }

 //高亮显示
 function onFocusText(id, message) {
 	clear(id);
 	$('#'+id+'Info').addClass('focus_validator_text');
 	$('#'+id+'Info').html("<span style='vertical-align:2px'>"+ message +"</span>");
 }

 //拦截提交信息，验证是否输入必输项
 function intercept(id, msg) {
 	if(isNull($('#'+id).val())) {
 		showError(id, msg);
 	}
 }
 
//格式化事件
 function getEvent(){
      //同时兼容ie和ff的写法
      if(document.all)    return window.event;
      func=getEvent.caller;
      while(func!=null){
          var arg0=func.arguments[0];
          if(arg0){
              if((arg0.constructor==Event || arg0.constructor ==MouseEvent)
                 || (typeof(arg0)=="object" && arg0.preventDefault && arg0.stopPropagation)){    
                 return arg0;
               }
          }
           func=func.caller;
         }
         return null;
 }
 
//文件校验
 function ajaxFileValidator(){
 	var fileValue = $("#file").val();
  	if(fileValue!='') {
       if(fileValue.indexOf(".xls")==-1) {
       	Dialog.alert("请使用 .xls 文件!");
       	return false;
       }
 	}else{
 		Dialog.alert("请上传产品xls文件!");
 		return false;
 	}
 	return true;
 }
 
 /**
 * 简单的二级联动显示
 **/
 function getCaseType(url,type_id,caseCallBack){
 	var evt = getEvent();
 	var o = evt.srcElement || evt.target;
 	var provId = $("#"+ o.id).val();
 	if(provId == ""){
 		createOption('',type_id);
 		return false;
 	}
 	
     $.ajax({
         type: "POST",
         url: window.domainname+ url +'?date='+new Date() +"&selectedId=" + provId,
         dataType: "json",
         success: function(json){
    	 	createOption(json,type_id);
 			if(caseCallBack){
 	 			try{
 	 				caseCallBack(json);
 	 			}catch(e){};
 	 		}
 		}
 	});
 }
 
 

 function createOption(ops,type_id){
 	var option ;
 	if(type_id == undefined){
 		return;
 	}else{
 		$("#"+type_id).empty();
 		if(ops.length == 0){
 			$("#"+type_id).append('<option value="0">请选择</option> ');
 			return false;
 		}
 		for(var i = 0; i<ops.length; i++){
 			option =  '<option value="'+ops[i].id+'">'+ops[i].name+'</option> ';
 			$("#"+type_id).append(option);
 		}
 	}
 }