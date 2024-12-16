package dao;

import bean.SystemNotify;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DelSystemNotifyImpl implements DelSystemNotify {
    @Override
    public List<SystemNotify> getSentNotifications(String sender) {
        List<SystemNotify> notifications = new ArrayList<>();
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        ResultSet res = null;

        try {
            conn = JDBCTools.getConnection();
            String statement = "SELECT * FROM system_notify WHERE sender = ?";
            preparedStatement = conn.prepareStatement(statement);
            preparedStatement.setString(1, sender);
            res = preparedStatement.executeQuery();

            while (res.next()) {
                notifications.add(new SystemNotify(
                        res.getInt("id"),
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

    //这个重载方法用于给教师和家长看系统信息用，不指定对应的管理员
    public List<SystemNotify> getSentNotifications() {
        List<SystemNotify> notifications = new ArrayList<>();
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        ResultSet res = null;

        try {
            conn = JDBCTools.getConnection();
            String statement = "SELECT * FROM system_notify";
            preparedStatement = conn.prepareStatement(statement);
            res = preparedStatement.executeQuery();

            while (res.next()) {
                notifications.add(new SystemNotify(
                        res.getInt("id"),
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
            String statement = "DELETE FROM system_notify WHERE id = ?";
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
