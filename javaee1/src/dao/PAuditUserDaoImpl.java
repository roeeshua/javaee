package dao;

import bean.JoinRequest;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PAuditUserDaoImpl implements AuditUserDao {

    @Override
    public List<JoinRequest> getPendingRequests(String creatorUsername) {
        List<JoinRequest> requests = new ArrayList<>();
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        ResultSet res = null;
        try {
            conn = JDBCTools.getConnection();
            String query = "SELECT pc.class_id as ci, pc.parent_id as pi , p.username as parent_username, c.name as class_name " +
                    "FROM parent_class pc " +
                    "JOIN parentstable p ON pc.parent_id = p.id " +
                    "JOIN classtable c ON pc.class_id = c.id " +
                    "WHERE pc.is_approved = 0 AND c.creator = ?";
            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setString(1, creatorUsername);
            res = preparedStatement.executeQuery();
            while (res.next()) {
                requests.add(new JoinRequest(res.getInt("ci"), res.getInt("pi"),res.getString("parent_username"), res.getString("class_name")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCTools.release(preparedStatement, conn);
        }
        return requests;
    }

    @Override
    public boolean approveRequest(int classId,int parentId) {
        return updateRequestStatus(classId,parentId, 1);
    }

    @Override
    public boolean rejectRequest(int classId,int parentId) {
        return updateRequestStatus(classId,parentId, -1);
    }

    private boolean updateRequestStatus(int classId,int parentId, int status) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        try {
            int result=0;
            conn = JDBCTools.getConnection();
            if(status==1) {
                String query = "UPDATE parent_class SET is_approved = ? WHERE class_id = ? AND parent_id = ?";
                preparedStatement = conn.prepareStatement(query);
                preparedStatement.setInt(1, status);
                preparedStatement.setInt(2, classId);
                preparedStatement.setInt(3, parentId);
                result = preparedStatement.executeUpdate();
            }else{
                String query = "DELETE FROM parent_class WHERE is_approved = ? AND class_id = ? AND parent_id = ?";
                preparedStatement = conn.prepareStatement(query);
                preparedStatement.setInt(1, 0);
                preparedStatement.setInt(2, classId);
                preparedStatement.setInt(3, parentId);
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
