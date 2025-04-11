/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package utils;

/**
 *
 * @author win
 */
public interface IConstant {

    // QUERY
    String SELECT_ALL_USER_QUERY = "SELECT * FROM user";
    String DELETE_USER_QUERY = "DELETE FROM cmslvl10_db.`user` WHERE user_id=?;";
    String UPDATE_USER_QUERY = "UPDATE cmslvl10_db.`user` SET full_name= ?, email= ?, phone_number= ?, status= ?, updated_by=?, updated_at=CURRENT_TIMESTAMP, role_id= ?, description = ? WHERE user_id= ?;";
    String ADD_USER_QUERY = "INSERT INTO cmslvl10_db.`user` (full_name, password, email, phone_number, status, avatar_image, created_by, role_id) VALUES(?, ?, ?, ?, ?, './view/assets/img/icon-user-default.png', ?, 4);";
    String SELECT_ADMIN_QUERY = "select user_id  from `user` u where role_id = 1;";
    String SELECT_USER_QUERY = "select SQL_CALC_FOUND_ROWS u.* from user u  join setting s on u.role_id = s.setting_id where u.full_name like ? or u.email like ? or u.phone_number like ? order by s.display_order asc limit ?,?";
    String SELECT_SETTING_BYID_QUERY = "SELECT * FROM cmslvl10_db.setting WHERE setting_id=?;";
    String SELECT_SETTINGID_BYNAME_QUERY = "SELECT setting_id FROM cmslvl10_db.setting where setting_name = ?;";
    String UPDATE_SETTING_QUERY = "UPDATE cmslvl10_db.setting\n"
            + "SET setting_group=?, setting_name=?, setting_value=?, description=?, status=?, updated_at=CURRENT_TIMESTAMP\n"
            + "WHERE setting_id=?;";
    String ADD_SETTING_QUERY = "INSERT INTO cmslvl10_db.setting (setting_group, setting_name, setting_value, display_order, description, status, created_by) VALUES( ?, ?, ?, ?, ?, 1, ?)";
    String RESET_PASSWORD_QUERY = "UPDATE cmslvl10_db.`user` SET password= ?, updated_by= ?, updated_at=CURRENT_TIMESTAMP WHERE user_id= ?;";
    String SELECT_USERID_BYEMAIL = "SELECT user_id FROM cmslvl10_db.`user` WHERE email = ?";
    String CHECK_LOGIN_QUERY = "Select * from User where email =? and password =?";
    String GET_SEMESTER_QUERY = "SELECT SQL_CALC_FOUND_ROWS *  FROM cmslvl10_db.setting  where setting_group = 'Semester'";
    String ADD_SEMESTER_QUERY = "INSERT INTO cmslvl10_db.setting (setting_group, setting_name, setting_value, display_order, description, status, created_by) VALUES( 'Semester', ?, ?, ?, ?, 1, ?)";
    String GET_NOOFSEMESTER_QUERY = "select count(*) as no from cmslvl10_db.setting where setting_group like 'Semester';";
    String UPDATE_SEMESTER_QUERY = "UPDATE cmslvl10_db.setting SET setting_name=?,setting_value=?, description=?, status=?, updated_at=CURRENT_TIMESTAMP WHERE setting_id=?";
    String GET_SETTINGBYROLE_QUERY = "SELECT * FROM cmslvl10_db.setting where setting_group = 'Role'";
    String SELECT_SUBJECT_QUERY = "select SQL_CALC_FOUND_ROWS *  from `subject` u \n"
            + "cross join `user` u2 on u2.user_id = u.manager_id \n"
            + "where subject_code like ? or subject_name like ? limit ?,?;";
    String SELECT_SUBJECTMANAGER_QUERY = "SELECT * FROM cmslvl10_db.`user` where role_id = 2";
    String SELECT_ALL_SUBJECT_QUERY = "SELECT s.subject_id, s.subject_code, s.subject_name,u.user_id ,u.full_name, s.status, s.description\n"
            + "FROM cmslvl10_db.subject s \n"
            + "cross join user u on u.user_id  = s.manager_id;";
    String SELECT_SETTING_QUERY = "select SQL_CALC_FOUND_ROWS *  from `setting` s \n"
            + "where setting_group like ? or setting_name like ? limit ?,?;";
    String ADD_SUBJECT_QUERY = "INSERT INTO cmslvl10_db.subject(subject_code, subject_name, manager_id, status, created_by, created_at,description)VALUES(?,?,?,0,?, CURRENT_TIMESTAMP,?);";
    String UPDATE_SUBJECT_QUERY = "UPDATE cmslvl10_db.subject SET subject_code= ?, subject_name= ?, manager_id=?,  updated_by= ?, updated_at=CURRENT_TIMESTAMP,description=? WHERE subject_id= ?;";
    String DELETE_SUBJECT_QUERY = "DELETE FROM cmslvl10_db.subject WHERE subject_id=?;";
    String SELECT_ALL_CLASS_QUERY = "SELECT class_id, class_code, semester_id, subject_id, manager_id, status, created_by, created_at, updated_by, updated_at FROM cmslvl10_db.class;";
    String DELETE_CLASS_QUERY = "DELETE FROM cmslvl10_db.class WHERE class_id=?;";
    String ADD_CLASS_QUERY = "INSERT INTO cmslvl10_db.class( class_code, semester_id, subject_id, manager_id, status, created_by, created_at)VALUES(?, ?, ?, ?, 0, ?, CURRENT_TIMESTAMP);";
    String UPDATE_CLASS_QUERY = "UPDATE cmslvl10_db.class SET class_code=?, semester_id=?, subject_id=?, manager_id=?, status=?, updated_by=?, updated_at=CURRENT_TIMESTAMP WHERE class_id=?;";
    String SELECT_CLASS_QUERY = "select SQL_CALC_FOUND_ROWS *  from `class` c \n"
            + "                                  cross join subject s on s.subject_id  = c.subject_id \n"
            + "                                  cross join `user` u on u.user_id = c.manager_id \n"
            + "                                  cross join `setting` st on st.setting_id  = c.semester_id  \n"
            + "                                  where c.class_code like ? limit ?,?;";
    String UPDATE_CHAPTER_QUERY = "UPDATE cmslvl10_db.chapter\n"
            + "SET chapter_name='', subject_id=0, status=0, created_by=0, created_at=CURRENT_TIMESTAMP, updated_by=0, updated_at=CURRENT_TIMESTAMP\n"
            + "WHERE chapter_id=?;";
    String ADD_CHAPTER_QUERY = "INSERT INTO cmslvl10_db.chapter\n"
            + "( chapter_name, subject_id, status, created_by, created_at)\n"
            + "VALUES( ?, ?, 0, ?, CURRENT_TIMESTAMP);";
    String SELECT_CHAPTER_QUERY = "select SQL_CALC_FOUND_ROWS *  from `chapter` c \n"
            + "cross join subject s on s.subject_id  = c.subject_id \n"
            + "where chapter_name like ? limit ?,?;";
    String SELECT_ALL_CHAPTER_QUERY = "SELECT chapter_id, chapter_name, subject_id, status, created_by, created_at, updated_by, updated_at\n"
            + "FROM cmslvl10_db.chapter;";
//   String SELECT_ALL_DIMENSION_QUERY = ""
//   String SELECT_ALL_CHAPTER_QUERY = "SELECT FROM  cmslvl10_db.chapter c ";
    public static String SELECT_ONE_USER_QUERY = "SELECT * FROM user Where user_id = ?";
    public static String CHANGE_PHOTO_QUERY = "UPDATE user SET avatar_image = ?, updated_by= ?, updated_at=CURRENT_TIMESTAMP WHERE user_id = ?";
    public static String UPDATE_USER_INFORMATION_QUERY = "UPDATE user SET full_name = ?, phone_number = ?, updated_by= ?, updated_at=CURRENT_TIMESTAMP WHERE user_id = ?";
    public static String GET_DOMAIN_QUERY = "SELECT SQL_CALC_FOUND_ROWS *  FROM cmslvl10_db.setting  where setting_group = 'Domain'";
    public static String UPDATE_DOMAIN_QUERY = "UPDATE cmslvl10_db.setting SET setting_name=?,setting_value=?, description=?, status=?, updated_at=CURRENT_TIMESTAMP WHERE setting_id=?";

    // LOGIN VIA GOOGLE KEY
    public static String GOOGLE_CLIENT_ID = "";
    public static String GOOGLE_CLIENT_SECRET = "";
    public static String GOOGLE_REDIRECT_URI = "http://localhost:8080/CMSLVL10/login-google";
    public static String GOOGLE_LINK_GET_TOKEN = "https://accounts.google.com/o/oauth2/token";
    public static String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";
    public static String GOOGLE_GRANT_TYPE = "authorization_code";

    // SENDING EMAIL
    public static String USERNAME = "748d65ba803ee9";
    public static String PASSWORD = "9691ea378b7c75";
    public static String STMPHOST = "smtp.mailtrap.io";
    public static int SMTPPORT = 587;
//    public static String FROMEMAIL = "toantthe170909@fpt.edu.vn";

}
