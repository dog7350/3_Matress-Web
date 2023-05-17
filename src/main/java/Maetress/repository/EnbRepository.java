package Maetress.repository;

import Maetress.entity.Enb;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface EnbRepository extends JpaRepository<Enb, Long> {
    @Query(value = "SELECT enbvalue FROM enbtable WHERE enbtitle=:enbtitle", nativeQuery = true)
    String findEnbValue(String enbtitle);
}