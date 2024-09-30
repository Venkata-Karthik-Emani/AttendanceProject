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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Nunito:wght@600;700;800&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="lib/animate/animate.min.css" rel="stylesheet">
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="css/style.css" rel="stylesheet">
    <link href="css/table.css" rel="stylesheet">

    <style>
        /* Custom styles for mobile optimization */
        table {
            width: 100%;
            margin: auto;
        }
        .table-responsive {
            overflow-x: auto;
        }
        th, td {
            text-align: center;
            vertical-align: middle;
        }
    </style>
</head>

<%
    if (request.getParameter("Activated") != null) {
%>
    <script>alert('Approved');</script>  
<%
    }
    if (request.getParameter("Rejected") != null) {
%>
    <script>alert('Rejected');</script>  
<%
    }
%>

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
        <a href="#" class="navbar-brand d-flex align-items-center px-4 px-lg-5"></a>
        <button type="button" class="navbar-toggler me-4" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarCollapse">
            <div class="navbar-nav ms-auto p-4 p-lg-0">
                <a href="StaffHome.jsp" class="nav-item nav-link">Home</a>
                <a href="StudentApproval.jsp" class="nav-item nav-link active">Students Approval</a>
                <a href="StudentDetails.jsp" class="nav-item nav-link">Students Details</a>
                <a href="CheckAttendance.jsp" class="nav-item nav-link">Check Attendance</a>
                <a href="AttendanceLogs.jsp" class="nav-item nav-link">Attendance Logs</a>
                <a href="logout.jsp" class="btn btn-primary py-2 px-3">Logout</a>
            </div>

            <a href="Attendance.jsp" class="btn btn-primary py-2 d-none d-lg-block">Attendance Scan<i class="fa fa-camera ms-3"></i></a>
            <!--<a href="logout.jsp" class="btn btn-primary py-2 d-none d-lg-block">Logout<i class="fa fa-lock ms-3"></i></a>-->
        </div>
    </nav>
    <!-- Navbar End -->

    <!-- Header Start -->
    <div class="container-fluid bg-primary py-5 mb-5">
        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-lg-10 text-center">
                    <h1 class="display-3 text-white animated slideInDown">Student Activations</h1>
                </div>
            </div>
        </div>
    </div>
    <!-- Header End -->

    <!-- Student Approval Table Start -->
    <div class="container-xxl py-5">
        <div class="container text-center">
            <div class="row justify-content-center">
                <div class="col-md-12">
                    <div class="table-responsive">
                        <table id="naresh" class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Id</th>
                                    <th>Name</th>
                                    <th>Roll No</th>
                                    <th>Year</th>
                                    <th>Department</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    Connection con = SQLconnection.getconnection();
                                    Statement st = con.createStatement();
                                    try {
                                        ResultSet rs = st.executeQuery("Select * from students where ustatus ='No'");
                                        while (rs.next()) {
                                %>
                                <tr>
                                    <td><%=rs.getString("id")%></td>
                                    <td><%=rs.getString("name")%></td>
                                    <td><%=rs.getString("rollno")%></td>
                                    <td><%=rs.getString("syear")%></td>
                                    <td><%=rs.getString("sdept")%></td>
                                    <td><%=rs.getString("email")%></td>
                                    <td><%=rs.getString("phone")%></td>
                                    <td><%=rs.getString("ustatus")%></td>
                                    <td>
                                        <a href="StudentActivate?uid=<%=rs.getString("id")%>&email=<%=rs.getString("email")%>" class="btn btn-success btn-sm" style="color: white">&nbsp;Approve</a>
                                        <a href="StudentReject?uid=<%=rs.getString("id")%>" class="btn btn-danger btn-sm" style="color: white">&nbsp;Reject</a>
                                    </td>
                                </tr>
                                <%
                                        }
                                    } catch (Exception ex) {
                                        ex.printStackTrace();
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Student Approval Table End -->

    <!-- Back to Top -->
    <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/wow/wow.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="js/main.js"></script>
</body>

</html>
