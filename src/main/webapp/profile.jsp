<%@ page import="model.customer" %>
<%@ page session="true" %>
<%
    customer user = (customer) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");  // redirect if not logged in
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Food Dash - Profile</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- FontAwesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
    <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-green-50 min-h-screen flex items-center justify-center py-12 px-4">

<div class="bg-white shadow-lg rounded-lg max-w-4xl w-full p-8">
    <h2 class="text-3xl font-semibold text-green-700 mb-6 text-center">Your Profile</h2>

    <form id="profileForm" method="post" action="update">
        <table class="table table-bordered w-full text-center align-middle">
            <thead class="bg-green-100 text-green-700">
            <tr>
                <th>Field</th>
                <th>Value</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td class="font-semibold">Name</td>
                <td>
                    <input
                            type="text"
                            name="name"
                            value="<%= user.getName() %>"
                            class="form-control"
                            readonly
                            required
                    />
                </td>
            </tr>
            <tr>
                <td class="font-semibold">Email</td>
                <td>
                    <input
                            type="email"
                            name="email"
                            value="<%= user.getEmail() %>"
                            class="form-control bg-light"
                            readonly
                            required
                    />
                </td>
            </tr>
            <tr>
                <td class="font-semibold">Phone</td>
                <td>
                    <input
                            type="tel"
                            name="phone"
                            value="<%= user.getPhone() %>"
                            class="form-control"
                            readonly
                            required
                    />
                </td>
            </tr>
            <tr>
                <td class="font-semibold">Address</td>
                <td>
                    <input
                            type="text"
                            name="address"
                            value="<%= user.getAddress() != null ? user.getAddress() : "" %>"
                            class="form-control"
                            readonly
                    />
                </td>
            </tr>
            <tr>
                <td class="font-semibold">City</td>
                <td>
                    <input
                            type="text"
                            name="city"
                            value="<%= user.getCity() != null ? user.getCity() : "" %>"
                            class="form-control"
                            readonly
                    />
                </td>
            </tr>
            <tr>
                <td class="font-semibold">Password</td>
                <td>
                    <input
                            type="password"
                            name="password"
                            value="<%= user.getPassword() %>"
                            class="form-control"
                            readonly
                            required
                    />
                </td>
            </tr>
            </tbody>
        </table>

        <div class="mt-6 flex justify-center space-x-4">
            <button
                    type="button"
                    id="editBtn"
                    class="btn btn-success flex items-center"
            >
                <i class="fas fa-edit mr-2"></i> Edit
            </button>

            <button
                    type="submit"
                    id="saveBtn"
                    class="btn btn-primary flex items-center hidden"
            >
                <i class="fas fa-save mr-2"></i> Save
            </button>

            <button
                    type="button"
                    id="cancelBtn"
                    class="btn btn-secondary flex items-center hidden"
            >
                <i class="fas fa-times mr-2"></i> Cancel
            </button>
        </div>
    </form>
</div>

<script>
    const editBtn = document.getElementById('editBtn');
    const saveBtn = document.getElementById('saveBtn');
    const cancelBtn = document.getElementById('cancelBtn');
    const form = document.getElementById('profileForm');
    const inputs = form.querySelectorAll('input');

    const initialValues = {};
    inputs.forEach(input => {
        initialValues[input.name] = input.value;
    });

    editBtn.addEventListener('click', () => {
        inputs.forEach(input => {
            if (input.name !== 'email') { // email still readonly
                input.removeAttribute('readonly');
                input.classList.remove('bg-light');
            }
        });
        editBtn.classList.add('hidden');
        saveBtn.classList.remove('hidden');
        cancelBtn.classList.remove('hidden');
    });

    cancelBtn.addEventListener('click', () => {
        inputs.forEach(input => {
            input.value = initialValues[input.name];
            input.setAttribute('readonly', 'readonly');
            if(input.name !== 'email') input.classList.add('bg-light');
        });
        editBtn.classList.remove('hidden');
        saveBtn.classList.add('hidden');
        cancelBtn.classList.add('hidden');
    });
</script>
</body>
</html>
