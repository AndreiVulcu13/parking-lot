<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<t:pageTemplate pageTitle="Sign in">
    <h1 class="mb-3">Sign in</h1>

    <!-- mesaj de eroare trimis de Login.doPost -->
    <c:if test="${not empty message}">
        <div class="alert alert-warning" role="alert">
                ${message}
        </div>
    </c:if>

    <!-- ATENȚIE: action = j_security_check, field-urile j_username / j_password -->
    <form class="needs-validation" novalidate
          method="POST"
          action="j_security_check">

        <div class="row g-3">

            <div class="col-md-6">
                <label for="username" class="form-label">Username</label>
                <input type="text"
                       class="form-control"
                       id="username"
                       name="j_username"
                       required>
                <div class="invalid-feedback">
                    Username is required.
                </div>
            </div>

            <div class="col-md-6">
                <label for="password" class="form-label">Password</label>
                <input type="password"
                       class="form-control"
                       id="password"
                       name="j_password"
                       required>
                <div class="invalid-feedback">
                    Password is required.
                </div>
            </div>

        </div>

        <hr class="my-4">

        <button class="btn btn-primary btn-lg" type="submit">
            Sign in
        </button>
    </form>
</t:pageTemplate>