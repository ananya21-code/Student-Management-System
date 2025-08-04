package com.example.students.listeners;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Initialize resources when the application starts
        System.out.println("Web application started. Initializing resources...");

        // Example: You can initialize a DB connection or any resources here
        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Establish a connection to the database
            String url = "jdbc:mysql://localhost:3306/student_management_system";
            String username = "root"; // replace with your DB username
            String password = "Shravya@28"; // replace with your DB password
            Connection conn = DriverManager.getConnection(url, username, password);

            // Store the connection in ServletContext for later use in servlets
            sce.getServletContext().setAttribute("dbConnection", conn);

            System.out.println("Database connection established successfully.");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            System.err.println("Failed to initialize database connection.");
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Clean up resources when the application shuts down
        System.out.println("Web application stopped. Cleaning up resources...");

        // Close any resources like database connections if necessary
        Connection conn = (Connection) sce.getServletContext().getAttribute("dbConnection");
        if (conn != null) {
            try {
                conn.close();
                System.out.println("Database connection closed.");
            } catch (SQLException e) {
                e.printStackTrace();
                System.err.println("Failed to close the database connection.");
            }
        }
    }
}