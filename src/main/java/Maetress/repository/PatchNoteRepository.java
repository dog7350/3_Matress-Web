package Maetress.repository;

import Maetress.entity.PatchNote;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.util.List;

@Repository
public interface PatchNoteRepository extends JpaRepository<PatchNote, Long> {
    @Query(value = "SELECT * FROM patchnote ORDER BY p_no DESC", nativeQuery = true)
    List<PatchNote> notesAll();

    @Query(value = "INSERT INTO patchnote(title, content, time) VALUES(:title, :content, now())", nativeQuery = true)
    void noteInsert(String title, String content);

    @Query(value = "SELECT * FROM patchnote WHERE p_no=:p_no", nativeQuery = true)
    PatchNote findOnenote(int p_no);

    @Query(value = "UPDATE patchnote SET title=:title, content=:content, time=:time WHERE p_no=:p_no", nativeQuery = true)
    void noteUpdate(String title, String content, Timestamp time, int p_no);

    @Query(value = "DELETE FROM patchnote WHERE p_no=:p_no", nativeQuery = true)
    void noteDelete(int p_no);
}
