package dal;

import static dal.BaseDAO.getConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import model.Subject;
import model.User;
import utils.IConstant;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author minhf
 */
public class SubjectDAO extends BaseDAO {

    private int noOfRecords;

    /**
     *
     * @return
     */
    public List<Subject> getSubjectList() {
        List<Subject> list = new ArrayList<>();
        String sql = IConstant.SELECT_ALL_SUBJECT_QUERY;

        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);  ResultSet rs = stm.executeQuery()) {

            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("manager_id"));
                user.setFullName(rs.getString("full_name"));
                Subject subject = new Subject(
                        rs.getInt("subject_id"),
                        rs.getString("subject_code"),
                        rs.getString("subject_name"),
                        user,
                        rs.getBoolean("status"),
                        rs.getInt("created_by"),
                        rs.getDate("created_at"),
                        rs.getInt("updated_by"),
                        rs.getDate("updated_at"),
                        rs.getString("description"));
                list.add(subject);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    /**
     *
     * @param subjectCode
     * @param subjectName
     * @param managerId
     * @param description
     */
    public void addSubject(String subjectCode, String subjectName, int managerId, String description) {
        String sql = IConstant.ADD_SUBJECT_QUERY;
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            int adminId = new UserDAO().getAdminId();
            stm.setString(1, subjectCode);
            stm.setString(2, subjectName);
            stm.setInt(3, managerId);
            stm.setInt(4, adminId);
            stm.setString(5, description);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *
     * @param subjectId
     * @param subjectCode
     * @param subjectName
     * @param managerId
     * @param status
     * @param description
     */
    public void updateSubject(int subjectId, String subjectCode, String subjectName, int managerId, String description) {
        String sql = IConstant.UPDATE_SUBJECT_QUERY;

        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {

            int adminId = new UserDAO().getAdminId();
            stm.setString(1, subjectCode);
            stm.setString(2, subjectName);
            stm.setInt(3, managerId);
            stm.setInt(4, adminId);
            stm.setInt(5, subjectId);
            stm.setString(6, description);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *
     * @param userId
     * @param status
     * @return
     */
    public List<Subject> getSubjects(int userId, int status, String subjectCode) {
        List<Subject> list = new ArrayList<>();
        String sql = "SELECT s.subject_id, s.subject_code, s.subject_name,u.user_id ,u.full_name, s.status, s.description\n"
                + "         FROM cmslvl10_db.subject s \n"
                + "          cross join user u on u.user_id  = s.manager_id\n"
                + "        Where (s.subject_code like ?);";
        if (status != -1) {
            sql += " AND s.status = " + status;
        }
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, "%" + subjectCode + "%");
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setFullName(rs.getString("full_name"));
                    Subject subject = new Subject();
                    subject.setSubjectId(rs.getInt("subject_id"));
                    subject.setSubjectCode(rs.getString("subject_code"));
                    subject.setSubjectName(rs.getString("subject_name"));
                    subject.setManager(user);
                    subject.setStatus(rs.getBoolean("status"));
                    subject.setSubjectDescription(rs.getString("description"));
                    list.add(subject);
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Subject> sortSubjects(List<Subject> subjects, String field, String order) {
        if (field != null && order != null) {
            Comparator<Subject> comparator = null;
            switch (field) {
                case "id":
                    comparator = Comparator.comparingInt(Subject::getSubjectId);
                    break;
                case "code":
                    comparator = Comparator.comparing(Subject::getSubjectCode);
                    break;
                case "name":
                    comparator = Comparator.comparing(Subject::getSubjectName);
                    break;

                default:
                    throw new AssertionError();
            }
            if (comparator != null) {
                if ("desc".equalsIgnoreCase(order)) {
                    comparator = comparator.reversed();
                }
                // Create a new sorted list using streams and collectors
                return subjects.stream()
                        .sorted(comparator)
                        .collect(Collectors.toList());
            }
        }
        // Return the original list if no sorting was performed
        return subjects;
    }

    /**
     *
     * @return
     */
    public int getNoOfRecords() {
        return noOfRecords;
    }

    /**
     *
     * @param subjectId
     */
    public void deleteSubject(int subjectId) {
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(IConstant.DELETE_SUBJECT_QUERY)) {

            stm.setInt(1, subjectId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *
     * @param subjectId
     * @return
     */
    public Subject getSubjectById(int subjectId) {
        String sql = "SELECT * FROM cmslvl10_db.subject WHERE subject_id=?";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, subjectId);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("manager_id"));
                    Subject subject = new Subject(
                            rs.getInt("subject_id"),
                            rs.getString("subject_code"),
                            rs.getString("subject_name"),
                            user,
                            rs.getBoolean("status"),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"),
                            rs.getString("description"));
                    return subject;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }

    /**
     *
     * @return
     */
    public int countSubject() {
        String sql = "SELECT COUNT(*) FROM subject";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);  ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    public void updateSubjectStatus(int subid, Boolean status) {
        UserDAO udao = new UserDAO();
        int id = udao.getAdminId();
        String sql = "UPDATE cmslvl10_db.`subject` SET status=?, updated_by=?, updated_at=CURRENT_TIMESTAMP WHERE subject_id = ?;";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setBoolean(1, status);
            stm.setInt(2, id);
            stm.setInt(3, subid);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *
     * @param userId
     * @return
     */
    public List<Subject> getAllSubjects(int userId) {
        List<Subject> list = new ArrayList<>();
        String sql = "select * from subject s where s.status = 1 and s.manager_id = ? ";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, userId);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("manager_id"));
                    Subject subject = new Subject(
                            rs.getInt("subject_id"),
                            rs.getString("subject_code"),
                            rs.getString("subject_name"),
                            user,
                            rs.getBoolean("status"),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"),
                            rs.getString("description"));
                    list.add(subject);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Subject> paginateRecords(List<Subject> subject, int page, int itemsPerPage) {
        int startIndex = (page - 1) * itemsPerPage;
        int endIndex = Math.min(startIndex + itemsPerPage, subject.size());
        return subject.subList(startIndex, endIndex);
    }

    public static void main(String[] args) {
        SubjectDAO s = new SubjectDAO();

    }
}
