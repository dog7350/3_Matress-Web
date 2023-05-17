package Maetress.repository;

import Maetress.entity.Comment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.util.List;

@Repository
public interface CommentRepository extends JpaRepository<Comment, Long>  {
    List<Comment> findByBoardNo(int b_no);

    @Query(value = "SELECT * FROM reply WHERE c_no=:c_no AND b_no=:b_no", nativeQuery = true)
    Comment findReplyBoardNo(int c_no, int b_no);

    @Query(value = "INSERT INTO reply(b_no, id, content, time) VALUES(:b_no, :id, :content, now())", nativeQuery = true)
    void replyinsert(int b_no, String id, String content);

    @Query(value = "UPDATE reply SET content=:content, time=:time WHERE c_no=:c_no AND b_no=:b_no", nativeQuery = true)
    void replyupdate(String content, Timestamp time, int c_no, int b_no);

    @Query(value = "DELETE FROM reply WHERE c_no=:c_no AND b_no=:b_no", nativeQuery = true)
    void replydelete(int c_no, int b_no);

    @Query(value = "UPDATE reply SET time=:time, report=:report WHERE c_no=:c_no AND b_no=:b_no", nativeQuery = true)
    void replyreport(Timestamp time, int report, int c_no, int b_no);

    // CRUD

    @Query(value = "SELECT count(*) FROM reply WHERE id LIKE %:search% OR content LIKE %:search%", nativeQuery = true)
    int adminReplyIdCount(String search);
    @Query(value = "SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY tbl.report DESC) AS rn, tbl.* FROM (SELECT * FROM reply WHERE id LIKE %:search% OR content LIKE %:search% ORDER BY report DESC) tbl) res WHERE res.rn > ((:page - 1) * :countPerPage) AND res.rn <= (:page * :countPerPage)", nativeQuery = true)
    List<Comment> adminReplyId(String search, int page, int countPerPage);
}
