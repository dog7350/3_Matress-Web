package Maetress.repository;

import Maetress.entity.UserRank;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserRankRepository extends JpaRepository<UserRank, Long> {
    @Query(value = "SELECT count(*) FROM userinfo", nativeQuery = true)
    int findUserListCount();
    @Query(value = "SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY tbl.mmr DESC) AS rn, tbl.* FROM (SELECT id, mmr, money FROM userinfo) tbl) res WHERE res.rn > ((:page - 1) * :countPerPage) AND res.rn <= (:page * :countPerPage)", nativeQuery = true)
    List<UserRank> findUserList(int page, int countPerPage);
    @Query(value = "SELECT ROW_NUMBER() OVER(ORDER BY tbl.mmr DESC) AS rn, tbl.* FROM (SELECT id, mmr, money FROM userinfo) tbl", nativeQuery = true)
    List<UserRank> findMainUserList();

    @Query(value = "SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY tbl.mmr DESC) AS rn, tbl.* FROM (SELECT id, mmr, money FROM userinfo) tbl) res WHERE res.rn > ((:page - 1) * :countPerPage) AND res.rn <= (:page * :countPerPage) AND res.id LIKE %:id%", nativeQuery = true)
    List<UserRank> findUserRankId(String id, int page, int countPerPage);

    @Query(value = "SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY tbl.mmr DESC) AS rn, tbl.* FROM (SELECT id, mmr, money FROM userinfo) tbl) res WHERE res.rn > ((:page - 1) * :countPerPage) AND res.rn <= (:page * :countPerPage) AND res.rn=:rank", nativeQuery = true)
    List<UserRank> findUserRank(int rank, int page, int countPerPage);
}
