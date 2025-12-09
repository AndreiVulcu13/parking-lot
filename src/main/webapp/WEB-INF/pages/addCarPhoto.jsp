<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<t:pageTemplate pageTitle="Add car photo">
    <h1 class="mb-3">Add car photo</h1>

    <form class="needs-validation" novalidate
          method="POST"
          enctype="multipart/form-data"
          action="${pageContext.request.contextPath}/AddCarPhoto">

        <div class="row g-3">

            <div class="col-12 col-md-6">
                <p>
                    <strong>License plate:</strong>
                        ${car.licensePlate}
                </p>
            </div>

            <div class="col-12 col-md-6">
                <label for="file" class="form-label">Photo</label>
                <input type="file" class="form-control"
                       id="file" name="file" required>
                <div class="invalid-feedback">
                    Please choose a file.
                </div>
            </div>

        </div>

        <!-- id-ul mașinii -->
        <input type="hidden" name="car_id" value="${car.id}"/>

        <hr class="my-4">
        <button class="btn btn-primary btn-lg" type="submit">Save</button>
    </form>
</t:pageTemplate>