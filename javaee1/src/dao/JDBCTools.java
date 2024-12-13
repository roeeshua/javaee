package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class JDBCTools {
    public static Connection getConnection() throws Exception{
        String user = "root";
        String password = "175617";
        String url ="jdbc:mysql://localhost:3306/javaee2?useSSL=true&useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai";
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url,user,password);
        return conn;
    }

    public static void release(ResultSet res, Statement statement,Connection conn){
        try{
            if (res !=null)
                res.close();
        }catch (Exception e){
            e.printStackTrace();
        }

        try{
            if(statement != null)
                statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }

        try{
            if(conn != null)
                conn.close();
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public static void release( Statement statement,Connection conn){

        try{
            if(statement != null)
                statement.close();
        }catch (Exception e){
            e.printStackTrace();
        }

        try{
            if(conn != null)
                conn.close();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
