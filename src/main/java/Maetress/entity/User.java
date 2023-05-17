package Maetress.entity;

import lombok.*;
import org.hibernate.annotations.ColumnDefault;

import javax.persistence.*;

@Entity
@Builder
@Table(name = "userinfo")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class User {

    @Id
    @Column(name = "id")
    private String userId;

    @Column(name = "pw")
    private String userPw;

    @Column(name = "name")
    private String userName;

    @Column(name = "email")
    private String userEmail;

    @Column(name = "mmr")
    @ColumnDefault("1000")
    private int userMmr;

    @Column(name = "money")
    @ColumnDefault("5000")
    private int userMoney;

    @Column(name = "cash")
    @ColumnDefault("0")
    private int userCash;

    @Column(name = "admin")
    @ColumnDefault("x")
    private String userAdmin;

    @Column(name = "connect")
    @ColumnDefault("x")
    private String userConnect;

}