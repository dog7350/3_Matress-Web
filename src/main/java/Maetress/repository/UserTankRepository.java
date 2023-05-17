package Maetress.repository;

import Maetress.entity.UserTank;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserTankRepository extends JpaRepository<UserTank, Long> {
}