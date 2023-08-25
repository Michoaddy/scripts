#!/bin/bash

# Check if Git is installed
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Installing Git..."
    sudo apt update
    sudo apt install -y git
else
    echo "Git is already installed."
fi

# Check if Tomcat is installed
if ! command -v catalina &> /dev/null; then
    echo "Tomcat is not installed. Installing Tomcat..."
    
    # Install OpenJDK (Java Development Kit) if not already installed
    if ! command -v java &> /dev/null; then
        echo "OpenJDK is not installed. Installing OpenJDK..."
        sudo apt install -y openjdk-11-jdk
    else
        echo "OpenJDK is already installed."
    fi

    # Download and install the latest version of Tomcat
    TOMCAT_VERSION=$(curl -s https://api.github.com/repos/apache/tomcat/tags | grep -o 'v[0-9]*\.[0-9]*\.[0-9]*' | head -n 1)
    TOMCAT_DIR="/opt/tomcat"

    sudo mkdir -p "$TOMCAT_DIR"
    sudo curl -L "https://archive.apache.org/dist/tomcat/tomcat-$TOMCAT_VERSION/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz" -o "/tmp/apache-tomcat-$TOMCAT_VERSION.tar.gz"
    sudo tar xf "/tmp/apache-tomcat-$TOMCAT_VERSION.tar.gz" -C "$TOMCAT_DIR" --strip-components=1
    sudo rm "/tmp/apache-tomcat-$TOMCAT_VERSION.tar.gz"
    
    echo "Tomcat $TOMCAT_VERSION is installed in $TOMCAT_DIR."
else
    echo "Tomcat is already installed."
fi

echo "Installation and checks complete."

# bellow code is used to create user after installations============
#<user username="micheal" password="08087975465" roles="manager-script,manager-status,manager-gui"/> 

