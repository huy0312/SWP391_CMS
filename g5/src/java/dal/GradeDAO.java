/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

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
import model.Grade;

/**
 *
 * @author win
 */
public class GradeDAO extends BaseDAO {

    /**
     * Get all grades of a student in the class with filter and keyword for
     * searching
     *
     * @param studentId ID of student
     * @param classId ID of class
     * @param gradeType type of grade
     * @param gradeName Name of grade
     * @return List of Grades
     */
    public List<Grade> getAllGrades(int studentId, int classId, int gradeType, String gradeName) {
        List<Grade> list = new ArrayList<>();
        String sql = "select * from grade where student_id = ? and class_id = ? and grade_name like ?";
        if (gradeType != 0) {
            sql += " AND grade_type = " + gradeType;
        }
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, studentId);
            stm.setInt(2, classId);
            stm.setString(3, "%" + gradeName + "%");
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Grade grade = new Grade(
                            rs.getInt("grade_id"),
                            rs.getString("grade_name"),
                            rs.getInt("grade_type"),
                            rs.getFloat("grade"),
                            rs.getString("note"),
                            new UserDAO().getUserById(rs.getInt("student_id")),
                            new QuizDAO().getQuizById(rs.getInt("quiz_id")),
                            new LessonDAO().getSmAssignmentById(rs.getInt("smassignment_id")),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"),
                            new ClassDAO().getClassById(rs.getInt("class_id")),
                            rs.getInt("attempt"));
                    list.add(grade);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(GradeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    /**
     * Paginate records for displaying lessons
     *
     * @param grades List of all grades
     * @param page no of page
     * @param itemsPerPage number of items per page
     * @return List of grade items for pagination
     */
    public List<Grade> paginateGrade(List<Grade> grades, int page, int itemsPerPage) {
        int startIndex = (page - 1) * itemsPerPage;
        int endIndex = Math.min(startIndex + itemsPerPage, grades.size());
        return grades.subList(startIndex, endIndex);
    }

    public void addGradeQuiz(String gradeName, int gradeType, float grade, int studentId, int quizId, int managerId, int attempt,int classId) {
        String sql = "INSERT INTO cmslvl10_db.grade   ( grade_name , grade_type  , grade , student_id , quiz_id, created_by , created_at, attempt, class_id) VALUES(?,?,?,?,?,?, CURRENT_TIMESTAMP, ?,?);";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setString(1, gradeName);
            stm.setInt(2, gradeType);
            stm.setFloat(3, grade);
            stm.setInt(4, studentId);
            stm.setInt(5, quizId);
            stm.setInt(6, managerId);
            stm.setInt(7, attempt);
            stm.setInt(8, classId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(GradeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void updateAttemptGradeQuiz(float grade, int quizId, int studentId) {
        String sql = "UPDATE cmslvl10_db.grade  SET grade = ?, attempt = attempt + 1, updated_by=?, updated_at=CURRENT_TIMESTAMP WHERE quiz_id  = ? and created_by = ?;";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setFloat(1, grade);
            stm.setInt(2, studentId);
            stm.setInt(3, quizId);
            stm.setInt(4, studentId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(GradeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public Grade getGradeById(int gradeId) {
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement("select * from grade g where g.grade_id = ?")) {
            stm.setInt(1, gradeId);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    return new Grade(
                            rs.getInt("grade_id"),
                            rs.getString("grade_name"),
                            rs.getInt("grade_type"),
                            rs.getFloat("grade"),
                            rs.getString("note"),
                            new UserDAO().getUserById(rs.getInt("student_id")),
                            new QuizDAO().getQuizById(rs.getInt("quiz_id")),
                            new LessonDAO().getSmAssignmentById(rs.getInt("smassignment_id")),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"),
                            new ClassDAO().getClassById(rs.getInt("class_id")),
                            rs.getInt("attempt"));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DimensionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public Grade getGradeByQuiz(int quizId, int studentId) {
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement("select * from grade g where g.quiz_id = ? and g.student_id  = ?")) {
            stm.setInt(1, quizId);
            stm.setInt(2, studentId);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    return new Grade(
                            rs.getInt("grade_id"),
                            rs.getString("grade_name"),
                            rs.getInt("grade_type"),
                            rs.getFloat("grade"),
                            rs.getString("note"),
                            new UserDAO().getUserById(rs.getInt("student_id")),
                            new QuizDAO().getQuizById(rs.getInt("quiz_id")),
                            new LessonDAO().getSmAssignmentById(rs.getInt("smassignment_id")),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"),
                            new ClassDAO().getClassById(rs.getInt("class_id")),
                            rs.getInt("attempt"));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DimensionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public boolean checkedQuiz(int quizId, int studentId) {
        String sql = "SELECT COUNT(*) FROM grade g  WHERE g.quiz_id  = ? AND g.created_by  = ?;";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, quizId);
            stm.setInt(2, studentId);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(GradeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    /**
     * Sort list of grade inputted by order of field
     *
     * @param grades List of grades need to be sorted
     * @param field Name of field to sort
     * @param order Order by which to sort
     * @return List of grades which is sorted
     */
    public List<Grade> sortGrade(List<Grade> grades, String field, String order) {
        if (field != null && order != null) {
            Comparator<Grade> comparator = null;
            switch (field) {
                case "id":
                    comparator = Comparator.comparingInt(Grade::getGradeId);
                    break;
                case "name":
                    comparator = Comparator.comparing(Grade::getGradeName);
                    break;
                case "type":
                    comparator = Comparator.comparingInt(Grade::getGradeType);
                    break;
                case "grade":
                    comparator = Comparator.comparingDouble(Grade::getGrade);
                    break;
                case "attempt":
                    comparator = Comparator.comparingInt(Grade::getAttempt);
                    break;
                case "note":
                    comparator = Comparator.comparing(Grade::getNote);
                    break;
                default:
                    throw new AssertionError();
            }
            if (comparator != null) {
                if ("desc".equalsIgnoreCase(order)) {
                    comparator = comparator.reversed();
                }
                // Create a new sorted list using streams and collectors
                return grades.stream()
                        .sorted(comparator)
                        .collect(Collectors.toList());
            }
        }
        // Return the original list if no sorting was performed
        return grades;
    }

    public static void main(String[] args) {
        System.out.println(new GradeDAO().getGradeByQuiz(24, 6));
    }

}
