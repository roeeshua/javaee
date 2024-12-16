package dao;

import java.util.List;

public interface SendToDao {
    List<String> getTeachersByParent(String parentUsername);

    List<String> getParentsByTeacher(String teacherUsername);
    boolean sendMessage(String sender, String receiver, String content);
}
