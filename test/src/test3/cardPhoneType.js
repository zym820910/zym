$(document).ready(function(){
	$("#resetPrdtAccessory").click(function(){
         this.form.reset();
     });
	
     $("#addBigPhoneType").click(function(){
    	var name = $("#big_name").val().Trim();
    	if("" == name){Dialog.alert("请输类型名称");$("#big_name").focus();return false;}
    	var url = window.domainname + "admin/customer/cardPhoneType/json/addCPT_TypeJson.action";
    	var data = {'cpt.name':name};
    	$.post(url, data, function (rs) {
    		if(rs&&rs.message=='success'){
    			Dialog.alert("添加成功");
    			var html = "";
    			if(rs.data){
    				$("#big_names").empty();
    				$(rs.data).each(function(index){
    					html += '<option value="' + this.id+'">'+this.name+'</option> ';
    				});
    				$("#big_names").append(html);
    				if($(rs.data) == undefined){
						$("#big_names").append('<option value="0">请选择</option> ');
						return;
    				}
        		}
        		ECSideUtil.reload("ec_big");
        	}else{
        		Dialog.alert("类型名字已被使用，请更换");
        	}
    	}, "json");
     });
     
     
     $("#addSmallPhoneType").click(function(){
    	 var pid = $("#big_names").val();
    	 if(pid == '0'){Dialog.alert("请选择总类型");$("#big_names").focus();return false;}
    	 
    	 
     	var name = $("#small_name").val().Trim();
     	if("" == name){Dialog.alert("请输入子类型名称");$("#small_name").focus();return false;}
     	var url = window.domainname + "admin/customer/cardPhoneType/json/addCPT_TypeJson.action";
     	var data = {'cpt.name':name,"cpt.parentId":pid};
     	$.post(url, data, function (rs) {
     		if(rs&&rs.message=='success'){
     			Dialog.alert("添加成功");
     			var html = "";
     			if(rs.data){
     				$("#big_names").empty();
     				$(rs.data).each(function(index){
     					html += '<option value="' + this.id+'">'+this.name+'</option> ';
     				});
     				$("#big_names").append(html);
     				if($(rs.data) == undefined){
 						$("#big_names").append('<option value="0">请选择</option> ');
 						return;
     				}
         		}
         		ECSideUtil.reload("ec_small");
         	}else{
         		Dialog.alert("类型名字已被使用，请更换");
         	}
     	}, "json");
      });
     
     
     $("#win_flag").click(function(){
    	 if(window.opener){
    		 window.opener.document.getElementById("refresh_type").onclick();
    		 setTimeout(closeWin,1000);
    	 }
     });
     
     
});   

function updateType(obj,id){
	var text = obj.parentNode.parentNode.parentNode.children[2].innerText;
	if("" == text.Trim()){Dialog.alert("请输类型名称");return false;}
	var url = window.domainname + "admin/customer/cardPhoneType/json/editCPT_TypeJson.action";
	var data = {'cpt.name':text.Trim(),"cpt.id":id,"cpt:parentId":$("#parentId").val()};
	$.post(url, data, function (rs) {
		if(rs && rs.data){
			if(rs.data == "success"){
				Dialog.alert("修改成功");
			}else{
				Dialog.alert("类型名字已被使用，请更换");
			}
		}
	}, "json");
}

function findSubType(sid){
	var pid = "";
	if(sid.value)
		pid = sid.value;
	else pid = sid;
	ECSideUtil.eoperateToGird("ec_small",'' ,{parentId:pid});
}



function delCallBack(tabid,text){
	Dialog.alert(text);
	ECSideUtil.reload("ec_small");
	ECSideUtil.reload("ec_big");
	return;
}