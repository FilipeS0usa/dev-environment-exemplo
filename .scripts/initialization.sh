#!/bin/bash

# Install dependencies from requirements.txt
pip3 install --user -r requirements.txt

# Change ownership of the current directory recursively
sudo chown -R vscode:vscode .

# Configure Git user information and disable SSL verification
git config --global user.name 'John Doe'
git config --global user.email 'john.doe@example.com'
git config --global http.sslVerify false

# Add gitlabserver.io to /etc/hosts
echo '192.168.1.1 gitlabserver.io' | sudo tee -a /etc/hosts
