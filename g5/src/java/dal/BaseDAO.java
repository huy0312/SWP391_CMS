package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import utils.Utils;

public class BaseDAO {

    public static Connection getConnection() throws SQLException {
        try {
            Properties properties = Utils.getPropertiesByFileName("utils/const.properties");
            String user = properties.getProperty("db.user");
            String pass = properties.getProperty("db.password");
            String url = properties.getProperty("db.url");
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(BaseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public static void main(String[] args) throws SQLException {
        Connection conn = getConnection();
        if (conn != null) {
            System.out.println("Connect successfully");
        } else {
            System.out.println("Connect failed");
        }
    }
}
