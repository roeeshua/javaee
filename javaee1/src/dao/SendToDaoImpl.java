package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SendToDaoImpl implements SendToDao {
    @Override
    public List<String> getTeachersByParent(String parentUsername) {
        List<String> teachers = new ArrayList<>();
        String query = """
            SELECT DISTINCT t.username 
            FROM teachertable t
            JOIN teacher_class tc ON t.ID = tc.teacher_id
            JOIN parent_class pc ON tc.class_id = pc.class_id
            WHERE pc.parent_id = (SELECT id FROM parentstable WHERE username = ?)
        """;

        try (Connection conn = JDBCTools.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, parentUsername);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                teachers.add(rs.getString("username"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return teachers;
    }

    @Override
    public List<String> getParentsByTeacher(String teacherUsername) {
        List<String> parents = new ArrayList<>();
        String query = """
            SELECT DISTINCT p.username 
            FROM parentstable p
            JOIN parent_class pc ON p.ID = pc.parent_id
            JOIN teacher_class tc ON pc.class_id = tc.class_id
            WHERE tc.teacher_id = (SELECT id FROM teachertable WHERE username = ?)
        """;

        try (Connection conn = JDBCTools.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, teacherUsername);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                parents.add(rs.getString("username"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return parents;
    }

    @Override
    public boolean sendMessage(String sender, String receiver, String content) {
        String query = "INSERT INTO messages (sender, receiver, content) VALUES (?, ?, ?)";
        try (Connection conn = JDBCTools.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, sender);
            stmt.setString(2, receiver);
            stmt.setString(3, content);
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
