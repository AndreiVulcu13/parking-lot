package com.parking.servlets;

import com.parking.common.UserDto;
import com.parking.ejb.UsersBean;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.HttpConstraint;
import jakarta.servlet.annotation.ServletSecurity;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;

/**
 * Edit User:
 *  - GET: afișează formularul precompletat
 *  - POST: salvează modificările
 *
 * Necesită rolul WRITE_USERS.
 */
@ServletSecurity(
        value = @HttpConstraint(rolesAllowed = {"WRITE_USERS"})
)
@WebServlet(name = "EditUser", value = "/EditUser")
public class EditUser extends HttpServlet {

    @Inject
    private UsersBean usersBean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Long userId = Long.parseLong(request.getParameter("id"));

        // User-ul ca DTO
        UserDto user = usersBean.findById(userId);
        request.setAttribute("user", user);

        // Grupurile user-ului (READ_CARS, WRITE_USERS etc.)
        Collection<String> userGroups = usersBean.findUserGroupsByUserId(userId);

        // Setăm niște booleene pentru checkbox-uri în JSP
        request.setAttribute("hasREAD_CARS",     userGroups.contains("READ_CARS"));
        request.setAttribute("hasWRITE_CARS",    userGroups.contains("WRITE_CARS"));
        request.setAttribute("hasREAD_USERS",    userGroups.contains("READ_USERS"));
        request.setAttribute("hasWRITE_USERS",   userGroups.contains("WRITE_USERS"));
        request.setAttribute("hasINVOICING",     userGroups.contains("INVOICING"));

        request.getRequestDispatcher("/WEB-INF/pages/editUser.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Long userId = Long.parseLong(request.getParameter("user_id"));
        String username = request.getParameter("username");
        String email    = request.getParameter("email");
        String password = request.getParameter("password"); // poate fi gol

        String[] groupsParam = request.getParameterValues("user_groups");
        List<String> groups = (groupsParam == null)
                ? List.of()
                : Arrays.asList(groupsParam);

        // În UsersBean.updateUser:
        //  - dacă password e null/goală → nu o modifici
        //  - dacă e completată → o hash-uiești și o actualizezi
        usersBean.updateUser(userId, username, email, password, groups);

        response.sendRedirect(request.getContextPath() + "/Users");
    }
}