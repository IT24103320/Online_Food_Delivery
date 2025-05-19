package service;

import config.AppConstants;
import model.customer;

import java.io.*;
        import java.util.ArrayList;

public class UserService {

    private static final String FILE_PATH = AppConstants.USER_DATA_FILE;

    // Register new customer - appends to file
    public void regUser(customer customer) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            // Include role when saving, if null assign default "user"
            String role = customer.getRole();
            if (role == null || role.isEmpty()) {
                role = "user";
                customer.setRole(role);
            }

            String userData = customer.getName() + "," +
                    customer.getEmail() + "," +
                    customer.getPhone() + "," +
                    customer.getPassword() + "," +
                    customer.getAddress() + "," +
                    customer.getCity() + "," +
                    role;

            writer.write(userData);
            writer.newLine();
            System.out.println("Customer data saved to file.");
        } catch (IOException e) {
            System.out.println("Failed to save customer data.");
            e.printStackTrace();
        }
    }

    // Validate customer based on email and password
    public boolean validate(customer customer) {
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length >= 5) {
                    String email = data[1];
                    String password = data[3];
                    if (email.equals(customer.getEmail()) && password.equals(customer.getPassword())) {
                        return true;
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get one customer by email and password
    public customer getOne(customer cust) {
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length >= 5) {
                    String email = data[1];
                    String password = data[3];
                    if (email.equals(cust.getEmail()) && password.equals(cust.getPassword())) {
                        cust.setName(data[0]);
                        cust.setPhone(data[2]);
                        cust.setPassword(data[3]);
                        cust.setAddress(data[4]);
                        cust.setCity(data[5]);
                        cust.setRole(data[4]);
                        return cust;
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get all customers from file
    public ArrayList<customer> getAllUser() {
        ArrayList<customer> listCust = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length >= 5) {
                    customer cust = new customer();
                    cust.setName(data[0]);
                    cust.setEmail(data[1]);
                    cust.setPhone(data[2]);
                    cust.setPassword(data[3]);
                    cust.setRole(data[4]);
                    listCust.add(cust);
                }
            }
            return listCust;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    // Update customer details in file
    public void updateUser(customer customer) {
        File inputFile = new File(FILE_PATH);
        File tempFile = new File(FILE_PATH + ".tmp");

        try (BufferedReader reader = new BufferedReader(new FileReader(inputFile));
             BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile))) {

            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length >= 5) {
                    String email = data[1];
                    if (email.equals(customer.getEmail())) {
                        String updatedData = customer.getName() + "," +
                                customer.getEmail() + "," +
                                customer.getPhone() + "," +
                                customer.getPassword() + "," +
                                customer.getRole();
                        writer.write(updatedData);
                    } else {
                        writer.write(line);
                    }
                    writer.newLine();
                }
            }
            System.out.println("Customer data updated to profile.");
        } catch (IOException e) {
            System.out.println("Customer data not updated to profile.");
            e.printStackTrace();
        }

    }

    // Delete customer by email
    public void deleteUserByEmail(String email) {
        File inputFile = new File(FILE_PATH);
        File tempFile = new File(FILE_PATH + ".tmp");

        try (BufferedReader reader = new BufferedReader(new FileReader(inputFile));
             BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile))) {

            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length >= 5) {
                    if (!data[1].equals(email)) {
                        writer.write(line);
                        writer.newLine();
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
            return;
        }

        if (!inputFile.delete()) {
            System.out.println("Could not delete original file");
            return;
        }
        if (!tempFile.renameTo(inputFile)) {
            System.out.println("Could not rename temp file");
        }
    }
}
