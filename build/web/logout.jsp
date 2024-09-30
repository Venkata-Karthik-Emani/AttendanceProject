<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logout</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            color: #343a40;
        }
        .logout-message {
            text-align: center;
        }
        .logout-message h1 {
            font-size: 2rem;
            margin-bottom: 20px;
        }
        .logout-message p {
            font-size: 1rem;
            margin-bottom: 30px;
        }
        .logout-message a {
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }
    </style>
</head>

<body>
    <div class="logout-message">
        <h1>Logged Out Successfully</h1>
        <p>You have been logged out. Thank you for using our service!</p>
        <p>Redirecting to <a href="index.jsp">Home</a>...</p>
    </div>

    <script>
        // Redirect to index.jsp after a delay of 2 seconds
        setTimeout(function() {
            window.location.href = "index.jsp";
        }, 2000);
    </script>

    <% 
        // Invalidate the session
        session.invalidate(); 
    %>
</body>

</html>
