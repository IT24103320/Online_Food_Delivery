<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Food Dash - Login</title>
  <!-- Tailwind CSS CDN -->
  <script src="https://cdn.tailwindcss.com"></script>
  <!-- FontAwesome CDN -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <!-- Bootstrap CDN -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-green-50">

<!-- Login Form Section -->
<section class="max-w-screen-md mx-auto py-16 px-6">
  <h2 class="text-4xl font-semibold text-center text-green-700 mb-6">Welcome Back to Food Dash</h2>
  <p class="text-center text-lg text-gray-600 mb-12">Log in to your account to start ordering food now!</p>

  <div class="bg-white p-8 rounded-lg shadow-lg">
    <form method="post" action="login">
      <!-- Email Address -->
      <div class="mb-4">
        <label for="email" class="block text-xl text-green-700 font-medium">Email Address</label>
        <input type="email" id="email" name="email" class="w-full p-3 mt-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-green-500" placeholder="Enter your email" required>
      </div>

      <!-- Password -->
      <div class="mb-4">
        <label for="password" class="block text-xl text-green-700 font-medium">Password</label>
        <input type="password" id="password" name="password" class="w-full p-3 mt-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-green-500" placeholder="Enter your password" required>
      </div>

      <!-- Remember Me Checkbox -->
      <div class="mb-4 flex items-center">
        <input type="checkbox" id="remember" name="remember" class="h-5 w-5 text-green-500">
        <label for="remember" class="ml-2 text-lg text-gray-600">Remember Me</label>
      </div>

      <!-- Submit Button -->
      <div class="flex items-center justify-between">
        <button type="submit" class="w-full bg-green-700 text-white py-3 rounded-md hover:bg-green-600 flex items-center justify-center">
          <i class="fas fa-sign-in-alt mr-2"></i> Log In
        </button>
      </div>

      <!-- Forgot Password Link -->
      <div class="text-center mt-4">
        <a href="#forgot-password" class="text-green-700 text-lg hover:text-green-300">Forgot Password?</a>
      </div>

    </form>
  </div>

  <div class="text-center mt-6">
    <p class="text-lg text-gray-600">Don't have an account? <a href="#signup" class="text-green-700 font-medium hover:text-green-300">Sign up here</a></p>
  </div>
</section>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

</body>
</html>
