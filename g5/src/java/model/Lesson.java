/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author win
 */
public class Lesson {

    private int lessonId;
    private String lessonName;
    private String youtubeLink;
    private String attachedFile;
    private String description;
    private boolean status;
    private Chapter chapter;
    private int createdBy;
    private Date createdAt;
    private int updatedBy;
    private Date updatedAt;
    private Quiz quiz;
    private int lessonType;
    private int displayOrder;

    public Lesson() {
    }

    public Lesson(int lessonId, String lessonName, String youtubeLink, String attachedFile, String description, boolean status, Chapter chapter, int createdBy, Date createdAt, int updatedBy, Date updatedAt, Quiz quiz, int lessonType, int displayOrder) {
        this.lessonId = lessonId;
        this.lessonName = lessonName;
        this.youtubeLink = youtubeLink;
        this.attachedFile = attachedFile;
        this.description = description;
        this.status = status;
        this.chapter = chapter;
        this.createdBy = createdBy;
        this.createdAt = createdAt;
        this.updatedBy = updatedBy;
        this.updatedAt = updatedAt;
        this.quiz = quiz;
        this.lessonType = lessonType;
        this.displayOrder = displayOrder;
    }

    public int getLessonId() {
        return lessonId;
    }

    public void setLessonId(int lessonId) {
        this.lessonId = lessonId;
    }

    public String getLessonName() {
        return lessonName;
    }

    public void setLessonName(String lessonName) {
        this.lessonName = lessonName;
    }

    public String getYoutubeLink() {
        return youtubeLink;
    }

    public void setYoutubeLink(String youtubeLink) {
        this.youtubeLink = youtubeLink;
    }

    public String getAttachedFile() {
        return attachedFile;
    }

    public void setAttachedFile(String attachedFile) {
        this.attachedFile = attachedFile;
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

    public Quiz getQuiz() {
        return quiz;
    }

    public void setQuiz(Quiz quiz) {
        this.quiz = quiz;
    }

    public int getLessonType() {
        return lessonType;
    }

    public void setLessonType(int lessonType) {
        this.lessonType = lessonType;
    }

    public int getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(int displayOrder) {
        this.displayOrder = displayOrder;
    }

    @Override
    public String toString() {
        return "Lesson{" + "lessonId=" + lessonId + ", lessonName=" + lessonName + ", youtubeLink=" + youtubeLink + ", attachedFile=" + attachedFile + ", description=" + description + ", status=" + status + ", chapter=" + chapter + ", createdBy=" + createdBy + ", createdAt=" + createdAt + ", updatedBy=" + updatedBy + ", updatedAt=" + updatedAt + ", quiz=" + quiz + ", lessonType=" + lessonType + ", displayOrder=" + displayOrder + '}';
    }
}
