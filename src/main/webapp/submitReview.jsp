<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Submit a Review</title>
  <style>
    body {
      font-family: sans-serif;
      background: linear-gradient(120deg, #f6d365, #fda085);
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }
    form {
      background: white;
      padding: 20px;
      border-radius: 12px;
      box-shadow: 0 0 10px #ccc;
    }
    input, textarea {
      width: 100%;
      margin-bottom: 10px;
      padding: 8px;
    }
  </style>
</head>
<body>
<form method="post" action="submitReview">
  <h2>Submit a Review</h2>
  <input type="text" name="name" placeholder="Your name" required />
  <input type="number" name="rating" min="1" max="5" placeholder="Rating (1-5)" required />
  <textarea name="message" rows="5" placeholder="Your review" required></textarea>
  <input type="submit" value="Submit Review" />
</form>
</body>
</html>
