# Stop the web server if running
sudo systemctl stop nginx || true

# Remove default Nginx index.html and other files
sudo rm -rf /usr/share/nginx/html/*

