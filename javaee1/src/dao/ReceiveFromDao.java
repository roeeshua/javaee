package dao;

import java.util.List;
import bean.Message;

public interface ReceiveFromDao {
    List<Message> getMessages(String receiverUsername);
}
