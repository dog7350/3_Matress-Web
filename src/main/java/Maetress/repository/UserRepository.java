package Maetress.repository;

import Maetress.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    User findByUserId(String userId);
    User findByUserEmail(String userEmail);

    @Query(value = "SELECT count(*) FROM userinfo", nativeQuery = true)
    int adminAllUserCount();
    @Query(value = "SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY tbl.id DESC) AS rn, tbl.* FROM (SELECT * FROM userinfo ORDER BY id DESC) tbl) res WHERE res.rn > ((:page - 1) * :countPerPage) AND res.rn <= (:page * :countPerPage)", nativeQuery = true)
    List<User> adminAllUser(int page, int countPerPage);

    @Query(value = "SELECT count(*) FROM userinfo WHERE id LIKE %:search% OR name LIKE %:search%", nativeQuery = true)
    int adminUserIdCount(String search);
    @Query(value = "SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY tbl.id DESC) AS rn, tbl.* FROM (SELECT * FROM userinfo WHERE id LIKE %:search% OR name LIKE %:search% ORDER BY id DESC) tbl) res WHERE res.rn > ((:page - 1) * :countPerPage) AND res.rn <= (:page * :countPerPage)", nativeQuery = true)
    List<User> adminUserId(String search, int page, int countPerPage);

    @Query(value = "DELETE FROM userinfo WHERE id=:id", nativeQuery = true)
    void deleteUser(String id);

    @Query(value = "UPDATE userinfo SET pw=:pw WHERE id=:id", nativeQuery = true)
    void updateUser(String pw, String id);

    @Query(value = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = 'userinfo' AND table_schema = 'maetress' AND column_name = 'rn'", nativeQuery = true)
    String rnField();
    @Query(value = "ALTER TABLE userinfo DROP rn", nativeQuery = true)
    void rnDrop();
}