package com.parking.ejb;

import com.parking.common.UserDto;
import com.parking.entities.User;
import com.parking.entities.UserGroup;
import jakarta.ejb.EJB;
import jakarta.ejb.EJBException;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;

import java.util.*;
import java.util.logging.Logger;

@Stateless
public class UsersBean {

    private static final Logger LOG = Logger.getLogger(UsersBean.class.getName());

    @PersistenceContext
    private EntityManager em;

    @EJB
    private PasswordBean passwordBean;

    // ===== READ ALL USERS (DTO) =====
    public List<UserDto> findAllUsers() {
        try {
            LOG.info("findAllUsers");
            TypedQuery<User> query =
                    em.createQuery("SELECT u FROM User u ORDER BY u.id", User.class);
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

    // ===== FIND BY ID (DTO) – pentru EditUser =====
    public UserDto findById(Long userId) {
        try {
            LOG.info("findById: " + userId);
            User user = em.find(User.class, userId);
            if (user == null) {
                return null;
            }
            return new UserDto(user.getId(), user.getUsername(), user.getEmail());
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }

    // ===== USERS BY IDS → USERNAMES (pentru InvoiceBean) =====
    public Collection<String> findUsernamesByUserIds(Collection<Long> userIds) {
        try {
            LOG.info("findUsernamesByUserIds: " + userIds);

            if (userIds == null || userIds.isEmpty()) {
                return Collections.emptyList();
            }

            return em.createQuery(
                            "SELECT u.username FROM User u WHERE u.id IN :userIds",
                            String.class
                    )
                    .setParameter("userIds", userIds)
                    .getResultList();

        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }

    // ===== CREATE USER + USERGROUPS =====
    public void createUser(String username,
                           String email,
                           String plainPassword,
                           List<String> groups) {
        try {
            LOG.info("createUser: " + username);

            String hashedPassword = passwordBean.convertToSha256(plainPassword);

            User user = new User();
            user.setUsername(username);
            user.setEmail(email);
            user.setPassword(hashedPassword);
            em.persist(user);

            if (groups != null) {
                for (String group : groups) {
                    if (group == null || group.isBlank()) {
                        continue;
                    }
                    UserGroup ug = new UserGroup();
                    ug.setUsername(username);
                    ug.setUserGroup(group);
                    em.persist(ug);
                }
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }

    // ===== USER GROUPS BY USER ID – pentru EditUser checkbox-uri =====
    public Collection<String> findUserGroupsByUserId(Long userId) {
        try {
            LOG.info("findUserGroupsByUserId: " + userId);
            User user = em.find(User.class, userId);
            if (user == null) {
                return Collections.emptyList();
            }

            return em.createQuery(
                            "SELECT ug.userGroup FROM UserGroup ug WHERE ug.username = :username",
                            String.class
                    )
                    .setParameter("username", user.getUsername())
                    .getResultList();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }

    // ===== UPDATE USER + USERGROUPS =====
    public void updateUser(Long userId,
                           String newUsername,
                           String newEmail,
                           String plainPassword,
                           List<String> groups) {
        try {
            LOG.info("updateUser: " + userId);

            User user = em.find(User.class, userId);
            if (user == null) {
                throw new EJBException("User not found: " + userId);
            }

            String oldUsername = user.getUsername();

            // actualizăm username + email
            user.setUsername(newUsername);
            user.setEmail(newEmail);

            // parolă – doar dacă e completată
            if (plainPassword != null && !plainPassword.isBlank()) {
                String hashedPassword = passwordBean.convertToSha256(plainPassword);
                user.setPassword(hashedPassword);
            }

            // ștergem grupurile vechi
            List<UserGroup> oldGroups = em.createQuery(
                            "SELECT ug FROM UserGroup ug WHERE ug.username = :username",
                            UserGroup.class
                    )
                    .setParameter("username", oldUsername)
                    .getResultList();

            for (UserGroup ug : oldGroups) {
                em.remove(ug);
            }

            // adăugăm grupurile noi
            if (groups != null) {
                for (String group : groups) {
                    if (group == null || group.isBlank()) {
                        continue;
                    }
                    UserGroup ug = new UserGroup();
                    ug.setUsername(newUsername);
                    ug.setUserGroup(group);
                    em.persist(ug);
                }
            }

        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }
}