package mapper;

import entity.Book;
import utils.SqlConnector;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookMapper {
    public static List<Book> getAllBook() {
        List<Book> list = new ArrayList<>();
        Connection conn = SqlConnector.getConnection();
        String sql = "select * from book";
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
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
            throw new RuntimeException("全部书籍数据查询失败");
        }
    }

    public static List<Book> getAllAvaBook() {
        List<Book> list=new ArrayList<>();
        Connection conn=SqlConnector.getConnection();
        //language=MySQL
        String sql="select * from book where not exists(select * from borrow where book.`index`=borrow.bookindex)";
        try{
            Statement stmt=conn.createStatement();
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
        }catch (SQLException e){
            throw new RuntimeException(e);
        }
    }

    public static boolean deleteBook(int index) {
        Connection con=SqlConnector.getConnection();
        //language=MySQL
        String sql="delete from book where `index`=?";
        try{
            PreparedStatement stmt=con.prepareStatement(sql);
            stmt.setInt(1,index);
            return stmt.executeUpdate()>0;
        }catch (SQLException e){
            throw new RuntimeException(e);
        }
    }

    public static boolean insertNewBook(Book newBook) {
        Connection conn=SqlConnector.getConnection();
        //language=MySQL
        String sql="insert into book(name, author, pubhos, summary, flag, price) values (?,?,?,?,?,?)";
        try{
            PreparedStatement stmt=conn.prepareStatement(sql);
            stmt.setString(1,newBook.getName());
            stmt.setString(2,newBook.getAuthor());
            stmt.setString(3,newBook.getPubhos());
            stmt.setString(4,newBook.getSummary());
            stmt.setString(5,newBook.getFlag());
            stmt.setFloat(6,newBook.getPrice());
            return stmt.executeUpdate()>0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static boolean updateBook(Book newBook) {
        Connection conn=SqlConnector.getConnection();
        //language=MySQL
        String sql="update book set name=?, author=?, pubhos=?, summary=?, flag=?, price=? where `index`=?";
        try{
            PreparedStatement stmt=conn.prepareStatement(sql);
            stmt.setString(1,newBook.getName());
            stmt.setString(2,newBook.getAuthor());
            stmt.setString(3,newBook.getPubhos());
            stmt.setString(4,newBook.getSummary());
            stmt.setString(5,newBook.getFlag());
            stmt.setFloat(6,newBook.getPrice());
            stmt.setInt(7,newBook.getIndex());
            return stmt.executeUpdate()>0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
