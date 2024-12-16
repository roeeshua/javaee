package bean;

public class ClassNotify {
    private int id;
    private int classId;
    private String sender;
    private String content;

    private String classname;

    public ClassNotify(int id, int classId, String sender, String content) {
        this.id = id;
        this.classId = classId;
        this.sender = sender;
        this.content = content;
    }

    public ClassNotify(int id, int classId, String classname, String sender, String content) {
        this.id = id;
        this.classId = classId;
        this.classname =classname;
        this.sender = sender;
        this.content = content;
    }
    public void setClassname(String classname){
        this.classname =classname;
    }

    public String getClassname(){
        return this.classname;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getClassId() {
        return classId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
