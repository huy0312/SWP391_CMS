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
import java.util.Comparator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import model.Assignment;
import model.Setting;
import model.SubmittedAssignment;

/**
 *
 * @author amshu
 */
public class SubmittedAssignmentDAO {

    /**
     *
     * @param userId
     * @param subjectId
     * @param chapterId
     * @param status
     * @return
     */
    public List<SubmittedAssignment> getAllSubmittedAssignments() {
        List<SubmittedAssignment> list = new ArrayList<>();
        String sql = "select sa.* from submitted_assignment sa join `assignment` a on sa.smassignment_id = a.assignment_id;";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    SubmittedAssignment sassignment = new SubmittedAssignment(
                            rs.getInt("smassignment_id"),
                            rs.getString("attached_file"),
                            rs.getString("description"),
                            new AssignmentDAO().getAssignmetntById(rs.getInt("assignment_id")),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"));

                    list.add(sassignment);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(AssignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<SubmittedAssignment> paginateRecords(List<SubmittedAssignment> sassignments, int page, int itemsPerPage) {
        int startIndex = (page - 1) * itemsPerPage;
        int endIndex = Math.min(startIndex + itemsPerPage, sassignments.size());
        return sassignments.subList(startIndex, endIndex);
    }

    public List<SubmittedAssignment> getSubmittedAssignment() {
        List<SubmittedAssignment> list = new ArrayList<>();
        String sql = "select * from submitted_assignment ";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    SubmittedAssignment sassignment = new SubmittedAssignment(
                            rs.getInt("smassignment_id"),
                            rs.getString("attached_file"),
                            rs.getString("description"),
                            new AssignmentDAO().getAssignmetntById(rs.getInt("assignment_id")),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"));

                    list.add(sassignment);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<SubmittedAssignment> getSubmittedAssignments(int assignmentId) {
        List<SubmittedAssignment> list = new ArrayList<>();
        String sql = "SELECT sa.* "
                + "FROM submitted_assignment sa "
                + "WHERE assignment_id = ?";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, assignmentId);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    SubmittedAssignment sassignment = new SubmittedAssignment(
                            rs.getInt("smassignment_id"),
                            rs.getString("attached_file"),
                            rs.getString("description"),
                            new AssignmentDAO().getAssignmetntById(rs.getInt("assignment_id")),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"));

                    list.add(sassignment);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<SubmittedAssignment> sortSubmittedAssignment(List<SubmittedAssignment> sassignments, String field, String order) {
        if (field != null && order != null) {
            Comparator<SubmittedAssignment> comparator = null;
            switch (field) {
                case "smassignmentId":
                    comparator = Comparator.comparingInt(SubmittedAssignment::getSmassignmentId);
                    break;
                default:
                    throw new AssertionError();
            }
            if (comparator != null) {
                if ("desc".equalsIgnoreCase(order)) {
                    comparator = comparator.reversed();
                }
                // Create a new sorted list using streams and collectors
                return sassignments.stream()
                        .sorted(comparator)
                        .collect(Collectors.toList());
            }
        }
        // Return the original list if no sorting was performed
        return sassignments;
    }

    /**
     *
     * @param description
     * @param assignmentId
     */
    public void addAssignment(String description, int assignmentId) {
        String sql = "INSERT INTO cmslvl10_db.submitted_assignment (attached_file,description,assignment_id ,created_by,created_at) VALUES( ?,?, ?, ?, CURRENT_TIMESTAMP);";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setString(1, description);
            stm.setInt(2, assignmentId);

            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SubmittedAssignmentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static void main(String[] args) {
        SubmittedAssignmentDAO smdao = new SubmittedAssignmentDAO();
        List<SubmittedAssignment> s = smdao.getSubmittedAssignments(2);
        System.out.println(s);
    }
}
