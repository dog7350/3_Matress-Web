package Maetress.entity;

import lombok.*;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Timestamp;

@Entity
@Builder
@Table(name = "reply")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@IdClass(Comment.class)
public class Comment implements Serializable {
    @Id
    @Column(name = "c_no")
    private int cmtNo;

    @Id
    @Column(name = "b_no")
    private int boardNo;

    @Column(name = "id")
    private String userId;

    @Column(name = "content")
    private String cmtContent;

    @Column(name = "time")
    private Timestamp cmtTime;

    @Column(name = "report")
    private int cmtReport;
}
