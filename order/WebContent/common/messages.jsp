<%@ page language="java" pageEncoding="UTF-8"%>

<% if (request.getAttribute("struts.valueStack") != null) { %>
<%-- ActionError Messages - usually set in Actions --%>
<s:if test="hasActionErrors()">
    <div class="errorMessages" id="errorMessages">    
      <s:iterator value="actionErrors">
        <img src="<c:url value="/images/common/iconWarning.gif"/>"
            alt="<fmt:message key="icon.warning"/>" class="icon" />
        <s:property/><br />
      </s:iterator>
   </div>
</s:if>

<%-- FieldError Messages - usually set by validation rules --%>
<s:if test="hasFieldErrors()">
    <div class="errorMessages" id="errorMessages">    
      <s:iterator value="fieldErrors">
          <s:iterator value="value">
            <img src="<c:url value="/images/common/iconWarning.gif"/>"
                alt="<fmt:message key="icon.warning"/>" class="icon" />
             <s:property/><br />
          </s:iterator>
      </s:iterator>
   </div>
</s:if>
<% } %>

<%-- Success Messages --%>
<s:if test="%{!hasFieldErrors() && !hasActionErrors()}">
<c:if test="${not empty messages}">
    <div class="successMessages" id="successMessages">    
        <c:forEach var="msg" items="${messages}">
            <img src="<c:url value="/images/common/iconInformation.gif"/>"
                alt="<fmt:message key="icon.information"/>" class="icon" />
            <fmt:message key="${msg}"/><br />
        </c:forEach>
    </div>
    <c:remove var="messages" scope="session"/>
</c:if>
</s:if>
<s:else>
	<c:remove var="messages" scope="session"/>
</s:else>

<%-- Error Messages (on JSPs, not through Struts 
<c:if test="${not empty errors}">
    <div class="error" id="errorMessages">
        <c:forEach var="error" items="${errors}">
            <img src="<c:url value="/images/common/iconWarning.gif"/>"
                alt="<fmt:message key="icon.warning"/>" class="icon" />
            <c:out value="${error}"/><br />
        </c:forEach>
    </div>
    <c:remove var="errors" scope="session"/>
</c:if>
--%>