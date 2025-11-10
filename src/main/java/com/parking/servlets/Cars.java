package com.parking.servlets;

import com.parking.common.CarDto;
import com.parking.ejb.CarsBean;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "Cars", value = "/Cars")
public class Cars extends HttpServlet {

    // CDI: injectăm EJB-ul nostru stateless CarsBean
    @Inject
    private CarsBean carsBean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Folosește EJB-ul pentru a obține datele
        List<CarDto> cars = carsBean.findAllCars();
        request.setAttribute("cars", cars);

        // Calcul pentru locuri libere
        int totalSpots = 100;
        int numberOfFreeParkingSpots = Math.max(0, totalSpots - cars.size());
        request.setAttribute("numberOfFreeParkingSpots", numberOfFreeParkingSpots);

        // pentru highlight în meniu
        request.setAttribute("activePage", "Cars");

        // Forward către JSP (care afișează lista din DB)
        request.getRequestDispatcher("/WEB-INF/pages/cars.jsp").forward(request, response);
    }
}