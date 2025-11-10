<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:pageTemplate pageTitle="Parking Lot">
    <h1>Welcome to the Parking Lot</h1>
    <p>This is the main page of your Jakarta EE Parking Lot web application.</p>
    <p>
        <a href="${pageContext.request.contextPath}/about.jsp">Go to About page</a>
    </p>
</t:pageTemplate>