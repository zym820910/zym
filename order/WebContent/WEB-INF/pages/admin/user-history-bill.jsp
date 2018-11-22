<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<title>历史账单查询</title>
<script src="../js/ui.core.js" type="text/javascript"></script>
<script src="../js/ui.datepicker.js" type="text/javascript"></script>
<link href="../css/ui.all.css" rel="stylesheet" type="text/css">
<link href="../css/ui.datepicker.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function go(date){
		var cardNo = $("#cardNo").val();
		if(cardNo == ""){
			alert("请输入卡号！");
			return;
		}
		if(date){
			window.location='user-history-bill.action?theDate='+date+'&cardNo='+cardNo;
		}else{
			var startTime = $("#startDate").val();
			var endTime = $("#endDate").val();
			window.location='user-history-bill.action?startTime='+startTime+'&endTime='+endTime+'&cardNo='+cardNo;
		}
	}
	jQuery(function($){
		$("#startDate, #endDate").datepicker({ 
			changeMonth: true,
			changeYear: true,
			dateFormat: 'yy-mm-dd', 
			clearText:'清除',
			closeText:'关闭',
			prevText:'前一月',
			nextText:'后一月',
			currentText:' ',
			monthNames:['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],
			beforeShow: '', 
			showOn: "button", 
			buttonImage: "${ctx}/images/calendar.gif", 
			buttonImageOnly: true 
			});
	});
</script>
</head>
<body >
<div class="right">
  <div class="mainBg">
    <div class="mainContent"> 
      <div class="box">
        <div class="top">
          <h2>历史账单查询</h2>
        </div>
        <div class="body">
          <div class="content">
            <div class="tips1">
              <div class="top"></div>
              <div class="body">
                <table>
                  <tr>
                  	<c:forEach items="${historyBefore}" var="month">
                  		<td><a href="#" onclick='go("<fmt:formatDate value="${month}" pattern="yyyyMM"/>")'><STRONG><fmt:formatDate value="${month}" pattern="yyyy年M月"/></STRONG></a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                  	</c:forEach>
                  </tr>
                </table>
                <p></p>
                <br></br>
                <div class="cal">
                  <table>
						<tr>
							<td class="mandatoryField">卡号：</td>
							<td><s:textfield name="cardNo" id="cardNo" maxlength="11"/></td>
							<td class="tdarrow">开始日期：</td>
							<td ><s:textfield id="startDate" name="startTime"/></td>
							<td class="tdarrow">结束日期：</td>
							<td ><s:textfield id="endDate" name="endTime"/></td>
						</tr>
						<tr>
							<td><input type="button" class="button2" value="查询" onclick="go()"/></td>
						</tr>
					</table>
                </div>
              </div>
            </div>
            <br></br>
            <h3 class="results" >查询结果如下：</h3>
            <br></br>
            <div class="tips1">
              <div class="body">
	                <table class="info">
	                  <tr>
	                    <td class="tdarrow">卡号：</td>
	                    <td>${cardNo }</td>
	                  </tr>
	                  <tr>  
	                    <td class="tdarrow">账单时间：</td>
	                    <td>
	                    	<s:if test="theDate != null ">
	                    		${fn:substring(theDate,0,4) }年${fn:substring(theDate,4,6) }月
	                    	</s:if>
	                    	<s:else>
	                    		<s:if test="startTime != '' && endTime == ''">
		                    		从 ${startTime} 到 今天
		                    	</s:if>
		                    	<s:if test="startTime == '' && endTime != ''">
		                    		账单截止日期 ${endTime}
		                    	</s:if>
		                    	<s:if test="startTime != '' && endTime != ''">
		                    		从 ${startTime} 到 ${endTime}
		                    	</s:if>
	                    	</s:else>
	                    </td>
	                  </tr>
	                </table>
	                <table width="100%">
						<tr>
							<td class="td">
							<display:table name="pageResult" class="list"
								id="row" style="width:100%" cellpadding="1" cellspacing="0"
								requestURI="" export="false" pagesize="10">
				
								<display:column headerClass="tit" paramId="id" paramProperty="id"
									title="费用名称"> 
						        	${row.chargeMethodDesc}
								</display:column>
				
								<display:column headerClass="tit" paramId="id" paramProperty="id"
									title="金额"> 
									${-1*row.moneyCharged}元
								</display:column>
				
								<display:column headerClass="tit" paramId="id" paramProperty="id"
									title="详细说明"> 
									${row.detailMethod}
								</display:column>
				
								<display:column headerClass="tit" paramId="id" paramProperty="id"
									title="账单时间"> 
									${row.chargeTime}
								</display:column>
							</display:table></td>
						</tr>
					</table>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="clearer"></div>
  </div>
</div>

</body>
<!-- InstanceEnd --></html>
