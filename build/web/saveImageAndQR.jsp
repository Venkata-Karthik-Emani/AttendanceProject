<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="QRAttendance.SQLconnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Base64"%>

<%
    String qrValue = request.getParameter("qrValue");
    String imageData = request.getParameter("imageData");

    if (qrValue == null || imageData == null) {
        response.sendRedirect("Students.jsp?error=Invalid input");
        return;
    }

    try (Connection con = SQLconnection.getconnection()) {
        String selectStudentQuery = "SELECT * FROM students WHERE unique_id = ? AND ustatus = 'Active'";
        try (PreparedStatement selectStudentStmt = con.prepareStatement(selectStudentQuery)) {
            selectStudentStmt.setString(1, qrValue);
            ResultSet rs = selectStudentStmt.executeQuery();

            if (rs.next()) {
                String name = rs.getString("name");
                String dept = rs.getString("sdept");
                String uid = rs.getString("id");
                session.setAttribute("sname", name);

                // Get today's date
                DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                java.sql.Date today = new java.sql.Date(new Date().getTime());

                // Check if attendance for today already exists
                String checkAttendanceQuery = "SELECT COUNT(*) AS count FROM attendance WHERE date = ? AND uid = ?";
                try (PreparedStatement checkStmt = con.prepareStatement(checkAttendanceQuery)) {
                    checkStmt.setDate(1, today);
                    checkStmt.setString(2, uid);
                    ResultSet countResult = checkStmt.executeQuery();

                    if (countResult.next() && countResult.getInt("count") > 0) {
                        response.sendRedirect("Students.jsp?status=AlreadyRecorded");
                        return;
                    }
                }

                // Insert the attendance record
                String insertAttendanceQuery = "INSERT INTO attendance (date, is_present, uid, sname, sdept, upic) VALUES (?, ?, ?, ?, ?, ?)";
                try (PreparedStatement insertStmt = con.prepareStatement(insertAttendanceQuery)) {
                    insertStmt.setDate(1, today);
                    insertStmt.setBoolean(2, true);
                    insertStmt.setString(3, uid);
                    insertStmt.setString(4, name);
                    insertStmt.setString(5, dept);
                    byte[] imageBytes = Base64.getDecoder().decode(imageData.split(",")[1]);
                    insertStmt.setBytes(6, imageBytes);
                    insertStmt.executeUpdate();

                    response.sendRedirect("Students.jsp?status=AttendanceRecorded");
                }
            } else {
                response.sendRedirect("Students.jsp?status=StudentNotFound");
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendRedirect("Students.jsp?status=DatabaseError");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("Students.jsp?status=GeneralError");
    }
%>
