package dao;

import bean.ClassNotify;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DelClassNotifyImpl implements DelClassNotify {

    @Override
    public List<ClassNotify> getSentNotifications(String sender) {
        List<ClassNotify> notifications = new ArrayList<>();
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        ResultSet res = null;

        try {
            conn = JDBCTools.getConnection();
            String statement = "SELECT * FROM class_notify WHERE sender = ?";
            preparedStatement = conn.prepareStatement(statement);
            preparedStatement.setString(1, sender);
            res = preparedStatement.executeQuery();

            while (res.next()) {
                notifications.add(new ClassNotify(
                        res.getInt("id"),
                        res.getInt("class_id"),
                        res.getString("sender"),
                        res.getString("content")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCTools.release(res, preparedStatement, conn);
        }

        return notifications;
    }

    @Override
    public boolean deleteNotification(int id) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;

        try {
            conn = JDBCTools.getConnection();
            String statement = "DELETE FROM class_notify WHERE id = ?";
            preparedStatement = conn.prepareStatement(statement);
            preparedStatement.setInt(1, id);

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