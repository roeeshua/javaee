package dao;

import bean.ClassNotify;
import java.util.List;

public interface DelClassNotify {
    List<ClassNotify> getSentNotifications(String sender);
    boolean deleteNotification(int id);
}