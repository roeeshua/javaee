package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class SystemNotifyDaoImpl implements SystemNotifyDao{
    public boolean sendNotification(String sender, String content) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;

        try {
            conn = JDBCTools.getConnection();
            String statement = "INSERT INTO system_notify (sender, content) VALUES (?, ?)";
            preparedStatement = conn.prepareStatement(statement);
            preparedStatement.setString(1, sender);
            preparedStatement.setString(2, content);

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
