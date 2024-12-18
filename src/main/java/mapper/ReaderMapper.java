package mapper;

import entity.Reader;
import utils.SqlConnector;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReaderMapper {
    public static List<Reader> getAllReader() {
        List<Reader> list = new ArrayList<>();
        Connection conn = SqlConnector.getConnection();
        String sql = "select * from reader";
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                list.add(new Reader(rs.getString("account"),
                        rs.getString("name"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getInt("type"),
                        rs.getString("flag")));
            }
            return list;
        } catch (SQLException e) {
            throw new RuntimeException("全部读者数据查询失败");
        }
    }

    public static Reader getReaderByAccount(String account) {
        Reader reader = new Reader();
        Connection conn = SqlConnector.getConnection();
        String sql = "select * from reader where account=?";
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, account);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                reader.setAccount(rs.getString("account"));
                reader.setName(rs.getString("name"));
                reader.setPhone(rs.getString("phone"));
                reader.setEmail(rs.getString("email"));
                reader.setFlag(rs.getString("flag"));
            }
            return reader;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static boolean deleteReaderByAccount(String account) {
        Connection conn = SqlConnector.getConnection();
        String sql = "delete from reader where account=?";
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, account);
            String newsql="delete from user where account=?";
            PreparedStatement stmt1 = conn.prepareStatement(newsql);
            stmt1.setString(1, account);
            return stmt.executeUpdate() > 0&&stmt1.executeUpdate()>0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static boolean updataReader(Reader reader) {
        Connection conn=SqlConnector.getConnection();
        //language=MySQL
        String sql="update reader set name=?,phone=?,email=?,flag=? where account=?";
        try{
            PreparedStatement stmt=conn.prepareStatement(sql);
            stmt.setString(1,reader.getName());
            stmt.setString(2,reader.getPhone());
            stmt.setString(3,reader.getEmail());
            stmt.setString(4,reader.getFlag());
            stmt.setString(5,reader.getAccount());
            return stmt.executeUpdate()>0;
        } catch (SQLException e) {
            throw new RuntimeException("修改失败");
        }
    }
}
