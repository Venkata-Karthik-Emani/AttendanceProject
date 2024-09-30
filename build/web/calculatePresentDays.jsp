<%@page import="QRAttendance.SQLconnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String selectedMonth = request.getParameter("selectedMonth");
    String uid = request.getParameter("uid");
    int totalPresentDays = 0;

    // Validate input
    if (selectedMonth == null || uid == null || !uid.matches("\\d+")) {
        response.sendRedirect("CheckAttendance.jsp?InvalidInput");
        return;
    }

    String year = selectedMonth.substring(0, 4);
    String month = selectedMonth.substring(5);

    try (Connection connection = SQLconnection.getconnection()) {
        // Use prepared statement for counting present days
        String countQuery = "SELECT COUNT(*) AS present_count FROM attendance WHERE YEAR(date) = ? AND MONTH(date) = ? AND uid = ? AND is_present = ?";
        
        try (PreparedStatement countStmt = connection.prepareStatement(countQuery)) {
            countStmt.setString(1, year);
            countStmt.setString(2, month);
            countStmt.setString(3, uid);
            countStmt.setBoolean(4, true);
            
            try (ResultSet countResultSet = countStmt.executeQuery()) {
                if (countResultSet.next()) {
                    totalPresentDays = countResultSet.getInt("present_count");
                }
            }
        }

        // Check if any records exist
        if (totalPresentDays == 0) {
            response.sendRedirect("CheckAttendance.jsp?NoRecord");
            return;
        }

        // Retrieve student details
        String studentQuery = "SELECT * FROM students WHERE id = ?";
        try (PreparedStatement studentStmt = connection.prepareStatement(studentQuery)) {
            studentStmt.setString(1, uid);
            
            try (ResultSet studentResultSet = studentStmt.executeQuery()) {
                if (studentResultSet.next()) {
                    String name = studentResultSet.getString("name");
                    String sdept = studentResultSet.getString("sdept");
                    String syear = studentResultSet.getString("syear");
                    String rollno = studentResultSet.getString("rollno");

                    // Redirect with student details
                    response.sendRedirect("AttendanceDetails.jsp?presentDays=" + totalPresentDays + "&sdept=" + sdept + "&name=" + name + "&syear=" + syear + "&rollno=" + rollno);
                } else {
                    response.sendRedirect("CheckAttendance.jsp?StudentNotFound");
                }
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendRedirect("CheckAttendance.jsp?ErrorOccurred");
    }
%>
