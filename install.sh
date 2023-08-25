#!/bin/bash

# Check if Git is installed
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Installing Git..."
    sudo apt-get update
    sudo apt-get install -y git
else
    echo "Git is already installed."
fi

# Check if Maven is installed
if ! command -v mvn &> /dev/null; then
    echo "Maven is not installed. Installing Maven..."
    sudo apt-get update
    sudo apt-get install -y maven
else
    echo "Maven is already installed."
fi

# Check if Jenkins is installed
if ! sudo systemctl is-active --quiet jenkins; then
    echo "Jenkins is not installed. Installing Jenkins..."
    sudo wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
    sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
    sudo apt-get update
    sudo apt-get install -y jenkins
    sudo systemctl start jenkins
    sudo systemctl enable jenkins
    echo "Jenkins is installed and started. You can access it at http://localhost:8080"
else
    echo "Jenkins is already installed."
fi

echo "Installation and checks complete."

