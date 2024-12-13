package dao;

import bean.ClassInfo;
import java.util.List;

public interface JoinClassDao {
    List<ClassInfo> getAvailableClasses(String teacherUsername);
    boolean applyToJoinClass(String teacherUsername, int classId);
}