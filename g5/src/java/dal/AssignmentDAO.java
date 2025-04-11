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
import java.sql.Timestamp;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Assignment;
import model.Chapter;

//import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author minhf
 */
public class AssignmentDAO extends BaseDAO {

    /**
     *
     * @param userId
     * @param status
     * @return
     */
    public List<Assignment> getAllAssignments(int userId, int status,String assignmentTitle) {
        List<Assignment> list = new ArrayList<>();
        String sql = "SELECT a.* \n" +
"                FROM assignment a \n" +
"                JOIN chapter c \n" +
"                ON a.chapter_id = c.chapter_id \n" +
"                JOIN class cl ON a.class_id=cl.class_id\n" +
"                where (a.assignment_title like ?)";

        if (status != -1) {
            sql += " AND a.status = " + status;
        }
        
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
             stm.setString(1, "%" + assignmentTitle+ "%");
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Assignment assignment = new Assignment(
                            rs.getInt("assignment_id"),
                            rs.getString("assignment_title"),
                            new SubjectSettingDAO().getChapterById(rs.getInt("chapter_id")),
                            rs.getTimestamp("deadline"),
                            rs.getString("description"),
                            rs.getBoolean("status"),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"),
                            new ClassDAO().getClassById(rs.getInt("class_id")));
                    list.add(assignment);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(AssignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    /**
     *
     * @param id
     * @return
     */
    public Assignment getAssignmetntById(int id) {
        String sql = "SELECT * FROM assignment WHERE assignment_id = ?";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, id);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Assignment assignment = new Assignment(
                            rs.getInt("assignment_id"),
                            rs.getString("assignment_title"),
                            new SubjectSettingDAO().getChapterById(rs.getInt("chapter_id")),
                            rs.getTimestamp("deadline"),
                            rs.getString("description"),
                            rs.getBoolean("status"),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"),
                            new ClassDAO().getClassById(rs.getInt("class_id")));

                    return assignment;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(AssignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     *
     * @param chapterId
     * @param userId
     * @return
     */
    public List<Chapter> getChapterByAssignment(int chapterId, int userId) {
        List<Chapter> list = new ArrayList<>();
        String sql = "select * from chapter c inner join assignment a "
                + "on c.chapter_id = a.chapter_id "
                + "where c.status = 1 and a.manager_id = ?";
        if (chapterId != -1) {
            sql += " and a.chapter_id = " + chapterId;
        }
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, userId);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Chapter chapter = new Chapter(
                            rs.getInt("chapter_id"),
                            rs.getString("chapter_name"),
                            new SubjectDAO().getSubjectById(rs.getInt("subject_id")),
                            rs.getBoolean("status"),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"));
                    list.add(chapter);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(AssignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    /**
     *
     * @param assignments
     * @param page
     * @param itemsPerPage
     * @return
     */
    public List<Assignment> paginateAssignment(List<Assignment> assignments, int page, int itemsPerPage) {
        int startIndex = (page - 1) * itemsPerPage;
        int endIndex = Math.min(startIndex + itemsPerPage, assignments.size());
        return assignments.subList(startIndex, endIndex);
    }

    /**
     *
     * @param id
     * @param status
     * @param managerId
     */
    public void updateAssigmentStatus(int id, Boolean status, int managerId) {
        String sql = "UPDATE cmslvl10_db.`assignment` SET status = ?,updated_by=?, updated_at=CURRENT_TIMESTAMP WHERE assignment_id = ?;";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setBoolean(1, status);
            stm.setInt(2, managerId);
            stm.setInt(3, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AssignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *
     * @param chapterId
     * @param file
     * @param description
     * @param status
     */
    public void addAssigment(String assignmentTitle, int chapterId, Timestamp deadline, String description, boolean status, int userId, int classId) {
        String sql = "INSERT INTO cmslvl10_db.`assignment`\n"
                + "( chapter_id, deadline, description, status, created_by, created_at, class_id, assignment_title)\n"
                + "VALUES( ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, ?, ?)";

        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {

            int Id = new UserDAO().getTrainerId();
            stm.setInt(1, chapterId);
            stm.setTimestamp(2, deadline);
            stm.setString(3, description);
            stm.setBoolean(4, status);
            stm.setInt(5, Id);
            stm.setInt(6, classId);
            stm.setString(7, assignmentTitle);

            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AssignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *
     * @param chapterId
     * @param attachedFile
     * @param description
     * @param status
     */
    public void updateAssignment(String assignmentTitle, int chapterId, Timestamp deadline, String description, boolean status, int userId, int classId, int assignmentId) {
        String sql = "UPDATE cmslvl10_db.`assignment`\n"
                + "SET chapter_id=?, deadline=?, description=?, status=?,  updated_by=?, updated_at=CURRENT_TIMESTAMP, class_id=?, assignment_title=?\n"
                + "WHERE assignment_id=?;";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setInt(1, chapterId);
            stm.setTimestamp(2, deadline);
            stm.setString(3, description);
            stm.setBoolean(4, status);
            stm.setInt(5, userId);
            stm.setInt(6, classId);
            stm.setString(7, assignmentTitle);
            stm.setInt(8, assignmentId);

            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AssignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static void main(String[] args) {
        AssignmentDAO a = new AssignmentDAO();
        Timestamp deadline = Timestamp.valueOf("2023-09-20 13:59:00");
        System.out.println(  a.getAllAssignments(11, 1, "name"));
    
    }
}
