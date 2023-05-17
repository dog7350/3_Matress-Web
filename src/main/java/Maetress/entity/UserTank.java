package Maetress.entity;

import lombok.*;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Builder
@Table(name = "usertank")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@IdClass(UserTank.class)
public class UserTank implements Serializable {
    @Id
    @Column(name = "id")
    private String userId;

    @Id
    @Column(name = "tno")
    private int tankNo;
}