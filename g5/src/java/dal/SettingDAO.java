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
import model.Setting;
import model.User;
import utils.IConstant;

public class SettingDAO extends BaseDAO {

    private int noOfRecords;

    public Setting getSettingById(int id) {
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(IConstant.SELECT_SETTING_BYID_QUERY)) {
            stm.setInt(1, id);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    return new Setting(
                            rs.getInt("setting_id"),
                            rs.getString("setting_group"),
                            rs.getString("setting_name"),
                            rs.getString("setting_value"),
                            rs.getString("description"),
                            rs.getBoolean("status"),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at")
                    );
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public int getSettingIdByName(String name) {
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(IConstant.SELECT_SETTINGID_BYNAME_QUERY)) {
            stm.setString(1, name);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    return rs.getInt("setting_id");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    public int getNoOfRecords() {
        return noOfRecords;
    }

    public List<User> getUsers(String searchTerm, int status, int roleId) {
        List<User> list = new ArrayList<>();
        String sql = "select u.* "
                + "from user u  join setting s "
                + "on u.role_id = s.setting_id "
                + "where (full_name LIKE ? OR email LIKE ? OR phone_number LIKE ?)";
        if (status != -1) {
            sql += " AND u.status = " + status;
        }
        if (roleId != -1) {
            sql += " AND u.role_id = " + roleId;
        }
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            searchTerm = "%" + searchTerm + "%";
            stm.setString(1, searchTerm);
            stm.setString(2, searchTerm);
            stm.setString(3, searchTerm);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    User user = new User(rs.getInt("user_id"),
                            rs.getString("full_name"),
                            rs.getString("password"),
                            rs.getString("email"),
                            rs.getString("phone_number"),
                            rs.getBoolean("status"),
                            rs.getString("avatar_image"),
                            rs.getString("description"),
                            new SettingDAO().getSettingById(rs.getInt("role_id")),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"));
                    list.add(user);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Setting> getSettings(String searchTerm, int status, int settingId) {
        List<Setting> list = new ArrayList<>();
        String sql = "select s.* "
                + "from setting s "
                + "where (setting_group Like ? or setting_name Like ?)";
        if (status != -1) {
            sql += " AND s.status = " + status;
        }
        if (settingId != -1) {
            sql += " AND s.setting_id = " + settingId;
        }
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            searchTerm = "%" + searchTerm + "%";
            stm.setString(1, searchTerm);
            stm.setString(2, searchTerm);

            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Setting setting = new Setting(
                            rs.getInt("setting_id"),
                            rs.getString("setting_group"),
                            rs.getString("setting_name"),
                            rs.getString("setting_value"),
                            rs.getString("description"),
                            rs.getBoolean("status"),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at")
                    );
                    list.add(setting);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    

    public List<Setting> getSettingByRole() {
        List<Setting> list = new ArrayList<>();
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(IConstant.GET_SETTINGBYROLE_QUERY);  ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                Setting setting = new Setting(
                        rs.getInt("setting_id"),
                        rs.getString("setting_group"),
                        rs.getString("setting_name"),
                        rs.getString("setting_value"),
                        rs.getString("description"),
                        rs.getBoolean("status"),
                        rs.getInt("created_by"),
                        rs.getDate("created_at"),
                        rs.getInt("updated_by"),
                        rs.getDate("updated_at")
                );
                list.add(setting);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<User> getUserList() {
        List<User> list = new ArrayList<>();
        SettingDAO sdao = new SettingDAO();

        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(IConstant.SELECT_ALL_USER_QUERY);  ResultSet rs = stm.executeQuery()) {

            while (rs.next()) {
                User user = new User(rs.getInt("user_id"),
                        rs.getString("full_name"),
                        rs.getString("password"),
                        rs.getString("email"),
                        rs.getString("phone_number"),
                        rs.getBoolean("status"),
                        rs.getString("avatar_image"),
                        rs.getString("description"),
                        sdao.getSettingById(rs.getInt("role_id")),
                        rs.getInt("created_by"),
                        rs.getDate("created_at"),
                        rs.getInt("updated_by"),
                        rs.getDate("updated_at"));
                list.add(user);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Setting> getSetting() {
        List<Setting> list = new ArrayList<>();
        String sql = "select * from setting ";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Setting setting = new Setting(
                            rs.getInt("setting_id"),
                            rs.getString("setting_group"),
                            rs.getString("setting_name"),
                            rs.getString("setting_value"),
                            rs.getString("description"),
                            rs.getBoolean("status"),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at")
                    );
                    list.add(setting);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Setting> sortSettings(List<Setting> settings, String field, String order) {
        if (field != null && order != null) {
            Comparator<Setting> comparator = null;
            switch (field) {
                case "settingId":
                    comparator = Comparator.comparingInt(Setting::getSettingId);
                    break;               
                case "settingGroup":
                    comparator = Comparator.comparing(Setting::getSettingGroup);
                    break;
                case "settingName":
                    comparator = Comparator.comparing(Setting::getSettingName);
                    break;
                case "settingValue":
                    comparator = Comparator.comparing(Setting::getSettingValue);
                    break;
                default:
                    throw new AssertionError();
            }
            if (comparator != null) {
                if ("desc".equalsIgnoreCase(order)) {
                    comparator = comparator.reversed();
                }
                // Create a new sorted list using streams and collectors
                return settings.stream()
                        .sorted(comparator)
                        .collect(Collectors.toList());
            }
        }
        // Return the original list if no sorting was performed
        return settings;
    }

    public void addSetting(String settingGroup, String settingName, String settingValue, String description, int status) {
        int admin_id = new UserDAO().getAdminId();
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(IConstant.ADD_SETTING_QUERY)) {
            stm.setString(1, settingGroup);
            stm.setString(2, settingName);
            stm.setString(3, settingValue);
            stm.setString(4, description);
            stm.setInt(5, status);
            stm.setInt(6, admin_id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<Setting> paginateRecords(List<Setting> settings, int page, int itemsPerPage) {
        int startIndex = (page - 1) * itemsPerPage;
        int endIndex = Math.min(startIndex + itemsPerPage, settings.size());
        return settings.subList(startIndex, endIndex);
    }

    public int getNoOfSemester() {
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(IConstant.GET_NOOFSEMESTER_QUERY);  ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                return rs.getInt("no");
            }
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    public void updateSetting(String settingGroup, String settingName, String settingValue, String description, int status, int setting_id) {
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(IConstant.UPDATE_SETTING_QUERY)) {
            stm.setString(1, settingGroup);
            stm.setString(2, settingName);
            stm.setString(3, settingValue);
            stm.setString(4, description);
            stm.setInt(5, status);
            stm.setInt(6, setting_id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Get list of setting by Domain
     *
     * @return List of Domain
     */
    public List<Setting> getSettingByDomain() {
        SettingDAO sdao = new SettingDAO();
        List<Setting> list = new ArrayList<>();
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(IConstant.GET_DOMAIN_QUERY);  ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                Setting setting = new Setting(rs.getInt("setting_id"),
                        rs.getString("setting_group"),
                        rs.getString("setting_name"),
                        rs.getString("setting_value"),
                        rs.getString("description"),
                        rs.getBoolean("status"),
                        rs.getInt("created_by"),
                        rs.getDate("created_at"),
                        rs.getInt("updated_by"),
                        rs.getDate("updated_at"));
                list.add(setting);

            }
            try ( ResultSet countRs = stm.executeQuery("SELECT FOUND_ROWS()")) {
                if (countRs.next()) {
                    this.noOfRecords = countRs.getInt(1);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public List<Setting> getSemester() {
        List<Setting> list = new ArrayList<>();
        String sql = "select * from setting where setting_group = 'Semester'";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql)) {
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Setting setting = new Setting(
                            rs.getInt("setting_id"),
                            rs.getString("setting_group"),
                            rs.getString("setting_name"),
                            rs.getString("setting_value"),
                            rs.getString("description"),
                            rs.getBoolean("status"),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at")
                    );
                    list.add(setting);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public void updateDomain(String setting_name, String setting_value, String description, int status, int setting_id) {
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(IConstant.UPDATE_DOMAIN_QUERY)) {
            stm.setString(1, setting_name);
            stm.setString(2, setting_value);
            stm.setString(3, description);
            stm.setInt(4, status);
            stm.setInt(5, setting_id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
  
   

   
}
