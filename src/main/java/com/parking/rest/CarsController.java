package com.parking.rest;

import com.parking.common.CarDto;
import com.parking.ejb.CarsBean;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;

import java.util.List;

/**
 * Resursă REST pentru Cars.
 *
 * GET /resources/cars       → lista de mașini
 * GET /resources/cars/{id}  → o singură mașină
 */
@Path("/cars")
public class CarsController {

    @Inject
    private CarsBean carsBean;

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<CarDto> findAllCars() {
        return carsBean.findAllCars();
    }

    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public CarDto findCar(@PathParam("id") Long id) {
        return carsBean.findById(id);
    }
}