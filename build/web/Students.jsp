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
    <style>
        body {
            overflow-x: hidden;
        }

        /* Adjust navbar padding for mobile screens */
        .navbar-nav .nav-link {
            padding: 12px 15px;
        }

        /* Image responsiveness */
        img.img-fluid {
            max-width: 100%;
            height: auto;
        }

        /* Back to top button */
        .back-to-top {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 1000;
            display: none; /* Hidden by default */
        }

        .show-back-to-top {
            display: block; /* Show on scroll */
        }

        /* Custom styles for form elements */
        .form-floating {
            margin-bottom: 15px;
        }

        @media (max-width: 576px) {
            .btn {
                width: 100%;
                margin-top: 10px;
            }
        }
    </style>
</head>

<%
    if (request.getParameter("LogAdded") != null) {
        String sname = session.getAttribute("sname").toString();
%>
    <script>alert('Hi <%=sname%>, your attendance has been registered');</script>  
<% } %>

<%
    if (request.getParameter("Already") != null) {
        String sname = session.getAttribute("sname").toString();
%>
    <script>alert('Hi <%=sname%>, your attendance has already been registered');</script>  
<% } %>

<%
    if (request.getParameter("LogFailed") != null) { %>
    <script>alert('Invalid ID');</script>  
<% } %>

<%
    if (request.getParameter("Success") != null) { %>
    <script>alert('Registration Success');</script>  
<% } %>

<%
    if (request.getParameter("mailid") != null) { %>
    <script>alert('Mail Id Already Registered');</script>  
<% } %>

<%
    if (request.getParameter("not") != null) { %>
    <script>alert('Your Account has not yet been approved. Please try again later.');</script>  
<% } %>

<%
    if (request.getParameter("Authentication_Failed") != null) { %>
    <script>alert('Incorrect ID and password');</script>  
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
            <h2 class="m-0 text-primary">Attendance System</h2>
        </a>
        <button type="button" class="navbar-toggler me-4" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarCollapse">
            <div class="navbar-nav ms-auto p-4">
                <a href="index.jsp" class="nav-item nav-link">Home</a>
                <a href="Staff.jsp" class="nav-item nav-link">Staff</a>
                <a href="Students.jsp" class="nav-item nav-link active">Students</a>
                <a href="Reg.jsp" class="nav-item nav-link">Registration</a>
            </div>
        </div>
    </nav>
    <!-- Navbar End -->

    <!-- Header Start -->
    <div class="container-fluid bg-primary py-5 mb-5">
        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-lg-10 text-center">
                    <h1 class="display-3 text-white animated slideInDown">Students</h1>
                </div>
            </div>
        </div>
    </div>
    <!-- Header End -->

    <!-- Contact Start -->
    <div class="container-xxl py-5">
        <div class="container">
            <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
                <h6 class="section-title bg-white text-center text-primary px-3">Login</h6>
            </div>
            <div class="row justify-content-center">
                <div class="col-md-6 wow fadeInUp" data-wow-delay="0.5s">
                    <form action="StudentLog" method="post">
                        <div class="form-floating">
                            <input type="email" class="form-control" id="email" name="email" required placeholder="Email">
                            <label for="email">Email</label>
                        </div>
                        <div class="form-floating">
                            <input type="password" class="form-control" id="password" name="password" required placeholder="Password">
                            <label for="password">Password</label>
                        </div>
                        <div class="col-12">
                            <button class="btn btn-primary w-100 py-3" type="submit">Submit</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <br>
    </div>
    <!-- Contact End -->

    <!-- Back to Top -->
    <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/wow/wow.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Back to Top Script -->
    <script>
        $(window).scroll(function () {
            if ($(this).scrollTop() > 100) {
                $('.back-to-top').addClass('show-back-to-top');
            } else {
                $('.back-to-top').removeClass('show-back-to-top');
            }
        });

        $('.back-to-top').click(function () {
            $('html, body').animate({ scrollTop: 0 }, 800);
            return false;
        });
    </script>

    <!-- Template Javascript -->
    <script src="js/main.js"></script>
</body>

</html>
