/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import static dal.BaseDAO.getConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Class;
import model.Setting;
import model.Subject;
import model.User;

/**
 *
 * @author minhf
 */
public class ClassDAO extends BaseDAO {

    /**
     *
     * @param userId
     * @param semesterId
     * @param subjectId
     * @param status
     * @param classCode
     * @return
     * @throws SQLException
     */
    public List<Class> getAllClass(int userId, int semesterId, int subjectId, int status, String classCode) throws SQLException {
        List<Class> list = new ArrayList<>();
        String sql = "select  *  from `class` c cross "
                + "join subject s on s.subject_id  = c.subject_id "
                + "cross join `user` u on u.user_id = c.manager_id  "
                + "cross join `setting` st on st.setting_id  = c.semester_id  "
                + "WHERE s.manager_id = ? "
                + "AND c.class_code like ?";
        if (semesterId != -1) {
            sql += " AND st.setting_id = " + semesterId;
        }
        if (subjectId != -1) {
            sql += " AND s.subject_id = " + subjectId;
        }
        if (status != -1) {
            sql += " AND c.status = " + status;
        }
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, userId);
            stm.setString(2, "%" + classCode + "%");
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Subject s = new Subject();
                    s.setSubjectId(rs.getInt("subject_id"));
                    s.setSubjectName(rs.getString("subject_name"));
                    User user = new User();
                    user.setUserId(rs.getInt("manager_id"));
                    user.setFullName(rs.getString("full_name"));
                    Setting st = new Setting();
                    st.setSettingId(rs.getInt("setting_id"));
                    st.setSettingName(rs.getString("setting_name"));
                    Class classes = new Class(
                            rs.getInt("class_id"),
                            rs.getString("class_code"),
                            st,
                            s,
                            user,
                            rs.getBoolean("status"),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"));
                    list.add(classes);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    /**
     *
     * @param userId
     * @return
     */
    public List<Class> getAllClasses(int userId) {
        List<Class> list = new ArrayList<>();
        String sql = "select * from class c where c.status = 1 and c.manager_id = ? ";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, userId);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Subject s = new Subject();
                    s.setSubjectId(rs.getInt("subject_id"));
                    s.setSubjectName(rs.getString("subject_name"));
                    User user = new User();
                    user.setUserId(rs.getInt("manager_id"));
                    user.setFullName(rs.getString("full_name"));
                    Setting st = new Setting();
                    st.setSettingId(rs.getInt("setting_id"));
                    st.setSettingName(rs.getString("setting_name"));
                    Class classes = new Class(
                            rs.getInt("class_id"),
                            rs.getString("class_code"),
                            st,
                            s,
                            user,
                            rs.getBoolean("status"),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"));
                    list.add(classes);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    /**
     *
     * @return @throws SQLException
     */
    public List<Class> getClassList() throws SQLException {
        List<Class> list = new ArrayList<>();
        String sql = "select  *  from `class` c "
                + "cross join subject s on s.subject_id  = c.subject_id "
                + "cross join `user` u on u.user_id = c.manager_id  "
                + "cross join `setting` st on st.setting_id  = c.semester_id";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Subject s = new Subject();
                    s.setSubjectId(rs.getInt("subject_id"));
                    s.setSubjectName(rs.getString("subject_name"));
                    User user = new User();
                    user.setUserId(rs.getInt("manager_id"));
                    user.setFullName(rs.getString("full_name"));
                    Setting st = new Setting();
                    st.setSettingId(rs.getInt("setting_id"));
                    st.setSettingName(rs.getString("setting_name"));
                    Class classes = new Class(
                            rs.getInt("class_id"),
                            rs.getString("class_code"),
                            st,
                            s,
                            user,
                            rs.getBoolean("status"),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"));
                    list.add(classes);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    /**
     * 
     * @param classId
     * @return 
     */
    public Class getClassById(int classId) {
        String sql = "SELECT * FROM class WHERE class_id = ?";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, classId);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Class classes = new Class(
                            rs.getInt("class_id"),
                            rs.getString("class_code"),
                            new SettingDAO().getSettingById(rs.getInt("semester_id")),
                            new SubjectDAO().getSubjectById(rs.getInt("subject_id")),
                            new UserDAO().getUserById(rs.getInt("manager_id")),
                            rs.getBoolean("status"),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"));
                    return classes;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     *
     * @param classCode
     * @param semesterId
     * @param subjectId
     */
    public void addClass(String classCode, int semesterId, int subjectId) {
        String sql = "INSERT INTO cmslvl10_db.class"
                + "(class_code, semester_id, subject_id ,"
                + "manager_id, status, created_by, created_at)"
                + "VALUES(?, ?, ?,?,0, ?, CURRENT_TIMESTAMP);";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            int Id = new UserDAO().getManagerId();
            stm.setString(1, classCode);
            stm.setInt(2, semesterId);
            stm.setInt(3, subjectId);
            stm.setInt(4, Id);
            stm.setInt(5, Id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *
     * @param classId
     * @param classCode
     * @param semesterId
     * @param subjectId
     */
    public void updateClass(int classId, String classCode, int semesterId, int subjectId) {
        String sql = "UPDATE cmslvl10_db.class "
                + "SET class_code=?, semester_id=?, subject_id=?, "
                + "updated_by=?, updated_at=CURRENT_TIMESTAMP "
                + "WHERE class_id=?;";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            int Id = new UserDAO().getManagerId();
            stm.setString(1, classCode);
            stm.setInt(2, semesterId);
            stm.setInt(3, subjectId);
            stm.setInt(4, Id);
            stm.setInt(5, classId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *
     * @param id
     * @param status
     * @param managerId
     */
    public void updateClassStatus(int id, Boolean status, int managerId) {
        String sql = "UPDATE cmslvl10_db.`class` "
                + "SET status = ?, updated_by = ?, "
                + "updated_at=CURRENT_TIMESTAMP "
                + "WHERE class_id = ?;";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setBoolean(1, status);
            stm.setInt(2, managerId);
            stm.setInt(3, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *
     * @param classes
     * @param page
     * @param itemsPerPage
     * @return
     */
    public List<Class> paginateClass(List<Class> classes, int page, int itemsPerPage) {
        int startIndex = (page - 1) * itemsPerPage;
        int endIndex = Math.min(startIndex + itemsPerPage, classes.size());
        return classes.subList(startIndex, endIndex);
    }

    /**
     *
     * @return
     */
    public int countClass() {
        String sql = "SELECT COUNT(*) FROM class";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);  ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }
    
    /**
     * 
     * @return 
     */
    public List<Class> getClasses() {
        List<Class> list = new ArrayList<>();
        String sql = "SELECT * FROM class WHERE status = 1";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Class classes = new Class(
                            rs.getInt("class_id"),
                            rs.getString("class_code"),
                            new SettingDAO().getSettingById(rs.getInt("semester_id")),
                            new SubjectDAO().getSubjectById(rs.getInt("subject_id")),
                            new UserDAO().getUserById(rs.getInt("manager_id")),
                            rs.getBoolean("status"),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"));
                    list.add(classes);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
        public List<Class> paginateClassCatalog(List<Class> lessons, int page, int itemsPerPage) {
        int startIndex = (page - 1) * itemsPerPage;
        int endIndex = Math.min(startIndex + itemsPerPage, lessons.size());
        return lessons.subList(startIndex, endIndex);
    }

    public List<Class> getClassesByTrainer(int trainerId) {
        List<Class> list = new ArrayList<>();
        String sql = "SELECT * FROM class WHERE manager_id = ? AND status = 1";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, trainerId);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Class classes = new Class(
                            rs.getInt("class_id"),
                            rs.getString("class_code"),
                            new SettingDAO().getSettingById(rs.getInt("semester_id")),
                            new SubjectDAO().getSubjectById(rs.getInt("subject_id")),
                            new UserDAO().getUserById(rs.getInt("manager_id")),
                            rs.getBoolean("status"),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"));
                    list.add(classes);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public void enrolClass(int classId, int userId) {
        String sql = "INSERT INTO cmslvl10_db.class_student (class_id, student_id, status, created_by, created_at) VALUES(?, ?, ?, ?, CURRENT_TIMESTAMP);";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setInt(1, classId);
            stm.setInt(2, userId);
            stm.setInt(3, 1);
            stm.setInt(4, userId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public List<Class> getClassesByStudent(int studentId) {
        List<Class> list = new ArrayList<>();
        String sql = "SELECT c.* FROM class c JOIN class_student cs on c.class_id = cs.class_id WHERE cs.student_id = ? AND cs.status = 1 AND c.status = 1";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, studentId);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Class classes = new Class(
                            rs.getInt("class_id"),
                            rs.getString("class_code"),
                            new SettingDAO().getSettingById(rs.getInt("semester_id")),
                            new SubjectDAO().getSubjectById(rs.getInt("subject_id")),
                            new UserDAO().getUserById(rs.getInt("manager_id")),
                            rs.getBoolean("status"),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"));
                    list.add(classes);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public List<Class> getClassCatalog(String keyword) {
        List<Class> list = new ArrayList<>();
        String sql = "SELECT c.*, s.subject_name, u.full_name "
                + "FROM class c "
                + "JOIN subject s "
                + "ON c.subject_id = s.subject_id "
                + "JOIN user u "
                + "ON u.user_id = c.manager_id "
                + "JOIN setting st "
                + "ON st.setting_id = c.semester_id "
                + "WHERE c.status = 1 AND (c.class_code LIKE ? OR s.subject_name LIKE ? OR u.full_name LIKE ? OR st.setting_name LIKE ?)";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, "%" + keyword + "%");
            stm.setString(2, "%" + keyword + "%");
            stm.setString(3, "%" + keyword + "%");
            stm.setString(4, "%" + keyword + "%");
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Class classes = new Class(
                            rs.getInt("class_id"),
                            rs.getString("class_code"),
                            new SettingDAO().getSettingById(rs.getInt("semester_id")),
                            new SubjectDAO().getSubjectById(rs.getInt("subject_id")),
                            new UserDAO().getUserById(rs.getInt("manager_id")),
                            rs.getBoolean("status"),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"));
                    list.add(classes);
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public boolean isClassRegistered(int classId, int studentId) {
        String sql = "SELECT COUNT(*) FROM class_student WHERE class_id = ? AND student_id = ?";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, classId);
            stm.setInt(2, studentId);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    int count = rs.getInt(1);
                    return count > 0;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
}
