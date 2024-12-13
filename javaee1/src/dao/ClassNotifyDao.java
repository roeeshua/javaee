package dao;

import bean.ClassInfo;
import java.util.List;

public interface ClassNotifyDao {
    List<ClassInfo> getCreatedClasses(String creator);
    boolean sendNotification(int classId, String sender, String content);
}
