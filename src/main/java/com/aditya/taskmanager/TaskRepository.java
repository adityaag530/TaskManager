package com.aditya.taskmanager;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TaskRepository extends JpaRepository<Task, Long> {
    // You can add custom query methods if needed, like:
    // List<Task> findByCompleted(boolean completed);
}