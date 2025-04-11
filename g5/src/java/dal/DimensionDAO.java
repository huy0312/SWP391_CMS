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
import model.Dimension;
import model.Subject;
import model.User;
///**
// *
// * @author minhf
// */

public class DimensionDAO extends BaseDAO {

    /**
     *
     * @param userId
     * @param subjectId
     * @param status
     * @param dimensionTpe
     * @param dimensionName
     * @return
     */
    public List<Dimension> getAllDimension(int userId, int subjectId, int status, String dimensionTpe, String dimensionName) {
        List<Dimension> list = new ArrayList<>();
        String sql = "SELECT * FROM dimension d JOIN subject s ON d.subject_id = s.subject_id  WHERE s.manager_id =? AND d.dimension_name LIKE ?";
        if (subjectId != -1) {
            sql += " AND s.subject_id = " + subjectId;
        }
        if (status != -1) {
            sql += " AND d.status = " + status;
        }
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, userId);
            stm.setString(2, "%" + dimensionName + "%");
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Subject s = new Subject();
                    s.setSubjectId(rs.getInt("subject_id"));
                    s.setSubjectName(rs.getString("subject_name"));
                    Dimension dimension = new Dimension(
                            rs.getInt("dimension_id"),
                            rs.getString("dimension_type"),
                            rs.getString("dimension_name"),
                            rs.getString("description"),
                            s,
                            rs.getBoolean("status"),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"));
                    list.add(dimension);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DimensionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    /**
     *
     * @param dimensionId
     * @return
     */
    public Dimension getDimensionById(int dimensionId) {
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement("SELECT * FROM dimension WHERE dimension_id = ?")) {
            stm.setInt(1, dimensionId);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    return new Dimension(
                            rs.getInt("dimension_id"),
                            rs.getString("dimension_type"),
                            rs.getString("dimension_name"),
                            rs.getString("description"),
                            new SubjectDAO().getSubjectById(rs.getInt("subject_id")),
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
     * @return
     */
    public List<Dimension> getDimensionList() {
        List<Dimension> list = new ArrayList<>();
        String sql = "SELECT * FROM dimension d JOIN subject s ON d.subject_id = s.subject_id";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Subject s = new Subject();
                    s.setSubjectId(rs.getInt("subject_id"));
                    s.setSubjectName(rs.getString("subject_name"));
                    Dimension dimension = new Dimension(
                            rs.getInt("dimension_id"),
                            rs.getString("dimension_type"),
                            rs.getString("dimension_name"),
                            rs.getString("description"),
                            s,
                            rs.getBoolean("status"),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"));
                    list.add(dimension);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DimensionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    /**
     *
     * @param dimensionType
     * @param dimensionName
     * @param description
     * @param subjectId
     */
    public void addDimension(String dimensionType, String dimensionName, String description, int subjectId) {
        String sql = "INSERT INTO cmslvl10_db.dimension( dimension_type, dimension_name, description, subject_id, status, created_by, created_at)VALUES( ?, ?, ?, ?, 0,? , CURRENT_TIMESTAMP);";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            int Id = new UserDAO().getManagerId();
            stm.setString(1, dimensionType);
            stm.setString(2, dimensionName);
            stm.setString(3, description);
            stm.setInt(4, subjectId);
            stm.setInt(5, Id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DimensionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *
     * @param dimensionId
     * @param dimensionType
     * @param dimensionName
     * @param description
     * @param subjectId
     * @param status
     */
    public void updateDimension(int dimensionId, String dimensionType, String dimensionName, String description, int subjectId, int status) {
        String sql = "UPDATE cmslvl10_db.dimension\n"
                + "SET dimension_type=?, dimension_name=?, description=?, subject_id=?, status=? updated_by=?, updated_at=CURRENT_TIMESTAMP\n"
                + "WHERE dimension_id=?;";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            int Id = new UserDAO().getManagerId();
            stm.setString(1, dimensionType);
            stm.setString(2, dimensionName);
            stm.setString(3, description);
            stm.setInt(4, subjectId);
            stm.setInt(5, status);
            stm.setInt(6, Id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DimensionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *
     * @param id
     * @param status
     * @param managerId
     */
    public void updateDimensionStatus(int id, Boolean status, int managerId) {
        String sql = "UPDATE cmslvl10_db.`dimension` SET status = ?, updated_by = ?, updated_at=CURRENT_TIMESTAMP WHERE dimension_id = ?;";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setBoolean(1, status);
            stm.setInt(2, managerId);
            stm.setInt(3, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DimensionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *
     * @param dimension
     * @param page
     * @param itemsPerPage
     * @return
     */
    public List<Dimension> paginateDimension(List<Dimension> dimension, int page, int itemsPerPage) {
        int startIndex = (page - 1) * itemsPerPage;
        int endIndex = Math.min(startIndex + itemsPerPage, dimension.size());
        return dimension.subList(startIndex, endIndex);
    }

    /**
     * 
     * @param subjectId
     * @param userId
     * @return 
     */
    public List<Dimension> getDimensionBySubject(int subjectId, int userId) {
        List<Dimension> list = new ArrayList<>();
        String sql = "select * from dimension d inner join subject s "
                + "on d.subject_id = s.subject_id "
                + "where s.manager_id = ?";
        if (subjectId != -1) {
            sql += " and s.subject_id = " + subjectId;
        }
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, userId);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Dimension dimension = new Dimension(
                            rs.getInt("dimension_id"),
                            rs.getString("dimension_type"),
                            rs.getString("dimension_name"),
                            rs.getString("description"),
                            new SubjectDAO().getSubjectById(rs.getInt("subject_id")),
                            rs.getBoolean("status"),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"));
                    list.add(dimension);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DimensionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
}
