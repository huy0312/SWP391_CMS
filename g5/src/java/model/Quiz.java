/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author win
 */
public class Quiz {
    private int quizId ;
    private String quizName;
    private Setting quizType;
    private String description;
    private boolean status;
    private Chapter chapter;
    private Subject subject;
    private Dimension dimension;
    private int noQuiz;
    private int duration;   
    private int createdBy;
    private Date createdAt;
    private int updatedBy;
    private Date updatedAt;

    public Quiz() {
    }

    public Quiz(int quizId, String quizName, Setting quizType, String description, boolean status, Chapter chapter, Subject subject, Dimension dimension, int noQuiz, int duration, int createdBy, Date createdAt, int updatedBy, Date updatedAt) {
        this.quizId = quizId;
        this.quizName = quizName;
        this.quizType = quizType;
        this.description = description;
        this.status = status;
        this.chapter = chapter;
        this.subject = subject;
        this.dimension = dimension;
        this.noQuiz = noQuiz;
        this.duration = duration;
        this.createdBy = createdBy;
        this.createdAt = createdAt;
        this.updatedBy = updatedBy;
        this.updatedAt = updatedAt;
    }

    public int getQuizId() {
        return quizId;
    }

    public void setQuizId(int quizId) {
        this.quizId = quizId;
    }

    public String getQuizName() {
        return quizName;
    }

    public void setQuizName(String quizName) {
        this.quizName = quizName;
    }

    public Setting getQuizType() {
        return quizType;
    }

    public void setQuizType(Setting quizType) {
        this.quizType = quizType;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Chapter getChapter() {
        return chapter;
    }

    public void setChapter(Chapter chapter) {
        this.chapter = chapter;
    }

    public Subject getSubject() {
        return subject;
    }

    public void setSubject(Subject subject) {
        this.subject = subject;
    }

    public Dimension getDimension() {
        return dimension;
    }

    public void setDimension(Dimension dimension) {
        this.dimension = dimension;
    }

    public int getNoQuiz() {
        return noQuiz;
    }

    public void setNoQuiz(int noQuiz) {
        this.noQuiz = noQuiz;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
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

    @Override
    public String toString() {
        return "Quiz{" + "quizId=" + quizId + ", quizName=" + quizName + ", quizType=" + quizType + ", description=" + description + ", status=" + status + ", chapter=" + chapter + ", subject=" + subject + ", dimension=" + dimension + ", noQuiz=" + noQuiz + ", duration=" + duration + ", createdBy=" + createdBy + ", createdAt=" + createdAt + ", updatedBy=" + updatedBy + ", updatedAt=" + updatedAt + '}';
    }

    

   
    
    
}
