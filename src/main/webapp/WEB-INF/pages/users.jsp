<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<t:pageTemplate pageTitle="Users">

    <h1 class="mb-3">Users</h1>

    <!-- Add User + Invoice (Invoice doar dacă userul are rol INVOICING) -->
    <div class="mb-3">
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/AddUser">
            Add User
        </a>

        <c:if test="${pageContext.request.isUserInRole('INVOICING')}">
            <button class="btn btn-secondary" type="submit" form="invoiceForm">
                Invoice
            </button>
        </c:if>
    </div>

    <!-- FORM pentru facturare (în jurul listei de users) -->
    <form id="invoiceForm"
          method="POST"
          action="${pageContext.request.contextPath}/Users">

        <div class="row gy-3">
            <c:forEach var="u" items="${users}">
                <div class="col-12 col-md-4">
                    <div class="form-check">
                        <input class="form-check-input"
                               type="checkbox"
                               name="user_ids"
                               value="${u.id}"
                               id="user-${u.id}">
                        <label class="form-check-label" for="user-${u.id}">
                                ${u.username} • ${u.email}
                        </label>
                    </div>

                    <!-- Buton Edit, vizibil doar pentru WRITE_USERS -->
                    <c:if test="${pageContext.request.isUserInRole('WRITE_USERS')}">
                        <a class="btn btn-sm btn-outline-secondary mt-1"
                           href="${pageContext.request.contextPath}/EditUser?id=${u.id}">
                            Edit
                        </a>
                    </c:if>
                </div>
            </c:forEach>

            <c:if test="${empty users}">
                <div class="col-12 text-muted">
                    No users found.
                </div>
            </c:if>
        </div>

    </form>

    <!-- Lista de facturi: doar pentru INVOICING -->
    <c:if test="${pageContext.request.isUserInRole('INVOICING') and not empty invoices}">
        <h2 class="mt-4">Invoices</h2>
        <c:forEach var="username" items="${invoices}" varStatus="status">
            ${status.index + 1}. ${username}<br/>
        </c:forEach>
    </c:if>

</t:pageTemplate>