package Maetress.entity;
import java.sql.*;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "patchnote")
@Getter
@Setter
public class PatchNote {
    @Id
    @Column(name = "p_no")
    private int patchNo;

    @Column(name = "title")
    private String patchTitle;

    @Column(name = "content")
    private String patchContent;

    @Column(name = "time")
    private Timestamp patchTime;
}
