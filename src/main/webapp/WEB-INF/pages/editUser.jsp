<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<t:pageTemplate pageTitle="Edit User">

    <h1 class="mb-3">Edit User</h1>

    <form class="needs-validation" novalidate
          method="POST"
          action="${pageContext.request.contextPath}/EditUser">

        <!-- id-ul user-ului -->
        <input type="hidden" name="user_id" value="${user.id}"/>

        <div class="row g-3">

            <div class="col-md-4">
                <label for="username" class="form-label">Username</label>
                <input type="text"
                       class="form-control"
                       id="username"
                       name="username"
                       value="${user.username}"
                       required>
                <div class="invalid-feedback">
                    Username is required.
                </div>
            </div>

            <div class="col-md-4">
                <label for="email" class="form-label">Email</label>
                <input type="email"
                       class="form-control"
                       id="email"
                       name="email"
                       value="${user.email}"
                       required>
                <div class="invalid-feedback">
                    Email is required.
                </div>
            </div>

            <div class="col-md-4">
                <label for="password" class="form-label">Password</label>
                <input type="password"
                       class="form-control"
                       id="password"
                       name="password"
                       placeholder="Leave empty to keep the same">
                <div class="form-text">
                    Leave empty if you don't want to change the password.
                </div>
            </div>

        </div>

        <hr class="my-4">

        <h5>Roles</h5>
        <div class="row">
            <div class="col-md-3">
                <div class="form-check">
                    <input class="form-check-input"
                           type="checkbox"
                           id="role-read-cars"
                           name="user_groups"
                           value="READ_CARS"
                           <c:if test="${hasREAD_CARS}">checked</c:if>>
                    <label class="form-check-label" for="role-read-cars">
                        READ_CARS
                    </label>
                </div>
            </div>

            <div class="col-md-3">
                <div class="form-check">
                    <input class="form-check-input"
                           type="checkbox"
                           id="role-write-cars"
                           name="user_groups"
                           value="WRITE_CARS"
                           <c:if test="${hasWRITE_CARS}">checked</c:if>>
                    <label class="form-check-label" for="role-write-cars">
                        WRITE_CARS
                    </label>
                </div>
            </div>

            <div class="col-md-3">
                <div class="form-check">
                    <input class="form-check-input"
                           type="checkbox"
                           id="role-read-users"
                           name="user_groups"
                           value="READ_USERS"
                           <c:if test="${hasREAD_USERS}">checked</c:if>>
                    <label class="form-check-label" for="role-read-users">
                        READ_USERS
                    </label>
                </div>
            </div>

            <div class="col-md-3">
                <div class="form-check">
                    <input class="form-check-input"
                           type="checkbox"
                           id="role-write-users"
                           name="user_groups"
                           value="WRITE_USERS"
                           <c:if test="${hasWRITE_USERS}">checked</c:if>>
                    <label class="form-check-label" for="role-write-users">
                        WRITE_USERS
                    </label>
                </div>
            </div>

            <div class="col-md-3 mt-2">
                <div class="form-check">
                    <input class="form-check-input"
                           type="checkbox"
                           id="role-invoicing"
                           name="user_groups"
                           value="INVOICING"
                           <c:if test="${hasINVOICING}">checked</c:if>>
                    <label class="form-check-label" for="role-invoicing">
                        INVOICING
                    </label>
                </div>
            </div>
        </div>

        <hr class="my-4">

        <button class="btn btn-primary btn-lg" type="submit">
            Save
        </button>
    </form>

</t:pageTemplate>