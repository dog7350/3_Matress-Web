package Maetress.entity;

import lombok.*;
import org.hibernate.annotations.ColumnDefault;

import javax.persistence.*;

@Entity
@Table(name = "userinfo")
@Getter
@Setter
public class UserRank {
    @Column(name = "rn")
    private String rn;

    @Id
    @Column(name = "id")
    private String rankId;

    @Column(name = "mmr")
    @ColumnDefault("1000")
    private int rankMmr;

    @Column(name = "money")
    @ColumnDefault("5000")
    private int rankMoney;

}