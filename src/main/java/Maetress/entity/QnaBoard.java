package Maetress.entity;
import java.io.Serializable;
import java.sql.*;

import lombok.*;

import javax.persistence.*;

@Entity
@Builder
@Table(name = "qnaboard")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@IdClass(QnaBoard.class)
public class QnaBoard implements Serializable {
    @Id
    @Column(name = "q_no")
    private int qnaNo;

    @Column(name = "c_no")
    private int qnaCno;

    @Column(name = "title")
    private String qnaTitle;

    @Column(name = "writer")
    private String qnaWriter;

    @Column(name = "commenter")
    private String qnaCommenter;

    @Column(name = "content")
    private String qnaContent;

    @Id
    @Column(name = "time")
    private Timestamp qnaTime;

    @Column(name = "secret")
    private String qnaSecret;
}
