package Maetress.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "item")
@Getter
@Setter
public class Item {
    @Id
    @Column(name = "ino")
    private int itemNo;

    @Column(name = "title")
    private String itemTitle;

    @Column(name = "content")
    private String itemContent;

    @Column(name = "money")
    private int itemMoney;
}
