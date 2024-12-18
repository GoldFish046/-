package hibernateEntity;

import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;

import java.sql.Date;

@Entity
public class Borrow {
    @Basic
    @Column(name = "bookindex")
    private int bookindex;
    @Basic
    @Column(name = "readerindex")
    private String readerindex;
    @Basic
    @Column(name = "begin")
    private Date begin;
    @Basic
    @Column(name = "end")
    private Date end;

    public int getBookindex() {
        return bookindex;
    }

    public void setBookindex(int bookindex) {
        this.bookindex = bookindex;
    }

    public String getReaderindex() {
        return readerindex;
    }

    public void setReaderindex(String readerindex) {
        this.readerindex = readerindex;
    }

    public Date getBegin() {
        return begin;
    }

    public void setBegin(Date begin) {
        this.begin = begin;
    }

    public Date getEnd() {
        return end;
    }

    public void setEnd(Date end) {
        this.end = end;
    }
}
