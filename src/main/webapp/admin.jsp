<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Dash - Admin Dashboard</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- FontAwesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50">

<!-- Admin Dashboard Section -->
<section class="max-w-screen-xl mx-auto py-16 px-6">
    <h2 class="text-4xl font-semibold text-center text-green-700 mb-6">Admin Dashboard</h2>
    <p class="text-center text-lg text-gray-600 mb-12">Manage all users of Food Dash</p>

    <!-- Search Form -->
    <div class="flex justify-center mb-6">
        <form action="searchUsers" method="get" class="flex space-x-4">
            <input type="text" name="search" placeholder="Search by name or email" class="w-80 p-3 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-green-500">
            <button type="submit" class="w-24 bg-green-700 text-white py-2 rounded-md hover:bg-green-600 flex items-center justify-center">
                <i class="fas fa-search"></i> Search
            </button>
        </form>
    </div>

    <!-- Users Table -->
    <div class="overflow-x-auto bg-white p-8 rounded-lg shadow-lg">
        <table class="table table-striped table-bordered w-full">
            <thead>
            <tr class="bg-green-700 text-white">
                <th class="px-4 py-2">#</th>
                <th class="px-4 py-2">Full Name</th>
                <th class="px-4 py-2">Email</th>
                <th class="px-4 py-2">Phone Number</th>
                <th class="px-4 py-2">Actions</th>
            </tr>
            </thead>
            <tbody>
            <!-- Example of user row, repeat for each user -->
            <tr>
                <td class="px-4 py-2 text-center">1</td>
                <td class="px-4 py-2">John Doe</td>
                <td class="px-4 py-2">john@example.com</td>
                <td class="px-4 py-2">+94 0781234567</td>
                <td class="px-4 py-2 text-center">
                    <button class="bg-red-500 text-white py-1 px-4 rounded-md hover:bg-red-600" onclick="deleteUser(1)">
                        <i class="fas fa-trash"></i> Delete
                    </button>
                </td>
            </tr>
            <tr>
                <td class="px-4 py-2 text-center">2</td>
                <td class="px-4 py-2">Jane Smith</td>
                <td class="px-4 py-2">jane@example.com</td>
                <td class="px-4 py-2">+94 0787654321</td>
                <td class="px-4 py-2 text-center">
                    <button class="bg-red-500 text-white py-1 px-4 rounded-md hover:bg-red-600" onclick="deleteUser(2)">
                        <i class="fas fa-trash"></i> Delete
                    </button>
                </td>
            </tr>
            <!-- Add more rows dynamically from your database -->
            </tbody>
        </table>
    </div>
</section>

<!-- Bootstrap JS (for interactive components like modals, dropdowns, etc.) -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

<!-- Custom JavaScript to handle delete action -->
<script>
    function deleteUser(userId) {
        if (confirm('Are you sure you want to delete this user?')) {
            // Replace with actual backend logic to delete the user
            alert('User ' + userId + ' deleted');
        }
    }
</script>

</body>
</html>
