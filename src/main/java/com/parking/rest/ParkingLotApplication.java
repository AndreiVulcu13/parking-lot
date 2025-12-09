package com.parking.rest;

import jakarta.ws.rs.ApplicationPath;
import jakarta.ws.rs.core.Application;

/**
 * Activează JAX-RS pentru aplicația ParkingLot.
 * Toate resursele REST vor fi sub /resources.
 *
 * Exemplu:
 *   /ParkingLot2-1.0-SNAPSHOT/resources/cars
 */
@ApplicationPath("/resources")
public class ParkingLotApplication extends Application {

}