package com.aditya.taskmanager;


import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class TaskRunner implements CommandLineRunner {

    private final TaskRepository taskRepository;

    public TaskRunner(TaskRepository taskRepository) {
        this.taskRepository = taskRepository;
    }

    @Override
    public void run(String... args) {
        System.out.println("--- Welcome to TASK MASTER ---");

        // Create and save a task
        Task task = new Task();
        task.setTitle("Finish Spring Boot setup");
        task.setCompleted(false);
        taskRepository.save(task);

        // Fetch and print tasks
        System.out.println("Tasks in database:");
        taskRepository.findAll().forEach(System.out::println);
    }
}
