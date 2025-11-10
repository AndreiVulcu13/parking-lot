<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<t:pageTemplate pageTitle="Users">
    <h1 class="mb-3">Users</h1>

    <div class="row gy-3">
        <c:forEach var="u" items="${users}">
            <div class="col-12 col-md-4">
                    ${u.username} • ${u.email}
            </div>
        </c:forEach>

        <c:if test="${empty users}">
            <div class="col-12 text-muted">No users found.</div>
        </c:if>
    </div>
</t:pageTemplate>