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

    <!-- Google Fonts (Mobile Friendly) -->
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Nunito:wght@600;700;800&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Bootstrap Stylesheet -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Stylesheet -->
    <link href="css/style.css" rel="stylesheet">

    <!-- Mobile-Specific Style -->
    <style>
        /* General mobile optimizations */
        body {
            font-size: 14px;
            padding: 0;
            margin: 0;
        }

        .form-floating label {
            padding: 0.4rem 1rem;
        }

        .btn {
            font-size: 1rem;
        }

        /* Responsive form styling */
        @media (max-width: 576px) {
            .form-floating input, .form-floating select, .form-floating textarea {
                font-size: 14px;
                padding: 0.8rem;
            }
            .form-floating label {
                font-size: 12px;
            }
            .container {
                padding: 15px;
            }
        }
    </style>
</head>

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
        <a href="#" class="navbar-brand d-flex align-items-center px-4 px-lg-5">
            <h2 class="m-0 text-primary">Student System</h2>
        </a>
        <button type="button" class="navbar-toggler me-4" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarCollapse">
            <div class="navbar-nav ms-auto p-4 p-lg-0">
                <a href="index.jsp" class="nav-item nav-link">Home</a>
                <a href="Students.jsp" class="nav-item nav-link">Students</a>
                <a href="Staff.jsp" class="nav-item nav-link">Staff</a> <!-- Added Staff link -->
                <a href="Reg.jsp" class="nav-item nav-link active">Registration</a>
            </div>
        </div>
    </nav>
    <!-- Navbar End -->

    <!-- Registration Form Start -->
    <div class="container-fluid bg-primary py-5 mb-5">
        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-lg-10 text-center">
                    <h1 class="display-3 text-white animated slideInDown">Students Registration</h1>
                </div>
            </div>
        </div>
    </div>

    <div class="container py-5">
        <div class="text-center">
            <h6 class="section-title bg-white text-center text-primary px-3">Registration</h6>
        </div>

        <div class="row justify-content-center">
            <div class="col-md-8">
                <form action="StudentReg" method="post" enctype="multipart/form-data">
                    <div class="row g-3">
                        <!-- Roll Number -->
                        <div class="col-12">
                            <div class="form-floating">
                                <input type="text" class="form-control" id="rollno" name="rollno" placeholder="Roll Number" required>
                                <label for="rollno">Roll Number</label>
                            </div>
                        </div>

                        <!-- Select Year -->
                        <div class="col-12">
                            <div class="form-floating">
                                <select class="form-control" id="syear" name="syear" required>
                                    <option value="1st Year">1 Year</option>
                                    <option value="2nd Year">2 Year</option>
                                    <option value="3rd Year">3 Year</option>
                                    <option value="Final Year">Final Year</option>
                                </select>
                                <label for="syear">Select Year</label>
                            </div>
                        </div>

                        <!-- Select Department -->
                        <div class="col-12">
                            <div class="form-floating">
                                <select class="form-control" id="sdept" name="sdept" required>
                                    <option value="IT">IT</option>
                                    <option value="CSE">CSE</option>
                                    <option value="MCA">MCA</option>
                                </select>
                                <label for="sdept">Select Department</label>
                            </div>
                        </div>

                        <!-- Upload Photo -->
                        <div class="col-12">
                            <div class="form-floating">
                                <input type="file" class="form-control" id="pphoto" name="pphoto" required>
                                <label for="pphoto">Upload Photo</label>
                            </div>
                        </div>

                        <!-- Name -->
                        <div class="col-12">
                            <div class="form-floating">
                                <input type="text" class="form-control" id="name" name="name" placeholder="Full Name" required>
                                <label for="name">Full Name</label>
                            </div>
                        </div>

                        <!-- Email -->
                        <div class="col-12">
                            <div class="form-floating">
                                <input type="email" class="form-control" id="email" name="email" placeholder="Email" required>
                                <label for="email">Email</label>
                            </div>
                        </div>

                        <!-- Phone -->
                        <div class="col-12">
                            <div class="form-floating">
                                <input type="tel" class="form-control" id="phone" name="phone" placeholder="Phone Number" required>
                                <label for="phone">Phone Number</label>
                            </div>
                        </div>

                        <!-- Address -->
                        <div class="col-12">
                            <div class="form-floating">
                                <textarea class="form-control" placeholder="Address" name="address" id="address" style="height: 150px;" required></textarea>
                                <label for="address">Address</label>
                            </div>
                        </div>

                        <!-- Password -->
                        <div class="col-12">
                            <div class="form-floating">
                                <input type="password" class="form-control" id="pass" name="pass" placeholder="Password" required>
                                <label for="pass">Password</label>
                            </div>
                        </div>

                        <!-- Submit Button -->
                        <div class="col-12">
                            <button class="btn btn-primary w-100 py-3" type="submit">Register</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- Registration Form End -->

    <!-- Back to Top -->
    <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/wow/wow.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Custom JavaScript -->
    <script src="js/main.js"></script>
</body>

</html>
