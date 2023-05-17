package Maetress.repository;

import Maetress.entity.QnaBoard;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QnaBoardRepository extends JpaRepository<QnaBoard, Long> {
    @Query(value = "SELECT count(*) FROM qnaboard WHERE title LIKE %:search% AND c_no=1", nativeQuery = true)
    int qnaTitleCount(String search);
    @Query(value = "SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY tbl.q_no DESC) AS rn, tbl.* FROM (SELECT * FROM qnaboard WHERE title LIKE %:search% AND c_no=1 ORDER BY q_no DESC) tbl) res WHERE res.rn > ((:page - 1) * :countPerPage) AND res.rn <= (:page * :countPerPage)", nativeQuery = true)
    List<QnaBoard> qnaTitle(String search, int page, int countPerPage);

    @Query(value = "SELECT count(*) FROM qnaboard WHERE writer LIKE %:search% AND c_no=1", nativeQuery = true)
    int qnaWriterCount(String search);
    @Query(value = "SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY tbl.q_no DESC) AS rn, tbl.* FROM (SELECT * FROM qnaboard WHERE writer LIKE %:search% AND c_no=1 ORDER BY q_no DESC) tbl) res WHERE res.rn > ((:page - 1) * :countPerPage) AND res.rn <= (:page * :countPerPage)", nativeQuery = true)
    List<QnaBoard> qnaWriter(String search, int page, int countPerPage);

    @Query(value = "SELECT count(*) FROM qnaboard WHERE c_no=1", nativeQuery = true)
    int qnaListCount();
    @Query(value = "SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY tbl.q_no DESC) AS rn, tbl.* FROM (SELECT * FROM qnaboard WHERE c_no=1 ORDER BY q_no DESC) tbl) res WHERE res.rn > ((:page - 1) * :countPerPage) AND res.rn <= (:page * :countPerPage)", nativeQuery = true)
    List<QnaBoard> qnaList(int page, int countPerPage);

    // qnaList

    @Query(value = "INSERT INTO qnaboard(c_no, title, writer, commenter, content, time, secret) VALUES(1, :title, :writer, :writer, :content, now(), :secret)", nativeQuery = true)
    void insertqna(String title, String writer, String content, String secret);
    @Query(value = "INSERT INTO qnaboard(q_no, c_no, commenter, content, time) VALUES(:q_no, 0, :commenter, :content, now())", nativeQuery = true)
    void answerqna(int q_no, String commenter, String content);


    @Query(value = "SELECT * FROM qnaboard WHERE q_no=:q_no AND c_no=1", nativeQuery = true)
    QnaBoard findOneQna(int q_no);
    @Query(value = "SELECT * FROM qnaboard WHERE q_no=:q_no AND c_no=0 ORDER BY time DESC", nativeQuery = true)
    List<QnaBoard> findQnaAnswer(int q_no);

    @Query(value = "DELETE FROM qnaboard WHERE q_no=:q_no", nativeQuery = true)
    void deleteqna(int q_no);
}
