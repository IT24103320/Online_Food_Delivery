<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Dash - Registration</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <!-- FontAwesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
</head>
<body class="bg-green-50">

<!-- Registration Form Section -->
<section class="max-w-screen-lg mx-auto py-16 px-6">
    <h2 class="text-4xl font-semibold text-center text-green-700 mb-6">Create Your Account</h2>
    <p class="text-center text-lg text-gray-600 mb-12">Join Food Dash and enjoy fast food delivered to your doorstep!</p>

    <div class="bg-white p-8 rounded-lg shadow-lg">
        <form method="post" action="addUser">
            <!-- Full Name -->
            <div class="mb-4">
                <label for="name" class="block text-xl text-green-700 font-medium">Full Name</label>
                <input type="text" id="name" name="name" class="w-full p-3 mt-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-green-500" placeholder="Enter your full name" required>
            </div>

            <!-- Email Address -->
            <div class="mb-4">
                <label for="email" class="block text-xl text-green-700 font-medium">Email Address</label>
                <input type="email" id="email" name="email" class="w-full p-3 mt-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-green-500" placeholder="Enter your email" required>
            </div>

            <!-- Phone Number -->
            <div class="mb-4">
                <label for="phone" class="block text-xl text-green-700 font-medium">Phone Number</label>
                <input type="tel" id="phone" name="phone" class="w-full p-3 mt-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-green-500" placeholder="Enter your phone number" required>
            </div>

            <!-- Address -->
            <div class="mb-4">
                <label for="address" class="block text-xl text-green-700 font-medium">Delivery Address</label>
                <input type="text" id="address" name="address" class="w-full p-3 mt-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-green-500" placeholder="Enter your delivery address" required>
            </div>

            <!-- City -->
            <div class="mb-4">
                <label for="city" class="block text-xl text-green-700 font-medium">City</label>
                <input type="text" id="city" name="city" class="w-full p-3 mt-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-green-500" placeholder="Enter your city" required>
            </div>

            <!-- Password -->
            <div class="mb-4">
                <label for="password" class="block text-xl text-green-700 font-medium">Password</label>
                <input type="password" id="password" name="password" class="w-full p-3 mt-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-green-500" placeholder="Enter a secure password" required>
            </div>

            <!-- Confirm Password -->
            <div class="mb-4">
                <label for="confirm_password" class="block text-xl text-green-700 font-medium">Confirm Password</label>
                <input type="password" id="confirm_password" name="confirm_password" class="w-full p-3 mt-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-green-500" placeholder="Confirm your password" required>
            </div>

            <!-- Submit Button -->
            <div class="flex items-center justify-between">
                <button type="submit" class="w-full bg-green-700 text-white py-3 rounded-md hover:bg-green-600 flex items-center justify-center">
                    <i class="fas fa-user-plus mr-2"></i> Register
                </button>
            </div>
        </form>
    </div>

    <div class="text-center mt-6">
        <p class="text-lg text-gray-600">Already have an account? <a href="#login" class="text-green-700 font-medium hover:text-green-300">Login here</a></p>
    </div>
</section>

<!-- Bootstrap JS (for potential interactive components) -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

</body>
</html>
