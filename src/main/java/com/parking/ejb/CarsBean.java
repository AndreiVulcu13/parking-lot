package com.parking.ejb;

import com.parking.entities.Car;
import com.parking.common.CarDto;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import jakarta.ejb.EJBException;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

@Stateless // A
public class CarsBean {

    private static final Logger LOG = Logger.getLogger(CarsBean.class.getName()); // B

    @PersistenceContext // C
    private EntityManager entityManager;

    public List<CarDto> findAllCars() {
        try {
            LOG.info("findAllCars"); // log
            TypedQuery<Car> typedQuery =
                    entityManager.createQuery("SELECT c FROM Car c JOIN FETCH c.owner", Car.class); // query
            List<Car> cars = typedQuery.getResultList(); // rezultat
            return copyCarsToDto(cars); // transformare
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }

    private List<CarDto> copyCarsToDto(List<Car> cars) {
        List<CarDto> dtos = new ArrayList<>();
        for (Car c : cars) {
            dtos.add(new CarDto(
                    c.getId(),
                    c.getLicensePlate(),
                    c.getParkingSpot(),
                    c.getOwner().getUsername() // ownerName
            ));
        }
        return dtos;
    }
}