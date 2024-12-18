package mapper;

import entity.User;
import utils.SqlConnector;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserMapper {
    public static List<User> getAllUser() {
        List<User> list = new ArrayList<>();
        Connection conn = SqlConnector.getConnection();
        String sql = "select * from user";
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                list.add(new User(rs.getString("account"), rs.getString("password"),rs.getString("type")));
            }
            return list;
        } catch (SQLException e) {
            throw new RuntimeException("全部用户数据查询失败");
        }
    }

    public static User getUserByAccount(String account) {
        Connection conn = SqlConnector.getConnection();
        String sql = "select * from user where account=?";
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, account);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new User(rs.getString("account"), rs.getString("password"),rs.getString("type"));
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException("用户查询失败");
        }
    }

    public static String newUser(User user) {
        if(user.getType()==null) user.setType("1");
        Connection conn = SqlConnector.getConnection();
        String sql = "insert into user(account,password,type)  values(?,?,?)";
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getAccount());
            stmt.setString(2, user.getPassword());
            stmt.setString(3,user.getType());
            stmt.executeUpdate();
            String readerSql="insert into reader(account) values(?)";
            PreparedStatement readerStmt=conn.prepareStatement(readerSql);
            readerStmt.setString(1,user.getAccount());
            readerStmt.executeUpdate();
            return "success";
        } catch (SQLException e) {
            throw new RuntimeException("新增用户失败");
        }
    }

    public static User loginInspection(User user) {
        Connection conn = SqlConnector.getConnection();
        String sql = "select * from user where account=? and password=?";
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getAccount());
            stmt.setString(2, user.getPassword());
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new User(rs.getString("account"), rs.getString("password"));
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException("用户登录失败");
        }
    }
}
