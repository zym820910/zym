<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>

<html>
<head>
<title>空卡批量导入</title>
<script>
//上传文件校验
function check(){
	if($("#myfile").val() == ""){
		alert("请选择文件!");
	}else if(!/\.xls$/.test($("#myfile").val())){
		alert("文件格式不正确!");
	}else{
		$("#frm").submit();
	}
}
</script>
</head>
<body>
<s:if test='!successInfo.equals("") '>
<div>
	<img class='ico' alt='提示' src='../images/iconInformation.gif'><font color='red'><s:property value="successInfo"/></font>
</div>
</s:if>
<div class="table">
  <form action="card_upload.action" method="post" id="frm" enctype="multipart/form-data">
	请选择文件：<s:file id="myfile" name="file"></s:file>
	<input type="button" class="button2" value="上传" onclick="check();" />	
  </form>
  <hr></hr>
  <span><font color="red"><strong>友好提示：建议使用Excel模板，请<a href="../download/card3g_upload.xls">点击这里</a>下载Excel模板，根据模板的格式输入数据。</strong></font></span>
  <br></br>
  <span><font color="red"><strong>注意：卡号、IMSI号、套餐编号必须输入。</strong></font></span>
  
</div>
</body>
</html>