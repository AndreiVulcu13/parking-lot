package com.parking.servlets;

import com.parking.common.CarDto;
import com.parking.ejb.CarsBean;
import jakarta.annotation.security.DeclareRoles;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.HttpConstraint;
import jakarta.servlet.annotation.HttpMethodConstraint;
import jakarta.servlet.annotation.ServletSecurity;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@DeclareRoles({"READ_CARS", "WRITE_CARS"})
@ServletSecurity(
        value = @HttpConstraint(rolesAllowed = {"READ_CARS"}),
        httpMethodConstraints = {
                @HttpMethodConstraint(
                        value = "POST",
                        rolesAllowed = {"WRITE_CARS"}
                )
        }
)
@WebServlet(name = "Cars", value = "/Cars")
public class Cars extends HttpServlet {

    @Inject
    private CarsBean carsBean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<CarDto> cars = carsBean.findAllCars();
        request.setAttribute("cars", cars);

        int totalSpots = 10; // conform cerinței: 10 locuri în total
        int numberOfFreeParkingSpots = Math.max(0, totalSpots - cars.size());
        request.setAttribute("numberOfFreeParkingSpots", numberOfFreeParkingSpots);

        request.setAttribute("activePage", "Cars");

        request.getRequestDispatcher("/WEB-INF/pages/cars.jsp")
                .forward(request, response);
    }

    // folosit pentru Delete Cars (checkbox-urile din formular)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String[] ids = request.getParameterValues("car_ids");

        if (ids != null && ids.length > 0) {
            List<Long> carIds = new ArrayList<>();
            for (String id : ids) {
                carIds.add(Long.parseLong(id));
            }
            carsBean.deleteCarsByIds(carIds);
        }

        response.sendRedirect(request.getContextPath() + "/Cars");
    }
}