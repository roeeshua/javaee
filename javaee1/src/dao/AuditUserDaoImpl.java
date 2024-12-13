package dao;

import bean.JoinRequest;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AuditUserDaoImpl implements AuditUserDao {

    @Override
    public List<JoinRequest> getPendingRequests(String creatorUsername) {
        List<JoinRequest> requests = new ArrayList<>();
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        ResultSet res = null;
        try {
            conn = JDBCTools.getConnection();
            String query = "SELECT tc.class_id as ci, tc.teacher_id as ti , t.username as teacher_username, c.name as class_name " +
                    "FROM teacher_class tc " +
                    "JOIN teachertable t ON tc.teacher_id = t.ID " +
                    "JOIN classtable c ON tc.class_id = c.id " +
                    "WHERE tc.is_approved = 0 AND c.creator = ?";
            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setString(1, creatorUsername);
            res = preparedStatement.executeQuery();
            while (res.next()) {
                requests.add(new JoinRequest(res.getInt("ci"), res.getInt("ti"),res.getString("teacher_username"), res.getString("class_name")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCTools.release(preparedStatement, conn);
        }
        return requests;
    }

    @Override
    public boolean approveRequest(int classId,int teacherId) {
        return updateRequestStatus(classId,teacherId, 1);
    }

    @Override
    public boolean rejectRequest(int classId,int teacherId) {
        return updateRequestStatus(classId,teacherId, -1);
    }

    private boolean updateRequestStatus(int classId,int teacherId, int status) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        try {
            int result=0;
            conn = JDBCTools.getConnection();
            if(status==1) {
                String query = "UPDATE teacher_class SET is_approved = ? WHERE class_id = ? AND teacher_id = ?";
                preparedStatement = conn.prepareStatement(query);
                preparedStatement.setInt(1, status);
                preparedStatement.setInt(2, classId);
                preparedStatement.setInt(3, teacherId);
                result = preparedStatement.executeUpdate();
            }else{
                String query = "DELETE FROM teacher_class WHERE is_approved = ? AND class_id = ? AND teacher_id = ?";
                preparedStatement = conn.prepareStatement(query);
                preparedStatement.setInt(1, 0);
                preparedStatement.setInt(2, classId);
                preparedStatement.setInt(3, teacherId);
                result = preparedStatement.executeUpdate();
            }
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            JDBCTools.release(preparedStatement, conn);
        }
    }
}
