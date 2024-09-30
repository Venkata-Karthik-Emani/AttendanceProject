/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package QRAttendance;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author NARESH
 */
@MultipartConfig(maxFileSize = 16177215)
public class StudentReg extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String rollno = request.getParameter("rollno");
             String syear = request.getParameter("syear");
            String sdept = request.getParameter("sdept");
            String name = request.getParameter("name");
            String mail = request.getParameter("email");
            String pass = request.getParameter("pass");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            Part filePart = request.getPart("pphoto");
            InputStream inputStream = null;
            if (filePart != null) {
                System.out.println(filePart.getName());
                System.out.println(filePart.getSize());
                System.out.println(filePart.getContentType());

                inputStream = filePart.getInputStream();
            }
            System.out.println("pass------------>>            :" + pass);
            System.out.println("email------------>>           :" + mail);
            DateFormat dateFormat = new SimpleDateFormat("YYYY/MM/dd HH:mm:ss");
            Date date = new Date();
            String time = dateFormat.format(date);
            System.out.println("Date and Time : " + time);
            System.out.println("name : " + name);
            
            Connection conn = SQLconnection.getconnection();
            Statement st = conn.createStatement();
            Statement st1 = conn.createStatement();
            ResultSet rs = st1.executeQuery("select * from students where email='" + mail + "'");
            int count = 0;
            while (rs.next()) {

                count++;
            }
            if (count > 0) {
                response.sendRedirect("Students.jsp?mailid");
            } else {

                try {
                    conn = SQLconnection.getconnection();

                    String sql = "INSERT INTO students (rollno, syear, sdept, name, email, phone, address, pass, ustatus, regtime, lastlog, ppic) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?)";
                    PreparedStatement statement = conn.prepareStatement(sql);
                    statement.setString(1, rollno);
                    statement.setString(2, syear);
                    statement.setString(3, sdept);
                    statement.setString(4, name);
                    statement.setString(5, mail);
                    statement.setString(6, phone);
                    statement.setString(7, address);
                    statement.setString(8, pass);
                    statement.setString(9, "No");
                    statement.setString(10, time);
                    statement.setString(11, "No");
                    if (inputStream != null) {
                        statement.setBlob(12, inputStream);
                    }
                    int row = statement.executeUpdate();
                    if (row > 0) {
                        System.out.println("success");
                        response.sendRedirect("Students.jsp?Success");
                    } else {
                        System.out.println("Students.jsp?failed");
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(StudentReg.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
