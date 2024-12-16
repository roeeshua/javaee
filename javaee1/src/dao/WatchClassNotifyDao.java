package dao;

import bean.ClassNotify;

import java.util.List;

public interface WatchClassNotifyDao {
    List<ClassNotify> getSentNotifications(String username ,int usercode);
}
