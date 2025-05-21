<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order & Delivery System</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Tailwind CSS -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        html, body {
            height: 100%;
            margin: 0;
            background-color: #f0f9f4;
        }

        body {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            max-width: 800px;
            text-align: center;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        .logo {
            background-image: url('https://d1csarkz8obe9u.cloudfront.net/posterpreviews/restaurant-logo%2Crestaurant-icon-logo-free-design-template-e4e92c7d3b5631a777fce7a5d629a00a_screen.jpg?ts=1737229867');
            background-size: contain;
            background-repeat: no-repeat;
            background-position: center;
            width: 200px;
            height: 200px;
            margin: 0 auto 20px;
        }

        h1 {
            color: #2f855a;
        }

        .links a {
            margin: 10px;
            padding: 10px 20px;
            background-color: #38a169;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .links a:hover {
            background-color: #2f855a;
        }

        .cart-button a {
            margin-top: 20px;
            display: inline-block;
            padding: 10px 20px;
            background-color: #38a169;
            color: white;
            border-radius: 5px;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .cart-button a:hover {
            background-color: #2f855a;
        }

        input[type="submit"] {
            background-color: #38a169;
            color: white;
        }

        input[type="submit"]:hover {
            background-color: #2f855a;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="logo"></div>
    <h1 class="text-2xl font-bold">Welcome to Order & Delivery System</h1>
    <p class="text-gray-700">Manage orders and track deliveries.</p>
    <div class="links">
        <a href="orders" class="inline-block"><i class="fas fa-box"></i> Order Management</a>
    </div>
</div>

<!-- Bootstrap and jQuery JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>