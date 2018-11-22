<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/ecside.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<html>
<head>

<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="cache-control" content="no-cache"/>
<meta http-equiv="expires" content="0"/>
<link rel="stylesheet" type="text/css"  href="<c:url value='/'/>css/common/ui.tabs.css" />
<script language="javaScript" src="<c:url value='/'/>js/common/jquery/ui.core.js" type="text/javascript"></script>
<script language="javaScript" src="<c:url value='/'/>js/common/jquery/ui.tabs.js" type="text/javascript"></script>
<script language="javaScript" src="<c:url value='/'/>js/storage/product/view.js"></script>
</head>
<body>
<div class="tabcontentcur">
<div id="container-1">
<ul>
	<li><a href="#fragment-1" onclick="refresh(1)"><span>产        品        管        理</span></a></li>
	<jxt:auth res="602">
		<li><a href="#fragment-2" onclick="refresh(2)"><span>入库</span></a></li>
	</jxt:auth>
	<jxt:auth res="601">
		<li><a href="#fragment-3" onclick="refresh(3)"><span>出库</span></a></li>
	</jxt:auth>
</ul>

<center>
<div id="fragment-1">
<h2>产        品        管        理</h2>
<form name="findForm" id="findForm">
	<table width="95%" border="0" cellPadding="4" cellSpacing="1" class="table_1">
		<tr>
			<td class="td_title" style="width:8%">产品编号&nbsp;</td>	
			<td class="td_content" style="text-align:left; width:12%">
				<input class="underline" type="text" name="p_no" id="p_no" size="25" value="" onkeyup="disabledField('p_no');"/> 
			</td>
			
			<td class="td_title" style="width:10%">产品编号范围&nbsp;</td>	
			<td class="td_content" style="text-align:left; width:25%">
				<input class="underline" type="text" name="p_no_from" id="p_no_from" size="15" value="" onkeyup="disabledFromAndTo('p_no');"/> - 
				<input class="underline" type="text" name="p_no_to" id="p_no_to" size="15" value="" onkeyup="disabledFromAndTo('p_no');"/>
			</td>
			
			<td class="td_title" style="width:10%">产品类型&nbsp;</td>
			<td class="td_content" style="text-align:left; width:10%">
				<select name="p_type" id="p_type">
					<option value="product_no" selected="selected">产品</option>
					<option value="card_sim_no">SIM卡</option>
					<option value="card_sn_no">硬件卡</option>
					<option value="card_box_no">盒子</option>
				</select>
			</td>
			
			<td class="td_title" style="width:8%">供应商&nbsp;</td>	
			<td class="td_content" style="text-align:left; width:20%">
				<select name="provider_no" id="provider_no" style="width:150px">
					<option value="0">请选择</option>
					<c:forEach items="${provider_list}" var="p">
						<option value="${p.agentNo}">${p.name}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		
		<tr>
			<td class="td_title">卡号&nbsp;</td>	
			<td class="td_content" style="text-align:left; ">
				<input class="underline" type="text" name="card_no" id="card_no" size="25" value="" onkeyup="disabledField('card_no');"/> 
			</td>
			
			<td class="td_title">卡号范围&nbsp;</td>	
			<td class="td_content" style="text-align:left; ">
				<input class="underline" type="text" name="card_no_from" id="card_no_from" size="15" value="" onkeyup="disabledFromAndTo('card_no');"/> - 
				<input class="underline" type="text" name="card_no_to" id="card_no_to" size="15" value="" onkeyup="disabledFromAndTo('card_no');"/>
			</td>
		
			<td class="td_title">库存状态&nbsp;</td>	
			<td class="td_content" style="text-align:left; ">
				<select name="p_status" id="p_status">
					<option value="1">出库</option>
					<option value="2" selected="selected">入库</option>
				</select>				
			</td>
			
			<td class="td_title">代理商&nbsp;</td>	
			<td class="td_content" style="text-align:left; " >
				<select name="agent_no" id="agent_no" style="width:150px">
					<option value="0">请选择</option>
					<c:forEach items="${agent_list}" var="a">
						<option value="${a.agentNo}">${a.name}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		
		<tr>
			<td class="td_title">sn&nbsp;</td>	
			<td class="td_content" style="text-align:left; ">
				<input type="text" name="sn_no" id="sn_no"  maxlength="30" class="underline" size="25" value="" onkeyup="disabledField('sn_no');"/>&nbsp;&nbsp;&nbsp;&nbsp;
			</td>
			
			<td class="td_title">sn范围&nbsp;</td>	
			<td class="td_content" style="text-align:left; ">
				<input class="underline" type="text" name="sn_no_from" id="sn_no_from" size="15" value="" onkeyup="disabledFromAndTo('sn_no');"/> - 
				<input class="underline" type="text" name="sn_no_to" id="sn_no_to" size="15" value="" onkeyup="disabledFromAndTo('sn_no');"/>
			</td>
			
			<td class="td_title">出入库时间&nbsp;</td>
			<td class="td_content" style="text-align:left;" colspan="3">
				<input class="underline" type="text" name="start_entryTime" id="start_entryTime" size="9" value=""/> - 
				<input class="underline" type="text" name="end_entryTime" id="end_entryTime" size="9" value=""/>
			</td>
			
		</tr>
		
		<tr>
			<td class="td_title">盒子序号&nbsp;</td>	
			<td class="td_content" style="text-align:left; ">
				<input type="text" name="box_no" id="box_no"  maxlength="30" class="underline" size="25" value="" onkeyup="disabledField('box_no');"/>&nbsp;&nbsp;&nbsp;&nbsp;
			</td>
		
			<td class="td_title">盒子序号范围&nbsp;</td>	
			<td class="td_content" style="text-align:left; ">
				<input class="underline" type="text" name="box_no_from" id="box_no_from" size="15" value="" onkeyup="disabledFromAndTo('box_no');"/> - 
				<input class="underline" type="text" name="box_no_to" id="box_no_to" size="15" value="" onkeyup="disabledFromAndTo('box_no');"/>
			</td>
			<td class="td_content" colspan="4">&nbsp; </td>
			
		</tr>
	</table>
	<br>
	<div style="width:95%">
		<span style="padding-right:500px">
			<input  type="button" name="searchVisitPlan" value="查询" id="queryBtn" class="button_1"/>&nbsp;&nbsp;&nbsp;&nbsp;
			<input  type="button" name="QueryPrdtAccessory" id="resetPrdtAccessory" value="清空" class="button_1"/>&nbsp;&nbsp;&nbsp;&nbsp;
		</span>
		<span style="padding-left: 250px">
			<input  type="button" name="preAddProductOut" id="preAddProductOut" value="产品出库"  class="button_1"/>&nbsp;&nbsp;&nbsp;&nbsp;
		</span>
	</div>
</form>

<div style="width:95%">
<ec:table  items="cardProduct_list" var="card" tableId="ec" 
	action="${ctx}/admin/storage/view_product.action?time=now"
	excludeParameters="deleteFlag"
	rowsDisplayed="5"
	maxRowsExported = "1000"
	xlsFileName="card.xls"
	toolbarContent="pagesize|navigation|pageSizeList|pagejump|refresh|export|extend| status  extend extend"
	tagAttributes="">
	<ec:row recordKey="${card.p_no}">
			<ec:column width="16px" cell="checkbox" headerCell="checkbox" alias="deleteFlag" value="${card.p_no}" viewsAllowed="html" sortable="false" 
					cellValue="${card.p_no_status == 2 && card.crad_no_status == 2 && card.sn_no_status == 2 && card.box_no_status == 2}" />   
		    <ec:column width="40px" property="_0" title="序号" style="text-align: center;" value="${GLOBALROWCOUNT}" />
		    <ec:column width="150px" property="p_no" title="产品序列号" style="text-align: center;" sortable="true" viewsAllowed="xls,html">
		   		<c:choose>
		   			<c:when test="${card.p_no_status =='1'}"><span style="color:red">${card.p_no}</span></c:when>
		   			<c:when test="${card.p_no_status =='2'}"><span style="color:green">${card.p_no}</span></c:when>
		   			<c:otherwise>-</c:otherwise>
		   		</c:choose>
		   	</ec:column>
		   	<ec:column width="150px" property="crad_no" title="卡号" style="text-align: center;" sortable="true" viewsAllowed="xls,html">
		  		<c:choose>
		   			<c:when test="${card.crad_no_status =='1'}"><span style="color:red">${card.crad_no}</span></c:when>
		   			<c:when test="${card.crad_no_status =='2'}"><span style="color:green">${card.crad_no}</span></c:when>
		   			<c:otherwise>-</c:otherwise>
		   		</c:choose>
		  	</ec:column>
		  	<ec:column width="150px" property="sn_no" title="硬卡" style="text-align: center;" sortable="true" viewsAllowed="xls,html">
		  		<c:choose>
		   			<c:when test="${card.sn_no_status =='1'}"><span style="color:red">${card.sn_no}</span></c:when>
		   			<c:when test="${card.sn_no_status =='2'}"><span style="color:green">${card.sn_no}</span></c:when>
		   			<c:otherwise>-</c:otherwise>
		   		</c:choose>
		  	</ec:column>
		  	<ec:column width="150px" property="box_no" title="盒子号" style="text-align: center;" sortable="true" viewsAllowed="xls,html">
		  		<c:choose>
		   			<c:when test="${card.box_no_status =='1'}"><span style="color:red">${card.box_no}</span></c:when>
		   			<c:when test="${card.box_no_status =='2'}"><span style="color:green">${card.box_no}</span></c:when>
		   			<c:otherwise>-</c:otherwise>
		   		</c:choose>
		  	</ec:column>
		  	<ec:column width="150px" property="p_no_agent_name" title="代理/供应商" style="text-align: center;" sortable="true" viewsAllowed="xls,html" value="${card.p_no_agent_name}" />
		  	<ec:column width="150px" property="entry_date" title="操作时间" style="text-align: center;" sortable="true" viewsAllowed="xls,html" value="${card.entry_date}" >
		  		<fmt:formatDate  pattern="yyyy-MM-dd" value="${card.entry_date}" />
		  	</ec:column>
	</ec:row>    
	 	
 	<ec:extend location="top">
 		<div style="word-break:break-all;word-wrap:break-word;">
 			<table style="width:90%"><tbody>
	 			<tr>
	 				<td style="width: 50%">
	 					<span style="color:green">库存余额：   </span>
			 			<span style="color:green">产品：    </span>  <b><s:property value="p_num.get('product_num_2')"/></b>&nbsp;&nbsp;
			 			<span style="color:green">sim卡：  </span>  <b><s:property value="p_num.get('card_sim_num_2')"/></b>&nbsp;&nbsp;
			 			<span style="color:green">硬件卡：</span>  <b><s:property value="p_num.get('card_sn_num_2')"/></b>&nbsp;&nbsp;
			 			<span style="color:green">盒子：     </span>  <b><s:property value="p_num.get('card_box_num_2')"/></b>&nbsp;&nbsp;
	 				</td>
	 				
	 				<td style="width: 50%">
	 					<span style="color:red">出库：    </span>  
			 			<span style="color:red">产品：    </span>    <b><s:property value="p_num.get('product_num_1')"/></b>&nbsp;&nbsp;
			 			<span style="color:red">sim卡：  </span>    <b><s:property value="p_num.get('card_sim_num_1')"/></b>&nbsp;&nbsp;
			 			<span style="color:red">硬件卡：</span>    <b><s:property value="p_num.get('card_sn_num_1')"/></b>&nbsp;&nbsp;
			 			<span style="color:red">盒子：     </span>    <b><s:property value="p_num.get('card_box_num_1')"/></b>&nbsp;&nbsp;
	 				</td>
	 			</tr>
 			</tbody></table>
 		</div>
 	</ec:extend>
   </ec:table>
</div>
 <div id="show_oprate" style="position:absolute;width:180px;height:163px;cursor:hand;display:none;border:1px solid #CCC;
 	background-color:#F2FDDB;" onmouseout="hide_oprate()">  
 </div>
</div>
<div id="fragment-2">
	<iframe src="" name="inFrame" id="inFrame"  width="100%" height="100%" scrolling="no" frameborder="0"></iframe>
</div>

<div id="fragment-3">
	<iframe src="" name="outFrame" id="outFrame" width="100%" height="100%" scrolling="no" frameborder="0"></iframe>
</div>

	
</center>
</div>
</div>
<script language="javascript"	src="<c:url value='/'/>js/common/datetime.js"></script>
</body>
</html>
