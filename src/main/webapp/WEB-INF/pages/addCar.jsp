<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<t:pageTemplate pageTitle="Add Car">
    <h1 class="mb-3">Add Car</h1>

    <form class="needs-validation" novalidate
          method="POST"
          action="${pageContext.request.contextPath}/AddCar">

        <div class="row g-3">

            <!-- License plate -->
            <div class="col-md-6">
                <label for="licensePlate" class="form-label">License plate</label>
                <input type="text" class="form-control" id="licensePlate"
                       name="license_plate" required>
                <div class="invalid-feedback">
                    Valid license plate is required.
                </div>
            </div>

            <!-- Parking spot -->
            <div class="col-md-6">
                <label for="parkingSpot" class="form-label">Parking spot</label>
                <input type="text" class="form-control" id="parkingSpot"
                       name="parking_spot" required>
                <div class="invalid-feedback">
                    Valid parking spot is required.
                </div>
            </div>

            <!-- Owner dropdown -->
            <div class="col-md-6">
                <label for="owner" class="form-label">Owner</label>
                <select class="form-select" id="owner" name="owner_id" required>
                    <option value="">Choose...</option>
                    <c:forEach var="u" items="${users}">
                        <option value="${u.id}">${u.username}</option>
                    </c:forEach>
                </select>
                <div class="invalid-feedback">
                    Please select an owner.
                </div>
            </div>
        </div>

        <hr class="my-4">

        <button class="w-100 btn btn-primary btn-lg" type="submit">
            Save
        </button>
    </form>
</t:pageTemplate>