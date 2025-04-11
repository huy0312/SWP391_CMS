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
import model.User;
import utils.IConstant;

/**
 *
 * @author win
 */
public class UserDAO extends BaseDAO {

    /**
     * Perform update user's detailed information operation by admin
     *
     * @param fullName Property full name of user
     * @param email Property email of user
     * @param mobile Property mobile of user
     * @param status Property status of user
     * @param roleId user's role ID
     * @param userId ID of user which is updated
     * @param description
     */
    public void updateUser(String fullName, String email, String mobile, int status, int roleId, int userId, String description) {
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(IConstant.UPDATE_USER_QUERY)) {
            stm.setString(1, fullName);
            stm.setString(2, email);
            stm.setString(3, mobile);
            stm.setInt(4, status);
            stm.setInt(5, getAdminId());
            stm.setInt(6, roleId);
            stm.setString(7, description);
            stm.setInt(8, userId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Get all of users in database
     * @return list of all users
     */
       

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
      public List<User> getManegerList() {
        List<User> list = new ArrayList<>();
        SettingDAO sdao = new SettingDAO();
        String sql ="SELECT * FROM user where role_id =2";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);  ResultSet rs = stm.executeQuery()) {
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

    /**
     * Perform add a new user operation by admin
     *
     * @param fullName Property full name of user
     * @param password Property password of user
     * @param email Property email of user
     * @param mobile Property mobile of user
     * @param status
     */
    public void addUser(String fullName, String password, String email, String mobile, int status) {
        int id = getAdminId();
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(IConstant.ADD_USER_QUERY);) {
            stm.setString(1, fullName);
            stm.setString(2, password);
            stm.setString(3, email);
            stm.setString(4, mobile);
            stm.setInt(5, status);
            stm.setInt(6, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Get number of users in the system
     * 
     * @return number of users
     */
    public int countUser() {
        String sql = "SELECT COUNT(*) FROM user";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);  ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    /**
     * Update the user's status
     * 
     * @param status Value of user's status
     * @param userId ID of the user
     */
    public void updateUserStatus(Boolean status, int userId) {
        int id = getAdminId();
        String sql = "UPDATE cmslvl10_db.`user` SET status=?, updated_by=?, updated_at=CURRENT_TIMESTAMP WHERE user_id=?;";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);) {
            stm.setBoolean(1, status);
            stm.setInt(2, id);
            stm.setInt(3, userId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Get all users with filter
     * 
     * @param searchTerm Keyword for searching
     * @param status Value of user's status
     * @param roleId ID of role
     * @return List of all users which is filtered
     */
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

    /**
     * Paginate list of users inputted
     * 
     * @param users List of users which need to be paginated
     * @param page no of page
     * @param itemsPerPage number of items per page
     * @return List of users which is paginated
     */
    public List<User> paginateRecords(List<User> users, int page, int itemsPerPage) {
        int startIndex = (page - 1) * itemsPerPage;
        int endIndex = Math.min(startIndex + itemsPerPage, users.size());
        return users.subList(startIndex, endIndex);
    }

    /**
     * get UserID of user who is Administrator
     *
     * @return ID of Administrator in User table, -1 if not exists
     */
    public int getAdminId() {
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(IConstant.SELECT_ADMIN_QUERY);  ResultSet rs = stm.executeQuery()) {

            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    /**
     * Get the ID of Subject Manager role in Setting table
     * 
     * @return ID of Subject Manager role
     */
    public int getManagerId() {
        String sql = "select user_id  from `user` u where role_id = 2;";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);  ResultSet rs = stm.executeQuery()) {

            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }
    
     public int getTrainerId() {
        String sql = "select user_id  from `user` u where role_id = 3;";
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(sql);  ResultSet rs = stm.executeQuery()) {

            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    /**
     * Check whether the email and password entered is valid for logging in
     * 
     * @param email Email entered from user
     * @param password Password of user
     * @return An User if log in successfully, otherwise null
     */
    public User checkLogin(String email, String password) {
        SettingDAO sdao = new SettingDAO();
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(IConstant.CHECK_LOGIN_QUERY)) {

            stm.setString(1, email);
            stm.setString(2, password);
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
                            sdao.getSettingById(rs.getInt("role_id")),
                            rs.getInt("created_by"),
                            rs.getDate("created_at"),
                            rs.getInt("updated_by"),
                            rs.getDate("updated_at"));
                    return user;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * Reset the password when user forgot password
     * 
     * @param password New password
     * @param userId ID of user
     */
    public void resetPassword(String password, int userId) {
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(IConstant.RESET_PASSWORD_QUERY)) {

            stm.setString(1, password);
            stm.setInt(2, userId);
            stm.setInt(3, userId);
            stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *  get the ID of user by Email
     * 
     * @param email Email of user
     * @return ID of user
     */
    public int getUserIdByEmail(String email) {
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement(IConstant.SELECT_USERID_BYEMAIL);  ResultSet rs = stm.executeQuery()) {

            stm.setString(1, email);
            while (rs.next()) {
                return rs.getInt("user_id");
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    /**
     *  Get a specific user by ID
     * 
     * @param id ID of user
     * @return An User if exists, otherwise null
     */
    public User getUserById(int id) {
        try ( Connection connection = getConnection();  PreparedStatement stm = connection.prepareStatement("SELECT * FROM user WHERE user_id = ?")) {
            stm.setInt(1, id);
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
                    return user;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    /**
     * Sort the list of users inputted by order by fields
     * @param users List of users which need to be sorted
     * @param field Name of field to sort
     * @param order Name of order to sort
     * @return List of users which is sorted
     */
    public List<User> sortUsers(List<User> users, String field, String order) {
        if (field != null && order != null) {
            Comparator<User> comparator = null;
            switch (field) {
                case "id":
                    comparator = Comparator.comparingInt(User::getUserId);
                    break;
                case "role":
                    comparator = Comparator.comparingInt(u -> u.getRole().getSettingId());
                    break;
                case "name":
                    comparator = Comparator.comparing(User::getFullName);
                    break;
                case "email":
                    comparator = Comparator.comparing(User::getEmail);
                    break;
                case "mobile":
                    comparator = Comparator.comparing(User::getMobile);
                    break;
                default:
                    throw new AssertionError();
            }
            if (comparator != null) {
                if ("desc".equalsIgnoreCase(order)) {
                    comparator = comparator.reversed();
                }
                // Create a new sorted list using streams and collectors
                return users.stream()
                        .sorted(comparator)
                        .collect(Collectors.toList());
            }
        }
        // Return the original list if no sorting was performed
        return users;
    }
    public static void main(String[] args) {
       UserDAO u = new UserDAO();
        System.out.println(  u.getManegerList());
    }
}
