<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Food Dash</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
</head>
<body>
<!-- Header Section (NavBar) -->
<header class="bg-white shadow-md py-4">
    <div class="container mx-auto px-4 flex justify-between items-center">
        <!-- Logo Section -->
        <div class="flex items-center space-x-4">
            <span class="text-2xl font-semibold text-green-600">Food Dash</span>
        </div>

        <!-- Navigation Links -->
        <nav class="hidden md:flex space-x-8 text-gray-700 font-medium">
            <a href="#home" class="hover:text-green-600 transition duration-300">Home</a>
            <a href="#menu" class="hover:text-green-600 transition duration-300">Menu</a>
            <a href="#about" class="hover:text-green-600 transition duration-300">About Us</a>
            <a href="#contact" class="hover:text-green-600 transition duration-300">Contact</a>
        </nav>

        <!-- Right Section (Icons and Account) -->
        <div class="flex items-center space-x-6">
            <!-- Search Bar -->
            <div class="relative">
                <input type="text" class="border border-gray-300 rounded-full px-4 py-2 text-gray-700 focus:outline-none focus:ring-2 focus:ring-green-500 w-40" placeholder="Search...">
                <i class="fas fa-search absolute top-2 right-2 text-gray-500"></i>
            </div>

            <!-- Cart Icon -->
            <a href="#cart" class="relative">
                <i class="bi bi-cart4 text-2xl text-gray-700 hover:text-green-600 transition duration-300"><i class="fa-solid fa-cart-shopping"></i></i>
                <span class="absolute top-0 right-0 bg-red-500 text-white text-xs rounded-full w-4 h-4 flex items-center justify-center">3</span>
            </a>

            <!-- User Account -->
            <div class="flex items-center space-x-4">
                <% if(session.getAttribute("role") != null && session.getAttribute("role").equals("admin")) { %>
                <li class="list-none">
                    <form action="adminuser" method="post">
                        <button type="submit" class="nav-btn dashboard-btn">Dashboard</button>
                    </form>
                </li>
                <% } %>
                <% if(session.getAttribute("role") != null ) { %>
                <a href="profile.jsp" class="">
                    <button class="text-lg font-medium text-gray-900 hover:text-gray-800 "><i class="fa-solid fa-user p-2 border-2 border-solid border-gray-900 hover:border-gray-800 rounded-full"></i></button>
                </a>
                <form action="logout" method="post">
                    <button type="submit" class="bg-red-700 text-white font-bold py-2 px-4 rounded-3xl hover:bg-red-800 focus:outline-none focus:ring-2 focus:ring-red-500 focus:ring-opacity-50">Logout</button>
                </form>
                <% } else { %>
                <a href="login.jsp">
                    <button class="text-lg font-medium text-gray-700 hover:text-green-600">Login</button>
                </a>
                <a href="register.jsp">
                    <button class="text-lg font-medium text-green-600 bg-white border border-green-600 px-4 py-2 rounded-md hover:bg-green-600 hover:text-white">Sign Up</button>
                </a>
                <% } %>

            </div>

        </div>
    </div>
</header>

<!-- Hero Section with Image Slider -->
<section x-data="{
         slideIndex: 0,
         slides: [
         'assets/b2.jpeg',
         'assets/B1.jpeg',
         'assets/B3.jpeg'
],
autoSlide() {
setInterval(() => {
this.slideIndex = (this.slideIndex + 1) % this.slides.length;
}, 5000); // Change image every 5 seconds
    }
}" x-init="autoSlide()" class="relative">
    <div class="w-full h-96 overflow-hidden relative">
        <!-- Dynamic Image -->
        <img :src="slides[slideIndex]" alt="Restaurant Banner" class="w-full h-full object-cover bg-center transition-all duration-1000 ease-in-out">
    </div>

    <!-- Overlay Text -->


    <!-- Arrow Navigation -->
    <div class="absolute inset-y-1/2 left-0 flex items-center">
        <button @click="slideIndex = (slideIndex === 0) ? slides.length - 1 : slideIndex - 1" class="bg-black text-white p-3 rounded-full hover:bg-green-600">
            <i class="fas fa-chevron-left"></i>
        </button>
    </div>
    <div class="absolute inset-y-1/2 right-0 flex items-center">
        <button @click="slideIndex = (slideIndex === slides.length - 1) ? 0 : slideIndex + 1" class="bg-black text-white p-3 rounded-full hover:bg-green-600">
            <i class="fas fa-chevron-right"></i>
        </button>
    </div>

    <!-- Dot Navigation -->
    <div class="absolute bottom-4 left-1/2 transform -translate-x-1/2 flex space-x-2">
        <template x-for="(slide, index) in slides" :key="index">
            <button @click="slideIndex = index" :class="{'bg-green-600': slideIndex === index, 'bg-white': slideIndex !== index}" class="w-3 h-3 rounded-full"></button>
        </template>
    </div>
</section>


<!-- Featured Foods Section -->
<section class="max-w-screen-xl mx-auto px-6 py-12">
    <h2 class="text-4xl font-semibold text-center text-green-700 mb-12">Featured Foods</h2>

    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-3 gap-8">
        <!-- Food Item 1 -->
        <div class="bg-white p-6 rounded-lg shadow-lg hover:shadow-xl transition duration-300">
            <img src="assets/Burger.jpeg" alt="Burger" class="w-full h-48 object-cover rounded-t-lg">
            <div class="text-left mt-4">
                <h3 class="text-2xl font-semibold text-green-700">Classic Burger</h3>
                <div class="flex items-center space-x-2 mt-2">
                    <i class="fas fa-star text-yellow-400"></i>
                    <i class="fas fa-star text-yellow-400"></i>
                    <i class="fas fa-star text-yellow-400"></i>
                    <i class="fas fa-star text-yellow-400"></i>
                    <i class="fas fa-star-half-alt text-yellow-400"></i>
                </div>
                <p class="text-lg font-semibold text-green-700 mt-2">Rs.550</p>
            </div>
            <button class="mt-4 w-full bg-green-700 text-white py-2 rounded-md hover:bg-green-600 flex items-center justify-center">
                <i class="fas fa-cart-plus mr-2"></i> Add to Cart
            </button>
        </div>

        <!-- Food Item 2 -->
        <div class="bg-white p-6 rounded-lg shadow-lg hover:shadow-xl transition duration-300">
            <img src="assets/Beef Sub.jpeg" alt="Submarine" class="w-full h-48 object-cover rounded-t-lg">
            <div class="text-left mt-4">
                <h3 class="text-2xl font-semibold text-green-700">Beef Submarine</h3>
                <div class="flex items-center space-x-2 mt-2">
                    <i class="fas fa-star text-yellow-400"></i>
                    <i class="fas fa-star text-yellow-400"></i>
                    <i class="fas fa-star text-yellow-400"></i>
                    <i class="fas fa-star-half-alt text-yellow-400"></i>
                    <i class="fas fa-star-half-alt text-yellow-400"></i>
                </div>
                <p class="text-lg font-semibold text-green-700 mt-2">Rs.950</p>
            </div>
            <button class="mt-4 w-full bg-green-700 text-white py-2 rounded-md hover:bg-green-600 flex items-center justify-center">
                <i class="fas fa-cart-plus mr-2"></i> Add to Cart
            </button>
        </div>

        <!-- Food Item 3 -->
        <div class="bg-white p-6 rounded-lg shadow-lg hover:shadow-xl transition duration-300">
            <img src="assets/French Fries.jpeg" alt="Fries" class="w-full h-48 object-cover rounded-t-lg">
            <div class="text-left mt-4">
                <h3 class="text-2xl font-semibold text-green-700">French Fries</h3>
                <div class="flex items-center space-x-2 mt-2">
                    <i class="fas fa-star text-yellow-400"></i>
                    <i class="fas fa-star text-yellow-400"></i>
                    <i class="fas fa-star text-yellow-400"></i>
                    <i class="fas fa-star text-yellow-400"></i>
                    <i class="fas fa-star-half-alt text-yellow-400"></i>
                </div>
                <p class="text-lg font-semibold text-green-700 mt-2">Rs.399</p>
            </div>
            <button class="mt-4 w-full bg-green-700 text-white py-2 rounded-md hover:bg-green-600 flex items-center justify-center">
                <i class="fas fa-cart-plus mr-2"></i> Add to Cart
            </button>
        </div>

        <!-- Food Item 4 -->
        <div class="bg-white p-6 rounded-lg shadow-lg hover:shadow-xl transition duration-300">
            <img src="assets/Wings.jpeg" alt="Chicken Wings" class="w-full h-48 object-cover rounded-t-lg">
            <div class="text-left mt-4">
                <h3 class="text-2xl font-semibold text-green-700">Spicy Chicken Wings</h3>
                <div class="flex items-center space-x-2 mt-2">
                    <i class="fas fa-star text-yellow-400"></i>
                    <i class="fas fa-star text-yellow-400"></i>
                    <i class="fas fa-star text-yellow-400"></i>
                    <i class="fas fa-star-half-alt text-yellow-400"></i>
                    <i class="fas fa-star-half-alt text-yellow-400"></i>
                </div>
                <p class="text-lg font-semibold text-green-700 mt-2">Rs.450</p>
            </div>
            <button class="mt-4 w-full bg-green-700 text-white py-2 rounded-md hover:bg-green-600 flex items-center justify-center">
                <i class="fas fa-cart-plus mr-2"></i> Add to Cart
            </button>
        </div>

        <!-- Food Item 5 -->
        <div class="bg-white p-6 rounded-lg shadow-lg hover:shadow-xl transition duration-300">
            <img src="assets/Hotdog.jpeg" alt="Hotdog" class="w-full h-48 object-cover rounded-t-lg">
            <div class="text-left mt-4">
                <h3 class="text-2xl font-semibold text-green-700">Classic Hotdog</h3>
                <div class="flex items-center space-x-2 mt-2">
                    <i class="fas fa-star text-yellow-400"></i>
                    <i class="fas fa-star text-yellow-400"></i>
                    <i class="fas fa-star text-yellow-400"></i>
                    <i class="fas fa-star-half-alt text-yellow-400"></i>
                    <i class="fas fa-star-half-alt text-yellow-400"></i>
                </div>
                <p class="text-lg font-semibold text-green-700 mt-2">Rs.550</p>
            </div>
            <button class="mt-4 w-full bg-green-700 text-white py-2 rounded-md hover:bg-green-600 flex items-center justify-center">
                <i class="fas fa-cart-plus mr-2"></i> Add to Cart
            </button>
        </div>

        <!-- Food Item 6 -->
        <div class="bg-white p-6 rounded-lg shadow-lg hover:shadow-xl transition duration-300">
            <img src="assets/Shawarma.jpeg" alt="Shawarma" class="w-full h-48 object-cover rounded-t-lg">
            <div class="text-left mt-4">
                <h3 class="text-2xl font-semibold text-green-700">Chicken Shawarma</h3>
                <div class="flex items-center space-x-2 mt-2">
                    <i class="fas fa-star text-yellow-400"></i>
                    <i class="fas fa-star text-yellow-400"></i>
                    <i class="fas fa-star text-yellow-400"></i>
                    <i class="fas fa-star text-yellow-400"></i>
                    <i class="fas fa-star-half-alt text-yellow-400"></i>
                </div>
                <p class="text-lg font-semibold text-green-700 mt-2">Rs.650</p>
            </div>
            <button class="mt-4 w-full bg-green-700 text-white py-2 rounded-md hover:bg-green-600 flex items-center justify-center">
                <i class="fas fa-cart-plus mr-2"></i> Add to Cart
            </button>
        </div>
    </div>
</section>

<!-- Footer Section -->
<footer class="bg-green-700 text-white py-12">
    <div class="max-w-screen-xl mx-auto px-6">
        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-12">
            <!-- Help Section -->
            <div>
                <h3 class="text-2xl font-semibold">Help</h3>
                <ul class="mt-4 space-y-2 text-lg">
                    <li><a href="#faq" class="hover:text-green-300">FAQ</a></li>
                    <li><a href="#shipping" class="hover:text-green-300">Shipping Info</a></li>
                    <li><a href="#returns" class="hover:text-green-300">Returns & Refunds</a></li>
                    <li><a href="#order-status" class="hover:text-green-300">Order Status</a></li>
                </ul>
            </div>

            <!-- Contact Us Section -->
            <div>
                <h3 class="text-2xl font-semibold">Contact Us</h3>
                <ul class="mt-4 text-lg">
                    <li><i class="fas fa-map-marker-alt mr-2"></i> 123 Food St, Havelock road, Colombo 07</li>
                    <li><i class="fas fa-phone-alt mr-2"></i> +94 (078) 4565480</li>
                    <li><i class="fas fa-envelope mr-2"></i> support@fooddash.com</li>
                </ul>
            </div>

            <!-- Follow Us Section -->
            <div>
                <h3 class="text-2xl font-semibold">Follow Us</h3>
                <div class="mt-4 flex space-x-6">
                    <a href="https://www.facebook.com" class="text-white hover:text-green-300">
                        <i class="fab fa-facebook-square text-3xl"></i>
                    </a>
                    <a href="https://twitter.com" class="text-white hover:text-green-300">
                        <i class="fab fa-twitter-square text-3xl"></i>
                    </a>
                    <a href="https://www.instagram.com" class="text-white hover:text-green-300">
                        <i class="fab fa-instagram-square text-3xl"></i>
                    </a>
                </div>
            </div>

            <!-- Additional Info Section -->
            <div>
                <h3 class="text-2xl font-semibold">Information</h3>
                <ul class="mt-4 space-y-2 text-lg">
                    <li><a href="#about" class="hover:text-green-300">About Us</a></li>
                    <li><a href="#careers" class="hover:text-green-300">Careers</a></li>
                    <li><a href="#terms" class="hover:text-green-300">Terms & Conditions</a></li>
                    <li><a href="#privacy" class="hover:text-green-300">Privacy Policy</a></li>
                </ul>
            </div>
        </div>

        <!-- Copyright Section -->
        <div class="mt-12 border-t border-green-600 pt-6 text-center text-lg">
            <p>&copy; 2025 Food Dash. All rights reserved.</p>
        </div>
    </div>
</footer>
</body>
</html>