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
import model.Answer;

/**
 *
 * @author Admin
 */
public class AnswerDAO {

    /**
     *
     * @param questionId
     * @return
     */
    public List<Answer> getAnswerByQuestion(int questionId) {
        List<Answer> list = new ArrayList<>();
        String sql = "SELECT * FROM question_answer WHERE question_id = ?";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, questionId);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Answer answer = new Answer(
                            rs.getInt("answer_id"),
                            rs.getString("text"),
                            rs.getBoolean("isCorrect"),
                            new QuestionDAO().getQuestionById(rs.getInt("question_id")),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"));
                    list.add(answer);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    /**
     * Get list of ID of correct answers by ID of question
     *
     * @param questionId ID of question
     * @return List of ID of correct answer
     */
    public List<String> getCorrectAnswerIdByQuestion(int questionId) {
        List<String> list = new ArrayList<>();
        String sql = "SELECT answer_id FROM question_answer WHERE isCorrect = 1 AND question_id = ?";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, questionId);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    list.add(Integer.toString(rs.getInt(1)));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<String> getSelectedAnswersForQuestion(List<String> selectedAnswerIds, String questionId) {
        List<String> selectedAnswersForQuestion = new ArrayList<>();
        for (String selectedAnswerId : selectedAnswerIds) {
            if (isAnswerExistInQuestion(
                    Integer.parseInt(selectedAnswerId),
                    Integer.parseInt(questionId))) {
                selectedAnswersForQuestion.add(selectedAnswerId);
            }
        }
        return selectedAnswersForQuestion;
    }

    /**
     * Check if answer is exists in question or not
     *
     * @param answerId ID of question
     * @param questionId ID of quiz
     * @return true if exists, otherwise not
     */
    public boolean isAnswerExistInQuestion(int answerId, int questionId) {
        String sql = "SELECT COUNT(*) FROM question_answer WHERE question_id = ? and answer_id = ?";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, questionId);
            stm.setInt(2, answerId);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public int countCorrectAnswerInQuestion(int questionId) {
        String sql = "SELECT COUNT(*) FROM question_answer WHERE isCorrect = 1 AND question_id = ?";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, questionId);
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
