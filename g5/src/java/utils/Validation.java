/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import dal.ChapterDAO;
import dal.ClassDAO;
import dal.DimensionDAO;
import dal.QuizDAO;
import model.Quiz;
import dal.LessonDAO;
import dal.QuestionDAO;
import dal.SettingDAO;
import dal.SubjectDAO;
import dal.UserDAO;
import java.sql.SQLException;
import java.util.List;
import model.Chapter;
import model.Dimension;
import model.Lesson;
import model.Question;
import model.Setting;
import model.Subject;
import model.User;

/**
 *
 * @author win
 */
public class Validation {

    /**
     * Check if user inserted is collied or not
     *
     * @param email : email property of user
     * @param mobile : phone_number property of user
     * @return True if collied, otherwise False
     */
    public boolean isColliedUser(String email, String mobile) {
        if (email == null || mobile == null) {
            return false; // Handle null parameters gracefully
        }
        UserDAO udao = new UserDAO();
        List<User> list = udao.getUserList();
        for (User user : list) {
            if (email.equalsIgnoreCase(user.getEmail())) {
                // Check if the email matches (case-insensitive)
                return true;
            }
            String userMobile = user.getMobile();
            if (userMobile != null && userMobile.equals(mobile)) {
                // Check if the mobile matches (null-safe)
                return true;
            }
        }
        return false;
    }

    /**
     *
     * @param email
     * @param mobile
     * @param originalEmail
     * @param originalMobile
     * @return
     */
    public boolean isColliedUser(String email, String mobile, String originalEmail, String originalMobile) {
        if (email == null || mobile == null) {
            return false; // Handle null parameters gracefully
        }
        // If either the email or mobile has changed, check for collisions
        if (!email.equalsIgnoreCase(originalEmail) || !mobile.equals(originalMobile)) {
            UserDAO udao = new UserDAO();
            List<User> list = udao.getUserList();
            for (User user : list) {
                if (!email.equalsIgnoreCase(originalEmail) && email.equalsIgnoreCase(user.getEmail())) {
                    // Check if the email has changed and collides (case-insensitive)
                    return true;
                }
                if (!mobile.equals(originalMobile)) {
                    String userMobile = user.getMobile();
                    if (userMobile != null && userMobile.equals(mobile)) {
                        // Check if the mobile has changed and collides (null-safe)
                        return true;
                    }
                }
            }
        }
        return false;
    }

    public boolean isColliedSetting(String settingName) {
        if (settingName == null) {
            return false;
        }
        SettingDAO sdao = new SettingDAO();
        List<Setting> list = sdao.getSetting();
        for (Setting setting : list) {
            if (settingName.equalsIgnoreCase(setting.getSettingName())) {

                return true;
            }
        }
        return false;
    }

    public boolean isColliedSetting(String settingName, boolean isAdd, boolean status) {
        SettingDAO sdao = new SettingDAO();
        List<Setting> list = sdao.getSetting();
        for (Setting setting : list) {
            if (isAdd) {//case add
                if (setting.getSettingName().equalsIgnoreCase(settingName));//check settingName is collied                      
                {
                    return true;
                }
            } else {//case update
                if (setting.getSettingName().equalsIgnoreCase(settingName)
                        && setting.isStatus() == (status)) {
                    return true;
                }
            }
        }
        return false;
    }

    /**
     *
     * @param subjectCode
     * @param subjectName
     * @param managerId
     * @param isAdd
     * @param status
     * @return
     */
    public boolean isColliedSubject(String subjectCode, String subjectName, int managerId, boolean isAdd, boolean status) {
        SubjectDAO sdao = new SubjectDAO();
        List<Subject> list = sdao.getSubjectList();
        for (Subject subject : list) {
            if (isAdd) {//case add
                if (subject.getSubjectCode().equalsIgnoreCase(subjectCode)//check if subject code is collied
                        || subject.getSubjectName().equals(subjectName)) //check if subject name is collied
                {
                    return true;
                }
            } else {//case update
                if (subject.getSubjectCode().equalsIgnoreCase(subjectCode)
                        && subject.getSubjectName().equals(subjectName)
                        && subject.isStatus() == (status)) {
                    return true;
                }
            }
        }
        return false;
    }

    /**
     * Check whether user is existed or not when registering
     *
     * @param email email of user registered
     * @return true if existed, otherwise false
     */
    public boolean isColliedRegister(String email) {
        UserDAO udao = new UserDAO();
        List<User> list = udao.getUserList();
        for (User user : list) {
            if (user.getEmail().equalsIgnoreCase(email)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Check whether lesson is existed or not when added
     *
     * @param newTitle New Title of lesson which is added new
     * @param chapterId ID of chapter which contains lessons need to be checked
     * @return true if collied, otherwise false
     */
    public boolean isColliedLesson(String newTitle, int chapterId) {
        List<Lesson> lessons = new LessonDAO().getLessonsByChapter(chapterId);
        for (Lesson lesson : lessons) {
            if (lesson.getLessonName().toLowerCase().trim().equals(newTitle.toLowerCase().trim())) {
                return true;
            }
        }
        return false;
    }

    /**
     *
     * @param newTitle
     * @param chapterId
     * @return
     */
    public boolean isColliedQuestion(String newTitle, int chapterId) {
        List<Question> questions = new QuestionDAO().getQuestionByChapter(chapterId);
        for (Question question : questions) {
            if (question.getQuestionText().toLowerCase().trim().equals(newTitle.toLowerCase().trim())) {
                return true;
            }
        }
        return false;
    }

    /**
     *
     * @param newTitle
     * @param diemsionId
     * @return
     */
    public boolean isColliedQuiz(String newTitle, int diemsionId) {
        List<Quiz> quizs = new QuizDAO().getQuizsByDimension(diemsionId);
        for (Quiz quiz : quizs) {
            if (quiz.getQuizName().toLowerCase().trim().equals(newTitle.toLowerCase().trim())) {
                return true;
            }
        }
        return false;
    }

    /**
     *
     * @param newTitle
     * @param subjectId
     * @param chapterId
     * @return
     */
    public boolean isColliedQuizTitle(String newTitle, int subjectId, int chapterId) {
        List<Quiz> quizs = new QuizDAO().getQuizBySubjectAndChapter(subjectId, chapterId, "");
        for (Quiz quiz : quizs) {
            if (quiz.getQuizName().toLowerCase().trim().equals(newTitle.toLowerCase().trim())) {
                return true;
            }
        }
        return false;
    }

    /**
     *
     * @param classCode
     * @return
     * @throws SQLException
     */
    public boolean isColliedClass(String classCode) throws SQLException {
        ClassDAO cdao = new ClassDAO();
        List<model.Class> classes = cdao.getClassList();
        for (model.Class c : classes) {
            if (c.getClassCode().toLowerCase().trim().equals(classCode.toLowerCase().trim())) {
                return true;
            }
        }
        return false;
    }

    /**
     *
     * @param chapterName
     * @return
     * @throws SQLException
     */
    public boolean isColliedChapter(String chapterName) throws SQLException {
        ChapterDAO cdao = new ChapterDAO();
        
        List<Chapter> chapter = cdao.getChapterList();
        for (Chapter c : chapter) {
            if (c.getChapterName().toLowerCase().trim().equals(chapterName.toLowerCase().trim())) {
                return true;
            }
        }
        return false;
    }

    /**
     *
     * @param dimensionType
     * @param dimensionName
     * @return
     * @throws SQLException
     */
    public boolean isColliedDimension(String dimensionType, String dimensionName) throws SQLException {
        DimensionDAO ddao = new DimensionDAO();
        List<Dimension> dimension = ddao.getDimensionList();
        for (Dimension d : dimension) {
            if (d.getDimensionName().toLowerCase().trim().equals(dimensionName.toLowerCase().trim()) || d.getDimensionType().toLowerCase().trim().equals(dimensionType.toLowerCase().trim())) {
                return true;
            }
        }
        return false;
    }

}
