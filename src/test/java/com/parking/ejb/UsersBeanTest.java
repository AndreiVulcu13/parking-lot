package com.parking.ejb;

import com.parking.entities.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import org.junit.jupiter.api.*;

import java.lang.reflect.Field;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class UsersBeanTest {

    private static EntityManagerFactory emf;
    private EntityManager em;
    private UsersBean usersBean;

    @BeforeAll
    static void initFactory() {
        emf = Persistence.createEntityManagerFactory("test-persistence");
    }

    @AfterAll
    static void closeFactory() {
        emf.close();
    }

    @BeforeEach
    void setUp() throws Exception {
        em = emf.createEntityManager();
        usersBean = new UsersBean();

        // inject EntityManager
        inject(usersBean, "em", em);

        // inject PasswordBean manual
        PasswordBean passwordBean = new PasswordBean();
        inject(usersBean, "passwordBean", passwordBean);

        em.getTransaction().begin();
    }

    @AfterEach
    void tearDown() {
        em.getTransaction().rollback();
        em.close();
    }

    @Test
    void createUser_persistsUser_andCanBeReadBack() {

        usersBean.createUser(
                "testuser",
                "testuser@example.com",
                "pass",
                List.of("READ_USERS")
        );

        List<User> users =
                em.createQuery("SELECT u FROM User u", User.class)
                        .getResultList();

        assertEquals(1, users.size());
        assertEquals("testuser", users.get(0).getUsername());
    }

    private static void inject(Object target, String fieldName, Object value)
            throws Exception {
        Field field = target.getClass().getDeclaredField(fieldName);
        field.setAccessible(true);
        field.set(target, value);
    }
}