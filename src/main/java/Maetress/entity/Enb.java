package Maetress.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "enbtable")
@Getter
@Setter
public class Enb {
    @Id
    @Column(name = "enbtitle")
    private String enbtitle;

    @Column(name = "enbvalue")
    private String enbvalue;
}
