package bean;

public class JoinRequest {
    private int class_id; // ����ID

    private int teacher_id; // ����ID
    private String teacherUsername; // �����ʦ���û���
    private String className; // �༶����

    // ���췽��
    public JoinRequest(int class_id,int teacher_id, String teacherUsername, String className) {
        this.class_id = class_id;
        this.teacher_id = teacher_id;
        this.teacherUsername = teacherUsername;
        this.className = className;
    }

    public int getClassId() {
        return class_id;
    }
    public int getTeacherId() {
        return teacher_id;
    }
    // ��������ID

    // ��ȡ��ʦ�û���
    public String getTeacherUsername() {
        return teacherUsername;
    }

    // ���ý�ʦ�û���
    public void setTeacherUsername(String teacherUsername) {
        this.teacherUsername = teacherUsername;
    }

    // ��ȡ�༶����
    public String getClassName() {
        return className;
    }

    // ���ð༶����
    public void setClassName(String className) {
        this.className = className;
    }

//    @Override
//    public String toString() {
//        return "JoinRequest{" +
//                "id=" + id +
//                ", teacherUsername='" + teacherUsername + '\'' +
//                ", className='" + className + '\'' +
//                '}';
//    }
}
