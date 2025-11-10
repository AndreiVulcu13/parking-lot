package com.parking.ejb;

import com.parking.common.UserDto;
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
public class UsersBean {

    private static final Logger LOG = Logger.getLogger(UsersBean.class.getName());

    @PersistenceContext
    private EntityManager em;

    public List<UserDto> findAllUsers() {
        try {
            LOG.info("findAllUsers");
            TypedQuery<User> query = em.createQuery("SELECT u FROM User u ORDER BY u.id", User.class);
            List<User> users = query.getResultList();

            List<UserDto> dtos = new ArrayList<>();
            for (User u : users) {
                dtos.add(new UserDto(u.getId(), u.getUsername(), u.getEmail()));
            }
            return dtos;
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }
}