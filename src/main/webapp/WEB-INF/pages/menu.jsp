<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container-fluid">

        <!-- Brand -->
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            Parking Lot
        </a>

        <!-- Mobile toggle -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#mainNav" aria-controls="mainNav"
                aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navbar content -->
        <div class="collapse navbar-collapse" id="mainNav">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">

                <!-- Home -->
                <li class="nav-item">
                    <a class="nav-link${'Home' eq (requestScope.activePage) ? ' active' : ''}"
                       href="${pageContext.request.contextPath}/">
                        Home
                    </a>
                </li>

                <!-- About -->
                <li class="nav-item">
                    <a class="nav-link${'About' eq (requestScope.activePage) ? ' active' : ''}"
                       href="${pageContext.request.contextPath}/about.jsp">
                        About
                    </a>
                </li>

                <!-- Cars: vizibil doar pentru READ_CARS -->
                <c:if test="${pageContext.request.isUserInRole('READ_CARS')}">
                    <li class="nav-item">
                        <a class="nav-link${'Cars' eq (requestScope.activePage) ? ' active' : ''}"
                           href="${pageContext.request.contextPath}/Cars">
                            Cars
                        </a>
                    </li>
                </c:if>

                <!-- Users: vizibil doar pentru READ_USERS -->
                <c:if test="${pageContext.request.isUserInRole('READ_USERS')}">
                    <li class="nav-item">
                        <a class="nav-link${'Users' eq (requestScope.activePage) ? ' active' : ''}"
                           href="${pageContext.request.contextPath}/Users">
                            Users
                        </a>
                    </li>
                </c:if>

            </ul>

            <!-- Right-side Login / Logout -->
            <ul class="navbar-nav">
                <li class="nav-item">
                    <c:choose>
                        <c:when test="${pageContext.request.remoteUser == null}">
                            <a class="nav-link"
                               href="${pageContext.request.contextPath}/Login">
                                Login
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a class="nav-link"
                               href="${pageContext.request.contextPath}/Logout">
                                Logout
                            </a>
                        </c:otherwise>
                    </c:choose>
                </li>
            </ul>
        </div>
    </div>
</nav>