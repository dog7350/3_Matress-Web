package Maetress.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "tank")
@Getter
@Setter
public class Tank {
    @Id
    @Column(name = "tno")
    private int tankNo;

    @Column(name = "tname")
    private String tankName;

    @Column(name = "ttype")
    private String tankType;

    @Column(name = "bname")
    private String tankBName;

    @Column(name = "bcont")
    private String tankBContent;

    @Column(name = "thp")
    private int tankHp;

    @Column(name = "tatk")
    private int tankAtk;

    @Column(name = "tdef")
    private int tankDef;

    @Column(name = "tspeed")
    private float tankSpeed;

    @Column(name = "money")
    private int tankMoney;

    @Column(name = "cash")
    private int tankCash;

    @Column(name = "skin")
    private String tankSkin;
}
