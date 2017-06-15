<%@include file = "common/header.jspf" %>
<%@include file = "common/navigation.jspf" %>
<div class="container">
<spring:message code="welcome.caption"/> ${name}.<BR/>
Now, you can <A href="/list-todos">manage your todos.</A>


</div>
<%@include file = "common/footer.jspf" %>