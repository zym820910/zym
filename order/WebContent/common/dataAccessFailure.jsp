<%@ page language="java" isErrorPage="true"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<s:set name="stackTrace" value="%{exceptionStack}" scope="page" />
<%
	String stackTrace = (String) pageContext.getAttribute("stackTrace");
	if (stackTrace != null) {
		StringBuffer sb = new StringBuffer();
		sb.append("daf.jsp on ").append(new java.util.Date());
		sb.append(", referer is ").append(request.getHeader("referer"));
		sb.append(", uri is ").append(request.getRequestURI());
		sb.append(", url is ").append(request.getRequestURL());
		System.out.println(sb);
		System.out.println(stackTrace);

		int index = stackTrace.indexOf("com.shmc.portal.");
		if (index >= 0) {
			org.apache.commons.logging.Log log = org.apache.commons.logging.LogFactory
					.getLog("com.shmc.portal");
			log.error(stackTrace);
		}
	} else {

		if (exception == null) {
			exception = (Exception) request.getAttribute("exception");
		}
		if (exception != null) {
			StringBuffer sb = new StringBuffer();
			sb.append("daf.jsp on ").append(new java.util.Date());
			sb.append(", referer is ").append(
					request.getHeader("referer"));
			sb.append(", uri is ").append(request.getRequestURI());
			sb.append(", url is ").append(request.getRequestURL());
			System.out.println(sb);
			exception.printStackTrace(System.out);
		}
	}
%>

页面出错
<br>
请联系系统管理员
<br>
