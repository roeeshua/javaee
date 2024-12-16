package dao;

public interface SystemNotifyDao {
    boolean sendNotification(String sender, String content);
}
