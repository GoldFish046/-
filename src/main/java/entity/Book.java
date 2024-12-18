package entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class Book {
    private int index;
    private String name;
    private String author;
    private String pubhos;
    private String summary;
    private String flag;
    private float price;

    public Book(int index, String name, String author, String pubhos, String summary, String flag, float price) {
        this.index = index;
        this.name = name;
        this.author = author;
        this.pubhos = pubhos;
        this.summary = summary;
        this.flag = flag;
        this.price = price;
    }
    public Book(){}
}
