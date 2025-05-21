<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Admin Login</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
      margin: 0;
      background-image: url('images/background.jpg');
      background-size: cover;
      background-repeat: no-repeat;
      background-attachment: fixed;
      background-position: center;
    }
    .form-card {
      background-color: rgba(255, 255, 255, 0.95);
      padding: 40px;
      border-radius: 15px;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
      width: 100%;
      max-width: 400px;
      text-align: center;
    }
    .title-text {
      font-family: 'Pacifico', cursive;
      font-size: 36px;
      color: #FF4500;
      text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
      margin-bottom: 20px;
    }
    .form-label {
      color: #333;
      font-weight: 500;
    }
    .form-control {
      border-radius: 10px;
      border: 1px solid #ced4da;
      padding: 10px;
      transition: border-color 0.3s ease;
    }
    .form-control:focus {
      border-color: #28A745;
      box-shadow: 0 0 5px rgba(40, 167, 69, 0.3);
    }
    .btn-primary {
      background-color: #28A745;
      border-color: #28A745;
      border-radius: 20px;
      padding: 10px 20px;
      transition: all 0.3s ease;
      width: 100%;
      font-size: 16px;
      margin-top: 10px;
    }
    .btn-primary:hover {
      background-color: #218838;
      border-color: #218838;
    }
    .alert {
      margin-bottom: 20px;
      border-radius: 10px;
    }
    @import url('https://fonts.googleapis.com/css2?family=Pacifico&display=swap');
  </style>
</head>
<body>
<div class="form-card">
  <h2 class="title-text">Admin Login</h2>
  <c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
  </c:if>
  <form action="admin" method="post">
    <div class="mb-3">
      <label for="username" class="form-label">Username</label>
      <input type="text" class="form-control" id="username" name="username" placeholder="Enter username" required>
    </div>
    <div class="mb-3">
      <label for="password" class="form-label">Password</label>
      <input type="password" class="form-control" id="password" name="password" placeholder="Enter password" required>
    </div>
    <button type="submit" class="btn btn-primary">Login</button>
  </form>
</div>
</body>
</html>