<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>

<head>
<title>吉信通信息管理系统</title>
<script type="text/javascript">
		if (self != top){
		   window.top.location = window.location;
		}
		function login(){
			loginForm.submit();
		}
	
		function login2(){
			if(event.keyCode == 13) login();
		}
	</script>
	
<style type="text/css">
	body {
		background: url(${ctx}/images/login/bg_login.gif) top #72b7fd repeat-x;
	}
	.transportBg{ width:544px; margin:0 auto;align:center }	
	.transportBg {background-image:url(${ctx}/images/login/bg_login1.png)!important;background-image:url();
FILTER: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${ctx}/login/images/bg_login1.png');
WIDTH: 544px;height:466px;}
</style>
</head>
<body>
<form method="post" id="loginForm" action="<c:url value='/j_spring_security_check'/>" onsubmit="saveUsername(this);return validateForm(this)">
	<div style="background:url(${ctx}/images/login/logo_volks.gif) top left no-repeat;" align="center">
	<div style="height:70"></div>
	<div class="transportBg" style="width:544px; margin:0 auto;" >
	<table width="544" height="100%" align="center">
	<tr><td height="150"></td></tr>
		<tr>
			<td>
				<table border="0" style="width: 400px; height: 163px;" align="right" cellpadding="3" cellspacing="0">
					<tr>
						<td valign="top">
							<div class="loginBox">
								<div class="loginInput">
									<table width="83%" cellspacing="3" cellpadding="3" align="center">
										<tr height="23">
											<td colspan=3>&nbsp;</td>
										</tr>
										<tr height="17">
											<td colspan=3>
												<c:if test="${param.login_error != null}">
													<div style="color: #BB0000">
														<img src="${ctx}/images/common/iconWarning.gif" alt="<fmt:message key='icon.warning'/>" class="icon" />
														<fmt:message key="errors.password.mismatch" />
													</div>
												</c:if>
											</td>
										</tr>
										<tr>
											<td width="80"><fmt:message key="label.username" />:</td>
											<td><input type="text" class="text medium" name="j_username" id="j_username" tabindex="1" style="position: relative" /></td>
											<td rowspan="2"><a href="javascript:login();" style="position: relative" target="_parent"> <img src="${ctx}/images/login/b_login.gif" border="0" /></a></td>
										</tr>
										<tr>
											<td><fmt:message key="label.password" />:</td>
											<td colspan=2><input type="password" class="text medium" name="j_password" id="j_password" tabindex="2" onkeydown="login2()" style="position: relative" /></td>
										</tr>
									</table>
								</div>
							</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
		</div>
		<div class="copyright">株洲友明餐饮服务有限公司版权所有<br>Copyright © 2015 zhuzhou youming cater Solutions Co,Ltd</div>
		</div>
</form>
</body>
