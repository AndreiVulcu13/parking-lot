<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<t:pageTemplate pageTitle="Cars">
    <h1 class="mb-3">Cars</h1>

    <!-- Layout simplu tip grilă (3 coloane pe rând) -->
    <div class="row gy-3">
        <c:forEach var="car" items="${cars}">
            <div class="col-12 col-md-4">
                    ${car.licensePlate} • Spot ${car.parkingSpot} • ${car.ownerName}
            </div>
        </c:forEach>

        <!-- dacă nu sunt mașini -->
        <c:if test="${empty cars}">
            <div class="col-12 text-muted">
                No cars found.
            </div>
        </c:if>
    </div>

    <h5 class="mt-4">Free parking spots: ${numberOfFreeParkingSpots}</h5>
</t:pageTemplate>