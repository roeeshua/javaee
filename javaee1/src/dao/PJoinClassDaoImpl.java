package dao;

import bean.ClassInfo;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PJoinClassDaoImpl implements JoinClassDao {
    @Override
    public List<ClassInfo> getAvailableClasses(String parentUsername) {
        List<ClassInfo> classes = new ArrayList<>();
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        ResultSet res = null;
        try {
            conn = JDBCTools.getConnection();  //连接
            String statement = "";

            statement = "SELECT id, name, about FROM classtable WHERE is_pass = 1 AND NOT EXISTS(SELECT 1 FROM parent_class WHERE parent_class.parent_id=(SELECT id FROM parentstable where username = ?) AND parent_class.class_id = classtable.id)";  //编写预编译语句

            preparedStatement = conn.prepareStatement(statement);  //获取语句
            //插入对应问号的值
            preparedStatement.setString(1, parentUsername);
            //执行mysql语句
            res = preparedStatement.executeQuery();
            while (res.next()) {
                classes.add(new ClassInfo(res.getInt("id"), res.getString("name"), res.getString("about")));
            }
            return classes;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCTools.release(preparedStatement, conn);
        }
        return classes;
    }


    //    @Override
    public boolean applyToJoinClass(String parentUsername, int classId) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        try {
            conn = JDBCTools.getConnection();  //连接
            String statement = "";

            statement = "INSERT INTO parent_class (parent_id, class_id, is_approved) VALUES ((SELECT id FROM parentstable WHERE username = ?),?,0)";  //编写预编译语句
            preparedStatement = conn.prepareStatement(statement);  //获取语句
            //插入对应问号的值
            preparedStatement.setString(1, parentUsername);
            preparedStatement.setInt(2, classId);
            //执行mysql语句
            int res = preparedStatement.executeUpdate();
            conn.commit();
            return res > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            JDBCTools.release(preparedStatement, conn);
        }
    }
}