package Maetress.entity;
import java.sql.*;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "openboard")
@Getter
@Setter
public class Board {
    @Id
    @Column(name = "b_no")
    private int boardNo;

    @Column(name = "id")
    private String userId;

    @Column(name = "title")
    private String boardTitle;

    @Column(name = "content")
    private String boardContent;

    @Column(name = "time")
    private Timestamp boardTime;

    @Column(name = "inquiry")
    private int boardInquiry;

    @Column(name = "report")
    private int boardReport;

    @Column(name = "notice")
    private String boardNotice;
}
