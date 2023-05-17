package Maetress.repository;

import Maetress.entity.Tank;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface TankRepository extends JpaRepository<Tank, Long> {
    @Query(value = "SELECT * FROM tank WHERE tno=:tno", nativeQuery = true)
    Tank findOneTank(int tno);
}
