/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;
import model.Class;

/**
 *
 * @author win
 */
public class Grade {

    private int gradeId;
    private String gradeName;
    private int gradeType;
    private float grade;
    private String note;
    private User student;
    private Quiz quiz;
    private SubmittedAssignment smAsm;
    private int createdBy;
    private Date createdAt;
    private int updatedBy;
    private Date updatedAt;
    private Class classes;
    private int attempt;

    public Grade() {
    }

    public Grade(int gradeId, String gradeName, int gradeType, float grade, String note, User student, Quiz quiz, SubmittedAssignment smAsm, int createdBy, Date createdAt, int updatedBy, Date updatedAt, Class classes, int attempt) {
        this.gradeId = gradeId;
        this.gradeName = gradeName;
        this.gradeType = gradeType;
        this.grade = grade;
        this.note = note;
        this.student = student;
        this.quiz = quiz;
        this.smAsm = smAsm;
        this.createdBy = createdBy;
        this.createdAt = createdAt;
        this.updatedBy = updatedBy;
        this.updatedAt = updatedAt;
        this.classes = classes;
        this.attempt = attempt;
    }

    public int getGradeId() {
        return gradeId;
    }

    public void setGradeId(int gradeId) {
        this.gradeId = gradeId;
    }

    public String getGradeName() {
        return gradeName;
    }

    public void setGradeName(String gradeName) {
        this.gradeName = gradeName;
    }

    public int getGradeType() {
        return gradeType;
    }

    public void setGradeType(int gradeType) {
        this.gradeType = gradeType;
    }

    public float getGrade() {
        return grade;
    }

    public void setGrade(float grade) {
        this.grade = grade;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public User getStudent() {
        return student;
    }

    public void setStudent(User student) {
        this.student = student;
    }

    public Quiz getQuiz() {
        return quiz;
    }

    public void setQuiz(Quiz quiz) {
        this.quiz = quiz;
    }

    public SubmittedAssignment getSmAsm() {
        return smAsm;
    }

    public void setSmAsm(SubmittedAssignment smAsm) {
        this.smAsm = smAsm;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public int getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(int updatedBy) {
        this.updatedBy = updatedBy;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    public Class getClasses() {
        return classes;
    }

    public void setClasses(Class classes) {
        this.classes = classes;
    }

    public int getAttempt() {
        return attempt;
    }

    public void setAttempt(int attempt) {
        this.attempt = attempt;
    }

    @Override
    public String toString() {
        return "Grade{" + "gradeId=" + gradeId + ", gradeName=" + gradeName + ", gradeType=" + gradeType + ", grade=" + grade + ", note=" + note + ", student=" + student + ", quiz=" + quiz + ", smAsm=" + smAsm + ", createdBy=" + createdBy + ", createdAt=" + createdAt + ", updatedBy=" + updatedBy + ", updatedAt=" + updatedAt + ", classes=" + classes + ", attempt=" + attempt + '}';
    }

}
