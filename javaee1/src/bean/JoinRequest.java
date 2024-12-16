package bean;

public class JoinRequest {
    private int class_id; // �༶id

    private int id; // ������id
    private String Username; // �����˵��û���
    private String className; // �༶����

    // ���췽��
    public JoinRequest(int class_id, int id, String Username, String className) {
        this.class_id = class_id;
        this.id = id;
        this.Username = Username;
        this.className = className;
    }

    public int getClassId() {
        return class_id;
    }

    public int getId() {
        return id;
    }
    // ��������ID

    // ��ȡ��ʦ�û���
    public String getUsername() {
        return Username;
    }

    // ���ý�ʦ�û���
    public void setUsername(String Username) {
        this.Username = Username;
    }

    // ��ȡ�༶����
    public String getClassName() {
        return className;
    }

    // ���ð༶����
    public void setClassName(String className) {
        this.className = className;
    }

}
