<%@page import="QRAttendance.SQLconnection"%>
<%@page contentType="image/png" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>

<%
    String uid = request.getParameter("sid");
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Establish a connection to the database
        con = SQLconnection.getconnection();
        
        // Use a prepared statement to prevent SQL injection
        String sql = "SELECT image_data FROM students WHERE id = ?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, uid);
        
        rs = pstmt.executeQuery();
        
        if (rs.next()) {
            Blob image = rs.getBlob("image_data");
            byte[] imgData = image.getBytes(1, (int) image.length());
            
            // Set the content type for the image response
            response.setContentType("image/png");
            response.setContentLength(imgData.length);  // Set the content length for better performance
            
            try (OutputStream o = response.getOutputStream()) {
                o.write(imgData);
                o.flush();
            }
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found for the given ID.");
        }
    } catch (SQLException e) {
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to retrieve image: " + e.getMessage());
    } catch (IOException e) {
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error writing image to response: " + e.getMessage());
    } finally {
        // Close resources in the finally block to avoid memory leaks
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
