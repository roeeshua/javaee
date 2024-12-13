package bean;

public class ClassInfo {
    private int id;          // �༶ ID
    private String name;     // �༶����
    private String about;    // �༶���

    // ���캯��
    public ClassInfo(int id, String name, String about) {
        this.id = id;
        this.name = name;
        this.about = about;
    }

    // Getter �� Setter ����
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAbout() {
        return about;
    }

    public void setAbout(String about) {
        this.about = about;
    }

    @Override
    public String toString() {
        return "ClassInfo{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", about='" + about + '\'' +
                '}';
    }
}
