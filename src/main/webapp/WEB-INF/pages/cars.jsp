<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<t:pageTemplate pageTitle="Cars">
    <h1 class="mb-3">Cars</h1>

    <!-- Add Car (doar pentru WRITE_CARS) -->
    <c:if test="${pageContext.request.isUserInRole('WRITE_CARS')}">
        <a class="btn btn-primary btn-lg mb-3"
           href="${pageContext.request.contextPath}/AddCar">
            Add Car
        </a>
    </c:if>

    <!-- formular Delete Cars, doar pentru WRITE_CARS -->
    <c:if test="${pageContext.request.isUserInRole('WRITE_CARS')}">
        <form method="POST" action="${pageContext.request.contextPath}/Cars">
            <div class="mb-3">
                <button type="submit" class="btn btn-danger">
                    Delete Cars
                </button>
            </div>

            <div class="row gy-3">
                <c:forEach var="car" items="${cars}">
                    <div class="col-12 col-md-4">

                        <div class="form-check">
                            <input class="form-check-input"
                                   type="checkbox"
                                   name="car_ids"
                                   value="${car.id}"
                                   id="car-${car.id}">
                            <label class="form-check-label" for="car-${car.id}">
                                    ${car.licensePlate} • Spot ${car.parkingSpot} • ${car.ownerName}
                            </label>
                        </div>

                        <!-- Poză mașină -->
                        <div class="mt-2">
                            <img src="${pageContext.request.contextPath}/CarPhotos?id=${car.id}"
                                 class="img-thumbnail"
                                 style="max-width: 80px; max-height: 80px;"
                                 alt="car photo"/>
                        </div>

                        <!-- Butoane Edit / Add photo -->
                        <div class="mt-2 d-flex gap-2">
                            <a class="btn btn-secondary btn-sm"
                               href="${pageContext.request.contextPath}/EditCar?id=${car.id}">
                                Edit Car
                            </a>
                            <a class="btn btn-outline-primary btn-sm"
                               href="${pageContext.request.contextPath}/AddCarPhoto?id=${car.id}">
                                Add photo
                            </a>
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${empty cars}">
                    <div class="col-12 text-muted">
                        No cars found.
                    </div>
                </c:if>
            </div>
        </form>
    </c:if>

    <!-- dacă userul are doar READ_CARS (fără WRITE_CARS), putem afișa lista simplă -->
    <c:if test="${not pageContext.request.isUserInRole('WRITE_CARS')}">
        <div class="row gy-3">
            <c:forEach var="car" items="${cars}">
                <div class="col-12 col-md-4">
                        ${car.licensePlate} • Spot ${car.parkingSpot} • ${car.ownerName}
                </div>
            </c:forEach>
        </div>
    </c:if>

    <h5 class="mt-4">Free parking spots: ${numberOfFreeParkingSpots}</h5>
</t:pageTemplate>