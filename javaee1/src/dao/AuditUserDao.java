package dao;

import bean.JoinRequest;
import java.util.List;

public interface AuditUserDao {
    List<JoinRequest> getPendingRequests(String creatorUsername);
    boolean approveRequest(int classId,int teacherId);
    boolean rejectRequest(int classId,int teacherId);
}
