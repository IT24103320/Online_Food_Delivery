#!/bin/bash

echo "Building the cart management system..."
mvn clean package

echo "\nDeploying to Tomcat (if you have Tomcat installed locally)..."
echo "Copy the WAR file from target/cart-management-1.0-SNAPSHOT.war to your Tomcat webapps directory"

echo "\nAlternatively, you can use the embedded Tomcat with the Cargo plugin:"
echo "mvn cargo:run"

echo "\nOpen your browser and navigate to: http://localhost:8080/cart-management-1.0-SNAPSHOT/"
