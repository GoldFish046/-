package mapper;

import entity.Book;
import entity.Borrow;
import utils.SqlConnector;

import java.sql.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class BorrowMapper {
    public static List<Borrow> getAllBorrow() {
        List<Borrow> list = new ArrayList<>();
        Connection conn = SqlConnector.getConnection();
        String sql = "select * from borrow";
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                list.add(new Borrow(rs.getInt("bookindex"),
                        rs.getString("readerindex"),
                        rs.getString("begin"),
                        rs.getString("end")));
            }
            return list;
        } catch (SQLException e) {
            throw new RuntimeException("全部借阅数据查询失败");
        }
    }

    public static List<Book> getAllMyBorrow(String account) {
        List<Book> list = new ArrayList<>();
        Connection conn = SqlConnector.getConnection();
        //language=MySQL
        String sql = "select book.`index`, name, author, pubhos, summary, flag, price " +
                "from book,borrow " +
                "where bookindex=book.`index` and readerindex='" + account + "'";
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs=stmt.executeQuery(sql);
            while (rs.next()){
                list.add(new Book(rs.getInt("index"),
                        rs.getString("name"),
                        rs.getString("author"),
                        rs.getString("pubhos"),
                        rs.getString("summary"),
                        rs.getString("flag"),
                        rs.getFloat("price")));
            }
            return list;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static boolean borrowNewBook(Borrow borrow) {
        LocalDate data=LocalDate.now();
        DateTimeFormatter formatter=DateTimeFormatter.ofPattern("yyyy-MM-dd");
        borrow.setBegin(data.format(formatter));
        borrow.setEnd(data.plusDays(3).format(formatter));
        Connection conn=SqlConnector.getConnection();
        //language=MySQL
        String sql="insert into borrow(bookindex, readerindex, begin, end)  values(?,?,?,?)";
        try{
            PreparedStatement stmt=conn.prepareStatement(sql);
            stmt.setInt(1,borrow.getBookIndex());
            stmt.setString(2,borrow.getReaderIndex());
            stmt.setString(3,borrow.getBegin());
            stmt.setString(4,borrow.getEnd());
            return stmt.executeUpdate()>0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static boolean returnBook(Borrow borrow) {
        Connection conn=SqlConnector.getConnection();
        //language=MySQL
        String sql="delete from borrow where bookindex=? and readerindex=?";
        try{
            PreparedStatement stmt=conn.prepareStatement(sql);
            stmt.setInt(1,borrow.getBookIndex());
            stmt.setString(2,borrow.getReaderIndex());
            return stmt.executeUpdate()>0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
