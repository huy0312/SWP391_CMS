/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.security.SecureRandom;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


/**
 *
 * @author win
 */
public class Utils {

    public static Properties getPropertiesByFileName(String fileName) {
        Properties properties = new Properties();
        try ( InputStream inputStream = Utils.class.getClassLoader().getResourceAsStream(fileName)) {
            properties.load(inputStream);
        } catch (IOException e) {
            System.out.println(e);
        }
        return properties;
    }

    public static java.sql.Date convertStringToSqlDate(SimpleDateFormat dateFormat, String dateString) {
        try {
            java.util.Date utilDate = dateFormat.parse(dateString);
            return new java.sql.Date(utilDate.getTime());
        } catch (ParseException e) {
            e.printStackTrace();
            return null; // Handle the exception according to your needs
        }
    }
    /**
     * Sending an email to owner of @param email
     *
     * @param email location send email to
     * @param subject subject of email
     * @param text text body of email
     */
    public void sendEmail(String email, String subject, String text) {
        try {
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.mailtrap.io"); //SMTP Host
            props.put("mail.smtp.port", "587"); //TLS Port
            props.put("mail.smtp.auth", "true"); //enable authentication
            props.put("mail.smtp.starttls.enable", "true"); //enable STARTTLS

            Authenticator auth = new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(IConstant.USERNAME, IConstant.PASSWORD);
                }
            };
            Session session = Session.getInstance(props, auth);
            MimeMessage msg = new MimeMessage(session);
            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
            msg.addHeader("format", "flowed");
            msg.addHeader("Content-Transfer-Encoding", "8bit");
            msg.setSubject(subject, "UTF-8");
            msg.setText(text, "UTF-8");
            msg.setSentDate(new Date());
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email, false));
            Transport.send(msg);
        } catch (MessagingException ex) {
            Logger.getLogger(Utils.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    /**
     * Generate a random string for password purpose
     *
     * @param len Length of string
     * @return A random string with ASCII range and alphanumeric
     */
    public String generateRandomPassword(int len) {
        // ASCII range – alphanumeric (0-9, a-z, A-Z)
        final String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

        SecureRandom random = new SecureRandom();
        StringBuilder sb = new StringBuilder();

        // each iteration of the loop randomly chooses a character from the given
        // ASCII range and appends it to the `StringBuilder` instance
        for (int i = 0; i < len; i++) {
            int randomIndex = random.nextInt(chars.length());
            sb.append(chars.charAt(randomIndex));
        }

        return sb.toString();
    }
public static java.sql.Date convertStringToSqlDate(String dateString) {
        try {
            // Create a SimpleDateFormat object with the specified format
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

            // Parse the input String to obtain a java.util.Date object
            java.util.Date utilDate = sdf.parse(dateString);

            // Convert java.util.Date to java.sql.Date
            return new java.sql.Date(utilDate.getTime());
        } catch (ParseException e) {
            // Handle the ParseException if the input String is not in the expected format
            e.printStackTrace(); // You might want to handle this exception differently in a real application
            return null;
        }
    }
    
    public Date formatStringToDate(String dateString) {
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        Date date = null;
        try {
            return formatter.parse(dateString);
        } catch (ParseException ex) {
            System.out.println(ex);
        }
        return null;
    }

    public String formatDateToString(Date date) {
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        return formatter.format(date);
    }

    public String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }

    public String extractFileName(String filePath) {
        // Implement logic to extract the file name from the file path
        // For example, if the filePath is a full path, extract the last part as the name
        int lastIndex = filePath.lastIndexOf(File.separator);
        if (lastIndex != -1) {
            return filePath.substring(lastIndex + 1);
        } else {
            return filePath;
        }
    }

    public File getFolderUpload(String directory) {
        File folderUpload = new File(directory);
        if (!folderUpload.exists()) {
            folderUpload.mkdirs();
        }
        return folderUpload;
    }

    public static void main(String[] args) {
        new Utils().sendEmail("tranthetoan2003@gmail.com", "test", "test");

    }
}
