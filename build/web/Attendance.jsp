<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>QR Based Student Attendance</title>
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

    <!-- Custom Styles -->
    <link href="css/style.css" rel="stylesheet">
</head>

<body>
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
                <a href="index.jsp" class="nav-item nav-link active">Home</a>
                <a href="Staff.jsp" class="nav-item nav-link">Staff</a>
                <a href="Students.jsp" class="nav-item nav-link">Students</a>
                <a href="Reg.jsp" class="nav-item nav-link">Registration</a>
            </div>
            <a href="Attendance.jsp" class="btn btn-primary py-3 px-lg-4 d-none d-lg-block">Scan QR<i class="fa fa-camera ms-3"></i></a>
        </div>
    </nav>
    <!-- Navbar End -->

    <!-- QR Scanner Section Start -->
    <div class="container-fluid bg-primary py-4">
        <div class="container text-center">
            <h1 class="text-white mb-3">Staff QR Scanner</h1>
        </div>
    </div>

    <div class="container py-5">
        <div class="text-center">
            <h6 class="section-title bg-white text-primary px-3">Scan QR for Attendance</h6>
        </div>
        <div class="row justify-content-center">
            <div class="col-md-10 col-lg-6 text-center">
                <video id="preview" style="width: 100%; max-width: 400px;"></video>
            </div>
        </div>
    </div>
    <!-- QR Scanner Section End -->

    <!-- Back to Top Button -->
    <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/rawgit.com_schmich_instascan-builds_master_instascan.min.js"></script>

    <!-- QR Code Scanner Script -->
    <script>
        let scanner = new Instascan.Scanner({ video: document.getElementById('preview') });

        scanner.addListener('scan', function(content) {
            console.log('Scanned QR Code:', content);
            capturePicture(content);
        });

        Instascan.Camera.getCameras().then(function(cameras) {
            if (cameras.length > 0) {
                scanner.start(cameras[0]);
            } else {
                alert('No cameras found.');
            }
        });

        function capturePicture(qrValue) {
            let video = document.getElementById('preview');
            let canvas = document.createElement('canvas');
            canvas.width = video.videoWidth;
            canvas.height = video.videoHeight;
            canvas.getContext('2d').drawImage(video, 0, 0, canvas.width, canvas.height);

            let imageDataURL = canvas.toDataURL('image/png');

            // Form submission
            let form = document.createElement('form');
            form.method = 'POST';
            form.action = 'saveImageAndQR.jsp';

            // Hidden input for QR value
            let qrInput = document.createElement('input');
            qrInput.type = 'hidden';
            qrInput.name = 'qrValue';
            qrInput.value = qrValue;

            // Hidden input for image data
            let imageInput = document.createElement('input');
            imageInput.type = 'hidden';
            imageInput.name = 'imageData';
            imageInput.value = imageDataURL;

            form.appendChild(qrInput);
            form.appendChild(imageInput);

            document.body.appendChild(form);
            form.submit();
        }
    </script>
</body>

</html>

<%
    if (request.getParameter("Failed") != null) {
%>
        <script>alert('Authentication Failed');</script>  
<%
    }
%>
