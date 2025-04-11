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
import model.Question;

/**
 *
 * @author win
 */
public class QuestionDAO extends BaseDAO {

    /**
     *
     * @param userId
     * @param chapterId
     * @param subjectId
     * @param dimensionId
     * @param lessonId
     * @param status
     * @param questionText
     * @return
     */
    public List<Question> getAllQuestions(int userId, int chapterId, int subjectId, int dimensionId, int lessonId, int status, String questionText) {
        List<Question> list = new ArrayList<>();
        String sql = "SELECT q.* "
                + "FROM question q "
                + "JOIN chapter c "
                + "ON q.chapter_id = c.chapter_id "
                + "JOIN subject s "
                + "ON q.subject_id = s.subject_id "
                + "JOIN dimension d "
                + "ON q.dimension_id = d.dimension_id "
                + "JOIN lesson l "
                + "ON q.lesson_id = l.lesson_id "
                + " WHERE s.manager_id = ? AND q.question_text LIKE ?";

        if (subjectId != -1) {
            sql += " AND s.subject_id = " + subjectId;
        }
        if (chapterId != -1) {
            sql += " AND c.chapter_id = " + chapterId;
        }
        if (status != -1) {
            sql += " AND q.status = " + status;
        }
        if (dimensionId != -1) {
            sql += " AND d.dimension_id = " + dimensionId;
        }
        if (lessonId != -1) {
            sql += " AND l.lesson_id = " + lessonId;
        }
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, userId);
            stm.setString(2, "%" + questionText + "%");
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Question question = new Question(
                            rs.getInt("question_id"),
                            rs.getString("question_text"),
                            new SubjectDAO().getSubjectById(rs.getInt("subject_id")),
                            new SubjectSettingDAO().getChapterById(rs.getInt("chapter_id")),
                            new LessonDAO().getLessonById(rs.getInt("lesson_id")),
                            new DimensionDAO().getDimensionById(rs.getInt("dimension_id")),
                            rs.getString("picture"),
                            rs.getString("description"),
                            rs.getBoolean("status"),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"));
                    list.add(question);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    /**
     *
     * @param questions
     * @param page
     * @param itemsPerPage
     * @return
     */
    public List<Question> paginateQuestion(List<Question> questions, int page, int itemsPerPage) {
        int startIndex = (page - 1) * itemsPerPage;
        int endIndex = Math.min(startIndex + itemsPerPage, questions.size());
        return questions.subList(startIndex, endIndex);
    }

    /**
     *
     * @param questionId
     * @return
     */
    public Question getQuestionById(int questionId) {
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement("SELECT * FROM question WHERE question_id = ?")) {
            stm.setInt(1, questionId);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    return new Question(
                            rs.getInt("question_id"),
                            rs.getString("question_text"),
                            new SubjectDAO().getSubjectById(rs.getInt("subject_id")),
                            new SubjectSettingDAO().getChapterById(rs.getInt("chapter_id")),
                            new LessonDAO().getLessonById(rs.getInt("lesson_id")),
                            new DimensionDAO().getDimensionById(rs.getInt("dimension_id")),
                            rs.getString("picture"),
                            rs.getString("description"),
                            rs.getBoolean("status"),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DimensionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     *
     * @param chapterId
     * @return
     */
    public List<Question> getQuestionByChapter(int chapterId) {
        List<Question> list = new ArrayList<>();
        String sql = "SELECT * FROM question WHERE chapter_id = ?";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, chapterId);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Question question = new Question(
                            rs.getInt("question_id"),
                            rs.getString("question_text"),
                            new SubjectDAO().getSubjectById(rs.getInt("subject_id")),
                            new SubjectSettingDAO().getChapterById(rs.getInt("chapter_id")),
                            new LessonDAO().getLessonById(rs.getInt("lesson_id")),
                            new DimensionDAO().getDimensionById(rs.getInt("dimension_id")),
                            rs.getString("picture"),
                            rs.getString("description"),
                            rs.getBoolean("status"),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"));
                    list.add(question);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    /**
     *
     * @param id
     * @param status
     * @param managerId
     */
    public void updateQuestionStatus(int id, Boolean status, int managerId) {
        String sql = "UPDATE cmslvl10_db.`question` SET status = ?, updated_by = ?, updated_at=CURRENT_TIMESTAMP WHERE question_id = ?;";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setBoolean(1, status);
            stm.setInt(2, managerId);
            stm.setInt(3, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *
     * @param questionId
     */
    public void deleteQuestion(int questionId) {
        String sql = "DELETE FROM cmslvl10_db.question WHERE question_id = ?";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setInt(1, questionId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *
     * @param questionText
     * @param link
     * @param description
     * @param status
     * @param dimensionId
     * @param lessonId
     * @param chapterId
     * @param subjectId
     * @param managerId
     */
    public void addQuestion(String questionText, String link, String description, boolean status, int dimensionId, int lessonId, int chapterId, int subjectId, int managerId) {
        String sql = "INSERT INTO cmslvl10_db.question (question_text, picture, description, status ,dimension_id, lesson_id, chapter_id, subject_id ,created_by, created_at) VALUES(?,?, ?, ?, ?,?, ?,?,?, CURRENT_TIMESTAMP);";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setString(1, questionText);
            stm.setString(2, link);
            stm.setString(3, description);
            stm.setBoolean(4, status);
            stm.setInt(5, dimensionId);
            stm.setInt(6, lessonId);
            stm.setInt(7, chapterId);
            stm.setInt(8, subjectId);
            stm.setInt(9, managerId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *
     * @param text
     * @param picture
     * @param description
     * @param status
     * @param dimensionId
     * @param lessonId
     * @param chapterId
     * @param subjectId
     * @param managerId
     */
    public void updateQuestion(String text, String picture, String description, boolean status, int dimensionId, int lessonId, int chapterId, int subjectId, int managerId) {
        String sql = "UPDATE cmslvl10_db.question "
                + "SET question_text=?,"
                + " picture=?,"
                + " description=?,"
                + " status=?,"
                + " dimension_id=?,"
                + " lesson_id=?,"
                + " chapter_id=?,"
                + " subject_id=?,"
                + " updated_by=?,"
                + " updated_at=CURRENT_TIMESTAMP,"
                + "WHERE question_id=?;";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setString(1, text);
            stm.setString(2, picture);
            stm.setString(3, description);
            stm.setBoolean(4, status);
            stm.setInt(5, dimensionId);
            stm.setInt(6, lessonId);
            stm.setInt(7, chapterId);
            stm.setInt(8, managerId);
            stm.setInt(9, subjectId);

            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *
     * @param quizId
     * @return
     */
    public List<Question> getQuestionListByQuiz(int quizId) {
        List<Question> list = new ArrayList<>();
        String sql = "SELECT * FROM cmslvl10_db.quiz_question qq2 join cmslvl10_db.question q3 on qq2.question_id =q3.question_id  WHERE qq2.quiz_id = ?";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, quizId);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Question question = new Question(
                            rs.getInt("question_id"),
                            rs.getString("question_text"),
                            new SubjectDAO().getSubjectById(rs.getInt("subject_id")),
                            new SubjectSettingDAO().getChapterById(rs.getInt("chapter_id")),
                            new LessonDAO().getLessonById(rs.getInt("lesson_id")),
                            new DimensionDAO().getDimensionById(rs.getInt("dimension_id")),
                            rs.getString("picture"),
                            rs.getString("description"),
                            rs.getBoolean("status"),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"));
                    list.add(question);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    /**
     * Get number of questions existing in quiz
     *
     * @param quizId ID of quiz
     * @return number of questions
     */
    public int countQuestionInQuiz(int quizId) {
        String sql = "SELECT COUNT(*) FROM quiz_question WHERE quiz_id = ?";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, quizId);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }
}
