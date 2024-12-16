package dao;

import bean.ClassNotify;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class WatchClassNotifyDaoImpl implements WatchClassNotifyDao {
    @Override
    public List<ClassNotify> getSentNotifications(String username, int usercode) {
        List<ClassNotify> notifications = new ArrayList<>();
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        ResultSet res = null;

        try {
            conn = JDBCTools.getConnection();
            // Step 1: 预加载 classtable 的 id 和 name 映射
            Map<Integer, String> classNameMap = new HashMap<>();
            String loadClassNamesSQL = "SELECT id, name FROM classtable";
            try (PreparedStatement loadClassStmt = conn.prepareStatement(loadClassNamesSQL);
                 ResultSet classRes = loadClassStmt.executeQuery()) {
                while (classRes.next()) {
                    classNameMap.put(classRes.getInt("id"), classRes.getString("name"));
                }
            }

            // Step 2: 查询 class_notify 数据
            String statement;
            if (usercode == 1) {
                statement = "SELECT * FROM class_notify WHERE class_id = ANY (" +
                        "SELECT class_id FROM parent_class WHERE parent_id = (" +
                        "SELECT id FROM parentstable WHERE username = ?))";
            } else {
                statement = "SELECT * FROM class_notify WHERE class_id = ANY (" +
                        "SELECT class_id FROM teacher_class WHERE teacher_id = (" +
                        "SELECT id FROM teachertable WHERE username = ?))";
            }

            preparedStatement = conn.prepareStatement(statement);
            preparedStatement.setString(1, username);
            res = preparedStatement.executeQuery();

            while (res.next()) {
                int classId = res.getInt("class_id");
                String className = classNameMap.getOrDefault(classId, "Unknown Class");

                notifications.add(new ClassNotify(
                        res.getInt("id"),
                        classId,
                        className,
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
}
