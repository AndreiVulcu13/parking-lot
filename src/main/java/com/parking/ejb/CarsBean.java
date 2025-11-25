package com.parking.ejb;

import com.parking.common.CarDto;
import com.parking.entities.Car;
import com.parking.entities.User;
import jakarta.ejb.EJBException;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

@Stateless
public class CarsBean {

    private static final Logger LOG = Logger.getLogger(CarsBean.class.getName());

    @PersistenceContext
    private EntityManager entityManager;

    // ===== READ ALL =====
    public List<CarDto> findAllCars() {
        try {
            LOG.info("findAllCars");
            TypedQuery<Car> typedQuery =
                    entityManager.createQuery(
                            "SELECT c FROM Car c JOIN FETCH c.owner",
                            Car.class
                    );
            List<Car> cars = typedQuery.getResultList();
            return copyCarsToDto(cars);
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }

    // ===== READ ONE =====
    public CarDto findById(Long carId) {
        Car c = entityManager.find(Car.class, carId);
        if (c == null) {
            return null;
        }
        return new CarDto(
                c.getId(),
                c.getLicensePlate(),
                c.getParkingSpot(),
                c.getOwner().getUsername()
        );
    }

    // ===== CREATE =====
    public void createCar(String licensePlate, String parkingSpot, Long userId) {
        try {
            LOG.info("createCar");

            User owner = entityManager.find(User.class, userId);
            if (owner == null) {
                throw new EJBException("User not found: " + userId);
            }

            Car car = new Car();
            car.setLicensePlate(licensePlate);
            car.setParkingSpot(parkingSpot);
            car.setOwner(owner);

            // menținem relația bidirecțională
            owner.getCars().add(car);

            entityManager.persist(car);
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }

    // ===== UPDATE =====
    public void updateCar(Long carId, String licensePlate, String parkingSpot, Long userId) {
        try {
            LOG.info("updateCar");

            Car car = entityManager.find(Car.class, carId);
            if (car == null) {
                throw new EJBException("Car not found: " + carId);
            }

            User newOwner = entityManager.find(User.class, userId);
            if (newOwner == null) {
                throw new EJBException("User not found: " + userId);
            }

            // scoatem mașina din vechiul owner (dacă s-a schimbat)
            User oldOwner = car.getOwner();
            if (oldOwner != null && !oldOwner.equals(newOwner)) {
                oldOwner.getCars().remove(car);
            }

            car.setLicensePlate(licensePlate);
            car.setParkingSpot(parkingSpot);
            car.setOwner(newOwner);

            // adăugăm în noul owner (dacă nu e deja acolo)
            if (!newOwner.getCars().contains(car)) {
                newOwner.getCars().add(car);
            }

            entityManager.merge(car);
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }

    // ===== DELETE =====
    public void deleteCarsByIds(List<Long> carIds) {
        if (carIds == null || carIds.isEmpty()) {
            return;
        }
        try {
            LOG.info("deleteCarsByIds: " + carIds);

            entityManager.createQuery("DELETE FROM Car c WHERE c.id IN :ids")
                    .setParameter("ids", carIds)
                    .executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }

    // ===== HELPER DTO =====
    private List<CarDto> copyCarsToDto(List<Car> cars) {
        List<CarDto> dtos = new ArrayList<>();
        for (Car c : cars) {
            dtos.add(new CarDto(
                    c.getId(),
                    c.getLicensePlate(),
                    c.getParkingSpot(),
                    c.getOwner().getUsername()
            ));
        }
        return dtos;
    }
}