<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@include file = "common/header.jspf" %>
<%@include file = "common/navigation.jspf" %>
<div class="container">

<h1>Add a Todo</h1>
<form:form method="post" commandName="todo">
	<form:hidden path="id"/>
	
	<fieldset class="form-group">
	<form:label path="desc">Description</form:label>
	<form:input path="desc" type="text" class="form-control" required="required"/>
	<form:errors path="desc" cssClass="text-warning"></form:errors>
	</fieldset>
	
	<fieldset class="form-group">
	<form:label path="targetDate">Target Date</form:label>
	<form:input path="targetDate" type="text" class="form-control" required="required"/>
	<form:errors path="targetDate" cssClass="text-warning"></form:errors>
	</fieldset>
	
	<input class="btn btn-success" type="submit" value="Submit"/>
	
</form:form>


</div>
<%@include file = "common/footer.jspf" %>