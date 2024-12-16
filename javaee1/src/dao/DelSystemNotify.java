package dao;

import bean.SystemNotify;

import java.util.List;

public interface DelSystemNotify {
    List<SystemNotify> getSentNotifications(String sender);

    boolean deleteNotification(int id);

    List<SystemNotify> getSentNotifications();
}
