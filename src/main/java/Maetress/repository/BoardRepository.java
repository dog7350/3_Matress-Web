package Maetress.repository;

import Maetress.entity.Board;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.util.List;

@Repository
public interface BoardRepository extends JpaRepository<Board, Long>  {
    @Query(value = "SELECT count(*) FROM openboard WHERE title LIKE %:search%", nativeQuery = true)
    int findBoardTitleCount(String search);
    @Query(value = "SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY tbl.b_no DESC) AS rn, tbl.* FROM (SELECT * FROM openboard WHERE title LIKE %:search% ORDER BY b_no DESC) tbl) res WHERE res.rn > ((:page - 1) * :countPerPage) AND res.rn <= (:page * :countPerPage)", nativeQuery = true)
    List<Board> findBoardTitle(String search, int page, int countPerPage);

    @Query(value = "SELECT count(*) FROM openboard WHERE id LIKE %:search%", nativeQuery = true)
    int findBoardWriterCount(String search);
    @Query(value = "SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY tbl.b_no DESC) AS rn, tbl.* FROM (SELECT * FROM openboard WHERE id LIKE %:search% ORDER BY b_no DESC) tbl) res WHERE res.rn > ((:page - 1) * :countPerPage) AND res.rn <= (:page * :countPerPage)", nativeQuery = true)
    List<Board> findBoardWriter(String search, int page, int countPerPage);

    @Query(value = "SELECT count(*) FROM openboard WHERE title LIKE %:search1% OR content LIKE %:search2%", nativeQuery = true)
    int findBoardTitleOrBoardContentCount(String search1, String search2);
    @Query(value = "SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY tbl.b_no DESC) AS rn, tbl.* FROM (SELECT * FROM openboard WHERE title LIKE %:search1% OR content LIKE %:search2% ORDER BY b_no DESC) tbl) res WHERE res.rn > ((:page - 1) * :countPerPage) AND res.rn <= (:page * :countPerPage)", nativeQuery = true)
    List<Board> findBoardTitleOrBoardContent(String search1, String search2, int page, int countPerPage);

    @Query(value = "SELECT count(*) FROM openboard", nativeQuery = true)
    int findBoardListCount();
    @Query(value = "SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY tbl.b_no DESC) AS rn, tbl.* FROM (SELECT * FROM openboard ORDER BY b_no DESC) tbl) res WHERE res.rn > ((:page - 1) * :countPerPage) AND res.rn <= (:page * :countPerPage)", nativeQuery = true)
    List<Board> findBoardList(int page, int countPerPage);
    @Query(value = "SELECT * FROM openboard ORDER BY b_no DESC", nativeQuery = true)
    List<Board> findMainBoardList();

    @Query(value = "SELECT count(*) FROM openboard WHERE notice='yes'", nativeQuery = true)
    int findNoticeBoardCount();
    @Query(value = "SELECT * FROM openboard WHERE notice='yes'", nativeQuery = true)
    List<Board> findNoticeBoard();

    Board findByBoardNo(int b_no);

    /* boardList */

    @Query(value = "INSERT INTO openboard(id, title, content, time, notice) VALUES(:id, :title, :content, now(), :not)", nativeQuery = true)
    void insertBoard(String id, String title, String content, String not);
    @Query(value = "UPDATE openboard set title=:title, content=:content, time=:time, notice=:not WHERE b_no=:b_no", nativeQuery = true)
    void updateBoard(String title, String content, Timestamp time, String not, int b_no);
    @Query(value = "DELETE FROM openboard WHERE b_no=:b_no", nativeQuery = true)
    void deleteBoard(int b_no);
    @Query(value = "UPDATE openboard set time=:time, report=:rep WHERE b_no=:b_no", nativeQuery = true)
    void reportBoard(Timestamp time, int rep, int b_no);
    @Query(value = "UPDATE openboard set time=:time, inquiry=:inquiry WHERE b_no=:b_no", nativeQuery = true)
    void inquiryboard(Timestamp time, int inquiry, int b_no);

    // CRUD

    @Query(value = "SELECT count(*) FROM openboard WHERE id LIKE %:search% OR title LIKE %:search%", nativeQuery = true)
    int adminBoardIdCount(String search);
    @Query(value = "SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY tbl.report DESC) AS rn, tbl.* FROM (SELECT * FROM openboard WHERE id LIKE %:search% OR title LIKE %:search% ORDER BY report DESC) tbl) res WHERE res.rn > ((:page - 1) * :countPerPage) AND res.rn <= (:page * :countPerPage)", nativeQuery = true)
    List<Board> adminBoardId(String search, int page, int countPerPage);
}
