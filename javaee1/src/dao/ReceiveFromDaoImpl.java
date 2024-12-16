package dao;

import bean.Message;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ReceiveFromDaoImpl implements ReceiveFromDao {
    @Override
    public List<Message> getMessages(String receiverUsername) {
        List<Message> messages = new ArrayList<>();
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        ResultSet res = null;

        try {
            conn = JDBCTools.getConnection();
            String sql =
                    "SELECT sender, content, timestamp " +
                            "FROM messages " +
                            "WHERE receiver = ? " +
                            "ORDER BY timestamp DESC";

            preparedStatement = conn.prepareStatement(sql);
            preparedStatement.setString(1, receiverUsername);
            res = preparedStatement.executeQuery();

            while (res.next()) {
                Message message = new Message();
                message.setSender(res.getString("sender"));
                message.setMessage(res.getString("content"));
                message.setTimestamp(res.getTimestamp("timestamp"));
                messages.add(message);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCTools.release(res, preparedStatement, conn);
        }

        return messages;
    }
}
