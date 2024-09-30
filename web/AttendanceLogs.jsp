<%@page import="QRAttendance.SQLconnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>QR Based Student Attendance Management System</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Nunito:wght@600;700;800&display=swap" rel="stylesheet">

    <!-- Bootstrap Stylesheet -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Stylesheet -->
    <link href="css/style.css" rel="stylesheet">
    <link href="css/table.css" rel="stylesheet">
    <style>
        /* Mobile-first styles */
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        table th, table td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
        }

        /* Ensure table scrolls horizontally on small screens */
        .table-responsive {
            width: 100%;
            overflow-x: auto;
        }

        /* Adjustments for better mobile experience */
        @media (max-width: 767px) {
            table th, table td {
                padding: 8px;
                font-size: 14px;
            }
            
            .navbar-nav .nav-item {
                padding: 5px;
            }

            .navbar-nav .nav-link {
                font-size: 14px;
            }

            .container-fluid {
                padding: 20px;
            }

            .container h1 {
                font-size: 28px;
            }

            .btn-primary {
                padding: 12px 24px;
                font-size: 14px;
            }
        }
    </style>
</head>

<% if (request.getParameter("Activated") != null) { %>
<script>alert('Approved');</script>
<% } if (request.getParameter("Rejected") != null) { %>
<script>alert('Rejected');</script>
<% } %>

<body>
    <!-- Spinner Start -->
    <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
        <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
            <span class="sr-only">Loading...</span>
        </div>
    </div>
    <!-- Spinner End -->

    <!-- Navbar Start -->
    <nav class="navbar navbar-expand-lg bg-white navbar-light shadow sticky-top p-0">
        <a href="#" class="navbar-brand d-flex align-items-center px-4">
            <h2 class="m-0 text-primary">Attendance</h2>
        </a>
        <button type="button" class="navbar-toggler me-4" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarCollapse">
            <div class="navbar-nav ms-auto p-4 p-lg-0">
                <a href="StaffHome.jsp" class="nav-item nav-link">Home</a>
                <a href="StudentApproval.jsp" class="nav-item nav-link">Student Approval</a>
                <a href="StudentDetails.jsp" class="nav-item nav-link">Student Details</a>
                <a href="CheckAttendance.jsp" class="nav-item nav-link">Check Attendance</a>
                <a href="AttendanceLogs.jsp" class="nav-item nav-link active">Attendance Logs</a>
                <a href="logout.jsp" class="btn btn-primary py-2 px-3">Logout</a>
            </div>
            <!--<a href="logout.jsp" class="btn btn-primary py-4 px-lg-5 d-none d-lg-block">Logout<i class="fa fa-lock ms-3"></i></a>-->
        </div>
    </nav>
    <!-- Navbar End -->

    <!-- Header Start -->
    <div class="container-fluid bg-primary py-4 mb-4">
        <div class="container text-center">
            <h1 class="text-white">Attendance Logs</h1>
        </div>
    </div>
    <!-- Header End -->

    <!-- Attendance Table Start -->
    <div class="container-xxl py-4">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-12">
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Department</th>
                                    <th>Date</th>
                                    <th>Time</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    Connection con = SQLconnection.getconnection();
                                    Statement st = con.createStatement();
                                    try {
                                        ResultSet rs = st.executeQuery("Select * from attendance");
                                        while (rs.next()) {
                                %>
                                <tr>
                                    <td><%=rs.getString("sname")%></td>
                                    <td><%=rs.getString("sdept")%></td>
                                    <td><%=rs.getString("date")%></td>
                                    <td><%=rs.getString("atime")%></td>
                                </tr>
                                <% } %>
                                <% } catch (Exception ex) {
                                    ex.printStackTrace();
                                } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Attendance Table End -->

    <!-- Back to Top Button -->
    <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Template Javascript -->
    <script src="js/main.js"></script>
</body>

</html>
