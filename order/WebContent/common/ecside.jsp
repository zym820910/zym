<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="ec"  uri="http://www.extremecomponents.org" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="jxt" uri="http://3g.gitelecom.net/taglibs"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="cache-control" content="no-cache"/>
<meta http-equiv="expires" content="0"/>
<link   rel="stylesheet" type="text/css" href="${ctx}/css/common/mydefault.css" />
<link   rel="stylesheet" type="text/css" href="${ctx}/css/common/ecside_style.css" />
<link   rel="stylesheet" type="text/css" href="${ctx}/css/common/jquery.dialog.css" />
<script language="javaScript" src="<c:url value='/'/>js/common/Dialog.js"></script>
<script language="javaScript" src="<c:url value='/'/>js/common/comm.js"></script>
<script language="javaScript" src="${ctx}/js/common/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
<script language="javaScript" src="${ctx}/js/common/ecside.js" type="text/javascript"></script>
<script language="javaScript" src="${ctx}/js/common/jquery/jquery.eform.js" type="text/javascript"></script>
<script language="javaScript" src="${ctx}/js/common/jquery/jquery.form.js" type="text/javascript"></script>
<script language="javaScript" src="${ctx}/js/common/jquery/ajaxfileupload.js" type="text/javaScript" ></script>
<script language="javaScript" src="${ctx}/js/common/jquery/jquery.dialog.js" type="text/javascript"></script>
<script language="javaScript" src="${ctx}/js/common/strconvert.js" type="text/javascript"></script>
<script type="text/javascript">
String.prototype.Trim = function(){return this.replace(/(^\s*)|(\s*$)/g,"");}
</script>
<script type="text/javascript">
	if(!window.domainname) window.domainname = "<c:url value='/'/>";
	
	var ECSideMessage={
			ENCODING		: "UTF-8",
			WAITTING_MSG	: "正在提交...",
			FILTERCLEAR_TEXT: "清除全部过滤条件",
			SORTASC_TEXT	: "升序排列",
			SORTDESC_TEXT	: "降序排列",
			SORTDEFAULT_TEXT: "清除排序状态",
			ERR_PAGENO		: "跳转页数只能是 1 至 #{1} 的整数!",
			EXPORT_CONFIRM	: "处理全部数据吗?\n\n( \"取消\" 为处理当前页面)",
			OVER_MAXEXPORT	: "数据总数超过了所允许的最大值( #{1} 条 ).",
			SHADOWROW_FAILED: "	无法取得相关信息",
			NO_RECORD_UPDATE: "没有记录需要被更新!",
			UPDATE_CONFIRM	: "确定要执行保存操作吗?",
			NEARPAGE_TITLE	: ""
	};
	
</script>

<script type="text/javascript">
document.src={id:'',nm:''};
function SC(){o=event.srcElement;src=document.src;D=document.getElementById("CWD");a=(o.align=='right');
if(true){L=GL(o);T=GT(o)+o.offsetHeight/(a?2:1)+1;D.style.left=L+(a?(o.scrollWidth-60):0)+'px';D.style.textAlign=(a?'right':'left');D.style.top=T+'px';src.id=o.id;src.nm=o.name;}
D.style.display='';D.innerText=(o.max!=0?'已输入':'最大可输入长度')+':'+o.value.length+(o.max!=0?'/'+o.max:'');}
function GT(o){T=o.offsetTop;if(o.offsetParent!=null)T+=GT(o.offsetParent);return T;}
function GL(o){L =o.offsetLeft;if(o.offsetParent!=null)L+=GL(o.offsetParent);return L;}
function HC(){o=event.srcElement;s=document.getElementById("CWD").style;if(o.max==0){s.display='none';}else if(o.value.length<=o.max){s.display="none";}else{o.focus();}}

function blink (elId){
	  var   html   =   '';   
      if   (document.all) html   +=   'var   el   =   document.all.'   +   elId   +   ';';   
      else  if  (document.getElementById)  html   +=   'var   el   =   document.getElementById("'   +   elId   +   '");';   
      html   += 'el.style.visibility   =   '   +    'el.style.visibility   ==   "hidden"   ?   "visible"   :   "hidden"';   
      if   (document.all   ||   document.getElementById)   
          setInterval(html,   500)   
}
String.prototype.Trim = function(){
	return this.replace(/(^\s*)|(\s*$)/g,"");
}
</script>

</head>
<div id="CWD" style="display:none;color:green;width:180px;height:15px;position:absolute;filter:progid:DXImageTransform.Microsoft.Alpha(opacity=60);"></div>
</html>
