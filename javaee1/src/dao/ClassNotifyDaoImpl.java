package dao;

import bean.ClassInfo;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ClassNotifyDaoImpl implements ClassNotifyDao {

    @Override
    public List<ClassInfo> getCreatedClasses(String creator) {
        List<ClassInfo> classes = new ArrayList<>();
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        ResultSet res = null;

        try {
            conn = JDBCTools.getConnection();
            String statement = "SELECT id, name, about FROM classtable WHERE creator = ?";
            preparedStatement = conn.prepareStatement(statement);
            preparedStatement.setString(1, creator);
            res = preparedStatement.executeQuery();

            while (res.next()) {
                classes.add(new ClassInfo(res.getInt("id"), res.getString("name"), res.getString("about")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCTools.release(res, preparedStatement, conn);
        }

        return classes;
    }

    @Override
    public boolean sendNotification(int classId, String sender, String content) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;

        try {
            conn = JDBCTools.getConnection();
            String statement = "INSERT INTO class_notify (class_id, sender, content) VALUES (?, ?, ?)";
            preparedStatement = conn.prepareStatement(statement);
            preparedStatement.setInt(1, classId);
            preparedStatement.setString(2, sender);
            preparedStatement.setString(3, content);

            int result = preparedStatement.executeUpdate();
            conn.commit();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCTools.release(preparedStatement, conn);
        }

        return false;
    }
}
