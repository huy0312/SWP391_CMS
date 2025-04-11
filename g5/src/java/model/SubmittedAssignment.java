/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author amshu
 */
public class SubmittedAssignment {
    private int smassignmentId;
    private String attachedFile;
    private String description;
    private Assignment assignmentId;
    private int createdBy;
    private Date createdAt;
    private int updatedBy;
    private Date updatedAt;

    public SubmittedAssignment() {
    }

    public SubmittedAssignment(int smassignmentId, String attachedFile, String description, Assignment assignmentId, int createdBy, Date createdAt, int updatedBy, Date updatedAt) {
        this.smassignmentId = smassignmentId;
        this.attachedFile = attachedFile;
        this.description = description;
        this.assignmentId = assignmentId;
        this.createdBy = createdBy;
        this.createdAt = createdAt;
        this.updatedBy = updatedBy;
        this.updatedAt = updatedAt;
    }

    public int getSmassignmentId() {
        return smassignmentId;
    }

    public void setSmassignmentId(int smassignmentId) {
        this.smassignmentId = smassignmentId;
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

    public Assignment getAssignmentId() {
        return assignmentId;
    }

    public void setAssignmentId(Assignment assignmentId) {
        this.assignmentId = assignmentId;
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
        return "SubmittedAssignment{" + "smassignmentId=" + smassignmentId + ", attachedFile=" + attachedFile + ", description=" + description + ", assignmentId=" + assignmentId + ", createdBy=" + createdBy + ", createdAt=" + createdAt + ", updatedBy=" + updatedBy + ", updatedAt=" + updatedAt + '}';
    }
    
    
}
