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
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import model.*;
import model.Class;

/**
 *
 * @author win
 */
public class LessonDAO extends BaseDAO {

    /**
     * Get all lessons with filter and keyword for searching
     *
     * @param userId ID of user
     * @param subjectId ID of subject
     * @param chapterId ID of chapter
     * @param status value of status of the lesson
     * @param lessonName keyword for searching
     * @return List of lessons which are filtered
     */
    public List<Lesson> getAllLessons(int userId, int subjectId, int chapterId, int status, String lessonName) {
        List<Lesson> list = new ArrayList<>();
        String sql = "SELECT l.* "
                + "FROM lesson l "
                + "JOIN chapter c "
                + "ON l.chapter_id = c.chapter_id "
                + "JOIN subject s "
                + "ON c.subject_id = s.subject_id "
                + "WHERE s.manager_id = ? "
                + "AND l.created_by = ? AND l.lesson_name LIKE ?";
        if (subjectId != -1) {
            sql += " AND s.subject_id = " + subjectId;
        }
        if (chapterId != -1) {
            sql += " AND c.chapter_id = " + chapterId;
        }
        if (status != -1) {
            sql += " AND l.status = " + status;
        }
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, userId);
            stm.setInt(2, userId);
            stm.setString(3, "%" + lessonName + "%");
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Lesson lesson = new Lesson(
                            rs.getInt("lesson_id"),
                            rs.getString("lesson_name"),
                            rs.getString("youtube_link"),
                            rs.getString("attached_files"),
                            rs.getString("description"),
                            rs.getBoolean("status"),
                            new SubjectSettingDAO().getChapterById(rs.getInt("chapter_id")),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"),
                            new QuizDAO().getQuizById(rs.getInt("quiz_id")),
                            rs.getInt("lesson_type"),
                            rs.getInt("display_order"));
                    list.add(lesson);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    /**
     * Get all lessons in a specific chapter
     *
     * @param chapterId ID of chapter
     * @return List of lessons in the chapter
     */
    public List<Lesson> getLessonsByChapter(int chapterId) {
        List<Lesson> list = new ArrayList<>();
        String sql = "SELECT * FROM lesson WHERE chapter_id = ? AND status = 1 ORDER BY display_order ASC";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, chapterId);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Lesson lesson = new Lesson(
                            rs.getInt("lesson_id"),
                            rs.getString("lesson_name"),
                            rs.getString("youtube_link"),
                            rs.getString("attached_files"),
                            rs.getString("description"),
                            rs.getBoolean("status"),
                            new SubjectSettingDAO().getChapterById(rs.getInt("chapter_id")),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"),
                            new QuizDAO().getQuizById(rs.getInt("quiz_id")),
                            rs.getInt("lesson_type"),
                            rs.getInt("display_order"));
                    list.add(lesson);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    /**
     * Paginate list of lessons inputted
     *
     * @param lessons List of lessons need to be paginated
     * @param page no of page
     * @param itemsPerPage Number of items per page
     * @return List of lessons which is paginated
     */
    public List<Lesson> paginateLesson(List<Lesson> lessons, int page, int itemsPerPage) {
        int startIndex = (page - 1) * itemsPerPage;
        int endIndex = Math.min(startIndex + itemsPerPage, lessons.size());
        return lessons.subList(startIndex, endIndex);
    }

    /**
     * Update status of the lesson
     *
     * @param id ID of lesson
     * @param status value of the lesson's status
     * @param managerId ID of the manager who operates the function
     */
    public void updateLessonStatus(int id, Boolean status, int managerId) {
        String sql = "UPDATE cmslvl10_db.`lesson` SET status = ?, updated_by = ?, updated_at=CURRENT_TIMESTAMP WHERE lesson_id = ?;";
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
     * Get a specific lesson by ID
     *
     * @param id ID of lesson
     * @return A lesson with corresponding ID
     */
    public Lesson getLessonById(int id) {
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement("SELECT * FROM lesson WHERE lesson_id = ?")) {
            stm.setInt(1, id);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    return new Lesson(
                            rs.getInt("lesson_id"),
                            rs.getString("lesson_name"),
                            rs.getString("youtube_link"),
                            rs.getString("attached_files"),
                            rs.getString("description"),
                            rs.getBoolean("status"),
                            new SubjectSettingDAO().getChapterById(rs.getInt("chapter_id")),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"),
                            new QuizDAO().getQuizById(rs.getInt("quiz_id")),
                            rs.getInt("lesson_type"),
                            rs.getInt("display_order"));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * Add a lesson with video type to the database
     *
     * @param name Title of the lesson
     * @param link Link of the video
     * @param content Content of the lesson
     * @param status Value of the lesson's status
     * @param chapterId ID of chapter
     * @param userId ID of user who operate the function
     * @param displayOrder Value of display order
     */
    public void addLessonWithVideo(String name, String link, String content, boolean status, int chapterId, int userId, int displayOrder) {
        String sql = "INSERT INTO cmslvl10_db.lesson (lesson_name, youtube_link, description, status, chapter_id, created_by, created_at, lesson_type, display_order) VALUES(?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, 1, ?);";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setString(1, name);
            stm.setString(2, link);
            stm.setString(3, content);
            stm.setBoolean(4, status);
            stm.setInt(5, chapterId);
            stm.setInt(6, userId);
            stm.setInt(7, displayOrder);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Add a lesson with quiz type to the database
     *
     * @param name Title of the lesson
     * @param quizId ID of the linked quiz
     * @param content Content of the lesson
     * @param status Value of the lesson's status
     * @param chapterId ID of chapter
     * @param userId ID of user who operate the function
     * @param displayOrder Value of display order
     */
    public void addLessonWithQuiz(String name, int quizId, String content, boolean status, int chapterId, int userId, int displayOrder) {
        String sql = "INSERT INTO cmslvl10_db.lesson (lesson_name, description, status, chapter_id, created_by, created_at, quiz_id, lesson_type, display_order) VALUES(?, ?, ?, ?, ?, CURRENT_TIMESTAMP, ?, 2, ?);";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setString(1, name);
            stm.setString(2, content);
            stm.setBoolean(3, status);
            stm.setInt(4, chapterId);
            stm.setInt(5, userId);
            stm.setInt(6, quizId);
            stm.setInt(7, displayOrder);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Add a lesson with assignment type to the database
     *
     * @param name Title of the lesson
     * @param file Path of the attached file
     * @param content Content of the lesson
     * @param status Value of the lesson's status
     * @param chapterId ID of chapter
     * @param userId ID of user who operate the function
     * @param displayOrder Value of display order
     */
    public void addLessonWithAssignment(String name, String file, String content, boolean status, int chapterId, int userId, int displayOrder) {
        String sql = "INSERT INTO cmslvl10_db.lesson (lesson_name, attached_files, description, status, chapter_id, created_by, created_at, lesson_type, display_order) VALUES(?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, 3, ?);";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setString(1, name);
            stm.setString(2, file);
            stm.setString(3, content);
            stm.setBoolean(4, status);
            stm.setInt(5, chapterId);
            stm.setInt(6, userId);
            stm.setInt(7, displayOrder);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Update lesson's details with assignment type
     *
     * @param name Title of the lesson
     * @param file Path of the attached file
     * @param content Content of the lesson
     * @param status Value of the lesson's status
     * @param chapterId ID of chapter
     * @param userId ID of user who operate the function
     * @param displayOrder Value of display order
     * @param lessonId ID of the lesson
     */
    public void updateLessonWithAssignment(String name, String file, String content, Boolean status, int chapterId, int userId, int displayOrder, int lessonId) {
        String sql = "UPDATE cmslvl10_db.lesson "
                + "SET lesson_name=?,"
                + " attached_files=?,"
                + " description=?,"
                + " status=?,"
                + " chapter_id=?,"
                + " updated_by=?,"
                + " updated_at=CURRENT_TIMESTAMP,"
                + " display_order=?"
                + " WHERE lesson_id=?;";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setString(1, name);
            stm.setString(2, file);
            stm.setString(3, content);
            stm.setBoolean(4, status);
            stm.setInt(5, chapterId);
            stm.setInt(6, userId);
            stm.setInt(7, displayOrder);
            stm.setInt(8, lessonId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Update lesson's details
     *
     * @param name Title of the lesson
     * @param videoLink Link of the video
     * @param attachedFile Path of the attached file
     * @param description Content of the lesson
     * @param status Value of the lesson's status
     * @param chapterId ID of chapter
     * @param managerId ID of the user who operate the function
     * @param quizId ID of the linked quiz
     * @param lessonType Value of lesson type
     * @param displayOrder Value of display order
     * @param lessonId ID of the lesson
     */
    public void updateLesson(String name, String videoLink, String attachedFile, String description, boolean status, int chapterId, int managerId, int quizId, int lessonType, int displayOrder, int lessonId) {
        String sql = "UPDATE cmslvl10_db.lesson "
                + "SET lesson_name=?,"
                + " youtube_link=" + (videoLink.equals("") ? "null," : "'" + videoLink + "',")
                + " attached_files=" + (attachedFile.equals("") ? "null," : "'" + attachedFile + "',")
                + " description=?,"
                + " status=?,"
                + " chapter_id=?,"
                + " updated_by=?,"
                + " updated_at=CURRENT_TIMESTAMP,"
                + " quiz_id=" + (quizId == -1 ? "null," : quizId + ",")
                + " lesson_type=?,"
                + " display_order=?"
                + " WHERE lesson_id=?;";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setString(1, name);
            stm.setString(2, description);
            stm.setBoolean(3, status);
            stm.setInt(4, chapterId);
            stm.setInt(5, managerId);
            stm.setInt(6, lessonType);
            stm.setInt(7, displayOrder);
            stm.setInt(8, lessonId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Delete a specific lesson
     *
     * @param lessonId ID of the lesson
     */
    public void deleteLesson(int lessonId) {
        String deleteVideoProgressSQL = "DELETE FROM cmslvl10_db.video_progress WHERE lesson_id = ?";
        String deleteLessonSQL = "DELETE FROM cmslvl10_db.lesson WHERE lesson_id = ?";

        try ( Connection connection = getConnection();  PreparedStatement deleteVideoProgressStm = connection.prepareStatement(deleteVideoProgressSQL);  PreparedStatement deleteLessonStm = connection.prepareStatement(deleteLessonSQL)) {
            // Delete related entries in video_progress table
            deleteVideoProgressStm.setInt(1, lessonId);
            deleteVideoProgressStm.executeUpdate();

            // Now delete the lesson
            deleteLessonStm.setInt(1, lessonId);
            deleteLessonStm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    //==============TRAINEE======================
    /**
     * Update the progress of the video in online learning into database
     *
     * @param videoPosition Position of last seen from user in the video
     * @param lessonId ID of the lesson
     * @param userId ID of user who learn the video lesson
     */
    public void updateVideoProgress(float videoPosition, int lessonId, int userId) {
        String sql = "UPDATE cmslvl10_db.video_progress SET video_position= ?, updated_by=?, updated_at=CURRENT_TIMESTAMP WHERE lesson_id = ? and user_id = ?;";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setFloat(1, videoPosition);
            stm.setInt(2, userId);
            stm.setInt(3, lessonId);
            stm.setInt(4, userId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Add a new progress if the user has never seen the video
     *
     * @param videoPosition Position of last seen from user in the video
     * @param lessonId ID of the lesson
     * @param userId ID of user who learn the video lesson
     */
    public void addVideoProgress(float videoPosition, int lessonId, int userId) {
        String sql = "INSERT INTO cmslvl10_db.video_progress (video_position, lesson_id, user_id, created_by, created_at) VALUES(?, ?, ?, ?, CURRENT_TIMESTAMP);";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setFloat(1, videoPosition);
            stm.setInt(2, lessonId);
            stm.setInt(3, userId);
            stm.setInt(4, userId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Get the video position from database
     *
     * @param lessonId ID of the lesson
     * @param userId ID of user who learn the video lesson
     * @return Position of the video where the user last seen
     */
    public float getVideoPosition(int lessonId, int userId) {
        String sql = "SELECT video_position FROM video_progress WHERE lesson_id = ? AND user_id = ?;";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, lessonId);
            stm.setInt(2, userId);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    return rs.getFloat(1);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    /**
     * Check if the user has ever learned the video or not
     *
     * @param lessonId ID of the lesson
     * @param userId ID of user
     * @return true if user has learned, otherwise false
     */
    public boolean getProgress(int lessonId, int userId) {
        String sql = "SELECT COUNT(*) FROM video_progress WHERE lesson_id = ? AND user_id = ?;";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, lessonId);
            stm.setInt(2, userId);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    /**
     * Get all the extra lessons created by user logging in with filter
     *
     * @param userId ID of user logging in
     * @param chapterId ID of the chapter
     * @param status value of the lesson's status
     * @param lessonName keyword for searching
     * @return List of all filtered lessons
     */
    public List<Lesson> getExtraLessons(int userId, int chapterId, int status, String lessonName) {
        List<Lesson> list = new ArrayList<>();
        String sql = "SELECT l.* "
                + "FROM lesson l "
                + "WHERE l.created_by = ? "
                + "AND chapter_id = ? "
                + "AND l.lesson_name LIKE ?";
        if (status != -1) {
            sql += " AND l.status = " + status;
        }
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, userId);
            stm.setInt(2, chapterId);
            stm.setString(3, "%" + lessonName + "%");
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Lesson lesson = new Lesson(
                            rs.getInt("lesson_id"),
                            rs.getString("lesson_name"),
                            rs.getString("youtube_link"),
                            rs.getString("attached_files"),
                            rs.getString("description"),
                            rs.getBoolean("status"),
                            new SubjectSettingDAO().getChapterById(rs.getInt("chapter_id")),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"),
                            new QuizDAO().getQuizById(rs.getInt("quiz_id")),
                            rs.getInt("lesson_type"),
                            rs.getInt("display_order"));
                    list.add(lesson);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    /**
     * Get all of lessons in the database
     *
     * @return List of all lessons
     */
    public List<Lesson> getLessons() {
        List<Lesson> list = new ArrayList<>();
        String sql = "select * from lesson ";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Lesson lesson = new Lesson(
                            rs.getInt("lesson_id"),
                            rs.getString("lesson_name"),
                            rs.getString("youtube_link"),
                            rs.getString("attached_files"),
                            rs.getString("description"),
                            rs.getBoolean("status"),
                            new SubjectSettingDAO().getChapterById(rs.getInt("chapter_id")),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"),
                            new QuizDAO().getQuizById(rs.getInt("quiz_id")),
                            rs.getInt("lesson_type"),
                            rs.getInt("display_order"));
                    list.add(lesson);
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
     * @return
     */
    public SubmittedAssignment getSmAssignmentById(int id) {
        String sql = "SELECT * FROM submitted_assignment WHERE smassignment_id = ?";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, id);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    return new SubmittedAssignment(rs.getInt("smassignment_id"),
                            rs.getString("attached_file"),
                            rs.getString("description"),
                            new AssignmentDAO().getAssignmetntById(rs.getInt("assignment_id")),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * Sort the list of lesson inputted with by order of fields
     *
     * @param lessons List of lessons need to be sorted
     * @param field Name of the field to sort
     * @param order Name of sort order
     * @return List the lessons which is sorted
     */
    public List<Lesson> sortLesson(List<Lesson> lessons, String field, String order) {
        if (field != null && order != null) {
            Comparator<Lesson> comparator = null;
            switch (field) {
                case "id":
                    comparator = Comparator.comparingInt(Lesson::getLessonId);
                    break;
                case "name":
                    comparator = Comparator.comparing(Lesson::getLessonName);
                    break;
                case "type":
                    comparator = Comparator.comparingInt(Lesson::getLessonType);
                    break;
                case "order":
                    comparator = Comparator.comparingInt(Lesson::getDisplayOrder);
                    break;
                default:
                    throw new AssertionError();
            }

            if (comparator != null) {
                if ("desc".equalsIgnoreCase(order)) {
                    comparator = comparator.reversed();
                }
                // Create a new sorted list using streams and collectors
                return lessons.stream()
                        .sorted(comparator)
                        .collect(Collectors.toList());
            }
        }
        // Return the original list if no sorting was performed
        return lessons;
    }
}
