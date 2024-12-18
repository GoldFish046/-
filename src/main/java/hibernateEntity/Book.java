package hibernateEntity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Entity
public class Book {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "index")
    private int index;
    @Basic
    @Column(name = "name")
    private String name;
    @Basic
    @Column(name = "author")
    private String author;
    @Basic
    @Column(name = "pubhos")
    private String pubhos;
    @Basic
    @Column(name = "summary")
    private String summary;
    @Basic
    @Column(name = "flag")
    private String flag;
    @Basic
    @Column(name = "price")
    private Double price;

}
