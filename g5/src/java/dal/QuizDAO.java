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
import model.Chapter;
import model.Dimension;
import model.Question;
import model.Quiz;
import model.Subject;
import model.User;
import utils.IConstant;

/**
 *
 * @author win
 */
public class QuizDAO {

    /**
     * Get all quizes with filter and keyword for searching
     *
     * @param userId ID of user
     * @param subjectId ID of subject
     * @param chapterId ID of chapter
     * @param dimensionId ID of dimension
     * @param status status of the quiz
     * @param quizName keyword for searching
     * @return
     */
    public List<Quiz> getQuizList(int userId, int subjectId, int chapterId, int dimensionId, int status, String quizName) {
        List<Quiz> list = new ArrayList<>();
        SubjectDAO sdao = new SubjectDAO();
        ChapterDAO cdao = new ChapterDAO();
        DimensionDAO ddao = new DimensionDAO();
        SettingDAO stdao = new SettingDAO();

        String sql = "select * from cmslvl10_db.quiz  join cmslvl10_db.quiz_config on cmslvl10_db.quiz.quiz_id  = cmslvl10_db.quiz_config.quiz_id  join subject s on quiz.subject_id = s.subject_id  where s.manager_id  = ? and quiz.quiz_name like ?";
        if (subjectId != -1) {
            sql += " AND quiz.subject_id = " + subjectId;
        }
        if (chapterId != -1) {
            sql += " AND chapter_id = " + chapterId;
        }
        if (dimensionId != -1) {
            sql += " AND dimension_id = " + dimensionId;
        }
        if (status != -1) {
            sql += " AND quiz.status = " + status;
        }

        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setInt(1, userId);
            stm.setString(2, "%" + quizName + "%");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Quiz quiz = new Quiz(rs.getInt("quiz_id"),
                        rs.getString("quiz_name"),
                        stdao.getSettingById(rs.getInt("quiz_type")),
                        rs.getString("description"),
                        rs.getBoolean("status"),
                        cdao.getChapterById(rs.getInt("chapter_id")),
                        sdao.getSubjectById(rs.getInt("subject_id")),
                        ddao.getDimensionById(rs.getInt("dimension_id")),
                        rs.getInt("no_of_question"),
                        rs.getInt("duration"),
                        rs.getInt("created_by"),
                        rs.getDate("created_at"),
                        rs.getInt("updated_by"),
                        rs.getDate("updated_at"));
                list.add(quiz);
            }
        } catch (SQLException ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    /**
     * Get all quizes in a specific dimension
     *
     * @param dimensionId Id of dimension
     * @return List of quizs in the dimension
     */
    public List<Quiz> getQuizsByDimension(int dimensionId) {
        List<Quiz> list = new ArrayList<>();
        SubjectDAO sdao = new SubjectDAO();
        ChapterDAO cdao = new ChapterDAO();
        DimensionDAO ddao = new DimensionDAO();
        SettingDAO stdao = new SettingDAO();
        String sql = "SELECT * FROM quiz join quiz_config on quiz.quiz_id=quiz_config.id WHERE quiz_config.dimension_id = ?";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, dimensionId);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Quiz quiz = new Quiz(rs.getInt("quiz_id"),
                            rs.getString("quiz_name"),
                            stdao.getSettingById(rs.getInt("quiz_type")),
                            rs.getString("description"),
                            rs.getBoolean("status"),
                            cdao.getChapterById(rs.getInt("chapter_id")),
                            sdao.getSubjectById(rs.getInt("subject_id")),
                            ddao.getDimensionById(rs.getInt("dimension_id")),
                            rs.getInt("no_of_question"),
                            rs.getInt("duration"),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"));
                    list.add(quiz);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    /**
     * Delete a quiz from a specific lesson
     *
     * @param quizId Id of quiz
     */
    public void deleteQuizFromLesson(int quizId) {
        String sql = "update cmslvl10_db.lesson set quiz_id = null where quiz_id = ?";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setInt(1, quizId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Delete all the config of a specific quiz
     *
     * @param quizId Id of quiz
     */
    public void deleteQuizConfig(int quizId) {
        String sql = "DELETE FROM cmslvl10_db.quiz_config c WHERE c.quiz_id = ?";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setInt(1, quizId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Delete a specific quiz
     *
     * @param quizId Id of quiz
     */
    public void deleteQuiz(int quizId) {
        String sql = "DELETE FROM cmslvl10_db.quiz z  WHERE z.quiz_id = ?";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setInt(1, quizId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Delete all question of that quiz
     *
     * @param quizId Id of quiz
     */
    public void deleteQuizListQuestion(int quizId) {
        String sql = "DELETE FROM cmslvl10_db.quiz_question q WHERE q.quiz_id = ?";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setInt(1, quizId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Get a specific quiz by ID
     * @param quizId Id of quiz
     * @return
     */
    public Quiz getQuizById(int quizId) {
        SubjectDAO sdao = new SubjectDAO();
        ChapterDAO cdao = new ChapterDAO();
        DimensionDAO ddao = new DimensionDAO();
        QuestionDAO qdao = new QuestionDAO();
        SettingDAO stdao = new SettingDAO();
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement("select * from cmslvl10_db.quiz  join cmslvl10_db.quiz_config on cmslvl10_db.quiz.quiz_id  = cmslvl10_db.quiz_config.quiz_id where cmslvl10_db.quiz.quiz_id = ?")) {

            stm.setInt(1, quizId);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    return new Quiz(rs.getInt("quiz_id"),
                            rs.getString("quiz_name"),
                            stdao.getSettingById(rs.getInt("quiz_type")),
                            rs.getString("description"),
                            rs.getBoolean("status"),
                            cdao.getChapterById(rs.getInt("chapter_id")),
                            sdao.getSubjectById(rs.getInt("subject_id")),
                            ddao.getDimensionById(rs.getInt("dimension_id")),
                            rs.getInt("no_of_question"),
                            rs.getInt("duration"),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * Get all quizes by subject and chapter for searching
     * @param subjectId Id of subject
     * @param chapterId Id of chapter
     * @param quizName keyword for searching
     * @return
     */
    public List<Quiz> getQuizBySubjectAndChapter(int subjectId, int chapterId, String quizName) {
        List<Quiz> list = new ArrayList<>();
        SubjectDAO sdao = new SubjectDAO();
        ChapterDAO cdao = new ChapterDAO();
        DimensionDAO ddao = new DimensionDAO();
        QuestionDAO qdao = new QuestionDAO();
        SettingDAO stdao = new SettingDAO();
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement("select * from cmslvl10_db.quiz q join cmslvl10_db.quiz_config qc  on q.quiz_id = qc.quiz_id where q.subject_id = ? and qc.chapter_id =? and q.quiz_name like ?")) {

            stm.setInt(1, subjectId);
            stm.setInt(2, chapterId);
            stm.setString(3, "%" + quizName + "%");
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Quiz quiz = new Quiz(rs.getInt("quiz_id"),
                            rs.getString("quiz_name"),
                            stdao.getSettingById(rs.getInt("quiz_type")),
                            rs.getString("description"),
                            rs.getBoolean("status"),
                            cdao.getChapterById(rs.getInt("chapter_id")),
                            sdao.getSubjectById(rs.getInt("subject_id")),
                            ddao.getDimensionById(rs.getInt("dimension_id")),
                            rs.getInt("no_of_question"),
                            rs.getInt("duration"),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"));
                    list.add(quiz);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    /**
     * Add a new quiz to database
     * @param name name of new quiz
     * @param content description of new quiz
     * @param status status of new quiz
     * @param subjectId id of subject
     * @param managerId id of user create new quiz
     */
    public void addQuiz(String name, String content, boolean status, int subjectId, int managerId) {
        String sql = "INSERT INTO cmslvl10_db.quiz   ( quiz_name , description , status , subject_id , created_by , created_at) VALUES(?,?,?,?,?, CURRENT_TIMESTAMP);";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setString(1, name);
            stm.setString(2, content);
            stm.setBoolean(3, status);
            stm.setInt(4, subjectId);
            stm.setInt(5, managerId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Add a new extra quiz to database
     * @param name name of extra quiz
     * @param content description of extra quiz
     * @param status status of extra quiz
     * @param subjectId Id of subject
     * @param managerId Id of user create extra quiz
     * @param quizType type of extra quiz
     * @param duration duration of extra quiz
     */
    public void addExtraQuiz(String name, String content, boolean status, int subjectId, int managerId, int quizType, int duration) {
        String sql = "INSERT INTO cmslvl10_db.quiz   ( quiz_name , description , status , subject_id , created_by , created_at, quiz_type, duration) VALUES(?,?,?,?,?, CURRENT_TIMESTAMP,?,?);";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setString(1, name);
            stm.setString(2, content);
            stm.setBoolean(3, status);
            stm.setInt(4, subjectId);
            stm.setInt(5, managerId);
            stm.setInt(6, quizType);
            stm.setInt(7, duration);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Add config of extra quiz to database
     * @param quizId Id of extra quiz
     * @param noQues number of questions in extra quiz
     * @param chapterId Id of chapter
     * @param managerId Id of user create extra quiz
     */
    public void addExtraQuizConfig(int quizId, int noQues, int chapterId, int managerId) {
        String sql = "INSERT INTO cmslvl10_db.quiz_config   ( quiz_id , no_of_question , chapter_id , created_by , created_at) VALUES(?,?,?,?, CURRENT_TIMESTAMP);";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setInt(1, quizId);
            stm.setInt(2, noQues);
            stm.setInt(3, chapterId);
            stm.setInt(4, managerId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Add config of new quiz to database
     * @param quizId Id of new quiz
     * @param dimensionId Id of dimension
     * @param chapterId Id of chapter
     * @param managerId Id of user create new quiz
     */
    public void addQuizConfig(int quizId, int dimensionId, int chapterId, int managerId) {
        String sql = "INSERT INTO cmslvl10_db.quiz_config   ( quiz_id , dimension_id , chapter_id , created_by , created_at) VALUES(?,?,?,?, CURRENT_TIMESTAMP);";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setInt(1, quizId);
            stm.setInt(2, dimensionId);
            stm.setInt(3, chapterId);
            stm.setInt(4, managerId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Update details for extra quiz
     * @param quizId Id of quiz
     * @param name name of extra quiz
     * @param content description of extra quiz
     * @param status status of extra quiz
     * @param managerId Id of user update extra quiz
     * @param duration duration of extra quiz
     */
    public void updateExtraQuiz(int quizId, String name, String content, boolean status, int managerId, int duration) {
        String sql = "UPDATE cmslvl10_db.quiz "
                + " SET quiz.quiz_name=?,"
                + " quiz.description=?,"
                + " quiz.status=?,"
                + " quiz.updated_by=?,"
                + " quiz.updated_at=CURRENT_TIMESTAMP,"
                + " quiz.duration=?"
                + " WHERE quiz.quiz_id=?;";

        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setString(1, name);
            stm.setString(2, content);
            stm.setBoolean(3, status);
            stm.setInt(4, managerId);
            stm.setInt(5, duration);
            stm.setInt(6, quizId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Update details config for extra quiz
     * @param quizId Id of extra quiz
     * @param noQues number of questions in extra quiz
     * @param managerId Id of user update extra quiz
     */
    public void updateExtraQuizConfig(int quizId, int noQues, int managerId) {
        String sql = "UPDATE cmslvl10_db.quiz_config "
                + " SET quiz_config.no_of_question=?,"
                + " quiz_config.updated_by=?,"
                + " quiz_config.updated_at=CURRENT_TIMESTAMP"
                + " WHERE quiz_config.quiz_id=?;";

        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {

            stm.setInt(1, noQues);
            stm.setInt(2, managerId);
            stm.setInt(3, quizId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Update detail for a specific quiz
     * @param quizId Id of quiz
     * @param name name of quiz
     * @param content description of extra quiz
     * @param status status of quiz
     * @param subjectId Id of subject
     * @param managerId Id of user update quiz
     */
    public void updateQuiz(int quizId, String name, String content, boolean status, int subjectId, int managerId) {
        String sql = "UPDATE cmslvl10_db.quiz "
                + "SET quiz.quiz_name=?,"
                + " quiz.description=?,"
                + " quiz.status=?,"
                + " quiz.subject_id=?,"
                + " quiz.updated_by=?,"
                + " quiz.updated_at=CURRENT_TIMESTAMP"
                + " WHERE quiz.quiz_id=?;";

        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setString(1, name);
            stm.setString(2, content);
            stm.setBoolean(3, status);
            stm.setInt(4, subjectId);
            stm.setInt(5, managerId);
            stm.setInt(6, quizId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Update details config for extra quiz
     * @param quizId Id of quiz
     * @param dimensionId Id of dimension
     * @param chapterId Id of chapter
     * @param managerId Id of user update quiz
     */
    public void updateQuizConfig(int quizId, int dimensionId, int chapterId, int managerId) {
        String sql = "UPDATE cmslvl10_db.quiz_config "
                + " SET quiz.dimension_id=?,"
                + " quiz.chapter_id=?,"
                + " quiz.updated_by=?,"
                + " quiz.updated_at=CURRENT_TIMESTAMP"
                + " WHERE quiz.quiz_id=?;";

        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {

            stm.setInt(1, dimensionId);
            stm.setInt(2, chapterId);
            stm.setInt(3, managerId);
            stm.setInt(4, quizId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Get Id of quiz after it created
     * @return Id of quiz
     */
    public int getLargestQuizId() {
        String sql = "SELECT MAX(quiz_id) FROM quiz";
        int largestQuizId = -1; // Initialize with a default value

        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);  ResultSet resultSet = stm.executeQuery()) {
            if (resultSet.next()) {
                largestQuizId = resultSet.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return largestQuizId;
    }

    /**
     * Paginate list of quizes inputted
     * @param quizs List of quizes need to be paginated
     * @param page number of page
     * @param itemsPerPage Number of items per page
     * @return List of quizes which is paginated
     */
    public List<Quiz> paginateQuiz(List<Quiz> quizs, int page, int itemsPerPage) {
        int startIndex = (page - 1) * itemsPerPage;
        int endIndex = Math.min(startIndex + itemsPerPage, quizs.size());
        return quizs.subList(startIndex, endIndex);
    }

    /**
     * Update status of quiz
     * @param id Id of quiz
     * @param status status of quiz
     * @param managerId Id of user update status of quiz
     */
    public void updateQuizStatus(int id, Boolean status, int managerId) {
        String sql = "UPDATE cmslvl10_db.quiz SET status = ?, updated_by = ?, updated_at=CURRENT_TIMESTAMP WHERE quiz_id = ?;";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setBoolean(1, status);
            stm.setInt(2, managerId);
            stm.setInt(3, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Update duration of quiz
     * @param duration duration of quiz
     * @param quizId id of quiz
     */
    public void updateQuizDuration(int duration, int quizId) {
        String sql = "UPDATE cmslvl10_db.quiz "
                + "SET duration=? "
                + "WHERE quiz_id=?;";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setInt(1, duration);
            stm.setInt(2, quizId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Add list of questions to a specific quiz
     * @param quizId Id of quiz
     * @param managerId Id of user create list of questions
     * @param noQues number of questions
     */
    public void addQuizListQuestionRandom(int quizId, int managerId, int noQues) {
        String sql = "INSERT INTO quiz_question (quiz_id, question_id, created_by)\n"
                + "select ? as quiz_id, question_id, ? \n"
                + "FROM question order by rand() limit ?";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setInt(1, quizId);
            stm.setInt(2, managerId);
            stm.setInt(3, noQues);

            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Get all quizes by subject
     * @param subjectId Id of subject
     * @return
     */
    public List<Quiz> getQuizBySubject(int subjectId) {
        List<Quiz> list = new ArrayList<>();
        SubjectDAO sdao = new SubjectDAO();
        String sql = "select * from cmslvl10_db.quiz where cmslvl10_db.quiz.subject_id = ? ";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setInt(1, subjectId);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Quiz quiz = new Quiz();
                    quiz.setQuizId(rs.getInt("quiz_id"));
                    quiz.setQuizName(rs.getString("quiz_name"));
                    quiz.setDescription(rs.getString("description"));
                    quiz.setStatus(rs.getBoolean("status"));
                    quiz.setSubject(sdao.getSubjectById(rs.getInt("subject_id")));
                    quiz.setCreatedBy(rs.getInt("created_by"));
                    quiz.setCreatedAt(rs.getDate("created_at"));
                    quiz.setUpdatedBy(rs.getInt("updated_by"));
                    quiz.setUpdatedAt(rs.getDate("updated_at"));
                    list.add(quiz);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    /**
     * Sort the list of quizes inputted with by order of fields
     * @param quizs list of quizes need to be sorted
     * @param field name of the field to sort
     * @param order name of sort order
     * @return List the quizes which is sorted
     */
    public List<Quiz> sortQuiz(List<Quiz> quizs, String field, String order) {
        if (field != null && order != null) {
            Comparator<Quiz> comparator = null;
            switch (field) {
                case "id":
                    comparator = Comparator.comparingInt(Quiz::getQuizId);
                    break;
                case "name":
                    comparator = Comparator.comparing(Quiz::getQuizName);
                    break;
                case "type":
                    comparator = Comparator.comparingInt(q -> q.getQuizType().getSettingId());
                    break;
                case "time":
                    comparator = Comparator.comparing(Quiz::getCreatedAt);
                    break;
                case "duration":
                    comparator = Comparator.comparingInt(Quiz::getDuration);
                    break;
                case "noQuestion":
                    comparator = Comparator.comparingInt(Quiz::getNoQuiz);
                    break;
                case "createdBy":
                    comparator = Comparator.comparingInt(Quiz::getCreatedBy);
                    break;
                case "subjectName":
                    comparator = Comparator.comparing(q -> q.getSubject().getSubjectName());
                    break;
                case "chapterName":
                    comparator = Comparator.comparing(q -> q.getChapter().getChapterName());
                    break;
                case "dimensionName":
                    comparator = Comparator.comparing(q -> q.getDimension().getDimensionName());
                    break;
                default:
                    throw new AssertionError();
            }
            if (comparator != null) {
                if ("desc".equalsIgnoreCase(order)) {
                    comparator = comparator.reversed();
                }
                // Create a new sorted list using streams and collectors
                return quizs.stream()
                        .sorted(comparator)
                        .collect(Collectors.toList());
            }
        }
        // Return the original list if no sorting was performed
        return quizs;
    }
    
    
}
