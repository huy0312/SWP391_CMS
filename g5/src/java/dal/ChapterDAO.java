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
import model.Chapter;
import model.Subject;
import model.User;
import utils.IConstant;

/**
 *
 * @author minhf
 */
public class ChapterDAO extends BaseDAO {

    /**
     *
     * @param userId
     * @param subjectId
     * @param status
     * @param chapterName
     * @return
     */
    public List<Chapter> getAllChapter(int userId, int subjectId, int status, String chapterName) {
        List<Chapter> list = new ArrayList<>();
        String sql = "SELECT * "
                + "FROM chapter c "
                + "JOIN subject s "
                + "ON c.subject_id = s.subject_id "
                + "WHERE s.manager_id =? and c.chapter_name LIKE ?  ";
        if (subjectId != -1) {
            sql += " AND s.subject_id = " + subjectId;
        }
        if (status != -1) {
            sql += " AND l.status = " + status;
        }
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, userId);
            stm.setString(2, "%" + chapterName + "%");
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Subject s = new Subject();
                    s.setSubjectId(rs.getInt("subject_id"));
                    s.setSubjectName(rs.getString("subject_name"));
                    Chapter chapter = new Chapter(
                            rs.getInt("chapter_id"),
                            rs.getString("chapter_name"),
                            s,
                            rs.getBoolean("status"),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"));
                    list.add(chapter);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    /**
     *
     * @return @throws SQLException
     */
    public List<Chapter> getChapterLists(int userId) throws SQLException {
        List<Chapter> list = new ArrayList<>();
        String sql = "SELECT * "
                + "FROM chapter c "
                + "JOIN subject s "
                + "ON c.subject_id = s.subject_id"
                + "where s.status = 1 and s.manager_id = ? ";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
              stm.setInt(1, userId);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Subject s = new Subject();
                    s.setSubjectId(rs.getInt("subject_id"));
                    s.setSubjectName(rs.getString("subject_name"));
                    Chapter chapter = new Chapter(
                            rs.getInt("chapter_id"),
                            rs.getString("chapter_name"),
                            s,
                            rs.getBoolean("status"),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"));
                    list.add(chapter);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public List<Chapter> getChapterList() throws SQLException {
        List<Chapter> list = new ArrayList<>();
        String sql = "SELECT * "
                + "FROM chapter c "
                + "JOIN subject s "
                + "ON c.subject_id = s.subject_id";
             
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
          
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Subject s = new Subject();
                    s.setSubjectId(rs.getInt("subject_id"));
                    s.setSubjectName(rs.getString("subject_name"));
                    Chapter chapter = new Chapter(
                            rs.getInt("chapter_id"),
                            rs.getString("chapter_name"),
                            s,
                            rs.getBoolean("status"),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"));
                    list.add(chapter);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }


    /**
     *
     * @return
     */

    public List<Chapter> getChapter() {
        List<Chapter> list = new ArrayList<>();
        String sql = "select * from chapter";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Subject s = new Subject();
                    s.setSubjectId(rs.getInt("subject_id"));
                    s.setSubjectName(rs.getString("subject_name"));
                    Chapter chapter = new Chapter(
                            rs.getInt("chapter_id"),
                            rs.getString("chapter_name"),
                            s,
                            rs.getBoolean("status"),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"));
                    list.add(chapter);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    /**
     *
     * @param chapterName
     * @param subjectId
     */
    public void addChapter(String chapterName, int subjectId) {
        String sql = IConstant.ADD_CHAPTER_QUERY;
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            int Id = new UserDAO().getManagerId();
            stm.setString(1, chapterName);
            stm.setInt(2, subjectId);
            stm.setInt(3, Id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *
     * @param chapterId
     * @param chapterName
     * @param subjectId
     * @param status
     */
    public void updateChapter(int chapterId, String chapterName, int subjectId, int status) {
        String sql = IConstant.UPDATE_CHAPTER_QUERY;
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, chapterName);
            stm.setInt(2, subjectId);
            stm.setInt(3, status);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *
     * @param id
     * @param status
     * @param managerId
     */
    public void updateChapterStatus(int id, Boolean status, int managerId) {
        String sql = "UPDATE cmslvl10_db.`chapter` SET status = ?, updated_by = ?, updated_at=CURRENT_TIMESTAMP WHERE chapter_id = ?;";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setBoolean(1, status);
            stm.setInt(2, managerId);
            stm.setInt(3, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *
     * @param userId
     * @return
     */
    public List<Subject> getAllSubjects(int userId) {
        List<Subject> list = new ArrayList<>();
        String sql = "select * from subject s where s.manager_id = ? ";
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
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    /**
     *
     * @param chapterId
     * @return
     */
    public Chapter getChapterById(int chapterId) {
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement("SELECT * FROM chapter WHERE chapter_id = ?")) {
            stm.setInt(1, chapterId);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    return new Chapter(
                            rs.getInt("chapter_id"),
                            rs.getString("chapter_name"),
                            new SubjectDAO().getSubjectById(rs.getInt("subject_id")),
                            rs.getBoolean("status"),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     *
     * @param chapters
     * @param page
     * @param itemsPerPage
     * @return
     */
    public List<Chapter> paginateChapter(List<Chapter> chapters, int page, int itemsPerPage) {
        int startIndex = (page - 1) * itemsPerPage;
        int endIndex = Math.min(startIndex + itemsPerPage, chapters.size());
        return chapters.subList(startIndex, endIndex);
    }

    /**
     *
     * @param subjectId
     * @param userId
     * @return
     */
    public List<Chapter> getChapterBySubject(int subjectId, int userId) {
        List<Chapter> list = new ArrayList<>();
        String sql = "select * from chapter c inner join subject s "
                + "on c.subject_id = s.subject_id "
                + "where c.status = 1 and s.manager_id = ?";
        if (subjectId != -1) {
            sql += " and s.subject_id = " + subjectId;
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
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public int getFirstChapterId(int subjectId) {
        String sql = "SELECT chapter_id FROM chapter "
                + "WHERE status = 1 and "
                + "subject_id = ? and "
                + "display_order = "
                + "(select min(display_order) "
                + "from chapter where status = 1)";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, subjectId);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }
    
    public List<Chapter> getChapterBySubject(int subjectId) {
        List<Chapter> list = new ArrayList<>();
        String sql = "select * from chapter "
                + "where status = 1 and subject_id = ? order by display_order asc";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, subjectId);
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
            Logger.getLogger(ChapterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
}
