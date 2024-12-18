package utils;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class SqlConnector {
    private static final String Driver = "com.mysql.cj.jdbc.Driver";
    private static final String URL = "jdbc:mysql://localhost:3306/booksmanagersystem";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "248815893qwe";

    public static Connection getConnection() {//获取数据库连接
        try {
            Class.forName(Driver);
            return java.sql.DriverManager.getConnection(URL, USERNAME, PASSWORD);
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException("数据库连接错误");
        }
    }

    public static void release(ResultSet rs, Statement stmt, Connection conn) {//关闭数据库连接
        try {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            throw new RuntimeException("数据库连接关闭错误");
        }
    }
}
