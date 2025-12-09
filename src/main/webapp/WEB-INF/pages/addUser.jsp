<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<t:pageTemplate pageTitle="Add User">

    <h1 class="mb-3">Add User</h1>

    <form class="needs-validation" novalidate
          method="POST"
          action="${pageContext.request.contextPath}/AddUser">

        <div class="row g-3">

            <div class="col-md-4">
                <label for="username" class="form-label">Username</label>
                <input type="text"
                       class="form-control"
                       id="username"
                       name="username"
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
                       required>
                <div class="invalid-feedback">
                    Password is required.
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
                           value="READ_CARS">
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
                           value="WRITE_CARS">
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
                           value="READ_USERS">
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
                           value="WRITE_USERS">
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
                           value="INVOICING">
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