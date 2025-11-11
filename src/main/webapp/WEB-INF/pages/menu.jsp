<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Bootstrap Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container-fluid">

        <!-- Brand -->
        <a class="navbar-brand" href="${pageContext.request.contextPath}">Parking Lot</a>

        <!-- Mobile toggle -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav"
                aria-controls="mainNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navbar content -->
        <div class="collapse navbar-collapse" id="mainNav">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">

                <!-- Home (NU în /WEB-INF) -->
                <li class="nav-item">
                    <a class="nav-link${pageContext.request.requestURI.substring(
               pageContext.request.requestURI.lastIndexOf("/")) eq '/index.jsp' ? ' active' : ''}"
                       href="${pageContext.request.contextPath}/index.jsp">
                        Home
                    </a>
                </li>

                <!-- About (NU în /WEB-INF) -->
                <li class="nav-item">
                    <a class="nav-link${pageContext.request.requestURI.substring(
               pageContext.request.requestURI.lastIndexOf("/")) eq '/about.jsp' ? ' active' : ''}"
                       href="${pageContext.request.contextPath}/about.jsp">
                        About
                    </a>
                </li>

                <!-- Cars (activ via requestScope.activePage din servlet) -->
                <li class="nav-item">
                    <a class="nav-link${'Cars' eq (requestScope.activePage) ? ' active' : ''}"
                       href="${pageContext.request.contextPath}/Cars">
                        Cars
                    </a>
                </li>

                <!-- Nav Users -->
                <li class="nav-item">
                    <a class="nav-link${'Users' eq (requestScope.activePage) ? ' active' : ''}"
                       href="${pageContext.request.contextPath}/Users">Users</a>
                </li>

            </ul>

            <!-- Right-side Login link -->
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/Login">Login</a>
                </li>
            </ul>
        </div>
    </div>
</nav>