<%@page import="QRAttendance.SQLconnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.io.OutputStream"%>

<%
    String uid = request.getParameter("uid");
    if (uid == null || uid.isEmpty()) {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "User ID is required.");
        return;
    }

    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        con = SQLconnection.getconnection();
        String query = "SELECT upic FROM attendance WHERE id = ?";
        pstmt = con.prepareStatement(query);
        pstmt.setString(1, uid);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            Blob image = rs.getBlob("upic");
            byte[] imgData = image.getBytes(1, (int) image.length());
            
            // Set the content type for the response
            response.setContentType("image/png");
            try (OutputStream out = response.getOutputStream()) {
                out.write(imgData);
                out.flush();
            }
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found for the provided ID.");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred.");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
    } finally {
        // Close resources in reverse order of their creation
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
