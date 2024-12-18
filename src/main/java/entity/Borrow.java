package entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class Borrow {
    private int bookIndex;
    private String readerIndex;
    private String begin;
    private String end;
    public Borrow(int bookIndex, String readerIndex, String begin, String end){
        this.bookIndex = bookIndex;
        this.readerIndex = readerIndex;
        this.begin = begin;
        this.end = end;
    }
    public Borrow(){}
}
